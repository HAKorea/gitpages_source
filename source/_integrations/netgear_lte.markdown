---
title: 넷기어 LTE(Netgear LTE)
description: Instructions on how to integrate your Netgear LTE modem within Home Assistant.
logo: netgear.png
ha_release: 0.72
ha_category:
  - Network
  - Notifications
  - Sensor
  - Binary Sensor
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/KCrGikV9w3g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Home Assistant 용 Netgear LTE 통합구성요소로 [Netgear LTE 모뎀](https://www.netgear.com/home/products/mobile-broadband/lte-modems/default.aspx)을 관찰하고 제어할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :

- Notifications
- Sensors
- Binary Sensors

이 통합구성요소는 SMS로 알림 전송, 이벤트로 수신 SMS보고 및 여러 센서 및 이진 센서에서 모뎀 및 연결 상태보고를 지원합니다.

<div class='note'>

긴 SMS 메시지 분할은 지원되지 않으므로 알림에 최대 70자를 사용할 수 있습니다. 축소된 GSM-7 알파벳을 사용하는 간단한 메시지는 최대 160자를 포함 할 수 있습니다. 대부분의 이모티콘이 지원되지 않습니다.

</div>


## 설정

연동을 가능하게하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
netgear_lte:
  - host: IP_ADDRESS
    password: SECRET
    notify:
      - name: sms
        recipient: "+15105550123"
    sensor:
      monitored_conditions:
        - usage
        - sms
    binary_sensor:
      monitored_conditions:
        - wire_connected
        - mobile_connected
```

{% configuration %}
host:
  description: The IP address of the modem web interface.
  required: true
  type: string
password:
  description: The password used for the modem web interface.
  required: true
  type: string
notify:
  description: A list of notification services connected to this specific host.
  required: false
  type: list
  keys:
    recipient:
      description: The phone number of a default recipient or a list with multiple recipients.
      required: false
      type: [string, list]
    name:
      description: The name of the notification service.
      required: false
      default: "`netgear_lte`"
      type: string
sensor:
  description: Configuration options for sensors.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: Sensor types to create.
      required: false
      default: usage
      type: list
      keys:
        cell_id:
          description: The Cell ID, a number identifying the base station.
        connection_text:
          description: A connection text, e.g., "4G".
        connection_type:
          description: The connection type, e.g., "IPv4Only".
        current_band:
          description: The radio band used, e.g., "LTE B3".
        current_ps_service_type:
          description: The service type, e.g. "LTE".
        radio_quality:
          description: A number with the radio quality in percent, e.g., "55"
        register_network_display:
          description: The name of the service provider.
        rx_level:
          description: The RSRP value, a measurement of the received power level, e.g., "-95".
        sms:
          description: Number of unread SMS messages in the modem inbox.
        sms_total:
          description: Number of SMS messages in the modem inbox.
        tx_level:
          description: Transmit power, e.g., "23".
        upstream:
          description: Current upstream connection, "WAN" or "LTE".
        usage:
          description: Amount of data transferred.
binary_sensor:
  description: Configuration options for binary sensors.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: Binary sensor types to create.
      required: false
      default: mobile_connected
      type: list
      keys:
        mobile_connected:
          description: The LTE connection state.
        wire_connected:
          description: The wired uplink connection state.
        roaming:
          description: The current roaming state.
{% endconfiguration %}

## 이벤트

### `netgear_lte_sms` 이벤트

모뎀의 inbox에 도착한 메시지는 다음 내용과 함께 'netgear_lte_sms' 유형의 이벤트로 전송됩니다.

| Event data attribute | Description                              |
| -------------------- | ---------------------------------------- |
| `host`               | The modem that received the message.
| `sms_id`             | The inbox ID of the received message.
| `from`               | The sender of the message.
| `message`            | The SMS message content.

## 서비스

### `netgear_lte.connect_lte` 서비스

이 서비스는 모뎀이 자동 연결되지 않은 경우 유용한 LTE 연결 설정을 모뎀에 요청합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `host`                 | yes      | The modem that should connect (optional when just one modem is configured).

### `netgear_lte.disconnect_lte` 서비스

이 서비스는 모뎀이 LTE 연결을 닫도록 요청합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `host`                 | yes      | The modem that should disconnect (optional when just one modem is configured).

### `netgear_lte.delete_sms` 서비스

통합구성요소는 모뎀의 inbox에서 메시지를 삭제하는 서비스를 제공합니다. 수신 SMS 이벤트 후 정리하는데 사용할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `host`                 | yes      | The modem that should have a message deleted (optional when just one modem is configured).
| `sms_id`               | no       | Integer or list of integers with inbox IDs of messages to delete.

### `netgear_lte.set_option` 서비스

이 서비스는 모뎀 설정 옵션 (모뎀 웹 UI에서 사용 가능)을 설정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `host`                 | yes      | The modem to set options on (optional when just one modem is configured).
| `autoconnect`          | yes      | Autoconnect value: `never`/`home`/`always`, with `home` meaning "not roaming".
| `failover`             | yes      | Failover mode: `wire` (wired connection only), `mobile` (mobile connection only), `auto` (wired connection with failover to mobile connection).

## 사례

다음 자동화 예제는 [Conversation](/integrations/conversation/) 연동으로 수신 SMS 메시지를 처리​​한 다음 받은 편지함(inbox)에서 메시지를 삭제합니다.

{% raw %}
```yaml
automation:
  - alias: SMS conversation
    trigger:
      - platform: event
        event_type: netgear_lte_sms
    action:
      - service: conversation.process
        data_template:
          text: '{{ trigger.event.data.message }}'
      - service: netgear_lte.delete_sms
        data_template:
          host: '{{ trigger.event.data.host }}'
          sms_id: '{{ trigger.event.data.sms_id }}'
```
{% endraw %}
