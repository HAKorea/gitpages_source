---
title: 에너지모니터링(Efergy)
description: Instructions on how to integrate Efergy devices within Home Assistant.
logo: efergy.png
ha_category:
  - Energy
ha_release: pre 0.7
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/uVpkgjqmvcI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Efergy](https://efergy.com) 미터기 정보를 Home Assistant에 연동하십시오.

## 셋업

앱 토큰을 얻으려면 :

1. Log in to your efergy account
2. Go to the Settings page
3. Click on App tokens
4. Click "Add token"

## 설정

센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: efergy
    app_token: APP_TOKEN
    utc_offset: UTC_OFFSET
    monitored_variables:
      - type: instant_readings
      - type: budget
      - type: cost
        period: day
        currency: $
      - type: amount
        period: day
      - type: current_values
```

{% configuration %}
app_token:
  description: The App Token for your account.
  required: true
  type: string
utc_offset:
  description: Some variables (currently only the daily_cost) require that the negative number of minutes your timezone is ahead/behind UTC time.
  required: false
  default: 0
  type: string
monitored_variables:
  description: Variables to monitor.
  required: true
  type: list
  keys:
    type:
      description: Name of the variable.
      required: true
      type: list
      keys:
        instant_readings:
          description: Instant energy consumption.
        budget:
          description: Monthly budget.
        cost:
          description: The cost for energy consumption (with the tariff that has been set in Efergy) over a given period.
        amount:
          description: The amount of energy consumed over a given period.
        current_values:
          description: This returns the current energy usage of each device on your account, as `efergy_\<sid of device\>`. If you only have one device in your account, this is effectively the same as instant_readings.
    period:
      description: Some variables take a period argument. Valid options are "day", "week", "month", and "year".
      required: false
      default: year
      type: string
    currency:
      description: This is used to display the cost/period as the unit when monitoring the cost. It should correspond to the actual currency used in your dashboard.
      required: false
      type: string
{% endconfiguration %}
