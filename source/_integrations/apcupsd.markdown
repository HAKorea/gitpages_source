---
title: 무정전전원장치(APCUPSd)
description: Instructions on how to integrate APCUPSd status with Home Assistant.
logo: apcupsd.png
ha_category:
  - System Monitor
  - Binary Sensor
  - Sensor
ha_release: 0.13
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/rIK2U8I3cxk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[APCUPSd](http://www.apcupsd.org/) 상태 정보는 APC 장치에 [NIS(Network Information Server)](http://www.apcupsd.org/manual/manual.html#nis-server-client-configuration-using-the-net-driver)가 구성된 경우 홈어시스턴트에 연동될 수 있습니다. 

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. 

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)

## Hass.io 설치

Hass.io와의 연동을 사용하려면 [unofficial add-on](https://github.com/korylprince/hassio-apcupsd/)을 설치하십시오. 단, add-on을 공식 지원할 수는 없습니다.

설치 후 Github 페이지의 지침에 따라 플러그인을 설정하십시오. 그런 다음 아래 통합 설정을 계속 따르십시오.

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
apcupsd:
```

{% configuration %}
host:
  description: The hostname/IP address on which the APCUPSd NIS is being served.
  required: false
  type: string
  default: localhost
port:
  description: The port on which the APCUPSd NIS is listening.
  required: false
  type: integer
  default: 3551
{% endconfiguration %}

<div class='note'>

Home Assistant 로그에 `ConnectionRefusedError: Connection refused` 오류가 표시되는 경우, 네트워크 정보 서버가 사용하는 [APCUPSd](http://www.apcupsd.org/) 설정 지시문이 모든 주소 [NISIP 0.0.0.0](http://www.apcupsd.org/manual/manual.html#configuration-directives-used-by-the-network-information-server)에서 연결을 허용하도록 설정되어 있는지 확인하십시오. 그렇지 않을 경우 로컬이 아닌 주소는 연결되지 않습니다. 이는 동일한 컴퓨터 또는 가상 컴퓨터에서 호스팅되는 경우에도 Docker에서 실행되는 Hass.io도 포함됩니다.

 </div>

## Binary sensor

[APCUPSd Sensor](#sensor) 장치 외에도 UPS 상태가 온라인일 때 단순히 "on" 상태이고 다른 시간에는 "off" 상태인 장치를 만들 수도 있습니다.

### 설정

이 센서를 활성화하려면 먼저 위의 apcupsd integration을 설정하고 `configuration.yaml` 파일에 다음 줄을 추가해야합니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: apcupsd
```

{% configuration %}
name:
  description: Name to use in the frontend.
  required: false
  type: string
  default: UPS Online Status
{% endconfiguration %}

## Sensor

 `apcupsd` 센서 플랫폼을 사용하면 [apcaccess](https://linux.die.net/man/8/apcaccess) 명령의 데이터를 사용하여 UPS (배터리 백업)를 모니터링 할 수 있습니다.

### 설정

이 센서 플랫폼을 사용하려면 먼저 위의 apcupsd 통합구성요소를 설정하고 `configuration.yaml` 파일에 다음을 추가해야합니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: apcupsd
    resources:
      - bcharge
      - linev
```

{% configuration %}
resources:
  description: Contains all entries to display.
  required: true
  type: list
{% endconfiguration %}

### 사례 

`apcaccess`의 출력은 다음과 같습니다.

```yaml
APC      : 001,051,1149
DATE     : 2016-02-09 17:13:31 +0000
HOSTNAME : localhost
VERSION  : 3.14.12 (29 March 2014) redhat
UPSNAME  : netrack
CABLE    : Custom Cable Smart
DRIVER   : APC Smart UPS (any)
UPSMODE  : Stand Alone
STARTTIME: 2016-02-09 16:06:47 +0000
MODEL    : SMART-UPS 1400
STATUS   : TRIM ONLINE
LINEV    : 247.0 Volts
LOADPCT  : 13.0 Percent
BCHARGE  : 100.0 Percent
TIMELEFT : 104.0 Minutes
MBATTCHG : 5 Percent
MINTIMEL : 3 Minutes
MAXTIME  : 0 Seconds
MAXLINEV : 249.6 Volts
MINLINEV : 244.4 Volts
OUTPUTV  : 218.4 Volts
[...]
```

왼쪽 열의 값을 사용하십시오 (소문자 필요).

전체 설정의 예 :

```yaml
sensor:
  - platform: apcupsd
    resources:
      - apc
      - date
      - hostname
      - version
      - upsname
      - cable
      - driver
      - upsmode
      - starttime
      - model
      - status
      - linev
      - loadpct
      - bcharge
      - timeleft
      - mbattchg
      - mintimel
      - maxtime
      - maxlinev
      - minlinev
      - outputv
```
