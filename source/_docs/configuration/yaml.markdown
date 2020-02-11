---
title: "YAML"
description: "Details about YAML to configure Home Assistant."
redirect_from: /getting-started/yaml/
---

홈어시스턴트는 설정에 [YAML](https://yaml.org/) 문법을 사용합니다. YAML은 익숙해지기까지 다소 시간이 걸리지 만 복잡한 구성을 표현할 수있는 능력이 있습니다.

홈어시스턴트에서 통합구성요소를 사용하려는 통합의 경우 `configuration.yaml` 파일에 코드를 추가 하여 설정을 합니다. 이는 특히 UI를 통해 구성 할 수 없는 연동 시 적용됩니다. 

다음 예제 항목은 사용자가 설정하고자하는 것으로 [pushbullet platform](/integrations/pushbullet)으로 [notify component](/integrations/notify)을 셋업한 내용입니다.

```yaml
notify:
  platform: pushbullet
  api_key: "o.1234abcd"
  name: pushbullet
```

- **component** 특정 기능을 위한 핵심 로직을 제공합니다. (`notify` 가 통지를 보내는 기능을 제공하는 것처럼).
- **platform** 특정 소프트웨어 또는 하드웨어 플랫폼으로 연결을 만듭니다. (`pushbullet` 가 pushbullet.com에서 서비스로 제공한 내용을 동작시키는 것처럼.).

YAML 문법의 기본 사항은 key-value pair들을 포함하는 블록 모음 및 매핑들입니다. 컬렉션의 각 항목은 `-`로 시작하고 매핑은 `key: value` 형식으로 나타냅니다. 중복된 key를 지정하면 key의 마지막 value가 사용됩니다. 이는 해시 테이블 또는 파이썬의 dictionary와 다소 유사합니다. 마찬가지로 중첩 될 수 있습니다.

들여 쓰기는 YAML을 사용하여 관계를 지정하는 데 중요한 부분입니다. 한 단계 높게 "안쪽으로" 중첩되어 들여쓰기 된 것들 입니다. 위의 예로 보면, `platform: pushbullet`는 `notify` component의 속성입니다. 

고정 폭 글꼴이있는 편집기를 사용하지 않는 경우 올바른 들여 쓰기를 얻는 것이 까다로울 수 있습니다. 들여 쓰기에는 탭을 사용할 수 없습니다. 규칙은 각 들여 쓰기 수준에 2 개의 공백을 사용하는 것입니다.

온라인 서비스 [YAMLLint](http://www.yamllint.com/) 를 사용하여 홈어시스턴트로 로드하기 전에 YAML 구문이 올바른지 확인하면 시간을 절약 할 수 있습니다. 
이 서비스는 타사 서비스이며 홈어시스턴트 커뮤니티에서 유지 관리하지 않습니다.

<div class='note'>

개인 데이터 (암호, API 키 등)를 `configuration.yaml` 파일에 직접 저장하지 않도록 주의하십시오. 개인 데이터는 [별도의 파일](/docs/configuration/secrets/) 또는  [환경 변수](/docs/configuration/yaml/#using-environment-variables)에 저장하여 보안 문제를 피할 수 있습니다. 
</div>

다음에 나오는 문자열 `#` 는 주석이며 시스템에서 무시됩니다.

다음은 옵션 값에 블록 콜렉션을 사용하는 [input_select](/integrations/input_select) 통합구성요소를 보여주는 예시입니다. 다른 속성들 (`name:` 같은) 은 매핑을 사용하여 지정됩니다. 여기서 `threat`는 input_select의 이름이며 그 값은 그 아래에 모두 중첩되어 있습니다.

```yaml
input_select:
  threat:
    name: Threat level
# A collection is used for options
    options:
     - 0
     - 1
     - 2
     - 3
    initial: 0
```

다음 예제는 맵핑에서 맵핑 모음의 중첩을 보여줍니다. 홈 어시스턴트에서는 각각 MQTT 플랫폼을 사용하지만 서로 다른 값을 갖는 `state_topic`(MQTT 센서에 사용되는 특성 중 하나)에 두 개의 센서를 지정할 수 있습니다.  

```yaml
sensor:
  - platform: mqtt
    state_topic: sensor/topic
  - platform: mqtt
    state_topic: sensor2/topic
```

## 값을 포함시키기

### 환경 변수

`!env_var`로 시스템 환경 변수의 값을 포함시킬 수 있습니다. 이는 이를 지정할 수 있는 시나리오에서만 작동합니다. Hass.io 유저는 `!include` 를 대체하여 사용하는 것을 추천합니다.

```yaml
example:
  password: !env_var PASSWORD
```

#### 기본값

환경 변수가 설정되지 않은 경우 기본값으로 대체 할 수 있습니다.

```yaml
example:
  password: !env_var PASSWORD default_password
```

### 전체 파일 포함시키기

가독성을 높이기 위해 `!include` 문법을 이용하여 현재 domain에서 특정 다른 domain으로 내용을 나눌 수가 있습니다. 

```yaml
lights: !include lights.yaml
```

이 기능에 대한 자세한 내용은 [splitting configuration](/docs/configuration/splitting_configuration/) 참조.

## 일반적인 문제

### 발견 된 문자 '\t'

다음 메시지가 표시되면 :

```txt
found character '\t' that cannot start any token
```

이것은 공백 대신 실수로 탭 문자를 입력했음을 의미합니다.

### 대문자와 소문자

홈 어시스턴트는 대소 문자를 구분하며 `'on'`상태는 `'On'`, `'ON'`과 같지 않습니다. 마찬가지로의 entity도 `group.Doors`와`group.doors`는 같지 않습니다

문제가 있는 경우 *Developer tools* 아래에 dev 상태 메뉴에서 홈 어시스턴트가 보고하는 상황을 확인하십시오.