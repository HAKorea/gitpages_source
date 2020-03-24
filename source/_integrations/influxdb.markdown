---
title: InfluxDB 데이터베이스
description: Record events in InfluxDB.
logo: influxdb.png
ha_category:
  - History
  - Sensor
ha_release: 0.9
ha_iot_class: Configurable
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/m9qIqq104as" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`influxdb` 통합구성요소를 통해 모든 상태 변경을 외부 [InfluxDB](https://influxdb.com/) 데이터베이스로 전송할 수 있습니다. nfluxDB 데이터베이스 설정 방법은 [공식 설치 문서](https://docs.influxdata.com/influxdb/v1.7/introduction/installation/)를 참조하십시오. 혹은 Hass.io를 사용하는 경우 [Add-on 추가 기능](https://community.home-assistant.io/t/community-hass-io-add-on-influxdb/54491)이 있습니다. 가장 쉬운 방법으로 Add-on 추가를 추천합니다. 

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :

- [Sensor](#sensor)

<div class='note'>

`influxdb` 데이터베이스 통합은 Home Assistant 데이터베이스와 병렬로 실행됩니다. 대체하지는 않습니다.

</div>

## 설정 

기본 InfluxDB 설정은 인증을 강제하지 않습니다. Home Assistant가 실행중인 동일한 호스트에 InfluxDB를 설치했으며 설정을 변경하지 않은 경우`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
influxdb:
```

여전히 InfluxDB의  command line 인터페이스를 통해 `home_assistant`라는 데이터베이스를 만들어야합니다. 데이터베이스 작성 방법에 대한 지시 사항은 설치 한 버전과 관련된 [InfluxDB documentation](https://docs.influxdata.com/influxdb/latest/introduction/getting_started/#creating-a-database)를 확인하십시오.

{% configuration %}
host:
  type: string
  description: "데이터베이스 호스트의 IP 주소 (예 : 192.168.1.10)"
  required: false
  default: localhost
port:
  type: integer
  description: 사용할 포트
  required: false
  default: 8086
username:
  type: string
  description: 데이터베이스 사용자의 사용자 이름. 사용자는 데이터베이스에 대한 읽기 / 쓰기 권한이 필요합니다
  required: false
password:
  type: string
  description: 데이터베이스 사용자 계정의 비밀번호
  required: false
database:
  type: string
  description: 사용할 데이터베이스 이름. 데이터베이스가 이미 존재해야합니다.
  required: false
  default: home_assistant
ssl:
  type: boolean
  description: http 대신 https를 사용하여 연결
  required: false
  default: false
verify_ssl:
  type: boolean
  description: https 요청에 대한 SSL 인증서를 확인.
  required: false
  default: true
max_retries:
  type: integer
  description: 데이터를 전송할 때 네트워크 오류가 있는 경우 연동이 재시도되도록 하려면 이 값을 설정하십시오..
  required: false
  default: 0
default_measurement:
  type: string
  description: 엔터티에 단위가 없을 때 사용할 측정 이름. 
  required: false
  default: 엔티티의 엔티티 ID를 사용
override_measurement:
  type: string
  description:  단위 또는 기본 측정 대신 사용할 측정 이름. 모든 데이터 포인트를 단일 측정에 저장합니다.
  required: false
exclude:
  type: list
  description:  nfluxDB에 기록에서 제외 할 통합구성요소를 설정.
  required: false
  keys:
    entities:
      type: list
      description:  InfluxDB에 기록에서 제외 할 엔티티 ID 목록
      required: false    
    domains:
      type: list
      description:  InfluxDB에 기록에서 제외 할 도메인 목록.
      required: false
include:
  type: list
  description: influxDB의 레코딩에 포함할 통합구성요소를 설정하십시오. 설정된 경우 다른 모든 엔터티는 InfluxDB에 **기록되지 않습니다.** 제외 목록에서 설정한 값이 우선합니다.
  required: false
  keys:
    entities:
      type: [string, list]
      description:  InfluxDB에 기록하는 데 포함될 엔티티 ID 목록.
      required: false    
    domains:
      type: [string, list]
      description:  InfluxDB에 기록하는 데 포함될 도메인 목록.
      required: false
tags:
  type: [string, list]
  description: 데이터를 표시하는 태그.
  default: 0
tags_attributes:
  type: [string, list]
  description: InfluxDB에 필드가 아닌 태그로 보고되어야하는 속성 이름 목록. 예를 들어 `friendly_name` 으로 설정하면 ID뿐만 아니라 엔티티의 이름으로도 그룹화 할 수 있습니다.
  required: false
  default: 0
component_config:
  type: string
  required: false
  description: 이 속성은 구성 요소 특정 대체 값을 포함합니다. 형식은 [Customizing devices and services](/getting-started/customizing-devices/)를 참조하십시오.
  keys:
    override_measurement:
      type: string
      description:  단위 또는 기본 측정 대신 사용할 측정 이름. 모든 데이터 포인트를 단일 측정에 저장합니다.
      required: false
component_config_domain:
  type: string
  required: false
  description: 이 속성에는 도메인 별 통합구성요소 대체값이 포함됩니다. 형식은 [Customizing devices and services](/getting-started/customizing-devices/)를 참조하십시오.
  keys:
    override_measurement:
      type: string
      description:  단위 또는 기본 측정 대신 사용할 측정 이름. 모든 데이터 포인트를 단일 측정에 저장합니다.
      required: false
component_config_glob: 
  type: string
  required: false
  description: 이 속성은 구성 요소 특정 대체 값을 포함합니다. 형식은 [Customizing devices and services](/getting-started/customizing-devices/)를 참조하십시오.
  keys:
    override_measurement:
      type: string
      description:  단위 또는 기본 측정 대신 사용할 측정 이름. 모든 데이터 포인트를 단일 측정에 저장합니다.
      required: false
{% endconfiguration %}

## Examples

### Full configuration

```yaml
influxdb:
  host: 192.168.1.190
  port: 20000
  database: DB_TO_STORE_EVENTS
  username: MY_USERNAME
  password: MY_PASSWORD
  ssl: true
  verify_ssl: true
  max_retries: 3
  default_measurement: state
  exclude:
    entities:
       - entity.id1
       - entity.id2
    domains:
       - automation
  include:
    entities:
       - entity.id3
       - entity.id4
  tags:
    instance: prod
    source: hass
```

## 센서 

`influxdb` 센서를 사용하면 [InfluxDB](https://influxdb.com/) 데이터베이스의 값을 사용하여 센서 상태를 채울 수 있습니다. 
`influxdb` 히스토리 구성 요소와 함께 사용되는 경우 home_assistant 센서에 대한 통계를 제공하는 데 사용할 수 있습니다. 외부 데이터 소스와 함께 사용할 수도 있습니다.

이 센서를 구성하려면 센서 연결 변수와 `configuration.yaml` 파일에 대한 쿼리 목록을 정의해야합니다. 각 쿼리마다 센서가 생성됩니다. :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: influxdb
    queries:
      - name: mean value of foo
        where: '"name" = ''foo'''
        measurement: '"°C"'
```

{% configuration %}
host:
  description: "데이터베이스 호스트의 IP 주소 (예 : 192.168.1.10)"
  required: false
  default: localhost
  type: string
port:
  description: 사용할 포트.
  required: false
  default: 8086
  type: string
username:
  description: 데이터베이스 사용자의 사용자 이름
  required: false
  type: string
password:
  description: 데이터베이스 사용자 계정의 비밀번호
  required: false
  type: string
ssl:
  description: http 대신 https를 사용하여 연결
  required: false
  default: false
  type: boolean
verify_ssl:
  description: https 요청에 대한 SSL 인증서를 확인
  required: false
  default: false
  type: boolean
queries:
  description: 쿼리 목록.
  required: true
  type: list
  keys:
    name:
      description: 센서의 이름
      required: true
      type: string
    unit_of_measurement:
      description: 센서의 측정 단위를 정의합니다 (있는 경우).
      required: false
      type: string
    measurement:
      description: Defines the measurement name in InfluxDB (the FROM clause of the query). 
      required: true
      type: string
    where:
      description: Defines the data selection clause (the where clause of the query).
      required: true
      type: string
    value_template:
      description: 페이로드에서 값을 추출하기 위해 [template](/docs/configuration/templating/#processing-incoming-data)을 정의합니다
      required: false
      type: template
    database:
      description: 사용할 데이터베이스 이름
      required: false
      default: home_assistant
      type: string
    group_function:
      description: 사용할 그룹 기능.
      required: false
      default: mean
      type: string
    field:
      description: 선택할 필드 이름.
      required: true
      type: string
      default: value
{% endconfiguration %}

## 사례 

### 전체 설정

아래 예제 구성 항목은 로컬 InfluxDB 인스턴스에 대한 두 가지 요청을 만듭니다. 하나는 데이터베이스`db1`에, 다른 하나는`db2`에 :

- `select last(value) as value from "°C" where "name" = "foo"`
- `select min(tmp) as value from "%" where "entity_id" = ''salon'' and time > now() - 1h`

```yaml
sensor:
  platform: influxdb
  host: localhost
  username: home-assistant
  password: password
  queries:
    - name: last value of foo
      unit_of_measurement: °C
      value_template: '{% raw %}{{ value | round(1) }}{% endraw %}'
      group_function: last
      where: '"name" = ''foo'''
      measurement: '"°C"'
      field: value
      database: db1
    - name: Min for last hour
      unit_of_measurement: '%'
      value_template: '{% raw %}{{ value | round(1) }}{% endraw %}'
      group_function: min
      where: '"entity_id" = ''salon'' and time > now() - 1h'
      measurement: '"%"'
      field: tmp
      database: db2
```
