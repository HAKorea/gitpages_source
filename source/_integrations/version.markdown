---
title: 버전(Version)
description: Instructions on how to integrate a version sensor into Home Assistant.
ha_category:
  - Utility
ha_iot_class: Local Push
logo: home-assistant.png
ha_release: 0.52
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

현재 홈어시스턴트 버전을 표시할 수있는 `version` 센서 플랫폼.

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: version
```

{% configuration %}
name:
  description: Name to use in the frontend.
  required: false
  type: string
  default: "`Current Version` in case of `source: local`, `Latest Version` otherwise."
beta:
  description: Flag to indicate that it will check for beta versions, only supported for the sources `pypi`, `hassio` and `docker`.
  required: false
  type: boolean
  default: false
image:
  description: The image you want to check against, this is only supported for `hassio` and `docker`, see full list under.
  required: false
  type: string
  default: default
source:
  description: The source you want to check against, possible values are `local`, `pypi`, `hassio`, `haio` and `docker`.
  required: false
  type: string
  default: local
{% endconfiguration %}

### HASS.IO 및 DOCKER에 지원되는 이미지

`default`, `qemux86`, `qemux86-64`, `qemuarm`, `qemuarm-64`, `intel-nuc`, `raspberrypi`, `raspberrypi2`, `raspberrypi3`, `raspberrypi3-64`, `raspberrypi4`, `raspberrypi4-64`, `tinker`, `odroid-c2`, `odroid-xu`

## 로컬 버전을 표시하기위한 대안

이 센서는 다양한 솔루션을 통해 동일한 결과를 얻기 위한 기존 솔루션의 대안입니다. 컴맨드 라인에서 설치된 버전을 쉽게 얻을 수 있습니다.

```bash
hass --version
```

또는 **개발자 도구**의 <img src='/images/screenshots/developer-tool-about-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> **정보** 섹션으로 이동하십시오.

[`hass`](/docs/tools/hass/)가 있는 [`command_line`](/integrations/sensor.command_line/)은 현재 버전을 표시합니다.

```yaml
sensor:
  - platform: command_line
    name: Version
    command: "/home/homeassistant/bin/hass --version"
```

홈어시스턴트 [configuration](/docs/configuration/) 폴더에 있는 `.HA_VERSION`이라는 파일을 읽을 수도 있습니다.

```yaml
sensor:
  - platform: command_line
    name: Version
    command: "cat /home/homeassistant/.homeassistant/.HA_VERSION"
```

*번역 재검토 필요*

You might think that a [`rest` sensor](/integrations/rest) could work, too , but it will not as Home Assistant is not ready when the sensor gets initialized.

{% raw %}
```yaml
sensor:
  - platform: rest
    resource: http://IP_ADDRESS:8123/api/config
    name: Current Version
    value_template: '{{ value_json.version }}'
```
{% endraw %}
