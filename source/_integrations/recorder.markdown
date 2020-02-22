---
title: Recorder
description: Instructions on how to configure the data recorder for Home Assistant.
logo: home-assistant.png
ha_category:
  - History
ha_release: pre 0.7
ha_quality_scale: internal
---

`recorder` 통합구성요소는 데이터베이스에 세부 사항을 저장하는 역할을 하며, 그런 다음 [`history` 통합구성요소](/integrations/history/).에 의해 처리됩니다.

홈어시스턴트는 ORM (Object Relational Mapper)인 [SQLAlchemy](https://www.sqlalchemy.org/) 를 사용합니다. 이는 [MySQL](https://www.mysql.com/), [MariaDB](https://mariadb.org/), [PostgreSQL](https://www.postgresql.org/), 혹은 [MS SQL Server](https://www.microsoft.com/en-us/sql-server/)와 같이 SQLAlchemy가 지원하는 레코더에 **모든** SQL 백엔드를 사용할 수 있습니다. 

기본 데이터베이스 엔진은 [SQLite](https://www.sqlite.org/) 이며 설정이 필요하지 않습니다. 데이터베이스는 Home Assistant 설정 디렉토리(`.homeassistant` 혹은 '/config/' Hass.io 경우)에 `home-assistant_v2.db`이름으로 저장됩니다. 

설치시 `recorder` 통합구성요소의 기본값을 변경하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
recorder:
```

{% configuration %}
recorder:
  description: 레코더 통합구성요소를 활성화. 한 번만 허용.
  required: true
  type: map
  keys:
    db_url:
      description: 데이터베이스를 가리키는 URL.
      required: false
      type: string
    purge_keep_days:
      description: 데이터기 제거된 후 레코드 데이터베이스에 보관할 히스토리 날짜수(기간)를 지정
      required: false
      default: 10
      type: integer
    purge_interval:
      description: "제거 작업이 실행되는 빈도(기간). 예약된 제거가 누락 된 경우 (예 : 홈어시스턴트가 실행 중이 아닌 경우) 홈어시스턴트가 다시 시작된 후 일정이 재개됩니다. 제거 일정에 영향을 주지 않고 필요할 때 [service](#service-purge) 호출 `purge`를 사용할 수 있습니다. 이것이 '0'으로 설정되면 자동 제거(purge)가 비활성화됩니다."
      required: false
      default: 1
      type: integer
    exclude:
      description: 레코딩에서 제외할 통합구성요소 설정.
      required: false
      type: map
      keys:
        domains:
          description: 레코딩에서 제외할 도메인 목록
          required: false
          type: list
        entities:
          description: 레코딩에서 제외할 엔티티 ID 목록.
          required: false
          type: list
    include:
      description: 레코딩에 포함할 통합구성요소 설정. 설정사 다른 모든 항목이 기록되지 않습니다..
      required: false
      type: map
      keys:
        domains:
          description: 레코딩에 포함할 도메인 목록.
          required: false
          type: list
        entities:
          description: 레코딩에 포함할 엔티티 ID 목록.
          required: false
          type: list
{% endconfiguration %}

기록된 정보에 기본적으로 만족할 수도 있지만 일부 엔티티 또는 도메인을 제거하려는 경우 도메인 및 엔티티를 `exclude`(일명 블랙리스트)로 정의하는 것이 편리합니다. 일반적으로 이들은 (`weblink`와 같이) 변경되지 않거나 (`updater` 또는 `automation`과 같이) 거의 변경되지 않는 엔티티/도메인입니다.

```yaml
# Example configuration.yaml entry with exclude
recorder:
  purge_keep_days: 5
  db_url: sqlite:////home/user/.homeassistant/test
  exclude:
    domains:
      - automation
      - weblink
      - updater
    entities:
      - sun.sun # Don't record sun data
      - sensor.last_boot # Comes from 'systemmonitor' sensor platform
      - sensor.date
```

`include` 설정(일명 화이트리스트)을 사용하여 기록할 도메인과 엔티티를 정의하면 시스템에 엔티티가 많아지고 `exclude` 목록이 매우 커질 때 편리합니다. 따라서 기록할 엔티티 또는 도메인을 정의하는 것이 좋습니다. 

```yaml
# Example configuration.yaml entry with include
recorder:
  include:
    domains:
      - sensor
      - switch
      - media_player
```

또한 `include` 목록을 사용하여 기록할 도메인/엔터티를 정의하고 `exclude` 목록 내의 일부를 제외할 수 있습니다. 예를 들어 `sensor` 도메인을 포함하지만 특정 `sensor`를 제외하려는 경우 이 방법이 적합합니다. 모든 센서 엔티티를 `include` `entities` 목록에 추가하는 대신 `sensor` 도메인만 포함하고 관심없는 센서 엔티티를 제외하십시오. 

```yaml
# Example configuration.yaml entry with include and exclude
recorder:
  include:
    domains:
      - sensor
      - switch
      - media_player
  exclude:
    entities:
     - sensor.last_boot
     - sensor.date
```

히스토리에서 이벤트만 숨기려면 [`history` integration](/integrations/history/)을 살펴보십시오. [logbook](/integrations/logbook/)도 마찬가지입니다. 그러나 특정 이벤트에 대한 개인 정보 보호 문제가 있거나 기록이나 로그북에서 이벤트를 원하지 않는 경우 `recorder` 통합구성요소의 `exclude`/`include`옵션을 사용해야합니다. 이런 방식으로 데이터베이스에 조차 없는 경우에도 자주 기록되는 특정 이벤트 (예 :`sensor.last_boot`)를 제외하여 스토리지를 줄이고 데이터베이스를 작게 유지할 수 있습니다.

### `purge` 서비스

`keep_days` 서비스 데이터에 따라 `recorder.purge`서비스를 호출하여 X일보다 오래된 이벤트 및 상태를 삭제하는 제거 작업을 시작합니다.

| Service data attribute | Optional | Description                                                                                                                                                           |
| ---------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `keep_days`            | yes      | 레코더 데이터베이스에 보관할 기록 일수 (기본값은 `purge_keep_days` 설정값)                                                 |
| `repack`               | yes      | 전체 데이터베이스를 다시 작성하여 디스크 공간을 절약. SQLite에서만 지원되며 데이터베이스에서 현재 사용중인 디스크 공간 이상이 필요합니다. |

## 커스텀 데이터베이스 엔진

| Database engine        | `db_url`                                                                                     |
| :--------------------- | :------------------------------------------------------------------------------------------- |
| SQLite                 | `sqlite:////PATH/TO/DB_NAME`                                                                 |
| MariaDB                | `mysql+pymysql://SERVER_IP/DB_NAME?charset=utf8`                                             |
| MariaDB                | `mysql+pymysql://user:password@SERVER_IP/DB_NAME?charset=utf8`                               |
| MariaDB (omit pymysql) | `mysql://user:password@SERVER_IP/DB_NAME?charset=utf8`                                       |
| MySQL                  | `mysql://SERVER_IP/DB_NAME?charset=utf8`                                                     |
| MySQL                  | `mysql://user:password@SERVER_IP/DB_NAME?charset=utf8`                                       |
| PostgreSQL             | `postgresql://SERVER_IP/DB_NAME`                                                             |
| PostgreSQL             | `postgresql://user:password@SERVER_IP/DB_NAME`                                               |
| PostgreSQL (Socket)    | `postgresql://@/DB_NAME`                                                                     |
| MS SQL Server          | `mssql+pyodbc://username:password@SERVER_IP/DB_NAME?charset=utf8;DRIVER={DRIVER};Port=1433;` |

<div class='note'>

MariaDB/MySQL을 설치하려면 ALTERNATE_PORT (타사 호스팅 제공 업체 또는 병렬 설치)를 SERVER_IP에 추가해야합니다 (예 : `mysql://user:password@SERVER_IP:ALTERNATE_PORT/DB_NAME?charset=utf8`).

</div>

<div class='note'>

홈어시스턴트로 외부 MariaDB 백엔드 (예: 별도의 NAS에서 실행)를 사용하는 경우 URL에서 `pymysql`을 생략해야합니다. `pymysql`은 기본 도커 이미지에 포함되어 있지 않으며 이것이 작동하는 데 필요하지 않습니다.

</div>

<div class='note'>

데이터베이스가 `recorder` 인스턴스 (예 : `localhost`)와 동일한 호스트에 있는 경우 Unix Socket 연결은 항상 TCP보다 성능이 더 좋습니다. 

</div>

<div class='note warning'>

PostgreSQL에 유닉스 소켓을 사용하려면 `pg_hba.conf`를 수정해야합니다. [PostgreSQL](#postgresql) 참조

</div>

<div class='note warning'>

MS SQL Server에 기본 `FULL` 복구 모델을 사용하는 경우 트랜잭션 로그가 너무 커지지 않도록 로그 파일을 수동으로 백업해야합니다. 백업 간의 데이터 손실이 걱정되지 않으면 복구 모델을 `SIMPLE`로 변경하는 것이 좋습니다.

</div>

### 데이터베이스 시작 (Database startup)

홈어시스턴트와 동일한 서버에서 데이터베이스 서버 인스턴스를 실행중인 경우 홈어시스턴트 시작전에 이 서비스가 시작되는지 확인해야합니다. Systemd (Raspberry Pi, Debian, Ubuntu 및 기타)를 실행하는 Linux 인스턴스의 경우 서비스 파일을 편집해야합니다. 

```bash
sudo nano /etc/systemd/system/home-assistant@homeassistant.service
```

PostgreSQL과 같은 데이터베이스 서비스를 추가하십시오. :

```txt
[Unit]
Description=Home Assistant
After=network.target postgresql.service
```

파일을 저장하고 `systemctl`을 다시로드하십시오. :

```bash
sudo systemctl daemon-reload
```

## 설치 노트 (Installation notes)

선택한 데이터베이스 엔진에 대한 모든 Python 바인딩을 직접 설치할 수있는 것은 아닙니다. 이 섹션에는 작동에 도움이되는 추가 정보가 포함되어 있습니다.

### MariaDB 와 MySQL

가상 환경(virtual environment)에 있는 경우 아래 설명된 `mysqlclient` Python 패키지를 설치하기 전에 활성화해야 합니다.

```bash
pi@homeassistant:~ $ sudo -u homeassistant -H -s
homeassistant@homeassistant:~$ source /srv/homeassistant/bin/activate
(homeassistant) homeassistant@homeassistant:~$ pip3 install mysqlclient
```

MariaDB의 경우 몇 가지 종속성을 설치해야 할 수 있습니다. MariaDB 버전 10.2를 사용하는 경우 `libmariadbclient-dev`의 이름이 `libmariadb-dev`로 변경되었습니다. MariaDB 10.3을 사용한다면 `libmariadb-dev-compat` 패키지도 설치해야합니다. MariaDB v10.0.34의 경우 `libmariadb-dev-compat` 만 필요합니다. MariaDB 버전에 따라 올바른 패키지를 설치하십시오. 

파이썬 측에서는 `mysqlclient`를 사용합니다. : 

```bash
sudo apt-get install libmariadbclient-dev libssl-dev
pip3 install mysqlclient
```

MySQL의 경우 몇 가지 종속성을 설치해야 할 수 있습니다. `pymysql` 과 `mysqlclient` 중에서 선택할 수 있습니다. :

```bash
sudo apt-get install default-libmysqlclient-dev libssl-dev
pip3 install mysqlclient
```

종속성을 설치 한 후 데이터베이스를 수동으로 작성해야합니다. 시작하는 동안 Home Assistant는 `db_url`에 지정된 데이터베이스를 찾습니다. 데이터베이스가 존재하지 않으면 데이터베이스가 자동으로 작성되지 않습니다.

홈어시스턴트가 올바른 권한 레벨로 데이터베이스를 찾으면 모든 필수 테이블이 자동으로 작성되고 그에 따라 데이터가 채워집니다.

### PostgreSQL

PostgreSQL의 경우 몇 가지 종속성을 설치해야 할 수도 있습니다 : 

```bash
sudo apt-get install postgresql-server-dev-X.Y
pip3 install psycopg2
```

유닉스 소켓을 사용하려면 [`pg_hba.conf`](https://www.postgresql.org/docs/current/static/auth-pg-hba-conf.html)에 다음 줄을 추가하십시오

`local  DB_NAME USER_NAME peer`

여기서 `DB_NAME` 은 데이터베이스 이름이고 `USER_NAME`은 Home Assistant 인스턴스를 실행하는 사용자의 이름입니다. ([securing your installation](/docs/configuration/securing/) 참조)

그 후 PostgreSQL 설정을 다시로드하십시오. :

```bash
$ sudo -i -u postgres psql -c "SELECT pg_reload_conf();"
 pg_reload_conf
----------------
 t
(1 row)
```
서비스 다시 시작도 동작합니다

### MS SQL 서버

MS SQL Server의 경우 몇 가지 종속성을 설치해야합니다. : 

```bash
sudo apt-get install unixodbc-dev
pip3 install pyodbc
```

가상 환경에 있는 경우 pyodbc 패키지를 설치하기 전에 활성화해야합니다. 

```bash
sudo -u homeassistant -H -s
source /srv/homeassistant/bin/activate
pip3 install pyodbc
```

ODBC 드라이버도 설치해야합니다. Microsoft ODBC 드라이버가 권장되지만 Microsoft에서 지원하지 않는 시스템에서는 FreeTDS를 사용할 수 있습니다. Microsoft ODBC 드라이버 설치 지침은 [here](https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/에서 찾을 수 있습니다. 

<div class='note'>

Hass.io를 사용중인 경우 FreeTDS가 이미 설치되어 있습니다. 사용해야하는 db_url은 `mssql+pyodbc://username:password@SERVER_IP/DB_NAME?charset=utf8;DRIVER={FreeTDS};Port=1433;` 입니다. 

</div>
