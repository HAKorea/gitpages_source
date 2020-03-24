---
title: MS 텍스트음성전환(Microsoft Text-to-Speech)
description: Instructions on how to set up Microsoft Text-to-Speech with Home Assistant.
logo: microsoft.png
ha_category:
  - Text-to-speech
ha_release: 0.57
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/auJJrHgG9Mc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Microsoft` 텍스트 음성 변환 플랫폼은 [Microsoft Text-to-Speech engine](https://docs.microsoft.com/en-us/azure/cognitive-services/speech/home)을 사용하여 자연스러운 소리가 나는 텍스트를 읽습니다. 이 통합구성요소는 Cognitive Services 오퍼링의 일부이며 Bing Speech API로 알려진 API를 사용합니다. 
무료 API 키가 필요합니다. [Azure subscription](https://azure.microsoft.com)을 사용하거나 [Cognitive Services site](https://azure.microsoft.com/en-us/try/cognitive-services/)에서 API 키를 얻을 수 있습니다.

## 설정

Microsoft로 텍스트 음성 변환을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
tts:
  - platform: microsoft
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your API key.
  required: true
  type: string
language:
  description: The language to use. Note that if you set the language to anything other than the default, you will need to specify a matching voice type as well. For the supported languages check the list of [available languages](https://github.com/home-assistant/home-assistant/blob/dev/homeassistant/components/microsoft/tts.py#L20).
  required: false
  type: string
  default: "`en-us`"
gender:
  description: The gender you would like to use for the voice. Accepted values are `Female` and `Male`.
  required: false
  type: string
  default: "`Female`"
type:
  description: "The voice type you want to use. Accepted values are listed as the service name mapping [in the documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/language-support#text-to-speech)."
  required: false
  type: string
  default: "`ZiraRUS`"
rate:
  description: "Change the rate of speaking in percentage. Example values: `25`, `50`."
  required: false
  type: integer
  default: 0
volume:
  description: "Change the volume of the output in percentage. Example values: `-20`, `70`."
  required: false
  type: integer
  default: 0
pitch:
  description: "Change the pitch of the output. Example values: `high`."
  required: false
  type: string
  default: "`default`"
contour:
  description: "Change the contour of the output in percentages. This overrides the pitch setting. See the [W3 SSML specification](https://www.w3.org/TR/speech-synthesis/#pitch_contour) for what it does. Example value: `(0,0) (100,100)`."
  required: false
  type: string
region:
  description: "The region of your API endpoint. See [documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/speech-service/regions)."
  required: false
  type: string
  default: "`eastus`"
{% endconfiguration %}

  
## 전체 설정 사례

선택적 변수를 포함한 전체 설정 샘플 :

```yaml
# Example configuration.yaml entry
tts:
  - platform: microsoft
    api_key: YOUR_API_KEY
    language: en-gb
    gender: Male
    type: George, Apollo
    rate: 20
    volume: -50
    pitch: high
    contour: (0, 0) (100, 100)
    region: eastus
```
