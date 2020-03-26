---
title: 장치상태확인(SNMP)
description: Instructions on how to integrate SNMP into Home Assistant.
logo: network-snmp.png
ha_category:
  - Network
  - Switch
  - Presence Detection
  - Sensor
ha_iot_class: Local Polling
ha_release: 0.57
---

<div class='videoWrapper'>
<iframe width="692" height="388" src="https://www.youtube.com/embed/II1iu_JSW_U" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

많은 WiFi 액세스 포인트와 WiFi 라우터는 SNMP(Simple Network Management Protocol)를 지원합니다. 네트워크 연결 장치를 모니터링/관리하는 표준화된 방법입니다. SNMP는 각 노드가 객체인 트리와 같은 계층을 사용합니다. 이러한 많은 개체에는 네트워크 인터페이스, 디스크 및 WiFi 등록과 같은 인스턴스(instances) 및 메트릭(metrics) 목록이 포함되어 있습니다.

현재 홈어시스턴트에는 다음 장치 유형이 지원됩니다.

- [Presence Detection](#precense-detection)
- [Sensor](#sensor)
- [Switch](#switch)

<div class='note warning'>
이 장치 추적기는 라우터에서 SNMP를 활성화해야합니다. SNMP 지원을 수동으로 설치해야 할 수도 있습니다.
</div>

## 재실 감지

다음 OID 예제는 라우터에서 현재 MAC 주소 테이블을 가져옵니다. 이는 네트워크에서 본 모든 최근 장치를 반영합니다. 그러나 시간이 초과될 때까지 장치가 제거되지 않기 때문에 [device tracker integration page](/integrations/device_tracker/)에는 바람직하지 않습니다. 대신 [Ping](/integrations/ping) 혹은 [Nmap](/integrations/nmap_tracker)를 사용하는 것이 좋습니다.

| Brand | Device/Firmware | OID |
| --- | --- | --- |
| Aerohive | AP230 | `1.3.6.1.4.1.26928.1.1.1.2.1.2.1.1` |
| Apple | Airport Express (2nd gen.) 7.6.9 | `1.3.6.1.2.1.3.1.1.2` or `1.3.6.1.2.1.4.22.1.2`|
| Aruba | IAP325 on AOS 6.5.4.8 | `1.3.6.1.4.1.14823.2.3.3.1.2.4.1.1` |
| BiPAC | 7800DXL Firmware 2.32e | `1.3.6.1.2.1.17.7.1.2.2.1.1` |
| DD-WRT | unknown version/model | `1.3.6.1.2.1.4.22.1.2` |
| Mikrotik | unknown RouterOS version/model | `1.3.6.1.4.1.14988.1.1.1.2.1.1` |
| Mikrotik | RouterOS 6.x on RB2011 | `1.3.6.1.2.1.4.22.1.2` |
| OpenWrt | Chaos Calmer 15.05 | `1.3.6.1.2.1.4.22.1.2` |
| OPNSense | 19.1 | `1.3.6.1.2.1.4.22.1.2` |
| pfSense | 2.2.4 | `1.3.6.1.2.1.4.22.1.2` |
| Ruckus | ZoneDirector 9.13.3 | `1.3.6.1.4.1.25053.1.2.2.1.1.3.1.1.1.6` |
| TP-Link | Archer VR1600v | `1.3.6.1.2.1.3.1.1.2.16.1` |
| TP-Link | Archer VR2600v | `1.3.6.1.2.1.3.1.1.2.19.1` |
| TP-Link | Archer VR600 | `1.3.6.1.2.1.3.1.1.2` |
| Ubiquiti | Edgerouter Lite v1.9.0 | `1.3.6.1.2.1.4.22.1.2` |

설치시 SNMP 버전 1 또는 2c 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry for SNMP version 1 or 2c
device_tracker:
  - platform: snmp
    host: 192.168.1.1
    community: public
    baseoid: 1.3.6.1.4.1.14988.1.1.1.2.1.1
```

암호화를 사용하려면 `auth_key` 및 `priv_key` 변수를 추가하고 라우터에서 SNMP 버전 3을 활성화하여 SNMP 버전 3을 활성화해야합니다. 현재 인증에는 SHA1만, 암호화에는 AES만 지원됩니다. SNMPv3 구성의 예 :

```yaml
# Example configuration.yaml entry for SNMP version 3
device_tracker:
  - platform: snmp
    host: 192.168.1.1
    community: USERNAME
    auth_key: AUTHPASS
    priv_key: PRIVPASS
    baseoid: 1.3.6.1.4.1.14988.1.1.1.2.1.1
```

{% configuration %}
host:
  description: The IP address of the router, e.g., 192.168.1.1.
  required: true
  type: string
community:
  description: The SNMP community which is set for the device. Most devices have a default community set to `public` with read-only permission (which is sufficient).
  required: true
  type: string
baseoid:
  description: The OID prefix where wireless client registrations can be found, usually vendor specific. It's advised to use the numerical notation. To find this base OID, check vendor documentation or check the MIB file for your device.
  required: true
  type: string
auth_key:
  description: "Authentication key for SNMPv3. Variable `priv_key` must also be set."
  required: inclusive
  type: string
priv_key:
  description: "Privacy key SNMPv3. Variable `auth_key` must also be set."
  required: inclusive
  type: string
{% endconfiguration %}

추적할 사람을 설정하는 방법에 대한 지침은 [device tracker integration page](/integrations/device_tracker/)를 참조하십시오.

## Sensor

`snmp` 센서 플랫폼은 [Simple Network Management Protocol (SNMP)](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol)를 통해 사용 가능한 정보를 표시합니다. SNMP는 각 노드가 개체인 트리와 같은 계층을 사용하며 주로 라우터, 모뎀 및 프린터와 같은 네트워크 지향 장치에서 지원됩니다.

설치시 이 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: snmp
    host: 192.168.1.32
    baseoid: 1.3.6.1.4.1.2021.10.1.3.1
```

{% configuration %}
host:
  description: The IP address of your host, e.g., `192.168.1.32`.
  required: false
  type: string
  default: 'localhost'
baseoid:
  description: The OID where the information is located. It's advised to use the numerical notation.
  required: true
  type: string
port:
  description: The SNMP port of your host.
  required: false
  type: string
  default: '161'
community:
  description: "The SNMP community which is set for the device for SNMP v1 and v2c. Most devices have a default community set to `public` with read-only permission (which is sufficient)."
  required: false
  type: string
  default: 'public'
username:
  description: Username to use for authentication.
  required: false
  type: string
  default: ''
auth_key:
  description: Authentication key to use for SNMP v3.
  required: false
  type: string
  default: no key
auth_protocol:
  description: Authentication protocol to use for SNMP v3.
  required: false
  type: string
  default: 'none'
priv_key:
  description: Privacy key to use for SNMP v3.
  required: false
  type: string
  default: no key
priv_protocol:
  description: Privacy protocol to use for SNMP v3.
  required: false
  type: string
  default: 'none'
version:
  description: "Version of SNMP protocol, `1`, `2c` or `3`. Version `2c` or higher is needed to read data from 64-bit counters."
  required: false
  type: string
  default: '1'
name:
  description: Name of the SNMP sensor.
  required: false
  type: string
unit_of_measurement:
  description: Defines the unit of measurement of the sensor, if any.
  required: false
  type: string
value_template:
  description: "Defines a [template](/docs/configuration/templating/#processing-incoming-data) to parse the value."
  required: false
  type: template
accept_errors:
  description: "Determines whether the sensor should start and keep working even if the SNMP host is unreachable or not responding. This allows the sensor to be initialized properly even if, for example, your printer is not on when you start Home Assistant."
  required: false
  type: string
  default: false
default_value:
  description: "Determines what value the sensor should take if `accept_errors` is set and the host is unreachable or not responding. If not set, the sensor will have value `unknown` in case of errors."
  required: false
  type: string
{% endconfiguration %}

`auth_protocol`의 유효한 값 :

- **none**
- **hmac-md5**
- **hmac-sha**
- **hmac128-sha224**
- **hmac192-sha256**
- **hmac256-sha384**
- **hmac384-sha512**

`priv_protocol`의 유효한 값 :

- **none**
- **des**
- **3des-ede**
- **aes-cfb-128**
- **aes-cfb-192**
- **aes-cfb-256**

### OIDs 찾기

OID는 공급 업체별로 다르므로 시스템마다 다를 수 있습니다. 설명서 외에도 [OID Repository](http://www.oid-info.com/)는 OID를 찾는 경우 시작하기에 좋은 장소입니다. 예를 들어, 다음 OID는 Linux 시스템로드를 위한 것입니다.

- 1 minute Load: `1.3.6.1.4.1.2021.10.1.3.1`
- 5 minute Load: `1.3.6.1.4.1.2021.10.1.3.2`
- 15 minute Load: `1.3.6.1.4.1.2021.10.1.3.3`

SNMP 작업에 사용할 수있는 많은 도구가 있습니다. `snmpwalk`를 사용하면 OID 값을 쉽게 검색할 수 있습니다.

```bash
$ snmpwalk -Os -c public -v 2c 192.168.1.32 1.3.6.1.4.1.2021.10.1.3.1
laLoad.1 = STRING: 0.19
```

### 사례

#### 프린터 가동 시간

가장 일반적인 SNMP 표준에 따르면 장치의 가동 시간은 OID `1.3.6.1.2.1.1.3.0`에서 액세스할 수 있습니다. 이 값은 `TimeTicks`라는 형식을 사용하여 100 분의 1 초 단위로 나타냅니다.

프린터 가동 시간을 분 단위로 표시하는 센서를 만들려면 다음 설정을 사용할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: snmp
    name: 'Printer uptime'
    host: 192.168.2.21
    baseoid: 1.3.6.1.2.1.1.3.0
    accept_errors: true
    unit_of_measurement: 'minutes'
    value_template: '{{((value | int) / 6000) | int}}'
```
{% endraw %}

`accept_errors` 옵션은 홈어시스턴트가 처음 시작될 때 프린터가 켜져 있지 않아도 센서가 작동할 수 있도록합니다. 센서는 분 단위 대신 `-` 만 표시합니다.

`value_template` 옵션은 원래 값을 분으로 변환합니다.

## Switch

`snmp` 스위치 플랫폼을 사용하면 SNMP 가능 장비를 제어할 수 있습니다.

현재 정수값을 허용하는 SNMP OID 만 지원됩니다. SNMP v1, v2c 및 v3이 지원됩니다.

SNMP 스위치를 사용하려면

```yaml
# Example configuration.yaml entry:
switch:
  - platform: snmp
    host: 192.168.0.2
    baseoid: 1.3.6.1.4.1.19865.1.2.1.4.0
```

{% configuration %}
baseoid:
  description: The SNMP BaseOID which to poll for the state of the switch.
  required: true
  type: string
command_oid:
  description: The SNMP OID which to set in order to turn the switch on and off, if different from `baseoid`.
  required: false
  type: string
host:
  description: The IP/host which to control.
  required: false
  type: string
  default: 'localhost'
port:
  description: The port on which to communicate.
  required: false
  type: string
  default: '161'
community:
  description: community string to use for authentication (SNMP v1 and v2c).
  required: false
  type: string
  default: 'private'
username:
  description: Username to use for authentication.
  required: false
  type: string
  default: ''
auth_key:
  description: Authentication key to use for SNMP v3.
  required: false
  type: string
  default: no key
auth_protocol:
  description: Authentication protocol to use for SNMP v3.
  required: false
  type: string
  default: 'none'
priv_key:
  description: Privacy key to use for SNMP v3.
  required: false
  type: string
  default: no key
priv_protocol:
  description: Privacy protocol to use for SNMP v3.
  required: false
  type: string
  default: 'none'
version:
  description: SNMP version to use - either `1`, `2c` or `3`.
  required: false
  type: string
  default: '1'
payload_on:
  description: What return value represents an `On` state for the switch. The same value is used in writes to turn on the switch if `command_payload_on` is not set.
  required: false
  type: string
  default: '1'
payload_off:
  description: What return value represents an `Off` state for the switch. The same value is used in writes to turn off the switch if `command_payload_off` is not set.
  required: false
  type: string
  default: '0'
command_payload_on:
  description: The value to write to turn on the switch, if different from `payload_on`.
  required: false
  type: string
command_payload_off:
  description: The value to write to turn off the switch, if different from `payload_off`.
  required: false
  type: string
{% endconfiguration %}

올바른 BaseOID와 스위치를 켜고 끄는 값은 장치 공급 업체에 문의하십시오.

`auth_protocol`의 유효한 값 :

- **none**
- **hmac-md5**
- **hmac-sha**
- **hmac128-sha224**
- **hmac192-sha256**
- **hmac256-sha384**
- **hmac384-sha512**

`priv_protocol`의 유효한 값 :

- **none**
- **des**
- **3des-ede**
- **aes-cfb-128**
- **aes-cfb-192**
- **aes-cfb-256**

완전한 예 :

```yaml
switch:
  - platform: snmp
    name: SNMP v1 switch
    host: 192.168.0.2
    community: private
    baseoid: 1.3.6.1.4.1.19865.1.2.1.4.0
    payload_on: 1
    payload_off: 0

  - platform: snmp
    name: SNMP v3 switch
    host: 192.168.0.3
    version: '3'
    username: 'myusername'
    auth_key: 'myauthkey'
    auth_protocol: 'hmac-sha'
    priv_key: 'myprivkey'
    priv_protocol: 'aes-cfb-128'
    baseoid: 1.3.6.1.4.1.19865.1.2.1.4.0
    payload_on: 1
    payload_off: 0
```
