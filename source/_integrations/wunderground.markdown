---
title: 웨더 언더그라운드 (WUnderground)
description: Instructions on how to integrate Weather Underground (WUnderground) Weather within Home Assistant.
logo: wunderground.png
ha_category:
  - Weather
ha_release: 0.27
ha_iot_class: Cloud Polling
---

`wunderground` 플랫폼은 현재 날씨 정보의 출처로 [Weather Underground](https://www.wunderground.com/)를 사용합니다.

<div class='note warning'>

WUnderground API 키 [here](https://www.wunderground.com/weather/api)서 받아오십시오. 더 이상 무료 API 키를 제공하지 않으며 모든키는 비용을 지불해야합니다. 현재 기존의 무료키는 계속 작동하지만 개인 기상 관측소를 소유하고 데이터를 WU (PWS 업로더)에 제공하는 경우를 제외하고 2018 년 12 월 31 일에 비활성화됩니다. 2018 년 9 월 6 일 현재 Weather Underground는 [End of Service for the Weather Underground API](https://apicommunity.wunderground.com/weatherapi/topics/end-of-service-for-the-weather-underground-api)를 선언한다고 밝혔습니다. 그들은 비상업적 사용자를 위한 새로운 계획을 개발할 것이라고 말합니다. 이에 대한 일정은 발표되지 않았습니다.

다음 정보를 사용할 때 이를 고려하십시오.

</div>

설정

설치에 Wunderground를 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: wunderground
    api_key: YOUR_API_KEY
    monitored_conditions:
      - alerts
      - dewpoint_c
```

{% configuration %}
api_key:
  description: The API key for Weather Underground. See above for details.
  required: true
  type: string
pws_id:
  description: "You can enter a Personal Weather Station ID. The current list of Wunderground PWS stations is available [here](https://www.wunderground.com/weatherstation/ListStations.asp). If you do not enter a PWS ID, the current location information (latitude and longitude) from your `configuration.yaml` will be used to display weather conditions."
  required: false
  type: string
lang:
  description: Specify the language that the API returns. The current list of all Wunderground language codes is available [here](https://www.wunderground.com/weather/api/d/docs?d=language-support). If not specified, it defaults to English (EN).
  required: false
  type: string
  default: EN
latitude:
  description: Latitude coordinate to monitor weather of (required if **longitude** is specified).
  required: false
  type: string
  default: Coordinates defined in your `configuration.yaml`
longitude:
  description: Longitude coordinate to monitor weather of (required if **latitude** is specified).
  required: false
  type: string
  default: Coordinates defined in your `configuration.yaml`
monitored_conditions:
  description: Conditions to display in the frontend. The following conditions can be monitored.
  required: true
  type: list
  default: symbol
  keys:
    alerts:
      description: Current severe weather advisories
    dewpoint_c:
      description: Temperature in Celsius below which water droplets begin to condense and dew can form
    dewpoint_f:
      description: Temperature in Fahrenheit below which water droplets begin to condense and dew can form
    dewpoint_string:
      description: Text summary of dew point
    feelslike_c:
      description: Feels like (or apparent) temperature in Celsius
    feelslike_f:
      description: Feels like (or apparent) temperature in Fahrenheit
    feelslike_string:
      description: Text summary of how the current temperature feels like
    heat_index_c:
      description: Heat index (combined effects of the temperature and humidity of the air) in Celsius
    heat_index_f:
      description: Heat index (combined effects of the temperature and humidity of the air) in Fahrenheit
    heat_index_string:
      description: Text summary of current heat index
    elevation:
      description: Elevation in feet
    location:
      description: City and State
    observation_time:
      description: Text summary of observation time
    precip_today_in:
      description: Total precipitation in inches
    precip_today_metric:
      description: Total precipitation in metric units
    precip_today_string:
      description: Text summary of precipitation today
    precip_1d_mm:
      description: "[<sup>[1d]</sup>](#1d): Forecasted precipitation intensity in millimeters"
    precip_1d_in:
      description: "[<sup>[1d]</sup>](#1d): Forecasted precipitation intensity in inches"
    precip_1d:
      description: "[<sup>[1d]</sup>](#1d): Forecasted precipitation probability in %"
    pressure_in:
      description: Atmospheric air pressure in inches
    pressure_mb:
      description: Atmospheric air pressure in millibars
    pressure_trend:
      description: "Atmospheric air pressure trend signal `(+/-)`"
    relative_humidity:
      description: Relative humidity
    station_id:
      description: Your personal weather station (PWS) ID
    solarradiation:
      description: Current levels of solar radiation
    temperature_string:
      description: Temperature text combining Fahrenheit and Celsius
    temp_c:
      description: Current temperature in Celsius
    temp_f:
      description: Current temperature in Fahrenheit
    temp_high_record_c:
      description: Maximum temperature measured in Celsius
    temp_high_record_f:
      description: Maximum temperature measured in Fahrenheit
    temp_low_record_c:
      description: Minimal temperature measured in Celsius
    temp_low_record_f:
      description: Minimal temperature measured in Fahrenheit
    temp_high_avg_c:
      description: Average high for today in Celsius
    temp_high_avg_f:
      description: Average high for today in Fahrenheit
    temp_low_avg_c:
      description: Average low for today in Celsius
    temp_low_avg_f:
      description: Average low for today in Fahrenheit
    temp_high_1d_c:
      description: "[<sup>[1d]</sup>](#1d): Forecasted high temperature in Celsius"
    temp_high_1d_f:
      description: "[<sup>[1d]</sup>](#1d): Forecasted high temperature in Fahrenheit"
    temp_low_1d_c:
      description: "[<sup>[1d]</sup>](#1d): Forecasted low temperature in Celsius"
    temp_low_1d_f:
      description: "[<sup>[1d]</sup>](#1d): Forecasted low temperature in Fahrenheit"
    UV:
      description: Current levels of UV radiation. See [here](https://www.wunderground.com/resources/health/uvindex.asp) for explanation.
    visibility_km:
      description: Average visibility in km
    visibility_mi:
      description: Average visibility in miles
    weather:
      description: A human-readable text summary with picture from Wunderground.
    weather_1d:
      description: "[<sup>[12h]</sup>](#12h): A human-readable weather forecast using imperial units."
    weather_1d_metric:
      description: "[<sup>[12h]</sup>](#12h): A human-readable weather forecast using metric units."
    weather_1h:
      description: "[<sup>[1h]</sup>](#1h): Weather conditions in 1 hour. (e.g., \"Thunderstorm\" etc.)"
    wind_degrees:
      description: Wind degrees
    wind_dir:
      description: Wind direction
    wind_gust_kph:
      description: Wind gusts speed in kph
    wind_gust_mph:
      description: Wind gusts speed in mph
    wind_gust_1d_kph:
      description: "[<sup>[1d]</sup>](#1d): Max. forecasted Wind in kph"
    wind_gust_1d_mph:
      description: "[<sup>[1d]</sup>](#1d): Max. forecasted Wind in mph"
    wind_kph:
      description: Current wind speed in kph
    wind_mph:
      description: Current wind speed in mph
    wind_1d_kph:
      description: "[<sup>[1d]</sup>](#1d): Forecasted wind speed in kph"
    wind_1d_mph:
      description: "[<sup>[1d]</sup>](#1d): Forecasted wind speed in mph"
    wind_string:
      description: Text summary of current wind conditions
{% endconfiguration %}

위에 나열된 모든 조건은 5 분마다 업데이트됩니다.

## Forecasts

### 12 hour forecasts

위에서 <a name="12h">[12h]</a>로 표시된 모니터링된 상태는 10 시간입니다. 다른 period/daytime에 대한 예측을 얻으려면 센서 이름의 `_1d_` 부분을 바꾸십시오. 예를 들어 `weather_2n`은 내일 밤 예보를 제공합니다. day의 유효 값은 `1`~`4`이고 daytime의 유효 값은 `d` 또는 `n`입니다.

### Daily forecasts

위의 <a name="1d">[1d]</a>로 표시된 조건은 일일 예측입니다. 다른 날을 예측하려면 센서 이름의 `_1d_` 부분에있는 숫자를 바꾸십시오. 유효한 값은 `1`에서 `4`입니다.

### Hourly forecasts

<a name="1h">[1h]</a>로 표시된 조건은 시간별 예측입니다. 다른 시간을 예측하려면 센서 이름의 `_1h_` 부분에있는 숫자를 `1`에서 `36`으로 바꾸십시오. 예를 들어 `weather_24h`는 24 시간 안에 날씨를 알려줍니다.

## 추가 예시들

### Daily forecast

```yaml
sensor:
  - platform: wunderground
    api_key: YOUR_API_KEY
    monitored_conditions:
      - weather_1d_metric
      - weather_1n_metric
      - weather_2d_metric
      - weather_2n_metric
      - weather_3d_metric
      - weather_3n_metric
      - weather_4d_metric
      - weather_4n_metric

group:
  daily_forecast:
    name: Daily Forecast
    entities:
      - sensor.pws_weather_1d_metric
      - sensor.pws_weather_1n_metric
      - sensor.pws_weather_2d_metric
      - sensor.pws_weather_2n_metric
      - sensor.pws_weather_3d_metric
      - sensor.pws_weather_3n_metric
      - sensor.pws_weather_4d_metric
      - sensor.pws_weather_4n_metric
```

![Daily Forecast](/images/screenshots/wunderground_daily_forecast.png)

### Weather overview

```yaml
sensor:
  - platform: wunderground
    api_key: YOUR_API_KEY
    monitored_conditions:
      - temp_high_record_c
      - temp_high_1d_c
      - temp_c
      - temp_low_1d_c
      - temp_low_record_c
      - precip_1d
      - precip_1d_mm
      - wind_kph
      - wind_1d_kph
      - alerts

group:
  weather_overview:
    name: Weather overview
    entities:
      - sensor.pws_weather_1d_metric
      - sensor.pws_temp_high_record_c
      - sensor.pws_temp_high_1d_c
      - sensor.pws_temp_c
      - sensor.pws_temp_low_1d_c
      - sensor.pws_temp_low_record_c
      - sensor.pws_precip_1d
      - sensor.pws_precip_1d_mm
      - sensor.pws_wind_kph
      - sensor.pws_wind_1d_kph
      - sensor.pws_alerts
```

![Weather overview](/images/screenshots/wunderground_weather_overview.png)

<div class='note warning'>
Note: 플랫폼을 "Wunderground"라고 부르는 동안 센서는 Home Assistant에서 "PWS"로 표시됩니다 (예 : sensor.pws_weather).
</div>

Weather Underground 센서가 entity_registry에 추가되므로 두 번째 이후의 개인 기상 관측소 ID (pws_id)는 모니터링 되는 조건에 색인 번호가 붙습니다. 다음 예 : 

```yaml
- sensor.pws_weather_1d_metric_2
```

API에 대한 추가 세부 사항이 있습니다. [여기](https://www.wunderground.com/weather/api/d/docs).
