---
title: 에코비(Ecobee)
description: Instructions for how to integrate ecobee thermostats and sensors within Home Assistant.
logo: ecobee.png
ha_category:
  - Sensor
  - Binary Sensor
  - Notifications
  - Climate
  - Weather
featured: true
ha_release: 0.9
ha_iot_class: Cloud Poll
ha_config_flow: true
ha_codeowners:
  - '@marthoc'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/wMT4TABxa7Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`ecobee` 통합구성요소를 통해 [ecobee](https://ecobee.com)온도 조절기의 센서 데이터를 제어하고 볼 수 있습니다.

## 예비 단계

이 통합구성요소를 사용하려면 ecobee의 [개발자 사이트](https://www.ecobee.com/developers/)에서 API 키를 얻어야합니다. 키(Key)를 얻으려면 온도조절기가 ecobee 웹 사이트에 등록되어 있어야합니다. (온도조절기를 설치하는 동안 이미했을 것입니다). 완료한 후 다음 단계를 수행하십시오.

1. Click on the **Become a developer** link on the [developer site](https://www.ecobee.com/developers/).
2. Log in with your ecobee credentials.
3. Accept the SDK agreement.
4. Fill in the fields.
5. Click **save**.

일반 consumer portal 에 로그인하고 오른쪽 상단에있는 overflow menu 버튼을 클릭하십시오. **Developer**라는 새로운 옵션이 표시됩니다. 이제 홈어시스턴트에 연결할 애플리케이션을 작성할 수 있습니다.

1. Select the **Developer** option from the hamburger menu.
2. Select **Create New**.
3. Give your App a name (it must be unique across all ecobee users; try your-name-or-alias-home-assistant) and a summary (which need not be unique). Neither of these are important as they are not used anywhere in Home Assistant.
4. For authorization method select **ecobee PIN**.
5. You don't need an Application Icon or Detailed Description.
6. Click **Create**.

이름 및 요약 섹션 아래에 API 키가 있습니다. 이 키를 복사하여 아래 설정 섹션에서 사용하십시오. **X**를 클릭하여 개발자 섹션을 닫습니다

## 통합구성요소 설정

Home Assistant에서 에코비 통합구성요소를 설정하려면 **설정** > **통합구성요소** 메뉴를 사용하거나 `configuration.yaml`에 항목을 추가하십시오.

### 통합구성요소 메뉴를 통한 설정

1. **설정** > **통합구성요소** 메뉴에서 **+** 를 클릭한 다음 팝업 메뉴에서 `ecobee`를 선택하십시오.
2. 팝업 상자에 ecobee.com에서 얻은 API 키를 입력하십시오.
3. 다음 팝업 상자에 [ecobee consumer portal](https://www.ecobee.com/consumerportal/index.html)에서 승인해야 하는 고유한 4자리 PIN 코드가 표시됩니다. 로그인하여 햄버거 메뉴에서 **My Apps** 을 선택하고 왼쪽에서**Add Application** 를 클릭하고 홈어시스턴트에서 PIN 코드를 입력한 다음 **Validate** 을 클릭한 다음 오른쪽 하단에 **Add Application** 을 클릭하십시오.
4. ecobee.com에서 앱을 승인한 후 홈어시스턴트로 돌아가서 **Submit**을 누르십시오. 인증에 성공하면 설정 항목이 작성되고 자동 온도 조절기 및 센서를 Home Assistant에서 사용할 수 있습니다.


### configuration.yaml에서 설정

[`configuration.yaml`](/docs/configuration/)에서 이 통합구성요소를 초기에 설정하려면 다음과 같이 API 키 (선택적 매개 변수 포함)를 추가하면됩니다.  (그러나 여전히 **통합구성요소** 메뉴를 통해 인증을 완료해야합니다.)

```yaml
# Example configuration.yaml entry
ecobee:
  api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: 에코비 API 키. 연동 초기 설정에만 필요합니다. 등록되면 제거할 수 있습니다. ecobee 포털에서 키를 취소하면 **통합구성요소** 메뉴에서 기존 `ecobee` 설정을 제거해야합니다, 이를 업데이트한 다음, 통합구성요소를 다시 설정하십시오.
  required: false
  type: string
{% endconfiguration %}

<p class='img'>
  <img src='{{site_root}}/images/screenshots/ecobee-sensor-badges.png' />
  <img src='{{site_root}}/images/screenshots/ecobee-thermostat-card.png' />
</p>

변경 사항을 적용하려면 [Home Assistant 다시 시작](/docs/configuration/#reloading-changes)합니다. 
**설정** > **통합구성요소** 메뉴에서 검색된 `ecobee` 항목 옆에 있는 **Configure**를 누르고 위의 통합구성요소 메뉴 지침에 따라 앱을 계속 승인합니다.

이 통합구성요소로 Home Assistant를 처음 다시 실행하면 [ecobee consumer portal](https://www.ecobee.com/consumerportal/index.html)에서 인증해야 하는 PIN 코드가 제공됩니다. 사이드 바의 **My Apps** 섹션에서 **Add Application**를 클릭하면됩니다.

PIN은 Ecobee 카드의 홈어시스턴트 포털에서 찾을 수 있거나 States developer tool의 **configurator.ecobee** 에서 찾을 수 있습니다. 

- 에코비 카드가 없다면, 카드가 보이지 않는 `default_view` 그룹을 사용하고 있을 수 있습니다. 이 문제를 해결하려면 `default_view` 섹션을 일시적으로 주석 처리하거나 `default_view`에 `configurator.ecobee` 통합구성요소를 추가하고 홈어시스턴트를 다시 시작할 수 있습니다.

에코비 사이트에서 PIN을 입력한 후 약 5분 정도 기다렸다가 에코비 팝업창의 맨 아래에있는 **I have authorized the app** 링크를 클릭하십시오. 모든 것이 올바르게 작동하면 Home Assistant를 다시 시작하여 모든 센서가 채워진 전체 에코비 카드를 보거나 개발자 도구의 센서 목록을 볼 수 있습니다. 이제 `default_view`를 다시 활성화하고 (비활성화해야 할 경우) 에코비 센서를 group 혹은/그리고 view로 추가할 수 있습니다. 

## 알림

에코비 알림이 Home Assistant와 작동하게 하려면 먼저 기본 에코비 통합구성요소를 로드하고 실행해야합니다. 설정이 완료되면 에코비 장치로 메시지를 보내도록 이 통합구성요소를 설정할 수 있습니다.

설치시 이 알림 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오. :

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: ecobee
```

{% configuration %}
name:
  description: 선택적 매개 변수 `name`을 설정하면 여러 알리미를 만들 수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME`에 바인딩합니다.
  required: false
  default: "`notify`"
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.

## 온도 조절기

### 개념

에코비 온도 조절기는 다음과 같은 주요 개념을 지원합니다.

_target temperature_ 는 장치가 목표하고자하는 온도입니다. 목표 온도는 현재 활성화된 climate에 의해 결정되거나 대기상태에 의해 무시될 수 있습니다. 온도 조절기가 자동 모드가 아닌 경우 단순한 목표 온도가 있습니다. 온도 조절기가 자동 HVAC 모드인 경우 한 쌍의 목표 온도가 있습니다. 목표 온도가 낮을수록 원하는 최저 온도가 결정되고 목표 온도가 높을수록 원하는 최고 온도가 결정됩니다. (온도조절장치는 가열과 냉각 사이를 전환하여 온도를 이 한계 내로 유지합니다). 

_climate_ 는 온도조절장치가 목표로 하는 사전정의된 또는 사용자정의 사전설정세트입니다. 
ecobee 온도조절기는 세 가지 사전 정의된 climate들을 제공합니다. : Home, Away, Sleep. Ecobee는 이를 _comfort settings_ 이라고합니다. 사용자는 추가 climate를 정의할 수 있습니다.

_preset_ 은 현재 활성화된 climate에 정의된 목표 온도를 덮어씁니다. 사전설정모드를 목표로 하는 온도는 사용자가 원하는 값으로 설정할 수 있고 (온도사전설정), 참조 climate(home, away, sleep, etc.)로 쓰거나, 온도 조절기에 의해 정의된 휴가시 사용하는 값으로 쓸 수도 있습니다. 모든 유지기간은 기간이 정해져 있습니다. 온도 조절기가 프로그램에 정의된 다음 climate로 전환할 때, 온도 및 climate 유지 기간이 만료됩니다. 휴가유지기간은 정의된 휴가 기간이 시작될 때 동작하고 휴가 기간이 끝나면 만료됩니다.

_away preset_ 에 있을 때, 목표 온도는 away climate에 대해 정의된 목표 온도에 의해 완전히 무시됩니다. away preset은 휴가 모드를 에뮬레이트하는 간단한 방법입니다.

_HVAC mode_ 는 에코비 온도조절기가 제공하는 현재 활성화된 작동모드입니다 : heat, auxHeatOnly, cool, auto, and off.

## 속성 

에코비 climate 엔티티에는 온도조절기의 상태를 나타내는 몇 가지 추가 속성이 있습니다.

| Name | Description |
| ---- | ----------- |
| `fan` | 팬이 현재 켜져 있거나 꺼져 있는 경우: `on` / `off`.
| `climate_mode` | 재정의가 활성화되지 않은 경우 이는 활성 상태이거나 활성 상태일 예정인 climate 모드입니다. 
| `equipment_running` | 현재 실행중인 장비를 쉼표로 구분한 목록입니다.
| `fan_min_on_time` | 팬이 시간당 실행되는 최소시간(분)입니다. 이는 에코비앱 또는 온도조절기 자체에서 변경할 수 있는 최소 팬 런타임 설정에 의해 결정됩니다.

## 서비스

홈어시스턴트 [Climate](/integrations/climate/) 통합구성요소에서 제공하는 표준 서비스 외에 ecobee 통합구성요소에서는 다음과 같은 추가 서비스가 제공됩니다.

- `ecobee.create_vacation`
- `ecobee.delete_vacation`
- `ecobee.resume_program`
- `ecobee.set_fan_min_on_time`

### `ecobee.create_vacation` 서비스

선택한 에코비 온도 조절기에 휴가(vacation)를 만듭니다.

| Service data attribute | Optional | Description                                                                                          |
| ---------------------- | -------- | ---------------------------------------------------------------------------------------------------- |
| `entity_id`            | no       | 휴가중 만들 에코비 온도 조절기                                                    |
| `vacation_name`        | no       | 만들 휴가의 이름. 온도조절기에서 고유해야합니다                                     |
| `cool_temp`            | no       | 휴가 중 냉각 온도                                                              |
| `heat_temp`            | no       | 휴가 기간 동안 난방 온도                                                              |
| `start_date`           | yes      | 휴가가 YYYY-MM-DD 형식으로 시작되는 날짜                                                        |
| `start_time`           | yes      | 현지 시간대로 휴가가 시작되는 시간. 24시간 형식 (HH:MM:SS)        |
| `end_date`             | yes      | 휴가가 YYYY-MM-DD 형식으로 끝나는 날짜 (제공되지 않은 경우 지금부터 14 일)                       |
| `end_time`             | yes      | 현지 시간대로 휴가가 끝나는 시간. 24시간 형식이어야합니다 (HH:MM:SS)          |
| `fan_mode`             | yes      | 휴가 중 온도 조절기의 팬 모드 (자동 또는 켜짐) (제공되지 않은 경우 자동)                   |
| `fan_min_on_time`      | yes      | 휴가 기간 동안 매시간 (0-60) 팬을 작동시키는 최소시간(분) (제공되지 않은 경우 0) |

### `ecobee.delete_vacation` 서비스

선택한 ecobee 온도 조절기에서 휴가(vacation)를 삭제하십시오.

| Service data attribute | Optional | Description                                       |
| ---------------------- | -------- | ------------------------------------------------- |
| `entity_id`            | no       | 휴가를 삭제할 ecobee 온도 조절기 |
| `vacation_name`        | no       | 삭제할 휴가 이름                    |

### `ecobee.resume_program` 서비스

현재 활성화된 일정을 재개합니다.

| Service data attribute | Optional | Description                                                                                            |
| ---------------------- | -------- | ------------------------------------------------------------------------------------------------------ |
| `entity_id`            | yes      | 제어할 climate 장치의 `entity_id`를 가리키는 문자열 또는 문자열 목록. 그렇지 않으면 모두를 목표로합니다. |
| `resume_all`           | no       | true 혹은 false                                                                                          |

### `ecobee.set_fan_min_on_time` 서비스

시간당 팬이 작동하는 최소 시간을 설정합니다. 

| Service data attribute | Optional | Description                                                                                            |
| ---------------------- | -------- | ------------------------------------------------------------------------------------------------------ |
| `entity_id`            | yes      | 제어할 climate 장치의 `entity_id`를 가리키는 문자열 또는 문자열 목록. 그렇지 않으면 모두를 목표로합니다. |
| `fan_min_on_time`      | no       | 정수 (예: 5)                                                                                       |
