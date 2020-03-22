---
title: AI에어컨관리(Ambiclimate)
description: Instructions on how to integrate Ambiclimate A/C controller into Home Assistant.
logo: ambiclimate.png
ha_category: Climate
ha_release: 0.93
ha_iot_class: Cloud Polling
ha_config_flow: true
ha_codeowners:
  - '@danielhiversen'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/HnhSGdNM7UI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Ambiclimate](https://ambiclimate.com/) 에어컨 컨트롤러를 홈어시스턴트에 연동합니다.

`client_id` 및 `client_secret`을 얻으려면 [here](https://api.ambiclimate.com/clients) 응용 프로그램을 만들어야합니다.
콜백 URL은 홈어시스턴트 `base_url` + `/api/ambiclimate`로 설정해야합니다. 예를 들어 `https://example.com/api/ambiclimate`

이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
ambiclimate:
  client_id: CLIENT_ID
  client_secret: CLIENT_SECRET
```

홈어시스턴트를 다시 시작하십시오. 그런 다음 프론트 엔드로 이동하여 Ambiclimate를 승인하십시오.

{% configuration %}
client_id:
  description: Your Ambiclimate API client ID.
  required: true
  type: string
client_secret:
  description: Your Ambiclimate API client secret.
  required: true
  type: string
{% endconfiguration %}

홈어시스턴트에서 A/C를 제어하려면 Ambiclimate 앱에서 수동 모드를 선택해야합니다.

## Component 서비스

AC에서 comfort 모드를 활성화하십시오. : 

`climate.set_comfort_mode`

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `Name` | yes | String with device name.

comfort 모드에 대한 의견 보내기 :

`climate.send_comfort_feedback`

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `Name` | yes | String with device name.
| `value` | yes | Send any of the following comfort values: too_hot, too_warm, bit_warm, comfortable, bit_cold, too_cold, freezing

AC에서 temperature 모드를 활성화하십시오.

`climate.set_temperature_mode`

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `Name` | yes | String with device name.
| `value` | yes | Target value in celsius
