---
title: "데이터베이스"
description: "Details about the database used by Home Assistant."
redirect_from: /details/database/
---

Home Assistant가 사용하는 기본 데이터베이스는 [SQLite](https://www.sqlite.org/), 이며 데이터베이스 파일은 [configuration directory](/getting-started/configuration/) 에 저장됩니다. (예: `<path to config dir>/.homeassistant/home-assistant_v2.db`). 데이터베이스 서버 (예 : PostgreSQL)를 실행하려면 [`recorder` component](/integrations/recorder/)를 사용하십시오.

command-line에서 수동으로 SQLite 데이터베이스로 작업하려면, `sqlite3`를 [설치](http://www.sqlitetutorial.net/download-install-sqlite/)해야합니다. 또는 [DB Browser for SQLite](http://sqlitebrowser.org/)는 데이터를 탐색하기위한 뷰어와 SQL 명령을 실행하기위한 편집기를 제공합니다. 
우선 다음 `sqlite3`를 사용하여 데이터베이스를 로드하십시오.

```bash
$ sqlite3 home-assistant_v2.db
SQLite version 3.13.0 2016-05-18 10:57:30
Enter ".help" for usage hints.
sqlite>
```

출력을 보다 읽기 쉽게하기 위해 몇 가지 옵션을 설정하는 데 도움이됩니다. :

```bash
sqlite> .header on
sqlite> .mode column
```

`sqlite3`를 쓰면 데이터베이스에 데이터를 추가할 수도 있습니다. 어떤 데이터베이스를 사용하고 있는지 잘 모르십니까? 특히 데이터를 삭제하려는 경우 확인하십시오. 

```bash
sqlite> .databases
seq  name             file
---  ---------------  ----------------------------------------------------------
0    main             /home/fab/.homeassistant/home-assistant_v2.db
```

### Schema

현재 홈 어시스턴트 데이터베이스에서 사용 가능한 모든 테이블을 가져 오십시오. :

```bash
sqlite> SELECT sql FROM sqlite_master;

-------------------------------------------------------------------------------------
CREATE TABLE events (
	event_id INTEGER NOT NULL,
	event_type VARCHAR(32),
	event_data TEXT,
	origin VARCHAR(32),
	time_fired DATETIME,
	created DATETIME,
	PRIMARY KEY (event_id)
)
CREATE INDEX ix_events_event_type ON events (event_type)
CREATE TABLE recorder_runs (
	run_id INTEGER NOT NULL,
	start DATETIME,
	"end" DATETIME,
	closed_incorrect BOOLEAN,
	created DATETIME,
	PRIMARY KEY (run_id),
	CHECK (closed_incorrect IN (0, 1))
)
CREATE TABLE states (
	state_id INTEGER NOT NULL,
	domain VARCHAR(64),
	entity_id VARCHAR(64),
	state VARCHAR(255),
	attributes TEXT,
	event_id INTEGER,
	last_changed DATETIME,
	last_updated DATETIME,
	created DATETIME,
	PRIMARY KEY (state_id),
	FOREIGN KEY(event_id) REFERENCES events (event_id)
)
CREATE INDEX states__significant_changes ON states (domain, last_updated, entity_id)
CREATE INDEX states__state_changes ON states (last_changed, last_updated, entity_id)
CREATE TABLE sqlite_stat1(tbl,idx,stat)
```

`states` 테이블 에 대한 세부 사항 만 표시하려면 (다음 예제에서 해당 테이블을 사용하므로)

```bash
sqlite> SELECT sql FROM sqlite_master WHERE type = 'table' AND tbl_name = 'states';
```

### 쿼리 (Query)

테이블에서 사용 가능한 열을 식별하면 이제 쿼리를 만들 수 있습니다. 상위 10 개 entity를 나열하겠습니다. :

```bash
sqlite> .width 30, 10,
sqlite> SELECT entity_id, COUNT(*) as count FROM states GROUP BY entity_id ORDER BY count DESC LIMIT 10;
entity_id                       count
------------------------------  ----------
sensor.cpu                      28874
sun.sun                         21238
sensor.time                     18415
sensor.new_york                 18393
cover.kitchen_cover             17811
switch.mystrom_switch           14101
sensor.internet_time            12963
sensor.solar_angle1             11397
sensor.solar_angle              10440
group.all_switches              8018
```

### Delete

특정 엔티티를 유지하지 않으려면 영구적으로 삭제할 수 있습니다. :

```bash
sqlite> DELETE FROM states WHERE entity_id="sensor.cpu";
```

`VACUUM` 명령은 데이터베이스를 정리합니다

```bash
sqlite> VACUUM;
```

데이터베이스에 대한 대화식 작업 방법은, [Data Science Portal](https://data.home-assistant.io/)확인하십시오.
