---
title: "IFTTT 경보 제어판"
description: "Instructions on how to integrate IFTTT-controlled security systems into Home Assistant."
logo: ifttt.png
ha_category:
  - Alarm
ha_release: 0.66
---

`ifttt` 플랫폼을 사용하면 공개 API가 없지만 [IFTTT](https://ifttt.com/discover)를 통해 제어할 수 있는 보안 시스템을 연동할 수 있습니다.

이 플랫폼은 [IFTTT](/integrations/ifttt/) 홈어시스턴트 통합구성요소에 따라 다릅니다. 해당 문서를 참조하여 설정하십시오.

<div class='note'>
이 플랫폼은 보안 시스템의 상태가 변경 될 때 IFTTT에 전적으로 의존하여 업데이트를 받습니다. 따라서 이 플랫폼은 가정 된 상태를 보여줍니다.
</div>

## 설정

이를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
ifttt:
  key: YOUR_WEBHOOK_KEY

alarm_control_panel:
  - platform: ifttt
    name: YOUR_ALARM_NAME
    code: YOUR_ALARM_CODE
    event_arm_away: YOUR_ARM_AWAY_EVENT
    event_arm_home: YOUR_ARM_HOME_EVENT
    event_arm_night: YOUR_ARM_NIGHT_EVENT
    event_disarm: YOUR_DISARM_EVENT
```

{% configuration %}
name:
  description: The name of your Home Assistant alarm control panel.
  required: false
  type: string
code:
  description: The code for the alarm control panel.
  required: false
  type: string
event_arm_away:
  description: IFTTT webhook event to call when the state is set to armed away.
  required: false
  type: string
  default: alarm_arm_away
event_arm_home:
  description: IFTTT webhook event to call when the state is set to armed home.
  required: false
  type: string
  default: alarm_arm_home
event_arm_night:
  description: IFTTT webhook event to call when the state is set to armed night.
  required: false
  type: string
  default: alarm_arm_night
event_disarm:
  description: IFTTT webhook event to call when the state is set to disarmed.
  required: false
  type: string
  default: alarm_disarm
optimistic:
  description: Specify if the state will be updated by an ifttt.push_alarm_state call (false) or can be set immediately (true).
  required: false
  type: boolean
  default: false
{% endconfiguration %}

<div class='note warning'>

암호화를 사용하지 않을 때는 이 플랫폼을 사용하지 않는 것이 좋습니다. 그렇지 않으면 API 비밀번호가 IFTTT 웹 후크를 통해 보호되지 않은 상태로 전송됩니다. [Let's Encrypt를 사용한 암호화 설정](https://home-assistant.io/blog/2017/09/27/effortless-encryption-with-lets-encrypt-and-duckdns/)을 권장합니다.

</div>

### 필요한 IFTTT 애플릿

다음으로 필요한 IFTTT 애플릿을 아래와 같이 설정해야합니다.

이 플랫폼은 `alarm_disarm`,`alarm_arm_away`, `alarm_arm_home`, `alarm_arm_night` 서비스를 지원합니다. 이러한 각 서비스에 대해 IFTTT 웹 후크가 트리거됩니다.

이 시스템이 올바르게 작동하려면 다음 IFTTT 애플릿을 설정해야합니다. 알람 장치가 일부 상태를 지원하지 않는 경우에는 애플릿을 제공할 필요가 없습니다.
* **IF** Webhook event `YOUR_DISARM_EVENT` is called, **THEN** disarm the alarm system.
* **IF** Webhook event `YOUR_ARM_HOME_EVENT` is called, **THEN** set the alarm system to armed home.
* **IF** Webhook event `YOUR_ARM_NIGHT_EVENT` is called, **THEN** set the alarm system to armed away.
* **IF** Webhook event `YOUR_DISARM_EVENT` is called, **THEN** set the alarm system to armed night.
* **IF** the alarm system was disarmed, **THEN** perform a Webhook `POST` web request to url `https://HASS_URL/api/services/ifttt/push_alarm_state?api_password=API_PASSWORD` with content type `application/json` and body `{"entity_id": "alarm_control_panel.DEVICE_NAME", "state": "disarmed"}`.
* **IF** the alarm system state changed to armed home, **THEN** perform a Webhook `POST` web request to url `https://HASS_URL/api/services/ifttt/push_alarm_state?api_password=API_PASSWORD` with content type `application/json` and body `{"entity_id": "alarm_control_panel.DEVICE_NAME", "state": "armed_home"}`.
* **IF** the alarm system state changed to armed away, **THEN** perform a Webhook `POST` web request to url `https://HASS_URL/api/services/ifttt/push_alarm_state?api_password=API_PASSWORD` with content type `application/json` and body `{"entity_id": "alarm_control_panel.DEVICE_NAME", "state": "armed_away"}`.
* **IF** the alarm system state changed to armed night, **THEN** perform a Webhook `POST` web request to url `https://HASS_URL/api/services/ifttt/push_alarm_state?api_password=API_PASSWORD` with content type `application/json` and body `{"entity_id": "alarm_control_panel.DEVICE_NAME", "state": "armed_night"}`.
