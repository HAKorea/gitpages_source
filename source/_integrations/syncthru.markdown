---
title: 삼성 프린터(Samsung SyncThru Printer)
description: Instructions on how to integrate a Samsung printer providing SyncThru within Home Assistant.
logo: samsung.png
ha_category:
  - System Monitor
ha_iot_class: Local Polling
ha_release: 0.66
ha_codeowners:
  - '@nielstron'
---

Samsung SyncThru 프린터 플랫폼을 사용하면 로컬 Samsung 프린터에서 현재 데이터를 읽을 수 있습니다.

일반적으로 장치 상태, 잉크 잔량 또는 토너량 및 용지함 상태에 대한 정보를 제공합니다. 플랫폼은 지원되는 모든 부품을 자동으로 모니터링합니다.

모니터링되는 특정값을 포함하지 않으려면 `monitored_conditions` 설정을 통해 프런트 엔드에 표시할 값을 지정하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: syncthru
    resource: http://my-printer.address
    name: My Awesome Printer
```

{% configuration %}
  resource:
    description: 프린터 연결을 위한 주소. SyncThru 웹 서비스 주소와 같습니다.
    required: true
    default: false
    type: string
  name:
    description: 프린터의 사용자 지정 이름. 기본값은 "Samsung Printer"이며 친숙한 이름은 프린터 모델의 이름입니다.
    required: false
    default: Samsung Printer
    type: string
{% endconfiguration %}

다음 정보는 사용 가능한 경우 별도의 센서에 표시됩니다 : 

 - 검정, 시안, 마젠타 및 노랑 토너 충전량
 - 블랙, 시안, 마젠타 및 옐로우 드럼 상태
 - 첫 번째 ~ 다섯 번째 입력 용지함 상태
 - 첫 번째 ~ 여섯 번째 용지 출력 트레이 상태

<div class="note warning">
프린터의 언어가 영어로 설정되어 있지 않으면 이 구성요소나 그 일부가 작동하지 않을 수 있습니다.
</div>
