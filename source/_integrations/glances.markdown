---
title: Glances 시스템 모니터
description: Instructions on how to integrate Glances sensors into Home Assistant.
logo: glances.png
ha_category:
  - System Monitor
ha_iot_class: Local Polling
ha_release: 0.7.3
ha_config_flow: true
ha_codeowners:
  - '@fabaff'
  - '@engrbm87'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/m9qIqq104as" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

glances 통합구성요소는 기본적으로 [glance Addon](https://github.com/hassio-addons/addon-glances)이 지원됨으로 홈어시스턴트의 Supervisor -> DASHBOARD에서 `glance add-on` 을 찾아 설치합니다. 

------------------------------------------------------------------------------------------------------------------
차후 번역 예정

`glances` 통합구성요소를 통해 [Glances](https://github.com/nicolargo/glances) API에서 제공하는 시스템 정보를 모니터링 할 수 있습니다. 이를 통해 원격 호스트를 추적하고 통계를 Home Assistant에 표시할 수 있습니다.

## 셋업

이러한 센서는 호스트에서 실행중인 `glances` 인스턴스가 필요합니다. 지원되는 `glances`의 최소 버전은 2.3입니다.
기본 포트 61208에서 Glances RESTful API 서버를 시작한 후 다음 명령을 사용하여 테스트할 수 있습니다.

```bash
$ sudo glances -w
Glances web server started on http://0.0.0.0:61208/
```

`http://IP_ADRRESS:61208/api/3`에 있는 API에 액세스할 수 있는지 확인하십시오. 61209 포트에서 XMLRPC 서버를 시작하므로 `-s`를 사용하지 마십시오. 홈어시스턴트는 GLANCES의 REST API 만 지원합니다.

메모리 사용량에 대한 세부 사항은 JSON 응답으로 제공됩니다. 그렇다면 계속 진행하십시오.

```bash
$ curl -X GET http://IP_ADDRESS:61208/api/3/mem/free
{"free": 203943936}
```

그래도 문제가 해결되지 않으면 최신 버전의 Glance가 설치되어 있지 않으면 `3`을 `2`로 변경해보십시오.

`glances` 자동 시작에 대한 자세한 내용은 [Start Glances through Systemd](https://github.com/nicolargo/glances/wiki/Start-Glances-through-Systemd)을 참조하십시오.

## 설정

**설정 -> 통합구성요소 -> Glances**를 통해 연동을 설정하십시오. `configuration.yaml`에서 설정을 가져 오려면 플랫폼 유형이 `glances`인 이전에 설정된 센서를 제거하고 다음 행을 추가하십시오. : 

```yaml
# Example configuration.yaml entry
glances:
  - host: IP_ADDRESS
```

{% configuration %}
host:
  description: IP address of the host where Glances is running.
  required: false
  type: string
  default: localhost
port:
  description: The port where Glances is listening.
  required: false
  type: integer
  default: 61208
name:
  description: The prefix for the sensors.
  required: false
  type: string
  default: Glances
username:
  description: Your username for the HTTP connection to Glances.
  required: false
  type: string
password:
  description: Your password for the HTTP connection to Glances.
  required: false
  type: string
ssl:
  description: "If `true`, use SSL/TLS to connect to the Glances system."
  required: false
  type: boolean
  default: false
verify_ssl:
  description: Verify the certification of the system.
  required: false
  type: boolean
  default: true
version:
  description: "The version of the Glances API. Supported version: `2` and `3`."
  required: false
  type: integer
  default: 3
{% endconfiguration %}

## 연동시 엔티티들

Glances 통합구성요소에 다음 센서가 추가됩니다. : 

- disk_use_percent: The used disk space in percent.
- disk_use: The used disk space.
- disk_free: The free disk space.
- memory_use_percent: The used memory in percent.
- memory_use: The used memory.
- memory_free: The free memory.
- swap_use_percent: The used swap space in percent.
- swap_use: The used swap space.
- swap_free: The free swap space.
- processor_load: The load.
- process_running: The number of running processes.
- process_total: The total number of processes.
- process_thread: The number of threads.
- process_sleeping: The number of sleeping processes.
- cpu_use_percent: The used CPU in percent.
- cpu_temp: The CPU temperature (may not be available on all platforms).
- docker_active: The count of active Docker containers.
- docker_cpu_use: The total CPU usage in percent of Docker containers.
- docker_memory_use: The total memory used by Docker containers.

모든 플랫폼이 모든 metrics을 제공할 수 있는 것은 아닙니다. 예를 들어 `cpu_temp`는 우분투에서 `lmsensors`를 설치하고 설정해야하며 다른 플랫폼에서는 전혀 사용하지 못할 수 있습니다.