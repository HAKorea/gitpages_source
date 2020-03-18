---
title: SQL
description: Instructions how to integrate SQL sensors into Home Assistant.
logo: sql.png
ha_category:
  - Utility
ha_release: 0.63
ha_codeowners:
  - '@dgomes'
---

`sql` 센서 플랫폼을 사용하면 [sqlalchemy](https://www.sqlalchemy.org) 라이브러리가 지원하는 [SQL](https://en.wikipedia.org/wiki/SQL) 데이터베이스의 값을 사용하여 센서 상태 (및 속성)를 채울 수 있습니다. `recorder` 통합구성요소 데이터베이스와 함께 사용되는 경우 홈어시스턴트 센서에 대한 통계를 제공하는 데 사용할 수 있습니다. 외부 데이터 소스와 함께 사용할 수도 있습니다.

## 설정

이 센서를 설정하려면 센서 연결 변수와 `configuration.yaml` 파일에 대한 쿼리 목록을 정의해야합니다. 각 쿼리마다 센서가 생성됩니다. :

이를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

{% raw %}
```yaml
# Example configuration.yaml
sensor:
  - platform: sql
    queries:
      - name: Sun state
        query: "SELECT * FROM states WHERE entity_id = 'sun.sun' ORDER BY state_id DESC LIMIT 1;"
        column: 'state'
```
{% endraw %}

{% configuration %}
db_url:
  description: The URL which points to your database. See [supported engines](/integrations/recorder/#custom-database-engines).
  required: false
  default: "Defaults to the default recorder `db_url` (not the current `db_url` of recorder)."
  type: string
queries:
  description: List of your queries.
  required: true
  type: map
  keys:
    name:
      description: The name of the sensor.
      required: true
      type: string
    query:
      description: An SQL QUERY string, should return 1 result at most.
      required: true
      type: string
    column:
      description: The field name to select.
      required: true
      type: string
    unit_of_measurement:
      description: Defines the units of measurement of the sensor, if any.
      required: false
      type: string
    value_template:
      description: Defines a template to extract a value from the payload.
      required: false
      type: template
{% endconfiguration %}

## 예시

본 섹션에서는 이 센서를 사용하는 방법에 대한 실제 예를 제공합니다.

### 엔터티의 현재 상태

이 예제는 센서 `sensor.temperature_in`의 이전 *recorded* 상태를 보여줍니다.

```yaml
sensor:
  - platform: random
    name: Temperature in
    unit_of_measurement: '°C'
```

쿼리는 다음과 같습니다. :

```sql
SELECT * FROM states WHERE entity_id = 'sensor.temperature_in' ORDER BY state_id DESC LIMIT 1;
```

{% raw %}
```yaml
# Example configuration.yaml
sensor:
  - platform: sql
    queries:
      - name: Temperature in
        query: "SELECT * FROM states WHERE entity_id = 'sensor.temperature_in' ORDER BY state_id DESC LIMIT 1;"
        column: 'state'
```
{% endraw %}

SQL 센서 상태는 SQL result set의 마지막 row에 해당합니다.

### 엔터티의 이전 상태

이 예제는 *binary_sensors* 에서만 작동합니다.

```sql
SELECT * FROM states WHERE entity_id = 'binary_sensor.xyz789' GROUP BY state ORDER BY last_changed DESC LIMIT 1;
```

### 데이터베이스 크기

#### Postgres의 데이터베이스 크기

{% raw %}
```yaml
sensor:
  - platform: sql
    db_url: postgresql://user:password@host/dbname
    queries:
      - name: DB size
        query: "SELECT (pg_database_size('dsmrreader')/1024/1024) as db_size;"
        column: "db_size"
        unit_of_measurement: MB
```
{% endraw %}

#### MariaDB/MySQL

센서가 올바르게 작동하도록 `table_schema="hass"`를 데이터베이스 이름으로 사용하는 이름으로 변경하십시오.

{% raw %}
```yaml
sensor:
  - platform: sql
    db_url: mysql://user:password@localhost/hass
    queries:
      - name: DB size
        query: 'SELECT table_schema "database", Round(Sum(data_length + index_length) / 1024, 1) "value" FROM information_schema.tables WHERE table_schema="hass" GROUP BY table_schema;'
        column: 'value'
        unit_of_measurement: kB
```
{% endraw %}
