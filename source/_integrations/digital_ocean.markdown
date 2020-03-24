---
title: 디지털 오션(Digital Ocean)
description: Instructions on how to integrate the Digital Ocean within Home Assistant.
ha_category:
  - System Monitor
  - Binary Sensor
  - Switch
ha_release: '0.30'
logo: digital_ocean.png
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/vHZLCahai4Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`digital_ocean` 통합구성요소를 통해 Home Assistant에서 [Digital Ocean](https://www.digitalocean.com/) droplets 정보에 액세스 할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](/integrations/digital_ocean/#binary-sensor)
- [Switch](/integrations/digital_ocean/#switch)

## 셋업

[Digital Ocean dashboard](https://cloud.digitalocean.com/settings/api/tokens)에서 API 키를 얻습니다.

## 설정

Digital Ocean droplets을 Home Assistant와 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
digital_ocean:
  access_token: YOUR_API_KEY
```

{% configuration %}
access_token:
  description: Your Digital Ocean API access token.
  required: true
  type: string
{% endconfiguration %}

## Binary Sensor

`digital_ocean` 이진 센서 플랫폼을 통해 Digital Ocean droplets을 모니터링 할 수 있습니다.

### 설정

Digital Ocean droplets을 사용하려면 먼저 [Digital Ocean hub](/integrations/digital_ocean/)를 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: digital_ocean
    droplets:
      - 'fedora-512mb-nyc3-01'
      - 'coreos-512mb-nyc3-01'
```

{% configuration %}
droplets:
  description: List of droplets you want to monitor.
  required: true
  type: list
{% endconfiguration %}

## Switch

`digital_ocean` 스위치 플랫폼을 사용하면 Digital Ocean droplets을 제어(start/stop)할 수 있습니다.

### 설정

Digital Ocean droplets을 사용하려면 먼저 [Digital Ocean hub](/integrations/digital_ocean/)를 설정한 다음 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
switch:
  - platform: digital_ocean
    droplets:
      - 'fedora-512mb-nyc3-01'
      - 'coreos-512mb-nyc3-01'
```

{% configuration %}
droplets:
  description: List of droplets you want to control.
  required: true
  type: list
{% endconfiguration %}
