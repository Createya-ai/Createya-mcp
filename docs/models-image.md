# 🖼 Image-модели Createya

> Этот файл синхронизируется автоматически раз в неделю с [createya.ai/v1/models](https://api.createya.ai/v1/models).  
> Последнее обновление: 2026-04-29  
> **70 endpoint'ов в 18 семействах моделей**

Полный каталог с интерактивными примерами и подробным описанием — на сайте: [**createya.ai/knowledge**](https://createya.ai/knowledge).

---

## 🌟 Главные семейства моделей

Опубликованные модели с подробной KB-статьёй:

| Модель | Слоган | Подробнее |
|---|---|---|
| **FLUX 2** | See More. Create Better. | [createya.ai/knowledge/flux-2](https://createya.ai/knowledge/flux-2) |
| **Flux Kontext** | Edit. Refine. Perfect. | [createya.ai/knowledge/flux-kontext](https://createya.ai/knowledge/flux-kontext) |
| **GPT Image 2.0** | Первая AI, которая думает перед тем как нарисовать | [createya.ai/knowledge/gpt-image-2-0](https://createya.ai/knowledge/gpt-image-2-0) |
| **GPT Image** | Say It. See It. | [createya.ai/knowledge/gpt-image](https://createya.ai/knowledge/gpt-image) |
| **Kling Image O3** | Think. Compose. Create. | [createya.ai/knowledge/kling-image-o3](https://createya.ai/knowledge/kling-image-o3) |
| **Higgsfield Soul** | Shot, Not Generated. | [createya.ai/knowledge/higgsfield-soul](https://createya.ai/knowledge/higgsfield-soul) |
| **Midjourney** | Art Beyond Imagination. | [createya.ai/knowledge/midjourney](https://createya.ai/knowledge/midjourney) |
| **Nano Banana 2** | Faster. Sharper. Smarter. | [createya.ai/knowledge/nano-banana-2](https://createya.ai/knowledge/nano-banana-2) |
| **Grok Imagine** | Imagine Without Limits. | [createya.ai/knowledge/grok-imagine](https://createya.ai/knowledge/grok-imagine) |
| **Runway Gen-4** | From Still to Motion. | [createya.ai/knowledge/runway-gen4](https://createya.ai/knowledge/runway-gen4) |

---

## 📋 Полный список endpoint'ов (70 версий)

Каждое семейство имеет несколько вариантов — обычные / быстрые / pro / max версии + разные режимы (text-to-image, image-to-image и т.д.).

> 💡 В `run_model` / `POST /v1/run` можно передать **family slug** (например `Flux`) — сервер сам выберет правильный endpoint по содержимому `input` (наличие `image_url`, `start_image_url+end_image_url` и т.п.). Можно передать и конкретный endpoint slug если нужна точная версия.

### FLUX (`Flux`) — 18 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-flux-2` | Flux 2 T2I |
| `fal-ai-flux-2-edit` | Flux 2 I2I |
| `fal-ai-flux-2-flash` | Flux 2 T2I Flash |
| `fal-ai-flux-2-flash-edit` | Flux 2 I2I Flash |
| `fal-ai-flux-2-flex` | Flux 2 Flex T2I |
| `fal-ai-flux-2-flex-edit` | Flux 2 Flex I2I |
| `fal-ai-flux-2-max` | Flux 2 Max T2I |
| `fal-ai-flux-2-max-edit` | Flux 2 Max I2I |
| `fal-ai-flux-2-pro` | Flux 2 Pro T2I |
| `fal-ai-flux-2-pro-edit` | Flux 2 Pro I2I |
| `fal-ai-flux-2-turbo` | Flux 2 T2I Turbo |
| `fal-ai-flux-2-turbo-edit` | Flux 2 I2I Turbo |
| `fal-ai-flux-pro-kontext` | Flux Kontext Pro I2I |
| `fal-ai-flux-pro-kontext-max` | Flux Kontext Max I2I |
| `fal-ai-flux-pro-kontext-max-multi` | Flux Kontext Max Multi I2I |
| `fal-ai-flux-pro-kontext-max-text-to-image` | Flux Kontext Max T2I |
| `fal-ai-flux-pro-kontext-multi` | Flux Kontext Pro Multi I2I |
| `fal-ai-flux-pro-kontext-text-to-image` | Flux Kontext Pro T2I |

### Wan (`wan-image`) — 8 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-wan-25-preview-image-to-image` | Wan 2.5 (Image-To-Image) |
| `fal-ai-wan-25-preview-text-to-image` | Wan 2.5 text-to-image |
| `fal-ai-wan-v2.7-edit` | wan v2.7 edit |
| `fal-ai-wan-v2.7-pro-edit` | wan v2.7 pro edit |
| `fal-ai-wan-v2.7-pro-text-to-image` | wan v2.7 pro text-to-image |
| `fal-ai-wan-v2.7-text-to-image` | wan v2.7 text-to-image |
| `wan-v2.6-image-to-image` | Wan 2.6  (Image-To-Image) |
| `wan-v2.6-text-to-image` | Wan 2.6 (Text-To-Image) |

### Nano Banana (`nano-banana`) — 6 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-nano-banana` | Text to Image Standart |
| `fal-ai-nano-banana-2` | Text to Image |
| `fal-ai-nano-banana-2-edit` | Image to Image (Edit) |
| `fal-ai-nano-banana-edit` | Image to Image Standart |
| `fal-ai-nano-banana-pro` | Text to Image |
| `fal-ai-nano-banana-pro-edit` | Image to Image (Edit) |

### Seedream (`bytedance-seedream`) — 6 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-bytedance-seedream-v4-edit` | bytedance seedream v4 edit |
| `fal-ai-bytedance-seedream-v4-text-to-image` | bytedance seedream v4 text-to-image |
| `fal-ai-bytedance-seedream-v4.5-edit` | Image to Image (Seedream V4.5 Edit) |
| `fal-ai-bytedance-seedream-v4.5-text-to-image` | Seedream V4.5 Text-To-Image |
| `fal-ai-bytedance-seedream-v5-lite-edit` | Image to Image (Seedream V5 Lite Edit) |
| `fal-ai-bytedance-seedream-v5-lite-text-to-image` | Seedream V5 Lite Text-To-Image |

### Ideogram (`ideogram`) — 5 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-ideogram-v3` | fal-ai/ideogram/v3 |
| `fal-ai-ideogram-v3-edit` | Image to Image (V3 Edit) |
| `fal-ai-ideogram-v3-reframe` | Image to Image (V3 Reframe) |
| `fal-ai-ideogram-v3-remix` | Image to Image (V3 Remix) |
| `fal-ai-ideogram-v3-replace-background` | Image to Image (V3 Replace-Background) |

### GPT Image (`gpt-image`) — 4 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-gpt-image-1.5` | Text to Image |
| `fal-ai-gpt-image-1.5-edit` | Image to Image (Edit) |
| `openai-gpt-image-2` | openai/gpt-image-2 |
| `openai-gpt-image-2-edit` | openai/gpt-image-2/edit |

### Kling image (`kling-image`) — 4 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-kling-image-o3-image-to-image` | fal-ai/kling-image/o3/image-to-image |
| `fal-ai-kling-image-o3-text-to-image` | fal-ai/kling-image/o3/text-to-image |
| `fal-ai-kling-image-v3-image-to-image` | Image to Image (V3 Image-To-Image) |
| `fal-ai-kling-image-v3-text-to-image` | V3 Text-To-Image |

### Topaz (`topaz-image`) — 4 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `topaz-image-denoise` | topaz/image/denoise |
| `topaz-image-lighting` | topaz/image/lighting |
| `topaz-image-restore` | topaz/image/restore |
| `topaz-image-sharpen` | topaz/image/sharpen |

### Imagen (`imagen`) — 3 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-imagen4-preview` | fal-ai/imagen4/preview |
| `fal-ai-imagen4-preview-fast` | Preview Fast |
| `fal-ai-imagen4-preview-ultra` | Preview Ultra |

### Grok Imagine (`grok-imagine-image`) — 2 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `xai-grok-imagine-image` | Grok Imagine T2I |
| `xai-grok-imagine-image-edit` | Grok Imagine I2I |

### RanWay (`Ranway`) — 2 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `runwayml-gen4-image` | runwayml gen4-image |
| `runwayml-gen4-image-turbo` | runwayml gen4-image-turbo |

### Recraft (`recraft`) — 2 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-recraft-v3-image-to-image` | recraft v3 image-to-image |
| `fal-ai-recraft-v3-text-to-image` | recraft v3 text-to-image |

### Angles (`Angles`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-qwen-image-edit-2511-multiple-angles` | fal-ai/qwen-image-edit-2511-multiple-angles |

### Higgsfield Soul (`higgsfield-soul`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `higgsfield-soul-image-to-image` | soul image-to-image |

### Midjourney (`Midjourney-text-to-image`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `midjourney-text-to-image` | midjourney text-to-image |

### RunWay (`RunWay-video`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `runwayml-upscale-v1` | runwayml/upscale-v1 |

### Z-Image (`kie-z-image`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `kie-z-image-text-to-image` | z-image |

### Извлечь кадр (`ffmpeg-api`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-ffmpeg-api-extract-frame` | Queue OpenAPI for fal-ai/ffmpeg-api/extract-frame |
