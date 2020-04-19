---
title: MySensors
description: Instructions on how to integrate MySensors sensors into Home Assistant.
logo: mysensors.png
ha_category:
  - DIY
ha_iot_class: Local Push
ha_release: 0.73
ha_codeowners:
  - '@MartinHjelmare'
---

<div class='videoWrapper'>
<iframe width="1250" height="713" src="https://www.youtube.com/embed/RwMASJiN7uA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[MySensors](https://www.mysensors.org) 프로젝트는 Arduino, ESP8266, Raspberry Pi, NRF24L01+, RFM69와 같은 장치를 결합하여 저렴한 센서 네트워크를 구축합니다. 이 통합구성요소는 [presentation](#presentation)이 완료된 후 사용 가능한 모든 장치를 Home Assistant에 자동으로 추가합니다. 즉, 장치를 추가하기 위해 설정에 아무것도 추가하지 않아도됩니다. 식별된 장치를 찾으려면 개발자 도구의 **상태** 섹션으로 이동하십시오.

### 설정

`configuration.yaml` 파일에 다음을 추가하여 직렬(Serial), 이더넷(LAN) 또는 MQTT MySensors 게이트웨이를 연동하십시오.

```yaml
# Example configuration.yaml entry
mysensors:
  gateways:
    - device: '/dev/ttyUSB0'
```

{% configuration %}
  gateways:
    description: A list of gateways to set up.
    required: true
    type: map
    keys:
      device:
        description: The path to the serial gateway where it is connected to your Home Assistant host, or the address of the TCP Ethernet gateway, or `mqtt` to setup the MQTT gateway. Resolving DNS addresses is theoretically supported but not tested.
        required: true
        type: string
      baud_rate:
        description: Specifies the baud rate of the connected serial gateway.
        required: false
        type: integer
        default: 115200
      persistence_file:
        description: The path to a file to save sensor information. The file extension determines the file type. Currently supported file types are 'pickle' and 'json'.
        required: false
        type: string
        default: path/to/config/directory/mysensors.pickle
      tcp_port:
        description: Specifies the port of the connected TCP Ethernet gateway.
        required: false
        type: integer
        default: 5003
      topic_in_prefix:
        description: Set the prefix of the MQTT topic for messages coming from the MySensors gateway in to Home Assistant.
        required: false
        type: string
        default: ''
      topic_out_prefix:
        description: Set the prefix of the MQTT topic for messages going from Home Assistant out to the MySensors gateway.
        required: false
        type: string
        default: ''
      nodes:
        description: A mapping of node ids to node settings, e.g. custom name.
        required: false
        type: map
        keys:
          name:
            description: The name the node will be renamed to. This node name becomes part of the entity_id. Default entity_id is [sketch_name]\_[node_id]\_[child_id] and when this name is set, the entity_id becomes [name]\_[child_id].
            required: true
            type: string
  persistence:
    description: Enable or disable local persistence of sensor information. If this is disabled, then each sensor will need to send presentation messages after Home Assistant starts.
    required: false
    type: integer
    default: true
  version:
    description: Specifies the MySensors protocol version to use. Supports versions 1.4 to 2.3.
    required: false
    type: string
    default: '1.4'
  optimistic:
    description: Enable or disable optimistic mode for actuators (switch/light). Set this to true if no state feedback from actuators is possible. Home Assistant will assume that the command succeeded and change state.
    required: false
    type: integer
    default: false
  retain:
    description: Enable or disable retain flag for published messages from Home Assistant when using the MQTT gateway.
    required: false
    type: integer
    default: true
{% endconfiguration %}

<div class='note'>
MySensors 2.x의 모든 기능이 아직 Home Assistant에서 지원되는 것은 아닙니다. 더 많은 기능이 추가되면 여기에서 설명서에 설명되어 있습니다. 현재 지원되는 메시지 유형을 보려면 "related components" 아래의 MySensors 플랫폼 페이지로 이동하십시오.
</div>

원래 Arduino를 직렬(Serial) 게이트웨이로 사용하는 경우 포트 이름은 ttyACM*입니다. 정확한 숫자는 아래 표시된 명령으로 확인할 수 있습니다.

```bash
$ ls /dev/ttyACM*
```

MQTT 게이트웨이를 사용하는 경우 홈어시스턴트에서 [MQTT 구성 요소](/integrations/mqtt/)도 설정해야합니다. 최소 MQTT 설정은 아래를 참조하십시오.

```yaml
mqtt:
  client_id: home-assistant-1
```

<div class='note'>
MQTT 게이트웨이에는 MySensors 버전 2.0 이상이 필요하며 MQTT 클라이언트 게이트웨이만 지원됩니다.
</div>

### 확장 설정 예시

```yaml
# Example configuration.yaml entry
mysensors:
  gateways:
    - device: '/dev/ttyUSB0'
      persistence_file: 'path/mysensors.json'
      baud_rate: 38400
      nodes:
        1:
          name: 'kitchen'
        3:
          name: 'living_room'
    - device: '/dev/ttyACM0'
      persistence_file: 'path/mysensors2.json'
      baud_rate: 115200
    - device: '192.168.1.18'
      persistence_file: 'path/mysensors3.json'
      tcp_port: 5003
    - device: mqtt
      persistence_file: 'path/mysensors4.json'
      topic_in_prefix: 'mygateway1-out'
      topic_out_prefix: 'mygateway1-in'
  optimistic: false
  persistence: true
  retain: true
  version: '2.0'
```

### Presentation

다음 단계에 따라 MySensors 센서 또는 액추에이터를 제시하십시오. : 

1. 직렬(serial) 게이트웨이를 컴퓨터에 연결하거나 이더넷 또는 MQTT 게이트웨이를 네트워크에 연결하십시오.
2. `configuration.yaml`에서 MySensors 통합구성요소를 설정하십시오.
3. 홈어시스턴트를 시작하십시오.
4. MySensors 스케치를 작성하여 센서에 업로드하십시오. 다음을 확인하십시오. :
    - sketch 이름을 보내십시오. 
    - 센서의 `S_TYPE`을 제시하십시오.
    - `V_TYPE`당 하나 이상의 초기값을 보냅니다. MySensors 버전 2.x에서는 loop function에서 수행해야합니다. 컨트롤러가 초기값을 받았는지 확인하는 방법에 대한 2.0 예제는 아래를 참조하십시오.
5. 센서를 시작시킵니다. 

```cpp
/*
 * Documentation: https://www.mysensors.org
 * Support Forum: https://forum.mysensors.org
 *
 * https://www.mysensors.org/build/relay
 */

#define MY_DEBUG
#define MY_RADIO_NRF24
#define MY_REPEATER_FEATURE
#define MY_NODE_ID 1
#include <SPI.h>
#include <MySensors.h>
#include <Bounce2.h>

#define RELAY_PIN  5
#define BUTTON_PIN  3
#define CHILD_ID 1
#define RELAY_ON 1
#define RELAY_OFF 0

Bounce debouncer = Bounce();
bool state = false;
bool initialValueSent = false;

MyMessage msg(CHILD_ID, V_STATUS);

void setup()
{
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  debouncer.attach(BUTTON_PIN);
  debouncer.interval(10);

  // Make sure relays are off when starting up
  digitalWrite(RELAY_PIN, RELAY_OFF);
  pinMode(RELAY_PIN, OUTPUT);
}

void presentation()  {
  sendSketchInfo("Relay+button", "1.0");
  present(CHILD_ID, S_BINARY);
}

void loop()
{
  if (!initialValueSent) {
    Serial.println("Sending initial value");
    send(msg.set(state?RELAY_ON:RELAY_OFF));
    Serial.println("Requesting initial value from controller");
    request(CHILD_ID, V_STATUS);
    wait(2000, C_SET, V_STATUS);
  }
  if (debouncer.update()) {
    if (debouncer.read()==LOW) {
      state = !state;
      // Send new state and request ack back
      send(msg.set(state?RELAY_ON:RELAY_OFF), true);
    }
  }
}

void receive(const MyMessage &message) {
  if (message.isAck()) {
     Serial.println("This is an ack from gateway");
  }

  if (message.type == V_STATUS) {
    if (!initialValueSent) {
      Serial.println("Receiving initial value from controller");
      initialValueSent = true;
    }
    // Change relay state
    state = (bool)message.getInt();
    digitalWrite(RELAY_PIN, state?RELAY_ON:RELAY_OFF);
    send(msg.set(state?RELAY_ON:RELAY_OFF));
  }
}
```

### SmartSleep

MySensors 버전 2.0-2.1을 사용하여 MySensors 장치에서 Home Assistant로 하트비트(heartbeat) `I_HEARTBEAT_RESPONSE`를 보내면 Home Assistant에서 SmartSleep 기능이 활성화됩니다. 이는 메시지가 버퍼링되고 장치에서 하트비트를 수신할 때만 장치로 전송됨을 의미합니다. 마지막으로 요청된 상태 변경만 장치로 전송되도록 상태 변경이 저장됩니다. 다른 유형의 메시지는 FIFO 대기열에 대기합니다. SmartSleep은 명령을 기다리는 배터리 구동식 액추에이터에 유용합니다. 하트비트를 전송하고 장치를 절전 모드로 전환하는 방법에 대한 정보는 MySensors 라이브러리 API를 참조하십시오.

MySensors 버전 2.2에서 직렬 API는 SmartSleep 신호로 `I_HEARTBEAT_RESPONSE`를 사용하는 방식에서, `I_PRE_SLEEP_NOTIFICATION` 및 `I_POST_SLEEP_NOTIFICATION` 사용으로 변경되었습니다. MySensors 버전 2.2.x 이상을 사용하는 경우 Home Assistant는 새 메시지 유형을 지원하도록 업그레이드되었으며 `I_PRE_SLEEP_NOTIFICATION` 타입의 메시지를 수신할 때 SmartSleep을 활성화합니다. Home Assistant가 MySensors 버전 2.0-2.1을 사용하도록 설정된 경우 이전 SmartSleep 동작이 유지됩니다.

### 메시지 검증 (Message validation)

홈어시스턴트와 MySensors 디바이스간에주고받는 메시지는 MySensors [직렬 API](https://www.mysensors.org/download/serial_api_20)에 따라 유효성이 검사됩니다. 메시지가 유효성 검사를 통과하지 못하면 메시지가 삭제되고 Home Assistant에 전달되지 않습니다. Arduino 스케치를 작성할 때 사용중인 MySensor 버전의 직렬 API를 따르십시오.

로그는 유효성 검사에 실패했거나 특정 하위 유형에 필요한 하위값이 누락된 메시지를 경고합니다. 홈어시스턴트는 경고 레벨에서 실패한 하위값의 유효성 검사를 기록합니다. 예를들어 플랫폼에 필요한 하나의 필수값 유형이 수신되었지만 다른 필수값 유형이 누락된 경우입니다. 

메시지 검증은 Home Assistant 버전 0.52에서 도입되었습니다.

### Debug logging

메시지가 끊어지거나 장치가 Home Assistant에 추가되지 않은 경우 `mysensors` 통합구성요소와 `mysensors` 패키지에 대한 디버그 로깅을 켜십시오. 그러면 무슨 일이 일어나고 있는지 알 수 있습니다. github 이슈 트래커에서 `mysensors` 통합구성요소에 대한 이슈를 보고하는 경우 이 로깅 설정을 사용하여 로그 샘플을 수집하십시오. 

```yaml
logger:
  default: info
  logs:
    homeassistant.components.mysensors: debug
    mysensors: debug
```


자세한 내용은 MySensors의 [library API][MySensors library api]를 방문하십시오.

[MySensors library API]: https://www.mysensors.org/download
