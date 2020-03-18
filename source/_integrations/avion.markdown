---
title: 블루투스 조명(Avi-on)
description: Instructions on how to setup GE Avi-on Bluetooth dimmers within Home Assistant.
ha_category:
  - Light
ha_iot_class: Assumed State
logo: avi-on.png
ha_release: 0.37
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/5eJ4ZBeRrT8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Avi-on Bluetooth dimmer 스위치 [Avi-On](https://avi-on.com/) 설정 방법

## 셋업

장치를 수동으로 추가하려면 (아래 예와 같이) API 키를 가져와야합니다. API 키는 다음 명령을 실행하여 얻을 수 있습니다.

```bash
$ curl -X POST -H "Content-Type: application/json" \
    -d '{"email": "fakename@example.com", "password": "password"}' \
    https://admin.avi-on.com/api/sessions | jq
```

이메일 및 비밀번호 필드를 모바일 앱을 통해 장치를 등록할 때 사용된 것으로 입력합니다. 결과값의 암호문구 필드는 설정에서 API 키로 사용되어야합니다.

## 설정

To enable these lights, add the following lines to your `configuration.yaml` file:
이 조명을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
light:
  - platform: avion
```

이 구성 요소를 설정하는 두 가지 방법이 있습니다 : 사용자 이름 및 비밀번호 또는 장치 목록. 하나를 선택해야합니다.

{% configuration %}
username:
  description: The username used in the Avion app. If username and password are both provided, all associated switches will automatically be added to your configuration.
  required: false
  type: string
password:
  description: The password used in the Avion app.
  required: false
  type: string
devices:
  description: An optional list of devices with their Bluetooth addresses.
  required: false
  type: list
  keys:
    name:
      description: A custom name to use in the frontend.
      required: false
      type: string
    api_key:
      description: The API Key.
      required: true
      type: string
    id:
      description: The ID of the dimmer switch. Only needed for independent control of multiple devices.
      required: true
      type: string
{% endconfiguration %}

## 전체 사례

사용자 이름과 비밀번호를 제공하지 않으면 다음과 같이 장치를 수동으로 설정해야합니다.

```yaml
# Manual device configuration.yaml entry
light:
  - platform: avion
    devices:
      00:21:4D:00:00:01:
        name: Light 1
        api_key: YOUR_API_KEY
```

여러 장치를 독립적으로 제어하려면 각 장치의 ID (1부터 시작하는 정수)를 지정해야합니다. 각 스위치의 ID는 Avi-On API에서 추측해내거나 감지할 수 있습니다.

```yaml
# Manual device configuration.yaml entry
light:
  - platform: avion
    devices:
      00:21:4D:00:00:01:
        name: Light 1
        api_key: YOUR_API_KEY
        id: 1
      00:21:4D:00:00:02:
        name: Light 1
        api_key: YOUR_API_KEY
        id: 2
```
