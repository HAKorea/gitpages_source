---
title: "MQTT 브로커"
description: "Instructions on how to setup MQTT brokers for Home Assistant."
logo: mqtt.png
---

MQTT 통합구성요소에서는 홈어시스턴트에서 연결할 MQTT 브로커를 실행해야합니다. 설정 및 개인 정보 보호 수준이 다양한 네 가지 옵션이 있습니다.

### 로컬 시스템에서 직접 운영 (Run your own)

For Hass.io users, the recommended setup method is to use the [Mosquitto MQTT broker addon](/addons/mosquitto).
가장 개인적인 옵션이지만 설정하는 데 약간의 작업이 필요합니다. [Mosquitto](http://mosquitto.org/), [EMQ](https://github.com/emqx/emqx) 혹은 [Mosca](http://www.mosca.io/) 와 같은 선택할 수있는 무료 및 오픈 소스 브로커가 여러 개 있습니다.<br><br> **Hass.io 사용자의 경우 권장 설정 방법은 [Mosquitto MQTT broker addon](/addons/mosquitto)** 을 사용하는 것 입니다.

```yaml
# Example configuration.yaml entry
mqtt:
  broker: 192.168.1.100
```

{% configuration %}
broker:
  required: false
  description: MQTT 브로커의 IP 주소 또는 호스트 이름 (예 192.168.1.32)
  type: string
port:
  required: false
  description: 연결할 네트워크 포트. 기본값은 1883입니다.
  type: integer
client_id:
  required: false
  description: 홈어시스턴트가 사용할 클라이언트 ID. 서버에서 고유해야합니다. 기본값은 임의로 생성 된 것입니다.
  type: string
keepalive:
  required: false
  description: 이 클라이언트에 대한 연결 유지 메시지를 보내는 데 걸리는 시간 (초)입니다. 기본값은 60입니다.
  type: integer
username:
  required: false
  description: MQTT 브로커와 함께 사용할 사용자 이름입니다.
  type: string
password:
  required: false
  description: MQTT 브로커와 함께 사용할 사용자 이름의 해당 비밀번호입니다.
  type: string
protocol:
  required: false
  description: 3.1 또는 3.1.1. 서버가 3.1.1을 지원하지 않으면 기본적으로 3.1.1로 연결시도하고 3.1로 대체됩니다.
  type: string
certificate:
  required: false
  description: 인증서 파일의 경로입니다 (예 `/home/user/.homeassistant/server.crt`).
  type: string
tls_insecure:
  required: false
  description: 서버 인증서에서 서버 호스트 이름의 확인을 설정하십시오.
  type: boolean
  default: false
tls_version:
  required: false
  description: "사용할 TLS / SSL 프로토콜 버전. 사용 가능한 옵션 : `'auto'`, `'1.0'`, `'1.1'`, `'1.2'`. 값을 따옴표로 묶어야합니다. 기본값 : `'auto'`."
  type: string
{% endconfiguration %}

<div class='note warning'>

Ubuntu 14.04 LTS에 포함 된 Mosquitto 패키지에 문제가 있습니다. 이 문제를 해결하려면 MQTT 설정에서 `protocol: 3.1`를 명기 하십시오. Specify `protocol: 3.1` in your MQTT configuration to work around this issue.
다음 오류가 발생하면 `AttributeError: module 'ssl' has no attribute 'PROTOCOL_TLS'`, 설정에 `tls_version: '1.2'`를 넣어야 합니다.

</div>

<div class='note'>

홈어시스턴트와 동일한 서버에서 Mosquitto 인스턴스를 실행중인 경우 홈어시스턴트보다 먼저 Mosquitto 서비스가 시작되는지 확인해야합니다. Systemd (Raspberry Pi, Debian, Ubuntu 및 기타)를 실행하는 Linux 인스턴스의 경우 `/etc/systemd/system/home-assistant@homeassistant.service`를 `root`로  (예: `sudo nano /etc/systemd/system/home-assistant@homeassistant.service`) 명령어를 써서 직접 Mosquitto service를 추가해야 합니다. :

```txt
[Unit]
Description=Home Assistant
After=network.target mosquitto.service
```

</div>

<div class='note'>

Let 's Encrypt와 같은 서비스를 사용하여 적절한 SSL 암호화를 사용하여 다른 서버에서 Mosquitto 인스턴스를 실행하는 경우 운영 체제 자체 `.crt` 인증서 파일로 인증서를 설정해야 할 수 있습니다. 우분투의 경우 `certificate: /etc/ssl/certs/ca-certificates.crt` 입니다. 

</div>

### 공공 브로커 (Public broker)

모스키토 프로젝트는 [public broker](http://test.mosquitto.org)를 운영합니다. 이것은 설정하기가 가장 쉽지만 모든 메시지가 공개되므로 프라이버시가 없습니다. 테스트 목적으로 만 사용하고 실제 장치 추적 또는 가정 제어에는 사용하지 마십시오.

```yaml
mqtt:
  broker: test.mosquitto.org
  port: 1883 or 8883

  # Optional, replace port 1883 with following if you want encryption
  # (doesn't really matter because broker is public)
  port: 8883
  # Download certificate from http://test.mosquitto.org/ssl/mosquitto.org.crt
  certificate: /home/paulus/downloads/mosquitto.org.crt
```

### CloudMQTT

[CloudMQTT](https://www.cloudmqtt.com) 는 최대 10 개의 연결된 장치를 무료로 제공하는 호스팅 된 프라이빗 MQTT 인스턴스입니다. 예를 들어 [OwnTracks](/integrations/owntracks/) 시작하고 가능한 것들을 경험할 수 있습니다.

<div class='note'>
홈 어시스턴트는 CloudMQTT와 관련이 없으며 어떤 협찬도 받지 않습니다.
</div>

 1. [Create an account](https://customer.cloudmqtt.com/login) (공짜로 가입가능)
 2. [Create a new CloudMQTT instance](https://customer.cloudmqtt.com/subscription/create)
    (Cute Cat 은 무료플랜)
 3. 제어판에서 **자세히** 버튼을 클릭하십시오
 4. 홈 어시스턴트 및 각 전화기에 연결할 고유 한 사용자 작성<br>(CloudMQTT는 동일한 사용자로부터 두 개의 연결을 허용하지 않음)
      1. 사용자 관리에서 사용자 이름, 비밀번호를 입력하고 추가를 클릭하십시오.
      2. ACL에서 user, topic `#`을 선택하고 '읽기 액세스'및 '쓰기 액세스'를 확인하십시오.
 5. 인스턴스 정보를 configuration.yaml에 복사하십시오. :

```yaml
mqtt:
  broker: CLOUDMQTT_SERVER
  port: CLOUDMQTT_PORT
  username: CLOUDMQTT_USER
  password: CLOUDMQTT_PASSWORD
```

<div class='note'>
암호화 된 CloudMQTT 채널에 연결하면 홈어시스턴트가 자동으로 올바른 인증서를 로드합니다(포트 범위 20000-30000). 
</div>

<div class='note'>

`Failed to connect due to exception: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed` 과 같은 오류 메시지가 표시 되면 `certificate: auto`를 브로커 설정에 추가 하고 홈어시스턴트를 다시 시작하십시오.

</div>

#### Owntracks

내부 브로커와 함께 자체 트랙을 사용하려면 앱이 MQTT 프로토콜 3.1.1 (프로토콜 레벨 4)을 사용하도록 구성을 약간 변경해야합니다.

Owntracks 환경 설정 (Android : v1.2.3 +, iOS : v9.5.1 +)에서 **Configuration Management**를 엽니 다. `mqttProtocolLevel`를 찾아 `4`로 변경합니다. 애플리케이션은 이제 MQTT 3.1.1을 사용하여 연결하며 임베드 된 브로커와 호환됩니다.

#### Settings

임베디드 브로커의 설정을 사용자 정의하려면, `embedded:` 를 사용하여 [HBMQTT Broker configuration](http://hbmqtt.readthedocs.org/en/latest/references/broker.html#broker-configuration)대로 설정해 보십시오. 그렇게 하면, 기본 구성이 바뀝니다.

```yaml
# Example configuration.yaml entry
mqtt:
  embedded:
    # Your HBMQTT config here. Example at:
    # http://hbmqtt.readthedocs.org/en/latest/references/broker.html#broker-configuration
```
