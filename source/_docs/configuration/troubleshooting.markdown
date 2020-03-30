---
title: "설정 문제 해결"
description: "Common problems with tweaking your configuration and their solutions."
redirect_from: /getting-started/troubleshooting-configuration/
---

홈어시스턴트를 설정하는 중에 문제가 발생할 수 있습니다. 통합구성요소가 표시되지 않거나 이상하게 작동하는 것 같습니다.  이 페이지에서는 가장 일반적인 몇가지 문제에 대해 설명합니다.

일반적인 문제를 다루기 전에 configuaration 디렉토리의 위치를 ​​확인하십시오. 홈어시스턴트는 시작할 때 사용중인 설정 디렉토리를 보여줍니다.

통합구성요소 또는 설정 옵션이 경고를 보여줄 때마다, `home-assistant.log` configuaration 디렉토리에 저장됩니다.  이 파일은 홈어시스턴트 시작시 재설정됩니다.

### 통합구성요소가 나타나지 않습니다

통합구성요소가 나타나지 여러가지 경우의 수를 생각할 수 있습니다. 이러한 단계를 수행하기 전에 `home-assistant.log`파일을 보고 설정하려는 통합구성요소와 관련된 오류가 있는지 확인하십시오.

설정 파일에 잘못된 항목이 있는 경우 [`check_config`](/docs/tools/check_config/) 스크립트를 사용하여 해당 항목을 식별할 수 있습니다 : `hass --script check_config`. 설정 경로를 제공해야하는 경우 다음 `-c` 인수를 사용하여 다음과 같은 명령을 수행할 수 있습니다 : `hass --script check_config -c /path/to/your/config/dir`.

#### 설정에 관한 문제

Home Assistant의 가장 일반적인 문제중 하나는 유효하지 않은 `configuration.yaml` 설정이거나 configuaration 파일이 다른 것일 경우입니다. 
 
- 홈어시스턴트로 [`ha` command](/hassio/commandline/#home-assistant) 사용 가능합니다. : `ha core check`.
  - `hass --script check_config` command line을 사용하여 Home Assistant Core로 설정을 테스트할 수 있습니다.
  - Docker에서는 `docker exec home-assistant python -m homeassistant --script check_config --config /config`를 사용할 수 있습니다. 여기서 `home-assistant`는 컨테이너의 이름입니다.


 - 설정 파일들, `configuration.yaml` 포함 모두 UTF-8 인코딩을 씁니다. `'utf-8' codec can't decode byte` 와 같은 오류가 표시되면, 문제가 되는 설정내용을 편집하여 UTF-8로 다시 저장합니다.
 - [this online YAML parser](http://yaml-online-parser.appspot.com/) 혹은 [YAML Lint](http://www.yamllint.com/)를 사용하여 설정의 yaml 구조를 확인할 수 있습니다. 
 - YAML의 특성에 대해 자세히 알아보려면, SaltStack 사이트에서 [YAML IDIOSYNCRASIES](https://docs.saltstack.com/en/latest/topics/troubleshooting/yaml_idiosyncrasies.html), (SaltStack에서 별도로 분석한 예제이지만 YAML 문제를 잘 설명하고 있습니다).

`configuration.yaml` 파일은 여러 섹션에 동일한 이름을 가질 수 없습니다. 하나의 구성요소에 여러 플랫폼을 로드하려는 경우, 이름에 [숫자 혹은 문자열](/getting-started/devices/#style-2-list-each-device-separately)을 추가하거나 [스타일](/getting-started/devices/#style-1-collect-every-entity-under-the-parent)을 사용하여 중첩시킬 수 있습니다. :

```yaml
sensor:
  - platform: forecast
    ...
  - platform: bitcoin
    ...
```

또 다른 일반적인 문제는 필요한 설정 세팅이 누락된 것입니다. 이 경우에 통합구성요소는 이 내용을 `home-assistant.log`로 보고합니다. 구성요소 설정 방법에 대한 지시 사항은 [다양한 통합구성요소](/integrations/)를 보면 확인할 수 있습니다. 

특정 모듈에 필요한 로깅 레벨을 정의하는 방법에 대한 지시 사항은 [logger](/integrations/logger/) 통합구성요소를 참조하십시오. 

오류가 있거나 설명서를 추가시키고 싶으시면, [알려주시기](https://github.com/home-assistant/home-assistant.io/issues) 바랍니다.

#### 의존성 문제

거의 모든 통합구성요소에는 장치 및 서비스와 통신하기위한 외부 종속성이 있습니다. 때로는 홈어시스턴트가 종속성으로인해 설치할 수 없는 경우가 있습니다. 이 경우에 `home-assistant.log`에 나타납니다 .

첫 번째 단계는 홈어시스턴트를 다시 시작하고 문제가 지속되는지 확인해 봅니다. 계속 그렇다면 로그를 보고 오류가 무엇인지 확인하십시오. 파악할 수 없는 경우 진행상황을 조사할 수 있도록 [report it](https://github.com/home-assistant/home-assistant/issues)으로 내용을 전달해주십시오.

#### 통합구성요소 연동 문제

홈어시스턴트가 잠시 실행된 후 일부 통합구성요소가 작동하지 않거나 작동을 멈출 수 있습니다. 이런 일이 발생하면, [report it](https://github.com/home-assistant/home-assistant/issues)로 알려주시길 바랍니다.

#### 여러 파일 중복

설정에 여러 파일을 사용하는 경우 포인터가 올바르게 지정되고 파일 형식이 유효한지 확인하십시오.

```yaml
light: !include devices/lights.yaml
sensor: !include devices/sensors.yaml
```
`lights.yaml`의 내용 (이럴 경우 `light:`는 아래와 같이 별도 관리):

```yaml
- platform: hyperion
  host: 192.168.1.98
  ...
```

`sensors.yaml`의 내용:

```yaml
- platform: mqtt
  name: "Room Humidity"
  state_topic: "room/humidity"
- platform: mqtt
  name: "Door Motion"
  state_topic: "door/motion"
  ...
```

<div class='note'>
문제를 보고할 때마다, 전 세계의 모든 단일 장치에 액세스할 수 없거나 모든 문제를 해결할 수 있는 시간이 무제한인 자원 봉사자들은 아니라는 건 이해해주십시오.
</div>

### Entity 이름

entity 이름에 유효한 문자 형식은 다음과 같습니다. :

* 소문자
* 번호
* 밑줄

다른 문자로 entity를 작성하면 홈어시스턴트가 해당 entity에 대한 오류를 생성하지 않을 수 있습니다. 그러나 해당 entity를 사용하려고 하면 오류가 발생하거나 자동으로 실패할 수 있습니다. (이는 소리없이 제대로된 설정이 안될 수 있습니다.)
