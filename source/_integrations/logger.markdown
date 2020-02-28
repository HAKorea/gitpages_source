---
title: 로거(Logger)
description: Instructions on how to enable the logger integration for Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_release: 0.8
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`logger` 통합구성요소는 홈어시스턴트 활동 로깅 레벨을 정의할 수 있습니다.


```yaml
logger:
```

모든 메시지를 기록하고 특정 구성 요소에 대한 위험보다 낮은 이벤트를 무시하려면 :

```yaml
logger:
  default: info
  logs:
    homeassistant.components.yamaha: critical
    custom_components.my_integration: critical
```

특정 구성 요소에 대해 위험 및 로그 이벤트보다 낮은 모든 메시지를 무시하려면 다음을 수행하십시오. :

```yaml
logger:
  default: critical
  logs:
    # log level for HA core
    homeassistant.core: fatal
    
    # log level for MQTT integration
    homeassistant.components.mqtt: warning
    
    # log level for all python scripts
    homeassistant.components.python_script: warning
    
    # individual log level for this python script
    homeassistant.components.python_script.my_new_script.py: debug
    
    # log level for SmartThings lights
    homeassistant.components.smartthings.light: info

    # log level for a custom component
    custom_components.my_integration: debug

    # log level for the `aiohttp` Python package
    aiohttp: error

    # log level for both 'glances_api' and 'glances' integration
    homeassistant.components.glances: fatal
    glances_api: fatal
```

The log entries are in the form  *timestamp* *log-level* *thread* [**namespace**] *message*  where **namespace** is the *<component_namespace>* currently logging. 
로그 항목은 *timestamp* *log-level* *thread* [**namespace**] *메시지* 여기서 **namespace**는 *<component_namespace>* 현재 로깅입니다.

{% configuration %}
  default:
    description: 기본 log level. [log_level](#log-levels) 참조.
    required: false
    type: string
    default: debug
  logs:
    description: 연동 목록 및 해당 log level.
    required: false
    type: map
    keys:
      '&lt;component_namespace&gt;':
        description: 구성 요소의 로거 네임 스페이스. [log_level](#log-levels) 참고.
        type: string
{% endconfiguration %}

이 예에서 'glances_api'와 'homeassistant.components.glances' 네임스페이스의 차이점에 주목하십시오. 
다른 API에 의해 기록됩니다.

자신의 환경에서 네임스페이스를 알고 싶다면 시작시 로그 파일을 확인하십시오.
homeassistant.loader에서 `loaded <component> from <namespace>`의 상태를 확인했다는 INFO log가 메시지가 표시됩니다.
이것들이 `log level`을 설정할 수있는 네임 스페이스입니다.

### 로그 레벨 (Log Levels)

가장 문제있는 것부터 덜 문제있는 것까지 순서대로 나열된 가능한 로그 문제 수준(severity levels)은 다음과 같습니다.

- critical
- fatal
- error
- warning
- warn
- info
- debug
- notset

## 서비스 (Services)

### `set_default_level` 서비스

`logger.set_default_level` 서비스를 사용하여 기본 로그 수준으로 변경할 수 있습니다. (지정된 로그 레벨이 없는 연동의 경우).

예제 호출은 다음과 같습니다. :

```yaml
service: logger.set_default_level
data:
  level: info
```

### `set_level` 서비스

`logger.set_level` 서비스를 사용하여 하나 이상의 연동에 대한 로그 수준을 변경할 수 있습니다. 설정에서 `logs`와 동일한 형식을 허용합니다.

예제 호출은 다음과 같습니다. :

```yaml
service: logger.set_level
data:
  homeassistant.core: fatal
  homeassistant.components.mqtt: warning
  homeassistant.components.smartthings.light: info
  custom_components.my_integration: debug
  aiohttp: error
```


Hass.io 사용자 인 경우 [SSH 애드온] (/ addons / ssh /)을 통해 로그인 할 때 아래 예를 사용할 수 있습니다. :

```bash
$ tail -f /config/home-assistant.log
```

Docker에서는 호스트 명령 줄을 직접 사용할 수 있습니다. - 동적으로 로그를 확인합니다 : 

```bash
# follow the log dynamically
docker logs --follow  MY_CONTAINER_ID
```

다른 옵션을 보려면 대신 `--help`를 사용하거나 전체 로그를 표시하는 옵션없이 그대로 두십시오.