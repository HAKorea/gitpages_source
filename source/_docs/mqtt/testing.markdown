---
title: "MQTT 테스트"
description: "Instructions on how to test your MQTT setup."
logo: mqtt.png
---

`mosquitto` 브로커 패키지는 command-line tool들 (`*-clients` 패키지 등) MQTT 메시지를 보내고 받기 위해 번들로 제공됩니다. 다른 대안으로는 HBMQTT에서 제공하는 [hbmqtt_pub](http://hbmqtt.readthedocs.org/en/latest/references/hbmqtt_pub.html) 그리고 [hbmqtt_sub](http://hbmqtt.readthedocs.org/en/latest/references/hbmqtt_sub.html) 가 있습니다. localhost에서 실행중인 브로커로 테스트 메시지를 보내려면 아래 예를 확인하십시오 : 

```bash
$ mosquitto_pub -h 127.0.0.1 -t home-assistant/switch/1/on -m "Switch is ON"
```

임베드된 MQTT 브로커를 사용중인 경우, MQTT 프로토콜 버전 및 [broker credentials](/docs/mqtt/broker#embedded-broker)을 추가해야하므로 명령이 약간 다르게 보입니다 .

```bash
$ mosquitto_pub -V mqttv311 -u homeassistant -P <broker password> -t "hello" -m world
```

MQTT 메시지를 직접 보내는 다른 방법은 프론트 엔드에서 "개발자 도구"를 사용하는 것입니다. "MQTT"탭을 선택하십시오. "topic"필드에 아래 예와 유사한 것을 입력하십시오.

```bash
   home-assistant/switch/1/power
 ```
페이로드 필드에
 ```bash
   ON
```
"Listen to a topic"필드에 #를 입력하여 모든 것을 보거나 "home-assistant/switch/#"를 입력하여 게시된 topic을 확인하십시오. "Start Listening"을 누른 다음 "Publish"를 누르십시오. 결과는 아래 텍스트와 유사하게 나타납니다

```bash
Message 23 received on home-assistant/switch/1/power/stat/POWER at 12:16 PM:
ON
QoS: 0 - Retain: false
Message 22 received on home-assistant/switch/1/power/stat/RESULT at 12:16 PM:
{
    "POWER": "ON"
}
QoS: 0 - Retain: false
```

localhost에서 실행중인 브로커로 `home-assistant` topic에 전송된 모든 메시지를 읽으려면 다음을 수행하십시오.

```bash
$ mosquitto_sub -h 127.0.0.1 -v -t "home-assistant/#"
```

For the embedded MQTT broker the command looks like:

```bash
$ mosquitto_sub -v -V mqttv311 -u homeassistant -P <broker password> -t "#"
```

