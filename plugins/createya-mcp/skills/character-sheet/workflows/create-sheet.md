# Workflow — Create character sheet

Пошаговый flow от запроса юзера до сохранённого персонажа.

## Trigger

Юзер сказал что-то из:
- «создай персонажа»
- «сделай character sheet»
- «сохрани образ»
- «лист персонажа»
- «AI-инфлюенсер для проекта»
- «модель для серии»

## Step 1 — Установить контекст

Прочитай `createya/MASTER_CONTEXT.md` (если файл существует). Если в нём уже есть секция `## Characters` — узнай что есть.

Спроси юзера:
1. **Имя/slug** для персонажа: `anya`, `boris`, `model_summer`. Lowercase + дефисы.
2. **Reference фото** — есть ли локально или нужен URL? Минимум 1 фото лица, желательно ещё фото в полный рост.

Если slug уже занят в `characters/` — предложи: переименовать или пересоздать (overwrite).

## Step 2 — Загрузить reference фото

Варианты:

### A. Юзер прикладывает файл в чат
Прочитай через `Read`, загрузи через `mcp__createya__request_upload_url` (presigned PUT) или REST `POST /v1/uploads` (multipart).

### B. Юзер даёт URL
Если URL уже на нашем CDN (`cdn-new.createya.ai`) — используй как есть. Если внешний — скачай через `bash` curl, загрузи в наш S3 (см. вариант A).

### C. Только текстовое описание
Сначала генерируем reference через `gpt-image-2-t2i`:

```
model: gpt-image-2-t2i
input:
  prompt: "Photorealistic portrait of <description>. Front-facing, neutral expression, plain white background, even studio lighting. Sharp focus, professional headshot."
  size: 1024x1024
  quality: high
```

Полученный URL → используем как reference для sheet'а.

⚠️ Это удваивает стоимость (~50 + 50 кредитов). Предупреди юзера.

## Step 3 — Outfit choice

Дефолт: **neutral grey t-shirt + dark jeans**. Универсально, не отвлекает.

Спроси если контекст требует другого:
- formal: tailored navy suit, white shirt, no tie
- casual: oversized hoodie + cargo pants + sneakers
- streetwear: cropped tee + baggy jeans + caps
- character-specific: уточни у юзера

Outfit идёт в placeholder `{outfit}` в prompt template.

## Step 4 — Credit gate

Прочитай баланс:
```
mcp__createya__get_balance
```

GPT Image 2 high quality ~50 кредитов. Если ожидается regenerate — заложи x2.

Покажи юзеру:
> «Создание sheet для [slug]. Стоимость ~50 кредитов (high quality, может потребоваться regenerate если drift). Текущий баланс: N кредитов. Продолжаем?»

Только после явного подтверждения переходи к step 5.

## Step 5 — Generate sheet

Используй `presets/sheet-template-4-angle.md` — там полный prompt с placeholder'ами для подстановки.

```
mcp__createya__run_model with:
  model: "gpt-image-2-i2i"
  input:
    image_url: <reference URL>
    prompt: <prompt из preset с подстановкой outfit и age_descriptor>
    size: "1536x1024"
    quality: "high"
    num_images: 1
    output_format: "png"
```

Дождись completion (sync режим).

## Step 6 — Vision QA

`Read` сгенерированный sheet (URL из `output.urls[0]`).

Чеклист (см. `presets/sheet-template-4-angle.md` → Vision QA):
- 4 фигуры в одном кадре?
- Все — один человек?
- Outfit идентичен?
- Белый фон чистый?
- Освещение ровное?

Если хоть один фейл — regenerate с уточняющим суффиксом в промте. Покажи юзеру оба варианта если нужно сравнение.

## Step 7 — Approve gate

Покажи sheet юзеру:
> «Готов sheet для [slug]. Лица консистентны, outfit един, фон чистый. Сохраняю в проект?»

Жди явного «да». Если юзер просит правки — итерируй с step 5.

## Step 8 — Save to project

Создай структуру:

```bash
mkdir -p createya/characters/<slug>/references
```

Скачай sheet локально:

```bash
curl -fsSL "<sheet_url>" -o createya/characters/<slug>/sheet.png
```

Скопируй reference фото в `references/`.

Создай `character_profile.json`:

```json
{
  "slug": "<slug>",
  "display_name": "<Slug capitalized>",
  "description": "<short description from refs>",
  "outfit": "<outfit used>",
  "sheet_url": "<CDN URL>",
  "sheet_local": "characters/<slug>/sheet.png",
  "reference_urls": ["<ref URL 1>", "..."],
  "created_at": "<ISO timestamp>",
  "model_used": "gpt-image-2-i2i",
  "prompt_template": "4-angle sheet template v1",
  "session_id": "<если есть>"
}
```

## Step 9 — Update MASTER_CONTEXT

Открой `createya/MASTER_CONTEXT.md`. Если файла нет — создай минимальный:

```markdown
# Master Context — <Project>

## Characters

(новая секция)
```

Добавь запись:

```markdown
- **<slug>** — <description>
  - Sheet: `characters/<slug>/sheet.png` (<sheet_url>)
  - Outfit: <outfit>
  - Created: <YYYY-MM-DD>
  - Use: передавай sheet как `start_image_url` или `image_url` в `run_model` для консистентности
```

## Step 10 — Confirm

Сообщи юзеру:
> «✅ Персонаж [slug] сохранён.
> - Sheet: `characters/[slug]/sheet.png`
> - В MASTER_CONTEXT.md записан в `## Characters`
> - Можешь использовать в любом workflow: «сделай Anya на пляже», «Anya в офисе» — я подцеплю sheet автоматически.»

## Что записать в session log

В session-logs (если ведёшь) — кратко:
- Создан character `<slug>` (<кредитов потрачено>)
- Reference: <ссылки>
- Sheet: <URL>
- Outfit: <описание>
- Regenerates: <count если были>
