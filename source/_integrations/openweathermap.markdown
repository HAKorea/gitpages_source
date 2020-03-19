---
title: 오픈기상지도(Openweathermap)
description: Instructions on how to integrate OpenWeatherMap within Home Assistant.
logo: openweathermap.png
ha_category:
  - Weather
  - Sensor
ha_release: 0.32
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@fabaff'
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/ccTAedW2KPg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`openweathermap` 기상 플랫폼은 [OpenWeatherMap](https://openweathermap.org/)를 현재 위치의 현재 기상 데이터 소스로 사용합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Sensor](#sensor)
- [Weather](#weather)

무료이지만 [등록](https://home.openweathermap.org/users/sign_up)이 필요한 API 키가 필요합니다.

## Weather

OpenWeatherMap을 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
weather:
  - platform: openweathermap
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your API key for [OpenWeatherMap](https://openweathermap.org/).
  required: true
  type: string
name:
  description: Name to use in the frontend.
  required: false
  type: string
  default: OpenWeatherMap
mode:
  description: "Can specify `hourly`, `daily` of `freedaily`. Select `hourly` for a three-hour forecast, `daily` for daily forecast or `freedaily` for a five days forecast with the free tier."
  required: false
  type: string
  default: "`hourly`"
latitude:
  description: Latitude of the location to display the weather.
  required: false
  type: float
  default: "The latitude in your `configuration.yaml` file."
longitude:
  description: Longitude of the location to display the weather.
  required: false
  type: float
  default: "The longitude in your `configuration.yaml` file."
{% endconfiguration %}

<div class='note'>

이 플랫폼은 [`openweathermap`](/integrations/openweathermap#sensor) 센서의 대안입니다.

</div>

## Sensor

`openweathermap` 플랫폼은 [OpenWeatherMap](https://openweathermap.org/)를 현재 위치의 현재 기상 데이터 소스로 사용합니다. `forecast`는 3 시간 안에 상태를 보여줄 것입니다.

OpenWeatherMap 센서를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: openweathermap
    api_key: YOUR_API_KEY
    monitored_conditions:
      - weather
```

{% configuration %}
api_key:
  description: Your API key for OpenWeatherMap.
  required: true
  type: string
name:
  description: Additional name for the sensors. Default to platform name.
  required: false
  default: OWM
  type: string
forecast:
  description: Enables the forecast. The default is to display the current conditions.
  required: false
  default: false
  type: string
language:
  description: The language in which you want text results to be returned. It's a two-characters string, e.g., `en`, `es`, `ru`, `it`, etc.
  required: false
  default: en
  type: string
monitored_conditions:
  description: Conditions to display in the frontend.
  required: true
  type: list
  keys:
    weather:
      description: A human-readable text summary.
    temperature:
      description: The current temperature.
    wind_speed:
      description: The wind speed.
    wind_bearing:
      description: The wind bearing.
    humidity:
      description: The relative humidity.
    pressure:
      description: The sea-level air pressure in millibars.
    clouds:
      description: Description about cloud coverage.
    rain:
      description: The rain volume.
    snow:
      description: The snow volume.
    weather_code:
      description: The current weather condition code.
{% endconfiguration %}

API에 대한 자세한 내용은 [OpenWeatherMap documentation](https://openweathermap.org/api)에서 확인할 수 있습니다.