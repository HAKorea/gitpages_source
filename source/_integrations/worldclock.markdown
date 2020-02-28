---
title: 세계시간
description: Instructions on how to integrate a Worldclock within Home Assistant.
logo: home-assistant.png
ha_category:
  - Calendar
ha_iot_class: Local Push
ha_release: pre 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`worldclock` 센서 플랫폼은 단순히 다른 시간대(time zone)에 현재 시간을 표시한다.

## 설정 (Configuration)

설치시 이 센서를 사용하려면 `configuration.yaml`파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: worldclock
    time_zone: America/New_York
```

{% configuration %}
time_zone:
  description: 값이 포함된 자원 또는 엔드 포인트.
  required: true
  type: string
name:
  description: 센서 이름 (예들들어 해당 도시 이름).
  required: false
  type: string
  default: Worldclock Sensor
{% endconfiguration %}

유효한 시간대 는 [Wikipedia overview](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)에서 **TZ** 열을 확인하십시오 . 또는 [pytz](https://pypi.python.org/pypi/pytz) 모듈 에서 전체 목록을 가져 옵니다 .

```shell
python3 -c "import pytz;print(pytz.all_timezones)"
```
