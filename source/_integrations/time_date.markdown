---
title: 시간 & 날짜
description: Instructions on how to integrate the time and the date within Home Assistant.
logo: home-assistant.png
ha_category:
  - Calendar
ha_iot_class: Local Push
ha_release: pre 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

시간 및 날짜 (`time_date`) 센서 플랫폼은 Home Assistant 상태 시스템에 하나 이상의 센서를 추가합니다. 설치시 이러한 센서를 사용 가능하게하려면 `configuration.yaml` 파일에 다음을 추가 하십시오 (각 옵션은 적절한 데이터를 포함하는 별도의 센서를 만듭니다).

```yaml
# Example configuration.yaml entry
sensor:
  - platform: time_date
    display_options:
      - 'time'
      - 'date'
      - 'date_time'
      - 'date_time_utc'
      - 'date_time_iso'
      - 'time_date'
      - 'time_utc'
      - 'beat'
```

- **display_options** 배열 (*필수*): 보여주기위한 옵션. *date_time*, *date_time_utc*, *time_date*, 그리고 *date_time_iso* 타입들은 시간와 날짜를 모두 보여줍니다. 다른 타입들은 시간 혹은 날짜입니다. *beat*는 [Swatch Internet Time](https://www.swatch.com/en_us/internet-time)을 보여줍니다.


<p class='img'>
  <img src='{{site_root}}/images/screenshots/time_date.png' />
</p>
