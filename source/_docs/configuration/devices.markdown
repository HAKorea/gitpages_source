---
title: "홈어시스턴트에 장치 추가"
description: "Steps to help you get your devices in Home Assistant."
redirect_from: /getting-started/devices/
---

[the discovery component](/integrations/discovery/)가 활성화된 경우 홈어시스턴트는 네트워크에서 사용 가능한 많은 장치와 서비스를 자동으로 검색할 수 있습니다. (기본 설정)

장치와 서비스에 대한 설치지침을 찾으려면 [통합구성요소 개요 페이지](/integrations/)를 참조하십시오. 즐겨 사용하는 장치 혹은 서비스에 대한 지원을 찾을 수 없으면 [지원기기 추가 고려](/developers/add_new_platform/)를 참조하십시오. 

사용 가능한 통합구성요소에 대한 분류 :

- [IoT class](/blog/2016/02/12/classifying-the-internet-of-things): 장치의 동작에 대한 분류.
- [Quality scale](/docs/quality_scale/): 연동 품질을 나타냅니다.

일반적으로 모든 entity는 `configuration.yaml` 파일에 자체 항목이 필요 합니다. 여러 항목에 대한 두 가지 스타일이 있습니다. :

## Style 1: “부모” 아래에 있는 모든 entity를 수집

```yaml
sensor:
  - platform: mqtt
    state_topic: "home/bedroom/temperature"
    name: "MQTT Sensor 1"
  - platform: mqtt
    state_topic: "home/kitchen/temperature"
    name: "MQTT Sensor 2"
  - platform: rest
    resource: http://IP_ADDRESS/ENDPOINT
    name: "Weather"

switch:
  - platform: vera
```

## Style 2: 각 장치를 개별적으로 나열

아래 예와 같이 항목을 구별하기 위해 숫자나 문자열을 추가해야합니다. 추가된 숫자 혹은 문자열은 고유해야합니다.

```yaml
sensor bedroom:
  platform: mqtt
  state_topic: "home/bedroom/temperature"
  name: "MQTT Sensor 1"

sensor kitchen:
  platform: mqtt
  state_topic: "home/kitchen/temperature"
  name: "MQTT Sensor 2"

sensor weather:
  platform: rest
  resource: http://IP_ADDRESS/ENDPOINT
  name: "Weather"

switch 1:
  platform: vera

switch 2:
  platform: vera
```

## 그룹화 장치

여러 장치를 설정한 후에는 장치를 그룹으로 구성해야합니다.
각 그룹은 이름과 entity ID 목록으로 구성됩니다. 개발자 도구 (<img src='/images/screenshots/developer-tool-states-icon.png' alt='service developer tool icon' class="no-shadow" height="38" />) 의 상태 설정 페이지를 사용하여 웹인터페이스에서 entity ID를 검색할 수 있습니다. 

```yaml
# Example configuration.yaml entry showing two styles
group:
  living_room:
    entities: light.table_lamp, switch.ac
  bedroom:
    entities:
      - light.bedroom
      - media_player.nexus_player
```

자세한 내용은 [Group](/integrations/group/) 페이지를 참고하십시오.
