# 🎬 Video-модели Createya

> Этот файл синхронизируется автоматически раз в неделю с [createya.ai/v1/models](https://api.createya.ai/v1/models).  
> Последнее обновление: 2026-04-29  
> **78 endpoint'ов в 14 семействах моделей**

Полный каталог с интерактивными примерами и подробным описанием — на сайте: [**createya.ai/knowledge**](https://createya.ai/knowledge).

---

## 🌟 Главные семейства моделей

Опубликованные модели с подробной KB-статьёй:

| Модель | Слоган | Подробнее |
|---|---|---|
| **Kling Video O3** | Reference. Clone. Direct. | [createya.ai/knowledge/kling-video-o3](https://createya.ai/knowledge/kling-video-o3) |
| **Kling Video V3** | Direct. Cut. Create. | [createya.ai/knowledge/kling-video-v3](https://createya.ai/knowledge/kling-video-v3) |
| **Kling VIDEO 4K** | Кино-качество в каждом кадре | [createya.ai/knowledge/kling-video-4k](https://createya.ai/knowledge/kling-video-4k) |
| **Veo 3.1** | Think Film. Generate Film. | [createya.ai/knowledge/veo](https://createya.ai/knowledge/veo) |
| **Veo 3.1 Fast** | Same Vision. Five Times Faster. | [createya.ai/knowledge/veo-fast](https://createya.ai/knowledge/veo-fast) |
| **Sora 2** | Imagine. Describe. Watch. | [createya.ai/knowledge/sora-2](https://createya.ai/knowledge/sora-2) |
| **Happy Horse 1.0** | Видео №1 в мире. Со звуком. За 10 секунд. | [createya.ai/knowledge/happy-horse](https://createya.ai/knowledge/happy-horse) |
| **Seedance 2.0** | Кино из одного промпта — звук, кадры, движение | [createya.ai/knowledge/seedance-2-0](https://createya.ai/knowledge/seedance-2-0) |
| **Seedance 1.5** | Move. Dance. Create. | [createya.ai/knowledge/seedance](https://createya.ai/knowledge/seedance) |

---

## 📋 Полный список endpoint'ов (78 версий)

Каждое семейство имеет несколько вариантов — обычные / быстрые / pro / max версии + разные режимы (text-to-image, image-to-image и т.д.).

> 💡 В `run_model` / `POST /v1/run` можно передать **family slug** (например `Flux`) — сервер сам выберет правильный endpoint по содержимому `input` (наличие `image_url`, `start_image_url+end_image_url` и т.п.). Можно передать и конкретный endpoint slug если нужна точная версия.

### Kling Video (`kling-video`) — 20 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-kling-video-o3-pro-image-to-video` | Image to Video (O3 Pro Image-To-Video) |
| `fal-ai-kling-video-o3-pro-reference-to-video` | Image to Video (O3 Pro Reference-To-Video) |
| `fal-ai-kling-video-o3-pro-text-to-video` | O3 Pro Text-To-Video |
| `fal-ai-kling-video-o3-pro-video-to-video-edit` | Image to Video (O3 Pro Video-To-Video Edit) |
| `fal-ai-kling-video-o3-pro-video-to-video-reference` | Image to Video (O3 Pro Video-To-Video Reference) |
| `fal-ai-kling-video-o3-standard-image-to-video` | kling-video o3 standard image-to-video |
| `fal-ai-kling-video-o3-standard-reference-to-video` | kling-video o3 standard reference-to-video |
| `fal-ai-kling-video-o3-standard-text-to-video` | kling-video o3 standard text-to-video |
| `fal-ai-kling-video-o3-standard-video-to-video-edit` | kling-video o3 standard video-to-video edit |
| `fal-ai-kling-video-o3-standard-video-to-video-reference` | kling-video o3 standard video-to-video reference |
| `fal-ai-kling-video-v2.6-pro-image-to-video` | V2.6 Pro Image-To-Video |
| `fal-ai-kling-video-v2.6-pro-motion-control` | Video to V2.6 Pro Motion-Control |
| `fal-ai-kling-video-v2.6-pro-text-to-video` | V2.6 Pro Text-To-Video |
| `fal-ai-kling-video-v2.6-standard-motion-control` | Video to V2.6 Standard Motion-Control |
| `fal-ai-kling-video-v3-pro-image-to-video` | V3 Pro Image-To-Video |
| `fal-ai-kling-video-v3-pro-motion-control` | Image to Video (V3 Pro Motion-Control) |
| `fal-ai-kling-video-v3-pro-text-to-video` | V3 Pro Text-To-Video |
| `fal-ai-kling-video-v3-standard-image-to-video` | V3 Standard Image-To-Video |
| `fal-ai-kling-video-v3-standard-motion-control` | Image to Video (V3 Standard Motion-Control) |
| `fal-ai-kling-video-v3-standard-text-to-video` | V3 Standard Text-To-Video |

### VEO (`veo3.1`) — 12 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-veo3.1` | fal-ai veo3.1 |
| `fal-ai-veo3.1-extend-video` | veo3.1 extend-video |
| `fal-ai-veo3.1-fast` | veo3.1 fast |
| `fal-ai-veo3.1-fast-extend-video` | veo3.1 fast extend-video |
| `fal-ai-veo3.1-fast-first-last-frame-to-video` | veo3.1 fast first-last-frame-to-video |
| `fal-ai-veo3.1-fast-image-to-video` | veo3.1 fast image-to-video |
| `fal-ai-veo3.1-first-last-frame-to-video` | First-Last-Frame-To-Video |
| `fal-ai-veo3.1-image-to-video` | veo3.1 image-to-video |
| `fal-ai-veo3.1-lite` | veo3.1 lite |
| `fal-ai-veo3.1-lite-first-last-frame-to-video` | veo3.1 lite first-last-frame-to-video |
| `fal-ai-veo3.1-lite-image-to-video` | veo3.1 lite image-to-video |
| `fal-ai-veo3.1-reference-to-video` | veo3.1 reference-to-video |

### Minimax (`minimax`) — 11 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-minimax-hailuo-02-fast-image-to-video` | minimax 02 fast image-to-video |
| `fal-ai-minimax-hailuo-02-pro-image-to-video` | minimax hailuo 02 pro image-to-video |
| `fal-ai-minimax-hailuo-02-pro-text-to-video` | minimax 02 pro text-to-video |
| `fal-ai-minimax-hailuo-02-standard-image-to-video` | minimax hailuo-02 standard image-to-video |
| `fal-ai-minimax-hailuo-02-standard-text-to-video` | minimax 02 standard text-to-video |
| `fal-ai-minimax-hailuo-2.3-fast-pro-image-to-video` | minimax 2.3-Fast Pro Image-To-Video |
| `fal-ai-minimax-hailuo-2.3-fast-standard-image-to-video` | minimax hailuo 2.3 fast standard image-to-video |
| `fal-ai-minimax-hailuo-2.3-pro-image-to-video` | minimax 2.3 pro image-to-video |
| `fal-ai-minimax-hailuo-2.3-pro-text-to-video` | minimax 2.3 pro text-to-video |
| `fal-ai-minimax-hailuo-2.3-standard-image-to-video` | minimax 2.3 standard image-to-video |
| `fal-ai-minimax-hailuo-2.3-standard-text-to-video` | minimax 2.3 standard text-to-video |

### Seedance (`bytedance-seedance`) — 8 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `bytedance-seedance-2.0-fast-image-to-video` | bytedance/seedance-2.0/fast/image-to-video |
| `bytedance-seedance-2.0-fast-reference-to-video` | bytedance/seedance-2.0/fast/reference-to-video |
| `bytedance-seedance-2.0-fast-text-to-video` | bytedance/seedance-2.0/fast/text-to-video |
| `bytedance-seedance-2.0-image-to-video` | bytedance/seedance-2.0/image-to-video |
| `bytedance-seedance-2.0-reference-to-video` | bytedance/seedance-2.0/reference-to-video |
| `bytedance-seedance-2.0-text-to-video` | bytedance/seedance-2.0/text-to-video |
| `fal-ai-bytedance-seedance-v1.5-pro-image-to-video` | Image to Video (Seedance V1.5 Pro Image-To-Video) |
| `fal-ai-bytedance-seedance-v1.5-pro-text-to-video` | Seedance V1.5 Pro Text-To-Video |

### Wan (`v2.6`) — 7 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-wan-25-preview-image-to-video` | fal-ai/wan-25-preview/image-to-video |
| `fal-ai-wan-25-preview-text-to-video` | fal-ai/wan-25-preview/text-to-video |
| `wan-v2.6-image-to-video` | wan v2.6 image-to-video |
| `wan-v2.6-image-to-video-flash` | wan v2.6 image-to-video flash |
| `wan-v2.6-reference-to-video` | wan v2.6 reference-to-video |
| `wan-v2.6-reference-to-video-flash` | wan v2.6 reference-to-video flash |
| `wan-v2.6-text-to-video` | wan v2.6 text-to-video |

### Grok Video (`grok-imagine-video`) — 5 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `xai-grok-imagine-video-edit-video` | grok imagine video edit-video |
| `xai-grok-imagine-video-extend-video` | Extend-Video |
| `xai-grok-imagine-video-image-to-video` |  grok-imagine-video image-to-video |
| `xai-grok-imagine-video-reference-to-video` | Reference-To-Video |
| `xai-grok-imagine-video-text-to-video` | grok imagine video text-to-video |

### Happy Horse (`happy-horse`) — 4 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `alibaba-happy-horse-image-to-video` | alibaba/happy-horse/image-to-video |
| `alibaba-happy-horse-reference-to-video` | alibaba/happy-horse/reference-to-video |
| `alibaba-happy-horse-text-to-video` | alibaba/happy-horse/text-to-video |
| `alibaba-happy-horse-video-edit` | alibaba/happy-horse/video-edit |

### Sora (`sora-2`) — 4 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-sora-2-image-to-video` | fal-ai/sora-2/image-to-video |
| `fal-ai-sora-2-image-to-video-pro` | fal-ai/sora-2/image-to-video/pro |
| `fal-ai-sora-2-text-to-video` | sora-2 text-to-video |
| `fal-ai-sora-2-text-to-video-pro` | fal-ai/sora-2/text-to-video/pro |

### RunWay (`RunWay-video`) — 2 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `runwayml-gen4-aleph` | runwayml/gen4-aleph |
| `runwayml-gen4-turbo` | runwayml/gen4-turbo |

### Higgsfield Video (`dop`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `higgsfield-dop-image-to-video` | higgsfield dop image-to-video |

### Infinitetalk (`infinitetalk`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `wavespeed-ai-infinitetalk` | wavespeed-ai/infinitetalk |

### Midjourney Video (`Midjourney-image-to-video`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `midjourney-image-to-video` | midjourney/image-to-video |

### Suno (`suno`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `music-video` | Create Music Video |

### Sync Lipsync V3 (`sync-lipsync`) — 1 endpoint'ов

| Endpoint slug | Описание |
|---|---|
| `fal-ai-sync-lipsync-v3` | fal-ai/sync-lipsync/v3 |
