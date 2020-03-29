---
title: "MySensors Switch"
description: "Instructions on how to integrate MySensors switches into Home Assistant."
logo: mysensors.png
ha_category:
  - DIY
  - Switch
ha_iot_class: Local Push
ha_release: 0.11
---

MySensors 스위치를 Home Assistant에 연동합니다. 설정 지침은 [main component]를 참조하십시오.

## 지원되는 액추에이터 유형

다음과 같은 액추에이터 유형이 지원됩니다.

### MySensors version 1.4 and higher

S_TYPE   | V_TYPE
---------|-------------------
S_DOOR   | V_ARMED
S_MOTION | V_ARMED
S_SMOKE  | V_ARMED
S_LIGHT  | V_LIGHT
S_LOCK   | V_LOCK_STATUS
S_IR     | V_IR_SEND, V_LIGHT

### MySensors version 1.5 and higher

S_TYPE       | V_TYPE
-------------|----------------------
S_LIGHT      | V_STATUS
S_BINARY     | [V_STATUS or V_LIGHT]
S_SPRINKLER  | V_STATUS
S_WATER_LEAK | V_ARMED
S_SOUND      | V_ARMED
S_VIBRATION  | V_ARMED
S_MOISTURE   | V_ARMED

### MySensors version 2.0 and higher

S_TYPE          | V_TYPE
----------------|---------
S_WATER_QUALITY | V_STATUS

플랫폼의 액추에이터를 활성화하려면 위의 각 S_TYPE에 대한 모든 V_TYPES가 필요합니다. 해당 V_TYPE이 필요한 경우 라이브러리 버전에 따라 V_LIGHT 또는 V_STATUS를 사용하십시오.

자세한 내용은 MySensors의 [serial api]를 방문하십시오.

## 서비스

MySensors 스위치 플랫폼은 IR 스위치 장치의 IR 코드 속성을 변경하고 스위치를 켜는 서비스를 제공합니다. 
MySensors 구성 요소의 [config](/integrations/mysensors/#configuration)에서 `optimistic` 이 `true`로 설정되어 있으면 IR 스위치가 켜진 후 자동으로 꺼집니다. 리모컨의 푸시 버튼을 시뮬레이션합니다. `optimistic`이 `false`인 경우 MySensors 장치는 스위치를 재설정하기 위해 업데이트된 상태를 보고해야합니다. 아래 IR 스위치에 대한  [example sketch](#ir-switch-sketch)를 참조하십시오.

| Service | Description |
| ------- | ----------- |
| mysensors.send_ir_code | Set an IR code as a state attribute for a MySensors IR device switch and turn the switch on.|

이 서비스는 자동화 스크립트의 일부로 사용할 수 있습니다. 예를 들면 다음과 같습니다.

```yaml
# Example configuration.yaml automation entry
automation:
  - alias: Turn HVAC on
    trigger:
      platform: time
      at: '5:30:00'
    action:
      service: mysensors.send_ir_code
      entity_id: switch.hvac_1_1
      data:
        V_IR_SEND: '0xC284'  # the IR code to send

  - alias: Turn HVAC off
    trigger:
      platform: time
      at: '0:30:00'
    action:
      service: mysensors.send_ir_code
      entity_id: switch.hvac_1_1
      data:
        V_IR_SEND: '0xC288'  # the IR code to send
```

## sketches 예시

### Switch sketch

```cpp
/*
 * Documentation: https://www.mysensors.org
 * Support Forum: https://forum.mysensors.org
 *
 * https://www.mysensors.org/build/relay
 */

#include <MySensor.h>
#include <SPI.h>

#define SN "Relay"
#define SV "1.0"
#define CHILD_ID 1
#define RELAY_PIN 3

MySensor gw;
MyMessage msgRelay(CHILD_ID, V_STATUS);

void setup()
{
  gw.begin(incomingMessage);
  gw.sendSketchInfo(SN, SV);
  // Initialize the digital pin as an output.
  pinMode(RELAY_PIN, OUTPUT);
  gw.present(CHILD_ID, S_BINARY);
  gw.send(msgRelay.set(0));
}

void loop()
{
  gw.process();
}

void incomingMessage(const MyMessage &message)
{
  if (message.type == V_STATUS) {
     // Change relay state.
     digitalWrite(RELAY_PIN, message.getBool() ? 1 : 0);
     gw.send(msgRelay.set(message.getBool() ? 1 : 0));
  }
}
```

### IR switch sketch

```cpp
/*
 * Documentation: https://www.mysensors.org
 * Support Forum: https://forum.mysensors.org
 *
 * https://www.mysensors.org/build/ir
 */

#include <MySensor.h>
#include <SPI.h>
#include <IRLib.h>

#define SN "IR Sensor"
#define SV "1.0"
#define CHILD_ID 1

MySensor gw;

char code[10] = "abcd01234";
char oldCode[10] = "abcd01234";
MyMessage msgCodeRec(CHILD_ID, V_IR_RECEIVE);
MyMessage msgCode(CHILD_ID, V_IR_SEND);
MyMessage msgSendCode(CHILD_ID, V_LIGHT);

void setup()
{
  gw.begin(incomingMessage);
  gw.sendSketchInfo(SN, SV);
  gw.present(CHILD_ID, S_IR);
  // Send initial values.
  gw.send(msgCodeRec.set(code));
  gw.send(msgCode.set(code));
  gw.send(msgSendCode.set(0));
}

void loop()
{
  gw.process();
  // IR receiver not implemented, just a dummy report of code when it changes
  if (String(code) != String(oldCode)) {
    Serial.print("Code received ");
    Serial.println(code);
    gw.send(msgCodeRec.set(code));
    strcpy(oldCode, code);
  }
}

void incomingMessage(const MyMessage &message) {
  if (message.type==V_LIGHT) {
    // IR sender not implemented, just a dummy print.
    if (message.getBool()) {
      Serial.print("Sending code ");
      Serial.println(code);
    }
    gw.send(msgSendCode.set(message.getBool() ? 1 : 0));
    // Always turn off device
    gw.wait(100);
    gw.send(msgSendCode.set(0));
  }
  if (message.type == V_IR_SEND) {
    // Retrieve the IR code value from the incoming message.
    String codestring = message.getString();
    codestring.toCharArray(code, sizeof(code));
    Serial.print("Changing code to ");
    Serial.println(code);
    gw.send(msgCode.set(code));
  }
}
```

[main component]: /integrations/mysensors/
[serial api]: https://www.mysensors.org/download
