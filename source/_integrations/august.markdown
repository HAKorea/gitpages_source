---
title: August 스마트 도어락
description: Instructions on how to integrate your August devices into Home Assistant.
logo: august.png
ha_category:
  - Doorbell
  - Binary Sensor
  - Camera
  - Lock
ha_release: 0.64
ha_iot_class: Cloud Polling
---

`august` 통합구성요소를 통해 [August](https://august.com/) 장치를 Home Assistant에 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Doorbell
- Binary Sensor
- Camera
- Lock

<div class='note'>
August Lock 2세대는 홈어시스턴트에 연결하려면 August Connect 또는 Doorbell이 필요합니다.
</div>

## 설정

이 모듈을 사용하려면 August 로그인 정보 (사용자 이름(전화번호 또는 이메일) 및 암호)가 필요합니다.

설정하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
august:
  login_method: phone
  username: "+16041234567"
  password: YOUR_PASSWORD
```

{% configuration %}
login_method:
  description: Method to login to your August account, either "email" or "phone". A verification code will be sent to your email or phone during setup.
  required: true
  type: string
username:
  description: The username for accessing your August account. This depends on your login_method, if login_method is email, this will be your email of the account. Otherwise, this will be your phone number.
  required: true
  type: string
password:
  description: The password for accessing your August account.
  required: true
  type: string
timeout:
  description: Timeout to wait for connections.
  required: false
  type: integer
  default: 10
{% endconfiguration %}

홈어시스턴트가 시작되면 전화번호나 이메일로 전송되는 인증 코드를 입력하라는 팝업이 나타납니다.

### Binary Sensor

August Doorbell이 있는 경우 August 구성 요소를 활성화하면 다음 센서가 표시됩니다.

- Doorbell ding sensor
- Doorbell motion sensor
- Doorbell online sensor

DoorSense와 함께 August Smart Lock이있는 경우 August 구성 요소를 활성화하면 다음 센서가 표시됩니다.

- Door sensor

### Camera

`august` 카메라 플랫폼을 사용하면 Home Assistant의 [August](https://august.com/) 장치에서 최신 카메라 이미지(동작에 의해 트리거 된)를 볼 수 있습니다.