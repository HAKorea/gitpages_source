---
title: 오픈TTS(MaryTTS)
description: Instructions on how to setup MaryTTS with Home Assistant.
logo: marytts.png
ha_category:
  - Text-to-speech
ha_release: 0.43
---

`marytts` 텍스트 음성 변환 플랫폼은 [MaryTTS](http://mary.dfki.de/) 텍스트 음성 변환 엔진을 사용하여 자연스러운 소리의 음성으로 텍스트를 읽습니다.

## 설정

MaryTTS로 텍스트 음성 변환을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
tts:
  - platform: marytts
```

{% configuration %}
host:
  description: The MaryTTS server hostname or IP address.
  required: false
  type: string
  default: localhost
port:
  description: The MaryTTS server port.
  required: false
  type: integer
  default: 59125
codec:
  description: "The audio codec. Supported codecs are `aiff`, `au` and `wav`."
  required: false
  type: string
  default: "`wav`"
voice:
  description: The speaker voice.
  required: false
  type: string
  default: "`cmu-slt-hsmm`"
language:
  description: "The language to use. Supported languages are `de`, `en-GB`, `en-US`, `fr`, `it`, `lb`, `ru`, `sv`, `te` and `tr`."
  required: false
  type: string
  default: "`en-US`"
{% endconfiguration %}

자세한 것은 [documentation](http://mary.dfki.de/documentation/index.html)를 참조하십니오.

## 전체 설정 사례

선택적 변수를 포함한 전체 설정 샘플 :

```yaml
# Example configuration.yaml entry
tts:
  - platform: marytts
    host: 'localhost'
    port: 59125
    codec: 'wav'
    voice: 'cmu-slt-hsmm'
    language: 'en-US'
```
