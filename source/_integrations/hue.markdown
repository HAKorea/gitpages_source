---
title: 필립스 휴(Philips Hue)
description: Instructions on setting up Philips Hue within Home Assistant.
logo: philips_hue.png
ha_category:
  - Hub
  - Light
ha_iot_class: Local Polling
featured: true
ha_release: "0.60"
ha_config_flow: true
ha_quality_scale: platinum
ha_codeowners:
  - "@balloob"
---

필립스 Hue 제품군은 Wifi, Bluetooth, Zigbee 3가지 통신방식의 제품들이 존재합니다. 

그중에서 **현재 가장 많이 쓰는 통신방식은 Zigbee 제품**임으로 [Zigbee2mqtt 설치방법](https://hakorea.github.io/integrations/zha/)를 통해 필립스 Hue 제품군들을 설치하시길 권장합니다. 

zigbee2mqtt의 [필립스 Hue 장치들의 지원 목록](https://www.zigbee2mqtt.io/information/supported_devices.html#philips)을 참조하십시오. 

이외에도 Zigbee2mqtt는 2020년 2월 17일 현재 **112개 회사의 584개 장치**들을 공식 지원합니다. 

----------------------------------------------------------------------------------------------------------
이하 필립스 Hue 번역 

Philips Hue support는 조명 및 센서 플랫폼을 구동할 수 있는 허브로 Home Assistant에 통합되어 있습니다. Philips Hue 플랫폼을 설정하는 기본 방법은 [discovery component](/integrations/discovery/)를 활성화하는 것입니다.

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. : 

- 조명
- 모션 센서 (온도 및 조도 센서 포함)

일단 사용자 정의 기본 보기가 있는 경우 상태 개발자 도구 ( < > )에서 `configurator.philips_hue`를 찾아 `configuration.yaml`의 그룹에 추가하십시오. 홈어시스턴트 대시보드에 설정화면이 표시되도록 홈어시스턴트를 다시 시작하십시오. 홈어시스턴트가 다시 시작되면 `configurator.philips_hue`를 찾아 클릭하여 시작 대화 상자를 여십시오. 이렇게하면 Hue 버튼을 눌러 홈어시스턴트에 Hue 브리지를 등록하라는 메시지가 표시됩니다. 완료되면 설정 엔터티는 더 이상 필요하지 않으며 `configuration.yaml`에 나타난 그룹에서 제거 할 수 있습니다.

Home Assistant에서 Hue 브리지를 설정하면 Home Assistant [configuration directory](/docs/configuration/)의 파일에 토큰을 기록합니다. 이 토큰은 Hue 브리지와의 통신을 인증합니다. 브리지의 IP 주소가 변경되면 홈어시스턴트에 다시 등록해야합니다. 이를 방지하기 위해 라우터에서 Hue 브리지의 DHCP 예약을 설정하여 항상 동일한 IP 주소를 갖도록 할 수 있습니다

등록이 완료되면 Hue 조명이 `light` 엔티티로, Hue 모션 센서가 `binary_sensor` 엔티티로, Hue 온도 및 조도 센서(모션 센서에 내장된)가 `sensor` 엔티티로 표시됩니다. 그렇지 않으면 홈어시스턴트를 다시 한번 더 시작해야 할 수도 있습니다.

[discovery component](/integrations/discovery/)에 의존하지 않고 통합구성요소를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
hue:
  bridges:
    - host: DEVICE_IP_ADDRESS
```

{% configuration %}
host:
  description: "브리지의 IP 주소 (예 : 192.168.1.10). Hue 브리지를 발견하기 위해 `discovery` 통합구성요소를 사용하지 않는 경우 필요."
  required: true
  type: string
allow_unreachable:
  description: 이를 통해 끊어진(unreachable) 조명의 상태를 정확히 보고할 수 있습니다.
  required: false
  type: boolean
  default: false
allow_hue_groups:
  description: Hue 브리지에 정의된 그룹을 Home Assistant에서 가져오지 못하게하려면 이 기능을 비활성화.
  required: false
  type: boolean
  default: true
{% endconfiguration %}

## 예시

```yaml
# Example configuration.yaml entry specifying optional parameters
hue:
  bridges:
    - host: DEVICE_IP_ADDRESS
      allow_unreachable: true
      allow_hue_groups: true
```

### 다중 Hue 브릿지

다중 Hue 브릿지는 discovery에 명확하게 작동하므로 특별히 설정하지 않아도 됩니다.

```yaml
# Example configuration.yaml entry
hue:
  bridges:
    - host: BRIDGE1_IP_ADDRESS
    - host: BRIDGE2_IP_ADDRESS
```

### 홈 어시스턴트에서 Hue 그룹 사용

Hue API를 사용하면 조명을 그룹화 할 수 있습니다. 홈어시스턴트는 기본적으로 엔티티 그룹화를 지원하지만 때때로 Hue 그룹을 사용하여 전구를 그룹화하는 것이 유용할 수 있습니다. 이렇게하면 홈어시스턴트는 그룹의 모든 조명에 대해 한 번의 호출 대신 해당 그룹의 모든 전구 상태를 변경하기 위해 한 번의 API 호출만 보내면됩니다. 이로 인해 모든 전구가 동시에 상태가 변경됩니다.

이 Hue 그룹은 `Luminaire`, `Lightsource`, `LightGroup` 또는 `Room`이 될 수 있습니다. Hue 브리지가 감지된 전구를 기반으로 자동으로 관리하기 때문에 `Luminaire` 와 `Lightsource`를 수동으로 만들 수 없습니다. `Room` 및 `LightGroup`은 API 또는 모바일 앱을 통해 수동으로 생성할 수 있습니다. 전구는 하나의 `Room`에만 존재할 수 있지만 둘 이상의 `LightGroup`에 존재할 수도 있습니다. `LightGroup`은 특정 전구를 서로 연결하려는 경우 유용할 수 있습니다.

The 2nd generation Hue app only has the ability to create a `Room`. You need to use the first generation app or the API to create a `LightGroup`.
2세대 Hue 앱은 `Room`만 만들 수 있습니다. `LightGroup`을 만들려면 1세대 앱 또는 API를 사용해야합니다.

예시 :

조명 1,2,3를 포함하는 `Ceiling lights`라는 `LightGroup`을 만들려면 다음 명령을 실행하십시오. : 

```bash
$ curl -XPOST -d '{"name": "Ceiling lights", "lights": ["1", "2", "3"]}' http://<bridge>/api/<username>/groups
```

`<username>`은 브리지에서 홈어시스턴트를 등록하는 데 사용하는 문자열입니다. configuration\.storage 경로의 `core.config_entries` 파일에서 찾을 수 있습니다. `<bridge>`는 Hue 브릿지의 IP 주소 또는 호스트 이름입니다.

다음 명령을 실행하여 조명의 ID를 찾을 수 있습니다 : 

```bash
$ curl http://<bridge>/api/<username>/lights
```

홈어시스턴트는 새 `LightGroup`을 자동으로 감지하여 인터페이스에 추가합니다.

<div class='note warning'>
  Hue 조명 그룹을 지원하려면 브리지에 펌웨어 1.13 이상이 있어야합니다 (2016년 6월 3일 출시).
</div>

자세한 내용은 [Philips Hue API documentation](https://www.developers.meethue.com/documentation/groups-api#22_create_group)에서 확인할 수 있습니다.

### 홈 어시스턴트에서 Hue 장면(Scenes) 사용

Hue 플랫폼에는 조명 그룹의 색상을 한번에 설정하기위한 고유한 장면 개념이 있습니다. Hue 장면은 매우 저렴하고 모든 종류의 앱에서 만들 수 있으며 (동시에 2개이상의 조명을 변경하는 유일한 방법이므로) 거의 삭제되지 않습니다. 전형적인 Hue 허브에는 수백 개의 장면이 저장되어 있을겁니다.

사용자 인터페이스 과부하를 피하기 위해 장면을 직접 노출시키지 않습니다. 대신 Hue가 있습니다. hue_activate_scene 서비스는 `automation` 또는 `script` 구성요소에서 사용할 수 있습니다. 이렇게 하면 Home Assistant에서 표준 장면을 사용할 때와 같이 한 번에 하나씩이 아니라 모든 전구가 한 번에 전환됩니다.

예시 :

```yaml
script:
  porch_on:
    sequence:
      - service: hue.hue_activate_scene
        data:
          group_name: "Porch"
          scene_name: "Porch Orange"
```

| Service data attribute | Optional | Description                                                           |
| ---------------------- | -------- | --------------------------------------------------------------------- |
| `group_name`           | no       | 라이트의 그룹/룸 이름입니다. 공식 Hue 앱에서 찾으십시오. |
| `scene_name`           | no       | 장면의 이름. 공식 Hue 앱에서 찾으십시오.            |

_Note_: `group_name`은 홈어시스턴트 그룹 이름에 대한 참조가 아닙니다. Hue 앱에서 그룹/룸의 이름 만 될 수 있습니다.

### 그룹 및 장면 이름 찾기

이 이름들을 어떻게 찾습니까?

가장 쉬운 방법은 방(그룹)과 장면 이름으로 구성된 2 세대 Hue 앱의 장면만 사용하는 것입니다. 앱에 표시되는 회의실 이름 및 장면 이름 값을 사용하십시오. Home Assistant 인스턴스의 `dev-service` 콘솔을 사용하여 이러한 작업이 작동하는지 테스트할 수 있습니다.

또는이 [gist](https://gist.github.com/sdague/5479b632e0fce931951c0636c39a9578)를 사용하여 모든 룸과 장면 이름을 가져올 수 있습니다. 이는 어떤 그룹과 장면이 함께 작동하는지 알려주지는 **않지만** `dev-service` 콘솔에서 테스트 할 수 있는 값을 얻는 것으로 충분합니다.

### 경고 (Caveats)

Hue API는 장면을 직접 활성화하지 않습니다. 오히려 Hue 그룹 (일반적으로 방, 특히 2 세대 앱을 사용하는 경우)과 연결되어야 합니다. 그러나 Hue 장면은 실제로 그룹을 참조하지 않습니다. 휴리스틱 매칭(heuristic matching)이 사용됩니다.

Hue에서 그룹 이름이나 장면 이름이 고유하지는 않습니다. 홈 어시스턴트에서 Hue 장면을 호출하여 예기치 않은 동작이 관찰되는 경우 Hue 앱에서 Hue 장면의 이름을 보다 구체적으로 지정하십시오.

Hue 허브에는 장면에 대한 공간이 제한되어 있으며 새 장면이 만들어지면 해당 공간을 오버플로하는 장면을 삭제합니다. API 문서에 따르면 이것이 "최근에 사용된" 장면을 기반으로합니다.