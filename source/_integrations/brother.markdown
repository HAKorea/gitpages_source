---
title: 브라더 프린터(Brother printer)
description: Instructions on how to integrate a Brother printer into Home Assistant.
logo: brother.png
ha_category:
  - System Monitor
ha_release: 0.104
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@bieniu'
---

`Brother Printer` 통합구성요소는 로컬 브라더 프린터에서 현재 데이터를 읽을 수 있습니다.

The integration monitors every supported part.
일반적으로 장치 상태, 남은 잉크 량 또는 토너 및 드럼 또는 프린터의 다른 부품의 남은 수명에 대한 정보를 제공합니다. 통합구성요소는 지원되는 모든 부분을 모니터링합니다.

## 설정

설치에 `Brother Printer`를 추가하려면 UI에서 **설정** >> **통합구성요소**로 이동하여 `+`기호가 있는 단추를 클릭하고 통합구성요소 목록에서 **Brother Printer**를 선택하십시오.

<div class="note warning">

일부 구형 Brother 프린터는 다른 데이터 형식을 사용하며 이러한 모델은 지원되지 않습니다. 통합은 구성 중에 이에 대한 정보를 표시합니다.

</div>
