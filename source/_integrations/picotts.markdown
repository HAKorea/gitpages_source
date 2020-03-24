---
title: 로컬 텍스트음성전환(Pico TTS)
description: Instructions on how to setup Pico Text-to-Speech with Home Assistant.
logo: home-assistant.png
ha_category:
  - Text-to-speech
ha_release: 0.36
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/bBVCpHLBctc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`picotts` 텍스트 음성 변환 플랫폼은 오프라인 피코 텍스트 음성 변환 엔진을 사용하여 자연스러운 소리의 음성으로 텍스트를 읽습니다. 
이를 위해서는 시스템에 pico tts 라이브러리를 설치해야합니다. 일반적으로 데비안에서는 `sudo apt-get install libttspico-utils`
일부 Raspbian 릴리스에서는이 패키지가 누락되었지만 debian에서 arm deb 패키지를 복사할 수 있습니다.

데비안 버스터에서 패키지가 누락되었습니다. 다음 명령을 사용하여 설치하십시오.

```bash
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico0_1.0+git20130326-9_armhf.deb
wget http://ftp.us.debian.org/debian/pool/non-free/s/svox/libttspico-utils_1.0+git20130326-9_armhf.deb
sudo apt-get install -f ./libttspico0_1.0+git20130326-9_armhf.deb ./libttspico-utils_1.0+git20130326-9_armhf.deb
```

## 설정

Pico로 텍스트 음성 변환을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
tts:
  - platform: picotts
```

{% configuration %}
language:
  description: "The language to use. Supported languages are `en-US`, `en-GB`, `de-DE`, `es-ES`, `fr-FR` and `it-IT`."
  required: false
  type: string
  default: "`en-US`"
{% endconfiguration %}

## Full configuration example

The configuration sample below shows how an entry can look like:

```yaml
# Example configuration.yaml entry
tts:
  - platform: picotts
    language: 'fr-FR'
```
