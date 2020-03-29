---
title: "설정 나누기"
description: "Splitting the configuration.yaml into several files."
redirect_from: /topics/splitting_configuration/
---

지금까지 홈어시스턴트를 사용하면서 configuration.yaml 파일을 분리시키거나 분산된 접근으로 시작하고 싶은 단순한 바램이 있어왔습니다, 여기 "configuration.yaml 나누기" 라는 방법으로 더욱 관리하기 용이한 방법(읽기 매우 편한)을 제시합니다.

먼저, 여러 커뮤니티 회원들이 갈고 닦은 여러 보기 편한 여러 설정들(api key, 패스워드는 제외된) 설정들을 [여기서](/cookbook/#example-configurationyaml) 볼 수 있을 것입니다, 

주석코드들이 언제나 적혀있지 않음으로, 자세히 읽어보십시오. 

이 방법으로 `configuaration.yaml`을 읽어내려가며 이론적 가정하에 설정을 참조하며 바꿔넣더라도, 아무리 보아도 어수선한 것은 사실입니다. 

이 가벼운 버전에서는 core snippet이라고 불리는 것이 여전히 필요합니다.

```yaml
homeassistant:
  # Name of the location where Home Assistant is running
  name: My Home Assistant Instance
  # Location required to calculate the time the sun rises and sets
  latitude: 37
  longitude: -121
  # 'metric' for Metric, 'imperial' for Imperial
  unit_system: imperial
  # Pick yours from here: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time_zone: America/Los_Angeles
  customize: !include customize.yaml
```

`homeassistant:` 이후 각 줄은 2 칸 들여쓰기됩니다. 홈어시스턴트의 설정 파일은 YAML 언어를 기반으로하기 때문에 들여쓰기와 간격이 중요합니다. 또한 아래 보기에 이상한 `customize:` 항목을 주목하십시오.    

`!include filename.yaml`는 해당 지점에 `filename.yaml` 내용을 삽입하도록 홈어시스턴트에 지시하는 명령문입니다.
이것이 우리가 뭉쳐져있고 읽기 어려운 파일(큰 파일일 때)보다 관리하기 쉬운 덩어리로 나누는 방법입니다. 

이제 다른 컴포넌트를 분리하기 전에 기본 파일에 남을 다른 연동(예제)을 살펴 보겠습니다.:

```yaml
history:
frontend:
logbook:
http:
  api_password: ImNotTelling!

ifttt:
  key: [nope]

wink:
  access_token: [wouldn't you]
  refresh_token: [like to know]

zwave:
  usb_path: /dev/ttyUSB0
  config_path: /usr/local/share/python-openzwave/config
  polling_interval: 10000

mqtt:
  broker: 127.0.0.1
```
core snippet과 마찬가지로 들여쓰기로 차이를 만듭니다. 통합구성요소인 헤더(`mqtt:`)는 완전히 좌측 정렬된 상태(인덴트 없음)여야 하고 매개 변수 (`broker:`)는 2 칸 들여쓰기해야합니다.

이러한 연동 중 일부는 기술적으로 별도의 파일로 옮길 수 있지만 너무 작거나 "일회성 (one off)"으로 분리할 필요가 없는 경우도 있습니다. 또한 # 기호 (hash/pound)가 표시된다는 걸 알게 될 것입니다. 이는 명령이 해석되지 않는 "주석"을 나타냅니다. 다시 말하면 접두사가 a 인 모든 행 #은 무시됩니다. 따라서 항목을 그대로 유지하면서 기능을 끄는 것은 말할 것도 없이 사람이 읽을 수 있도록 파일을 분할하는 것이 매우 편리합니다. 

이제 홈어시스턴트 설정 디렉토리에 다음 각 항목에 대해 빈 파일이 작성되었다고 가정하십시오.

```text
automation.yaml
zone.yaml
sensor.yaml
switch.yaml
device_tracker.yaml
customize.yaml
```

`automation.yaml`은 모든 자동화 연동 세부 사항을 보유합니다. `zone.yaml`은 zone의 여러가지 연동 세부 사항 등을 유지합니다. 이러한 파일은 무엇이든 호출 할 수도 있지만 기능과 일치하는 이름을 지정하면 추적하기가 쉬워집니다.

기본 설정 파일 내에 다음 항목을 추가하십시오.:

```yaml
automation: !include automation.yaml
zone: !include zone.yaml
sensor: !include sensor.yaml
switch: !include switch.yaml
device_tracker: !include device_tracker.yaml
```

통합구성요소마다 `!include`는 하나만 있을 수 있으므로 이들을 연결시키는 것은 작동하지 않습니다. 

자, 기본 파일에 단일 통합 및 include 문이 있습니다. 추가 파일에 무엇이 들어 있습니까?

`device_tracker.yaml` 예제파일을 보십시오 :

```yaml
- platform: owntracks
- platform: nmap_tracker
  hosts: 192.168.2.0/24
  home_interval: 3

  track_new_devices: true
  interval_seconds: 40
  consider_home: 120
```

이 작은 예는 "분할" 파일의 작동 방식을 보여줍니다. 이 경우 두 개의 장치 추적기 항목(`owntracks`, `nmap`)으로 시작합니다. 이 파일은 ["style 1"](/getting-started/devices/#style-2-list-each-device-separately) 즉, 완전히 왼쪽으로 정렬된 선행 항목(`- platform: owntracks`) 다음에 2 개의 공백으로 들여쓴 매개 변수 항목이 있습니다.

이 (방대한) 센서 설정은 또 다른 예를 제공합니다. :

```yaml
### sensor.yaml
### METEOBRIDGE #############################################
- platform: tcp
  name: 'Outdoor Temp (Meteobridge)'
  host: 192.168.2.82
  timeout: 6
  payload: "Content-type: text/xml; charset=UTF-8\n\n"
  value_template: "{% raw %}{{value.split (' ')[2]}}{% endraw %}"
  unit: C
- platform: tcp
  name: 'Outdoor Humidity (Meteobridge)'
  host: 192.168.2.82
  port: 5556
  timeout: 6
  payload: "Content-type: text/xml; charset=UTF-8\n\n"
  value_template: "{% raw %}{{value.split (' ')[3]}}{% endraw %}"
  unit: Percent

#### STEAM FRIENDS ##################################
- platform: steam_online
  api_key: [not telling]
  accounts:
      - 76561198012067051

#### TIME/DATE ##################################
- platform: time_date
  display_options:
      - 'time'
      - 'date'
- platform: worldclock
  time_zone: Etc/UTC
  name: 'UTC'
- platform: worldclock
  time_zone: America/New_York
  name: 'Ann Arbor'
```

이 예제에는 2 차 매개 변수 섹션 (steam 섹션 아래)과 주석을 사용하여 파일을 섹션으로 나누는 방법에 대한 더 나은 예가 포함되어 있습니다.

이제 마무리합니다.

설정 디렉토리 및 들여쓰기에 문제가 있는 경우 `home-assistant.log`를 체크하십시오. 그럼에도 불구하고 잘되지 않는다면, [Discord chat server][discord]에 와서 상담을 하십시오.  

### 여러 설정 파일 디버깅

설정 파일이 많은 경우, `check_config` 스크립트를 사용하면 홈어시스턴트가 해당 파일을 해석하는 방법을 확인할 수 있습니다. :
- 로드된 모든 파일 나열 : `hass --script check_config --files`
- 구성요소(component) 설정보기 : `hass --script check_config --info light`
- 또는 모든 구성요소(component)의 설정보기 :  `hass --script check_config --info all`

다음을 사용하여 commans line에서 도움을 받을 수 있습니다. : `hass --script check_config --help`

### 고급 사용법

우리는 한 번에 전체 디렉토리를 포함하는 네 가지 고급 옵션을 제공합니다. 파일은 `.yaml` 파일 확장자를 가져야합니다.; `.yml`은 지원되지 않습니다.
- `!include_dir_list`는 디렉토리의 내용을 목록으로 반환하며 각 파일 내용은 목록의 항목입니다. 목록 항목은 파일 이름의 영숫자 순서에 따라 정렬됩니다.
- `!include_dir_named`는 디렉토리의 내용을 파일 이름으로 매핑하는 사전(dictionary)으로 반환합니다. => 파일의 내용.
- `!include_dir_merge_list`은 모든 파일 (목록을 포함해야 함)을 하나의 큰 목록으로 병합하여 디렉토리의 내용을 목록으로 반환합니다.
- `!include_dir_merge_named`은 각 파일을 로드하고 하나의 큰 사전에 병합하여 디렉토리의 내용을 사전으로 반환합니다.

이들은 재귀적으로 작동합니다. `!include_dir_* automation`를 사용한 예로서, 아래에 표시된 6 개의 파일이 모두 포함됩니다. :

```bash
.
└── .homeassistant
    ├── automation
    │   ├── lights
    │   │   ├── turn_light_off_bedroom.yaml
    │   │   ├── turn_light_off_lounge.yaml
    │   │   ├── turn_light_on_bedroom.yaml
    │   │   └── turn_light_on_lounge.yaml
    │   ├── say_hello.yaml
    │   └── sensors
    │       └── react.yaml
    └── configuration.yaml (not included)
```

#### 예시: `!include_dir_list`

`configuration.yaml`

```yaml
automation:
  - alias: Automation 1
    trigger:
      platform: state
      entity_id: device_tracker.iphone
      to: 'home'
    action:
      service: light.turn_on
      entity_id: light.entryway
  - alias: Automation 2
    trigger:
      platform: state
      entity_id: device_tracker.iphone
      from: 'home'
    action:
      service: light.turn_off
      entity_id: light.entryway
```

이렇게 바꿀 수 있습니다. :

`configuration.yaml`

```yaml
automation: !include_dir_list automation/presence/
```

`automation/presence/automation1.yaml`

```yaml
alias: Automation 1
trigger:
  platform: state
  entity_id: device_tracker.iphone
  to: 'home'
action:
  service: light.turn_on
  entity_id: light.entryway
```

`automation/presence/automation2.yaml`

```yaml
alias: Automation 2
trigger:
  platform: state
  entity_id: device_tracker.iphone
  from: 'home'
action:
  service: light.turn_off
  entity_id: light.entryway
```

`!include_dir_list`를 사용할때 각 파일에는 **하나**의 항목만 포함되어야합니다. 
자동화 UI를 지원하기 위해 -id:를 추가한 후 파일을 분할하는 경우 각 분할 파일에서 -id: 행을 제거해야합니다.

#### 예시: `!include_dir_named`

`configuration.yaml`

```yaml
{% raw %}
alexa:
  intents:
    LocateIntent:
      action:
        service: notify.pushover
        data:
          message: Your location has been queried via Alexa.
      speech:
        type: plaintext
        text: >
          {%- for state in states.device_tracker -%}
            {%- if state.name.lower() == User.lower() -%}
              {{ state.name }} is at {{ state.state }}
            {%- endif -%}
          {%- else -%}
            I am sorry. Pootie! I do not know where {{User}} is.
          {%- endfor -%}
    WhereAreWeIntent:
      speech:
        type: plaintext
        text: >
          {%- if is_state('device_tracker.iphone', 'home') -%}
            iPhone is home.
          {%- else -%}
            iPhone is not home.
          {% endif %}{% endraw %}
```

이렇게 바꿀 수 있습니다 :

`configuration.yaml`

```yaml
alexa:
  intents: !include_dir_named alexa/
```

`alexa/LocateIntent.yaml`

```yaml
{% raw %}
action:
  service: notify.pushover
  data:
    message: Your location has been queried via Alexa.
speech:
  type: plaintext
  text: >
    {%- for state in states.device_tracker -%}
      {%- if state.name.lower() == User.lower() -%}
        {{ state.name }} is at {{ state.state }}
      {%- endif -%}
    {%- else -%}
      I am sorry. Pootie! I do not know where {{User}} is.
    {%- endfor -%}{% endraw %}
```

`alexa/WhereAreWeIntent.yaml`

```yaml
{% raw %}
speech:
  type: plaintext
  text: >
    {%- if is_state('device_tracker.iphone', 'home') -%}
      iPhone is home.
    {%- else -%}
      iPhone is not home.
    {% endif %}{% endraw %}
```

#### 예시: `!include_dir_merge_list`

`configuration.yaml`

```yaml
automation:
  - alias: Automation 1
    trigger:
      platform: state
      entity_id: device_tracker.iphone
      to: 'home'
    action:
      service: light.turn_on
      entity_id: light.entryway
  - alias: Automation 2
    trigger:
      platform: state
      entity_id: device_tracker.iphone
      from: 'home'
    action:
      service: light.turn_off
      entity_id: light.entryway
```

이렇게 바꿀 수 있습니다 :

`configuration.yaml`

```yaml
automation: !include_dir_merge_list automation/
```

`automation/presence.yaml`

```yaml
- alias: Automation 1
  trigger:
    platform: state
    entity_id: device_tracker.iphone
    to: 'home'
  action:
    service: light.turn_on
    entity_id: light.entryway
- alias: Automation 2
  trigger:
    platform: state
    entity_id: device_tracker.iphone
    from: 'home'
  action:
    service: light.turn_off
    entity_id: light.entryway
```

`!include_dir_merge_list`를 사용할 때, 각 파일에 목록을 포함해야합니다 (각 목록 항목은 하이픈 [-]으로 표시됨).  각 파일에는 하나 이상의 항목이 포함될 수 있습니다.

#### 예시: `!include_dir_merge_named`

`configuration.yaml`

```yaml
group:
  bedroom:
    name: Bedroom
    entities:
      - light.bedroom_lamp
      - light.bedroom_overhead
  hallway:
    name: Hallway
    entities:
      - light.hallway
      - thermostat.home
  front_yard:
    name: Front Yard
    entities:
      - light.front_porch
      - light.security
      - light.pathway
      - sensor.mailbox
      - camera.front_porch
```

이렇게 바꿀 수 있습니다. :

`configuration.yaml`

```yaml
group: !include_dir_merge_named group/
```

`group/interior.yaml`

```yaml
bedroom:
  name: Bedroom
  entities:
    - light.bedroom_lamp
    - light.bedroom_overhead
hallway:
  name: Hallway
  entities:
    - light.hallway
    - thermostat.home
```

`group/exterior.yaml`

```yaml
front_yard:
  name: Front Yard
  entities:
    - light.front_porch
    - light.security
    - light.pathway
    - sensor.mailbox
    - camera.front_porch
```

[discord]: https://discord.gg/c5DvZ4e
