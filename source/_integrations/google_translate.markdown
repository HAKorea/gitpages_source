---
title: 구글 번역 TTS(Google Translate TTS)
description: Instructions on how to setup Google Translate Text-to-Speech with Home Assistant.
logo: google.png
ha_category:
  - Text-to-speech
ha_release: 0.35
ha_codeowners:
  - '@awarecan'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/hqRT2VKhxJ0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`google_translate` text-to-speech 플랫폼은 비공식 [Google Translate Text-to-Speech engine](https://translate.google.com/)을 사용하여 자연스러운 목소리와 텍스트를 읽을 수 있습니다.

<div class='note'>

0.92 릴리스 이후 `google`에서 `google_translate`로 이름이 바뀌었습니다.  

</div>

## 설정

Google에서 텍스트 음성 변환을 사용하려면 `configuration.yaml`에 다음 행을 추가하십시오. :

```yaml
# Example configuration.yaml entry
tts:
  - platform: google_translate
```

{% configuration %}
language:
  description: "사용할 언어."
  required: false
  type: string
  default: "`en`"
{% endconfiguration %}

[지원되는 언어의 전체 목록](https://translate.google.com/intl/en_ALL/about/languages/)(Google 번역에서 "talk" 기능이 활성화된 언어)를 확인하고 허용된 값을 체크하세요. 
언어 이름을 클릭할 때 URL 끝에 있는 2 digit language code를 사용하십시오.

## 전체 설정의 예

선택적 변수를 포함한 전체 설정 샘플 :

```yaml
# Example configuration.yaml entry
tts:
  - platform: google_translate
    language: 'de'
```

SSL 인증서 또는 Docker를 사용하는 경우, `base_url` 설정 변수를 `http` 통합구성요소와 함께 다음과 같이 추가해야 합니다. :

```yaml
#Example configuration.yaml entry
http:
  base_url: https://example.duckdns.org
```

## 한국어 구글 TTS 설정과 거실 환경 듣기 

네이버 ST카페의 [라라라이이이님이 설정한 설정기](https://cafe.naver.com/stsmarthome/17295)를 링크합니다. 



