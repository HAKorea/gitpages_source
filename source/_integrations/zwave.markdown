---
title: Z-Wave
description: Instructions on how to integrate your existing Z-Wave within Home Assistant.
logo: z-wave.png
ha_category:
  - Hub
  - Binary Sensor
  - Climate
  - Cover
  - Fan
  - Light
  - Lock
  - Sensor
  - Switch
featured: true
ha_iot_class: Local Push
ha_release: 0.7
ha_config_flow: true
ha_codeowners:
  - '@home-assistant/z-wave'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/BrZhsSpv3BY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Z-Wave](https://www.z-wave.com/)는 우리나라에서 [**스마트홈을 가장 먼저 시작한 통신사인 LG유플러스**](https://www.uplus.co.kr/ent/shome/SmartHomeInfo.hpi)의 장치들을 HA에서 사용할 수 있습니다. 

대신 LG유플러스에서 제공하는 자체적인 서비스는 사용할 수 없지만, 기존 [Z-WAVE LG유플러스 동글](http://www.grib-iot.com/iotdevice/iot_hub_dongle.asp)을 활용하여 HA에서 Z-WAVE 환경을 어렵지 않게 만들 수 있습니다. 

기존에 LG유플러스에서 쓰던 [플러그](https://m.blog.naver.com/activetia/220901736851), [스위치](https://www.uplus.co.kr/ent/shome/IotswiInfo.hpi), 심지어 [가스락](http://blog.naver.com/fromzip/221887786159), [도어락](https://cafe.naver.com/koreassistant/37) 까지 어렵지 않게 페어링해서 쓸 수 있습니다. 

[다모아님의 Z-WAVE USB 동글 설치기](https://cafe.naver.com/koreassistant/198)를 참조하시고 LG유플러스 USB동글에 동일하게 적용할 시 기존의 Z-WAVE 장치들을 어렵지않게 쓰실 수 있습니다. 

----------------------------------------------------------------------------------------------
이하 Z-WAVE 번역

Home Assistant의 [Z-Wave](https://www.z-wave.com/) 통합구성요소를 통해 연결된 Z-Wave 장치를 관찰하고 제어할 수 있습니다. Z-Wave 컴포넌트 사용과 설정 방법에 대한 자세한 문서는 [Z-Wave getting started section](/docs/z-wave/)을 참조하십시오.

현재 홈어시스턴트에서 다음 장치 유형이 지원됩니다.

- Binary Sensor
- [Climate](#climate)
- [Cover](#cover)
- Fan
- Light
- [Lock](#lock)
- Sensor
- Switch

## 설정 

요구 사항을 설정한 경우 다음 항목을 `configuration.yaml` 파일에 추가하십시오. :

```yaml
# Example configuration.yaml entry
zwave:
```

## Climate

Z-Wave 온도조절기 또는 HVAC 장치를 Home Assistant와 함께 사용하려면 일반적인 [Z-Wave component](/getting-started/z-wave/) 지침을 따르십시오.

<div class='note'>

팬모드 혹은 다른 작동 모드를 지원하는 온도 조절 장치는 HVAC 장치처럼 처리되며 하나의 장치로도 감지됩니다.

온도조절기가 다른 작동 모드를 지원하는 경우 각 모드마다 하나의 온도조절기 엔터티가 제공됩니다. `configuration.yaml` 파일의 사용자 정의 설정을 사용하여 설정으로 숨길 수 있습니다. 

</div>

Z-Wave 네트워크의 Climate 통합구성요소를 가능하게 하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
climate:
  - platform: zwave
```

활성화되면 Z-Wave Climate 장치를 Home Assistant에서 사용할 수 있습니다. 여러 엔티티가 작성될 수 있습니다. Remotec ZXT-120에 대해 다음 엔티티가 작성됩니다.

- `climate.remotec_zxt120_heating_1_id`: 연결된 장치를 제어할 수 있습니다. 사례는 아래를 참조.
- `sensor.remotec_zxt120_temperature_38`: 연결된 장치에 설정된 현재 온도를 반환하는 센서.

### Z-Wave Climate 장치 자동화

다음 예는 Remotec ZXT-120에 연결된 장치 모드를 Heating으로 설정하고 오후 8시 이후 24도에서 온도를 설정하도록 지시합니다. 다음을 `automation.yaml`에 추가하십시오.

```yaml
automation:
  - alias: Turn on Heater at 8pm
    trigger:
      - platform: time
        at: "20:00:00"
    action:
      - service: climate.set_hvac_mode
        data:
          entity_id: climate.remotec_zxt120_heating_1_id
          hvac_mode: Heat
      - service: climate.set_temperature
        data:
          entity_id: climate.remotec_zxt120_heating_1_39
          temperature: 24
```

일반적으로 Home Assistant에서 `homeassistant/turn_off` 서비스를 사용하여 장치를 끌 수 있습니다. Remotec ZXT-120의 경우 대신 다음과 같이 서비스를 요청해야합니다.

```yaml
automation:
  - alias: Turn off Heater at 9pm
    trigger:
      - platform: time
        at: "21:00:00"
    action:
      - service: climate.set_hvac_mode
        data:
          entity_id: climate.remotec_zxt120_heating_1_id
          hvac_mode: 'Off'
```

**Note:** 위의 예에서 단어 `Off`는 유효한 YAML이 되도록 작은 따옴표로 묶습니다.

### 테스트 (Test if it works)

Z-Wave Climate 장치가 작동하는지 테스트하는 간단한 방법은 **개발자 도구**의 <img src='/images/screenshots/developer-tool-services-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> **Service**를 사용하는 것입니다. **Available services:** 목록에서 해당 Climate 서비스를 선택하고 **Service Data** 필드에 아래 샘플과 같은 것을 입력한 다음 **CALL SERVICE**를 누릅니다.

```json
{
  "entity_id": "climate.remotec_zxt120_heating_1_id",
  "hvac_mode": "Heat"
}
```

## Cover 

Z-Wave 차고문, 블라인드, 롤러 셔터는 홈어시스턴트의 Cover로 지원됩니다.

Z-Wave Cover가 홈어시스턴트와 작동하게 하려면 일반 [Z-Wave component](#configuration)에 대한 지시 사항을 따르십시오.

특정 장치에 대해 닫기/열기의 [invert the operation](/docs/z-wave/installation/#invert_openclose_buttons)해야한다는 상황을 발견한 경우, `configuration.yaml` 파일의 Z-Wave 섹션에서 이 동작을 다음과 같이 변경할 수 있습니다. 또한 [invert percent position](/docs/z-wave/installation/#invert_percent)도 추가할 수 있습니다. 

```yaml
zwave:
  device_config:
    cover.my_cover:
      invert_openclose_buttons: true
      invert_percent: true
```

## Lock

Z-Wave Lock이 Home Assistant와 작동하게 하려면 일반 [Z-Wave component](#configuration)에 대한 지침을 따르십시오.

Z-Wave Lock은 Lock 도메인에서 3개의 서비스를 노출하여 Lock이 지원하는 경우 사용자 코드를 관리합니다. :

| Service | Description |
| ------- | ----------- |
| clear_usercode | code_slot X에서 사용자 코드를 지웁니다. 유효한 code_slots는 1-254이지만 max는 lock에 의해 정의됨 |
| get_usercode | code_slot의 lock에서 사용자 코드를 가져옵니다. Valid code_slots are 1-254이지만 max는 lock에 의해 정의됨. |
| set_usercode | code_slot Y에서 사용자 코드를 X로 설정합니다. 유효한 사용자 코드는 4자리 이상이며 max lock에 의해 정의됨. |
