---
title: 가스측정기(Tank Utility)
description: How to integrate Tank Utility sensors within Home Assistant.
logo: tank_utility.png
ha_category:
  - Energy
ha_release: 0.53
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/a2q4V_SjUTY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Tank Utility](https://www.tankutility.com/) 프로판 탱크 모니터를 홈어시스턴트에 추가하십시오.

## 셋업

### Authentication

Tank Utility API에 대한 인증은 [https://app.tankutility.com](https://app.tankutility.com)에 사용 된 것과 동일한 이메일 및 비밀번호 자격 증명(credentials)으로 수행됩니다.

### 장치

장치 목록의 각 항목은 24 자 문자열입니다. 이 값은 [Tank Utility devices page](https://app.tankutility.com/#/devices)의 그래프 하단에있는 **Usage Reports** 링크를 클릭하면 찾을 수 있습니다.

장치 item 값은 URL 경로의 마지막 세그먼트입니다 (예 : URL [https://app.tankutility.com/#/reports/000000000000000000000000](https://app.tankutility.com/#/reports/000000000000000000000000)는 `000000000000000000000000`을 장치 값으로 나타냅니다.

## 설정

컴포넌트를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: tank_utility
    email: YOUR_EMAIL_ADDRESS
    password: YOUR_PASSWORD
    devices:
      - 000000000000000000000000
```

{% configuration %}
email:
  description: "Your [https://app.tankutility.com](https://app.tankutility.com) email address."
  required: true
  type: string
password:
  description: "Your [https://app.tankutility.com](https://app.tankutility.com) password."
  required: true
  type: string
unit_of_measurement:
  description: All devices to monitor.
  required: true
  type: map
{% endconfiguration %}
