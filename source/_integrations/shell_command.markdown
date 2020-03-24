---
title: 쉘 명령(Shell Command)
description: Instructions on how to integrate Shell commands into Home Assistant.
ha_category:
  - Automation
logo: home-assistant.png
ha_release: 0.7.6
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

이 통합구성요소는 일반 쉘 명령을 서비스로 노출시킬 수 있습니다. [script] 나 [automation] 를 통해 서비스를 호출 할 수 있습니다 . 셸 명령은 소문자 이름 만 사용하고 이름을 밑줄로 구분하십시오.

[script]: /integrations/script/
[automation]: /getting-started/automation/

```yaml
# Example configuration.yaml entry
# Exposes service shell_command.restart_pow
shell_command:
  restart_pow: touch ~/.pow/restart.txt
```

{% configuration %}
alias:
  description: 쉘 명령에 이름 (별칭)을 변수로 지정하고 콜론 다음에 실행할 명령을 설정하십시오. 예를들어 `alias`:`the shell command you want to execute`.
  required: true
  type: string
{% endconfiguration %}

템플릿을 사용하여 인수값을 삽입하는 명령은 동적 일 수 있습니다. 템플릿을 사용할 때 shell_command는 보다 안전한 환경에서 실행되므로 홈 디렉토리(`~`)를 자동으로 확장하거나 파이프 심볼을 사용하여 여러 명령을 실행하는 등의 shell helpers를 허용하지 않습니다. 마찬가지로 첫 번째 공백 이후의 컨텐츠만 템플릿에서 생성 할 수 있습니다. 즉, 명령 이름 자체는 템플릿으로 생성 할 수 없지만 문자 그대로 제공해야합니다.

셸 명령을 활성화하기 위해 서비스 요청에 전달된 서비스 데이터는 템플릿 내에서 변수로 사용할 수 있습니다.

명령의`stdout` 및`stderr` 출력은 모두 캡처되며 [log level](/integrations/logger/)을 디버그로 설정하여 기록됩니다.

```yaml

# Apply value of a GUI slider to the shell_command
automation:
  - alias: run_set_ac
    trigger:
      platform: state
      entity_id: input_number.ac_temperature
    action:
      service: shell_command.set_ac_to_slider

input_number:
  ac_temperature:
    name: A/C Setting
    initial: 24
    min: 18
    max: 32
    step: 1

{% raw %}
shell_command:
  set_ac_to_slider: 'irsend SEND_ONCE DELONGHI AC_{{ states("input_number.ac_temperature") }}_AUTO'
{% endraw %}
```
