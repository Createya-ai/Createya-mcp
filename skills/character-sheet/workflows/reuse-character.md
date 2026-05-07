# Workflow — Reuse existing character

Юзер хочет сгенерировать что-то с уже сохранённым персонажем.

## Trigger

Юзер сказал:
- «Сделай [slug] на пляже»
- «[slug] в офисе»
- «возьми Anya и сними lookbook»
- «use character anya»
- «повтори того же человека из прошлой генерации»

Skill распознаёт `<slug>` или указание «тот же человек» и подгружает character.

## Step 1 — Найти character

Прочитай `createya/MASTER_CONTEXT.md`.

В секции `## Characters` найди slug. Если не нашёл — ответь юзеру:
> «Персонажа `<slug>` нет в проекте. Доступные: [...список из MASTER_CONTEXT...]. Создать новый? Тогда «создай персонажа [slug]».»

Если slug найден → прочитай `characters/<slug>/character_profile.json`.

## Step 2 — Подготовить параметры генерации

Возьми из profile:
- `sheet_url` — это reference для image_url / start_image_url / image_urls[0]
- `description` — для injection в промт
- `outfit` — для injection если новый сценарий не требует другого

## Step 3 — Запросить недостающее у юзера

Если юзер сказал только «Anya на пляже» — спроси (через AskUserQuestion с кнопками если возможно):

1. **Тип результата**: фото / видео / серия фото
2. **Aspect ratio**: 1:1 / 9:16 / 16:9 / 4:5
3. **Outfit**: как в sheet (`{character.outfit}`) или другой? (для творческих сценариев)
4. **Mood/lighting**: golden hour / studio / overcast / neon
5. **Сколько вариантов**: 1 / 2 / 4

## Step 4 — Построить промт

Шаблон:

```
{Photorealistic | Cinematic | Editorial} <type> shot of the woman/man from
the reference character sheet. Maintain exact character identity:
{character.description}.

Scene: {user-specified scenario, e.g. "luxury yacht at sunset, panoramic ocean view"}
Outfit: {outfit from profile or user override}
Lighting: {requested mood}
Composition: {aspect-specific framing}
Style: {photo aesthetic — fashion / lifestyle / commercial / candid}
```

Пример для «Anya на яхте, sunset, 16:9»:

```
Cinematic photo shot of the woman from the reference character sheet.
Maintain exact character identity: 25-year-old, dark wavy hair, slim
build, warm skin tone.

Scene: standing at the bow of a luxury sailing yacht, panoramic ocean
view, sunset glow on horizon
Outfit: white linen wrap dress, barefoot
Lighting: golden hour, warm rim light from behind, soft fill from front
Composition: wide shot, character right-of-centre, golden ratio
Style: editorial fashion photography, Annie Leibovitz reference
```

## Step 5 — Выбрать endpoint

Используй `mcp__createya__list_models` чтобы увидеть актуальный каталог.

### Для image:
- `gpt-image-2-i2i` — главный i2i, поддерживает сложные сцены, dest 16:9, high quality
- `nano-banana-pro-i2i` — быстрее, дешевле, для простых сценариев
- `flux-kontext-pro-i2i` — альтернатива с другим стилем

Передай sheet как `image_url`:

```
model: nano-banana-pro-i2i
input:
  image_url: <character.sheet_url>
  prompt: <prompt из step 4>
  aspect_ratio: <user choice>
  num_images: <count>
```

### Для video:
- `seedance-2.0-i2v` — primary (Seedance 2.0, новейший)
- `happy-horse-i2v` — для CGI/hyper-motion
- `kling-video-v3-pro-i2v` — для motion control

Двухшаговый pipeline: сначала генерируем still через image модель (используя sheet), потом этот still → i2v:

1. Generate still: image модель + sheet → `<still_url>`
2. Approve user: «Это нужный кадр?»
3. Generate video: `seedance-2.0-i2v` с `image_url=<still_url>` + motion description

## Step 6 — Vision QA

После генерации — `Read` результат, проверь:
- Лицо матчит sheet (не изменилось)
- Outfit соответствует тому что просил юзер
- Сцена соответствует промту

Если drift лица — regenerate с более явной инструкцией:
> "CRITICAL: maintain exact face from reference. Do not alter facial features."

## Step 7 — Update character profile (если новый outfit)

Если юзер использовал персонажа в новом outfit'е и доволен — спроси:
> «Сохранить этот outfit в профиль anya как `outfit_yacht`?»

Если да — обнови `character_profile.json`:
```json
"alternative_outfits": {
  "yacht": "white linen wrap dress, barefoot"
}
```

И добавь в `MASTER_CONTEXT.md` под персонажем:
```markdown
- **anya** — ...
  - Alternative outfits: yacht (white linen wrap dress)
```

## Step 8 — Save session log

В session-log записать что использовали character `<slug>` для сценария `<X>`. Это даст «история использований» персонажа в будущем.

## Edge cases

### Юзер хочет двух персонажей в одном кадре

Сейчас image endpoints принимают один `image_url`. Workaround:
1. Создай compositional reference: «Anya и Boris рядом» через text-to-image с описанием обоих персонажей по их profile'ам.
2. Используй полученный compose как `image_url` в i2i endpoint.

Когда модели начнут поддерживать `image_urls[]` массив — можно будет передавать оба sheet'а напрямую.

### Юзер хочет совершенно новый outfit, который не совместим с sheet

Если outfit радикально отличается (например sheet — t-shirt+jeans, а юзер хочет fantasy armor) — модель может потерять identity. Решение:
1. Сначала сгенерируй промежуточный still: «Same person from reference, wearing fantasy armor, neutral pose, white background» через i2i.
2. Vision QA → identity сохранилось?
3. Этот still используй как новый reference для финальной сцены.

### Sheet был сделан давно и юзеру не нравится

Предложи: «Пересоздать sheet с новыми reference фото? Текущий сохранится как `sheet-v1.png` для history.»
