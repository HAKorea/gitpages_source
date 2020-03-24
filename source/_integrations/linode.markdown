---
title: 린노드(Linode)
description: Instructions on how to set up Linode within Home Assistant.
ha_category:
  - System Monitor
  - Binary Sensor
  - Switch
logo: linode.png
ha_release: 0.57
ha_iot_class: Cloud Polling
---

+<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/gdzXNF2NYLc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`linode` 통합구성요소를 통해 Home Assistant에서 [Linode](https://linode.com) 시스템에 대한 정보에 액세스 할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Switch](#switch)

## 셋업

Linode 계정에서 oAuth2 액세스 토큰을 받으십시오.

- <http://cloud.linode.com>
- Log in
- Select API Tokens
- Create a Personal Access Token,
- Assigned scope (Please choose the least possible access required.)

## 설정

Linode를 Home Assistant와 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
linode:
  access_token: YOUR_ACCESS_TOKEN
```

{% configuration %}
  access_token:
    description: The Linode access token.
    required: true
    type: string
{% endconfiguration %}

## Binary Sensor

`linode` 이진 센서 플랫폼을 사용하면 Linode 노드를 모니터링 할 수 있습니다.

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: linode
    nodes:
      - 'myvpsname'
```

{% configuration %}
nodes:
  description:  List of VPSs you want to control.
  required: true
  type: string
{% endconfiguration %}

## Switch

`linode` 스위치 플랫폼을 사용하면 Linode 노드를 켜거나 끌 수 있습니다.

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: linode
    nodes:
      - 'myvpsname'
```

{% configuration linode %}
  nodes:
    description:  List of VPSs you want to control.
    required: true
    type: string
{% endconfiguration %}
