---
title: 보이스RSS(VoiceRSS)
description: Instructions on how to setup VoiceRSS TTS with Home Assistant.
logo: voicerss.png
ha_category:
  - Text-to-speech
ha_release: 0.35
---

`voicerss` 텍스트 음성 변환 플랫폼은 [VoiceRSS](http://www.voicerss.org/) Text-to-Speech 엔진을 사용하여 자연스럽게 들리는 음성으로 텍스트를 읽습니다.

## 설정

VoiceRSS로 텍스트 음성 변환을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
tts:
  - platform: voicerss
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: The API Key for VoiceRSS.
  required: true
  type: string
language:
  description: The language to use.
  required: false
  type: string
  default: "`en-us`"
codec:
  description: The audio codec.
  required: false
  type: string
  default: mp3
format:
  description: The audio sample format.
  required: false
  type: string
  default: 8khz_8bit_mono
{% endconfiguration %}

허용된 값은 [VoiceRSS API 문서](http://www.voicerss.org/api/documentation.aspx)를 확인하십시오.

## 전체 설정 사례

아래 설정 샘플은 항목이 어떻게 표시되는지 보여줍니다.

```yaml
# Example configuration.yaml entry
tts:
  - platform: voicerss
    api_key: YOUR_API_KEY
    language: 'de-de'
    codec: mp3
    format: '8khz_8bit_mono'
```

일부 media_players에는 특정 형식이 필요합니다. 예를 들어 Sonos에는 '44khz_16bit_stereo'형식이 필요합니다