---
title: 일회성 비밀번호(OTP)
description: Instructions on how to add One-Time Password (OTP) sensors into Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.49
ha_quality_scale: internal
---

`otp` 센서는 Google OTP를 포함하여 사용 가능한 대부분의 OTP 생성기와 호환되는 [RFC6238](https://tools.ietf.org/html/rfc6238)에 따라 일회용 암호를 생성합니다. 사용자 지정 보안 솔루션을 구축할 때 이를 사용할 수 있으며 30 초마다 변경되는 "rolling codes"를 사용할 수 있습니다.

## 설정

OTP 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: otp
    token: SHARED_SECRET_TOKEN
```

{% configuration %}
name:
  description: Name of the sensor to use in the frontend.
  required: false
  default: OTP Sensor
  type: string
token:
  description: The shared secret you use in your OTP generator (e.g., Google Authenticator on your phone).
  required: true
  type: string
{% endconfiguration %}

## 토큰 생성하기

새 센서에 대해 `token`을 생성하는 간단한 방법은 Home Assistant 가상 환경에서이 Python 코드 스니펫을 실행하는 것입니다.

```shell
$ pip3 install pyotp
$ python3 -c 'import pyotp; print("Token:", pyotp.random_base32())'
Token: IHEDPEBEVA2WVHB7
```

Docker 컨테이너에서 실행하려면 : 

```shell
$ docker exec -it home-assistant python -c 'import pyotp; print("Token:", pyotp.random_base32())'
Token: IHEDPEBEVA2WVHB7
```

토큰을 복사하여 Home Assistant 설정에 붙여 넣고 OTP 생성기에 추가하십시오. 이들이 동일한 코드를 생성하는지 확인하십시오.

<div class='note warning'>
홈어시스턴트 서버와 OTP 장치 생성기 (예: 전화기) 모두에서 시스템 시계가 정확해야합니다. 그렇지 않으면 생성된 코드가 일치하지 않습니다! 문제를 만들기 전에 NTP가 실행되고 시간을 올바르게 동기화하고 있는지 확인하십시오.
</div>
