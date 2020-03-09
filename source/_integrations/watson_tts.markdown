---
title: IBM 왓슨 TTS
description: Instructions on how to setup IBM Watson TTS with Home Assistant.
logo: watson_tts.png
ha_category:
  - Text-to-speech
ha_release: 0.94
ha_codeowners:
  - '@rutkai'
---

[IBM Watson Cloud](https://www.ibm.com/watson/services/text-to-speech/)와 함께 작동하여 음성 출력을 작성하는 `watson_tts` 텍스트 음성 변환 플랫폼입니다.
Watson은 IBM Cloud를 통한 유료 서비스이지만 매월 10000 개의 무료 문자를 제공하는 적절한 [free tier](https://www.ibm.com/cloud/watson-text-to-speech/pricing)가 있습니다.

## 셋업

지원되는 형식 및 음성은 [IBM Cloud About section](https://cloud.ibm.com/docs/services/text-to-speech?topic=text-to-speech-about#about)으로 이동하십시오.

시작하려면 [Getting started tutorial](https://cloud.ibm.com/docs/services/text-to-speech?topic=text-to-speech-gettingStarted#gettingStarted)를 읽으십시오

## 설정

Watson TTS를 설정하려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
tts:
  - platform: watson_tts
    watson_apikey: YOUR_GENERATED_APIKEY
```

IBM Cloud 콘솔에서 credentials를 생성한 후 이러한 토큰을 얻을 수 있습니다. :

<p class='img'>
  <img src='{{site_root}}/images/screenshots/watson_tts_screen.png' />
</p>

{% configuration %}
watson_url:
  description: "The endpoint to which the service will connect."
  required: false
  type: string
  default: https://stream.watsonplatform.net/text-to-speech/api
watson_apikey:
  description: "Your secret apikey generated on the IBM Cloud admin console."
  required: true
  type: string
voice:
  description: Voice name to be used.
  required: false
  type: string
  default: en-US_AllisonVoice
output_format:
  description: "Override the default output format. Supported formats: `audio/flac`, `audio/mp3`, `audio/mpeg`, `audio/ogg`, `audio/ogg;codecs=opus`, `audio/ogg;codecs=vorbis`, `audio/wav`"
  required: false
  type: string
  default: audio/mp3
{% endconfiguration %}

## 사용법

모든 `media_player` 장치 엔티티에게 말하십시오 :

```yaml
- service: tts.watson_tts_say
  data_template:
    message: 'Hello from Watson'
```

혹은

```yaml
- service: tts.watson_tts_say
  data_template:
    message: >
      <speak>
          Hello from Watson
      </speak>
```


```yaml
- service: tts.watson_tts_say
  data_template:
    entity_id: media_player.living_room
    message: >
      <speak>
          Hello from Watson
      </speak>
```

쉬고 말하세요. :

```yaml
- service: tts.watson_tts_say
  data_template:
    message: >
      <speak>
          Hello from
          <break time=".9s" />
          Watson
      </speak>
```
