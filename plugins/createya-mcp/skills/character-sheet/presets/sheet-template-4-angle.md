# Sheet Template — 4-angle (Front / 3-quarter / Profile / Back)

Базовый prompt template для генерации character sheet через `gpt-image-2-i2i`.

## Параметры подстановки

| Placeholder | Что подставить |
|-------------|----------------|
| `{outfit}` | Описание одежды. Дефолт: `neutral grey t-shirt and dark jeans` |
| `{age_descriptor}` | Опционально, для усиления identity. Например: `25-year-old`, `mid-30s`, `young adult`. Дефолт: пустая строка |
| `{additional_features}` | Опционально: специфические черты — татуировки, очки, аксессуары. Дефолт: пустая строка |

## Prompt (английский — модель работает лучше на нём)

```
Character reference sheet for AI generation. Same person from 4 viewpoints
arranged horizontally in a single frame, left to right:
1) Full body front view (facing camera directly)
2) Full body 3/4 view (turned 45 degrees to camera right)
3) Full body profile view (90 degrees, side-on)
4) Full body back view (facing away from camera)

Person details: {age_descriptor} same individual across all four poses,
identical facial features, hairstyle, body proportions, skin tone matching
the reference image. {additional_features}

Outfit: {outfit}, identical on every pose, no accessories changing between views.

Pose: neutral standing, arms relaxed at sides, weight evenly distributed.
No exaggerated expressions, neutral relaxed face on visible angles.

Background: pure white seamless studio backdrop, no shadows on the wall.
Soft floor shadow only directly beneath each figure.

Lighting: even soft studio lighting (large softbox front-key), no harsh
shadows on face or body, consistent across all four figures.

Composition: all four figures aligned on the same baseline (feet level),
same height in frame, equal horizontal spacing, no overlap between figures.

Style: photorealistic photography, sharp focus on faces, clean professional
e-commerce / fashion lookbook aesthetic. 16:9 horizontal aspect ratio.

NEGATIVE: do not invent additional people, do not add furniture or props,
do not change outfit between angles, do not add cinematic colour grading,
no motion blur, no artistic effects.
```

## Параметры endpoint

```
model: gpt-image-2-i2i
input:
  image_urls: ["<CDN URL reference фото>"]   # array, max 4
  prompt: <prompt выше с подстановками>
  image_size: "landscape_16_9_hd"             # 1920x1080, простор для 4 фигур
  quality: "high"                             # для high-fidelity faces
  num_images: 1
  output_format: "png"                        # без compression artefacts
```

`image_urls` — обязательный массив (1-4 элемента). Если у юзера несколько reference фото — передай все, модель усреднит identity. Если только одно — массив из одного элемента.

## Альтернативные размеры (через `image_size` enum)

- **`landscape_16_9_hd`** (1920×1080) — дефолт, лучше всего для 4 фигур в ряд.
- **`landscape_16_9_2k`** (2560×1440) — для extra детализации лиц (дороже).
- **`square_hd`** (1024×1024) — fallback на 2×2 grid если 4 в ряд не помещаются красиво. В промте заменить «arranged horizontally» на «arranged in 2×2 grid».
- **`portrait_3_4_hd`** (1536×2048) — если хочется вертикальный sheet (2×2 более удобный).

## Vision QA чеклист (после генерации)

Прогони `Read` сгенерированного sheet и проверь:

| Проверка | Как смотреть |
|----------|-------------|
| 4 фигуры в кадре | Считаем людей слева направо |
| Все 4 — один человек | Сравниваем лица: цвет глаз, форма носа, причёска |
| Outfit идентичен | Цвет, фасон, обувь — одинаковые на всех |
| Белый фон чистый | Без артефактов, без второстепенных объектов |
| Освещение ровное | Нет тёмной стороны, нет жёстких теней на лицах |
| Поза neutral | Руки по бокам, не задирая, не размахивая |

При drift'е (одна фигура отличается) — regenerate с уточнением:
> «Make all four figures appear identical: same face, same hair, same outfit. Reference figure 1 (front view) for identity matching.»

## Расход кредитов

Endpoint `gpt-image-2-i2i` (на момент 2026-05-07):
- `quality: low` ~ 6 кредитов
- `quality: medium` ~ 16 кредитов
- `quality: high` ~ 50 кредитов (рекомендуется для sheets)

Один regenerate = ещё столько же. Имеет смысл проверить баланс через `get_balance` до старта и предупредить юзера.

---

## Будущие варианты этого preset'а

- `sheet-template-8-angle.md` — расширенный (front, 3/4 left, side left, back-3/4 left, back, back-3/4 right, side right, 3/4 right). Для motion / animation pipelines.
- `sheet-template-character-only.md` — без фона полностью (alpha PNG cutout), для compositing.
- `sheet-template-portrait-only.md` — head-and-shoulders, 4 ракурса лица. Для face-focused use cases.

Эти варианты добавим когда появится спрос — не делаем заранее.
