---
title: 링크시스 스마트 Wifi(Linksys Smart Wifi)
description: Instructions on how to integrate Linksys Smart Wifi Router into Home Assistant.
ha_category:
  - Presence Detection
logo: linksys.png
ha_release: 0.48
---

`linksys_smart플랫폼`은 Linksys Smart Wifi 기반 라우터에 연결된 장치를 보고 재실 감지 기능을 제공합니다.

테스트한 라우터 :

- Linksys WRT3200ACM MU-MIMO Gigabit Wi-Fi Wireless Router
- Linksys WRT1900ACS Dual-band Wi-Fi Router

## 셋업 

이 플랫폼이 올바르게 작동하려면 라우터 관리 페이지의 로컬 관리 액세스 섹션에서 "Access via wireless"기능을 비활성화해야합니다. "Access via wireless"가 비활성화되어 있지 않으면 Home Assistant 통합이 사용자 ID 및 암호를 전달하려고하지만 라우터가 암호 만 기대하기 때문에 연결 충돌이 발생합니다.

## 설정

홈 어시스턴트 설치에서 Linksys Smart Wifi 라우터를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: linksys_smart
    host: 192.168.1.1
```

{% configuration %}
host:
  description: "라우터의 호스트 이름 또는 IP 주소. (예: 192.168.1.1)"
  required: true
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오 .