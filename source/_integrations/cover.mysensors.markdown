---
title: "MySensors Cover"
description: "Instructions on how to integrate MySensors covers into Home Assistant."
logo: mysensors.png
ha_category:
  - DIY
  - Cover
ha_release: "0.30"
ha_iot_class: Local Push
---

MySensors 커버(Cover)를 Home Assistant에 연동합니다. 설정 지침은 [main component]를 참조하십시오.

다음과 같은 액추에이터 유형이 지원됩니다.

##### MySensors version 1.4

S_TYPE  | V_TYPE
--------|--------------------------------------------
S_COVER | V_UP, V_DOWN, V_STOP, [V_DIMMER or V_LIGHT]

##### MySensors version 1.5 and higher

S_TYPE  | V_TYPE
--------|-------------------------------------------------
S_COVER | V_UP, V_DOWN, V_STOP, [V_PERCENTAGE or V_STATUS]

위의 모든 V_TYPES가 필요합니다. 커버의 정확한 위치를 백분율로 알고 있으면 V_PERCENTAGE (또는 V_DIMMER)를 사용하고, 그렇지 않으면 V_STATUS (또는 V_LIGHT)를 사용하십시오.

자세한 내용은 MySensors의 [serial api]를 방문하십시오.

### sketch 사례

```cpp
/*
 * Documentation: https://www.mysensors.org
 * Support Forum: https://forum.mysensors.org
 */

// Enable debug prints to serial monitor
#define MY_DEBUG
#define MY_RADIO_NRF24

#include <MySensors.h>
#define SN "Cover"
#define SV "1.1"

// Actuators for moving the cover up and down respectively.
#define COVER_UP_ACTUATOR_PIN 2
#define COVER_DOWN_ACTUATOR_PIN 3
// Sensors for finding out when the cover has reached its up/down position.
// These could be simple buttons or linear hall sensors.
#define COVER_UP_SENSOR_PIN 4
#define COVER_DOWN_SENSOR_PIN 5

#define CHILD_ID 0

// Internal representation of the cover state.
enum State {
  IDLE,
  UP, // Window covering. Up.
  DOWN, // Window covering. Down.
};

static int state = IDLE;
static int status = 0; // 0=cover is down, 1=cover is up
static bool initial_state_sent = false;
MyMessage upMessage(CHILD_ID, V_UP);
MyMessage downMessage(CHILD_ID, V_DOWN);
MyMessage stopMessage(CHILD_ID, V_STOP);
MyMessage statusMessage(CHILD_ID, V_STATUS);

void sendState() {
  // Send current state and status to gateway.
  send(upMessage.set(state == UP));
  send(downMessage.set(state == DOWN));
  send(stopMessage.set(state == IDLE));
  send(statusMessage.set(status));
}

void setup() {
  pinMode(COVER_UP_SENSOR_PIN, INPUT);
  pinMode(COVER_DOWN_SENSOR_PIN, INPUT);
}

void presentation() {
  sendSketchInfo(SN, SV);

  present(CHILD_ID, S_COVER);
}

void loop() {
  if (!initial_state_sent) {
    sendState();
    initial_state_sent = true;
  }

  if (state == IDLE) {
    digitalWrite(COVER_UP_ACTUATOR_PIN, LOW);
    digitalWrite(COVER_DOWN_ACTUATOR_PIN, LOW);
  }

  if (state == UP && digitalRead(COVER_UP_SENSOR_PIN) == HIGH) {
    Serial.println("Cover is up.");
    // Update status and state; send it to the gateway.
    status = 1;
    state = IDLE;
    sendState();
    // Actuators will be disabled in next loop() iteration.
  }

  if (state == DOWN && digitalRead(COVER_DOWN_SENSOR_PIN) == HIGH) {
    Serial.println("Cover is down.");
    // Update status and state; send it to the gateway.
    status = 0;
    state = IDLE;
    sendState();
    // Actuators will be disabled in next loop() iteration.
  }
}

void receive(const MyMessage &message) {
  if (message.type == V_UP) {
    // Set state to covering up and send it back to the gateway.
    state = UP;
    sendState();
    Serial.println("Moving cover up.");

    // Activate actuator until the sensor returns HIGH in loop().
    digitalWrite(COVER_UP_ACTUATOR_PIN, HIGH);
  }

  if (message.type == V_DOWN) {
    // Set state to covering up and send it back to the gateway.
    state = DOWN;
    sendState();
    Serial.println("Moving cover down.");
    // Activate actuator until the sensor returns HIGH in loop().
    digitalWrite(COVER_DOWN_ACTUATOR_PIN, HIGH);
  }

  if (message.type == V_STOP) {
    // Set state to idle and send it back to the gateway.
    state = IDLE;
    sendState();
    Serial.println("Stopping cover.");

    // Actuators will be switched off in loop().
  }
}
```

[main component]: /integrations/mysensors/
[serial api]: https://www.mysensors.org/download/serial_api_20
