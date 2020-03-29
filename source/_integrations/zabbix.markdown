---
title: 자빅스(Zabbix)
description: Instructions on how to integrate Zabbix into Home Assistant.
logo: zabbix.png
ha_category:
  - System Monitor
  - Sensor
ha_release: 0.37
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="421" src="https://www.youtube.com/embed/gCrVxbU3KU4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`zabbix` 통합구성요소는 Zabbix API를 통해 [Zabbix](https://www.zabbix.com/) 모니터링 인스턴스에 연결하기위한 주요 통합구성요소입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Sensor](#sensor)

## 설정

Zabbix 통합구성요소를 설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
zabbix:
  host: IP_ADDRESS
```

{% configuration %}
host:
  description: Your Zabbix server.
  required: true
  type: string
path:
  description: Path to your Zabbix install.
  required: false
  type: string
  default: "`/zabbix/`"
ssl:
  description: Set to `true` if your Zabbix installation is using SSL.
  required: false
  type: boolean
  default: false
username:
  description: Your Zabbix username.
  required: false
  type: string
password:
  description: Your Zabbix password.
  required: false
  type: string
{% endconfiguration %}

### 전체 설정

```yaml
# Example configuration.yaml entry
zabbix:
  host: ZABBIX_HOST
  path: ZABBIX_PATH
  ssl: false
  username: USERNAME
  password: PASSWORD
```

## Sensor

`zabbix` 센서 플랫폼을 사용하면 [Zabbix](https://www.zabbix.com/) 모니터링 인스턴스에 대한 현재 활성 트리거 수를 모니터링 할 수 있습니다.

<div class='note'>
해당 센서를 사용하도록 <a href="#configuration">Zabbix component</a>가 설정되어 있어야합니다.
</div>

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: zabbix
    triggers:
      name: Important Hosts Trigger Count
      hostids: [10051,10081,10084]
      individual: true
```

{% configuration %}
triggers:
  description: Specifies that this sensor is for Zabbix 'triggers'. In the future there will be other Zabbix sensors.
  required: true
  type: string
name:
  description: Allows you to specify the name for the Sensor, otherwise the host name, as stored in Zabbix, is used. This is useful when you are specifying a list of hostids to monitor as a single count.
  required: false
  type: string
hostids:
  description: This is a list of Zabbix hostids that we want to filter our count on.
  required: false
  type: string
individual:
  description: A 'true'/'false' to specify whether we should show individual sensors when a list of hostids is provided. If false, the sensor state will be the count of all triggers for the specified hosts (or all hosts within the Zabbix instance, if hostids isn't provided).
  required: false
  type: boolean
  default: false
{% endconfiguration %}
