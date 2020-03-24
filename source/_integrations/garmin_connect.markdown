---
title: 가민 컨넥트(Garmin Connect)
description: Instructions on how to configure the Garmin Connect integration for Home Assistant.
logo: garmin_connect.png
ha_category:
  - Health
ha_iot_class: Cloud Polling
ha_release: 0.105
ha_codeowners:
  - '@cyberjunky'
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/S0y-IGKR2lo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Garmin Connect 센서를 사용하면 [Garmin Connect](https://connect.garmin.com) 에서 Home Assistant로 데이터를 노출 할 수 있습니다 .

## 설정

Garmin Connect를 설치에 추가하려면 UI에서 설정 >> 통합구성요소로 이동한 후 사용자정보를 입력하여 Garmin Connect 연동을 활성화하십시오.

로그인에 성공하면 표준 센서 세트가 활성화됩니다. 필요한 경우 통합 페이지를 사용하여 더 많은 기능을 사용할 수 있습니다.

Garmin Connect는 최대 속도 제한이 매우 낮습니다. 10분이하 마다  1회.

## 사용가능한 센서

모든 센서에 의미있는 값이 있는 것은 아니며 사용하는 추적 장치 및 연결된 앱에 따라 다릅니다.

기본 활성 센서:

```text
Total Steps
Daily Step Goal
Total KiloCalories
Active KiloCalories
BMR KiloCalories
Consumed KiloCalories
Burned KiloCalories
Total Distance Mtr
Active Time
Sedentary Time
Sleeping Time
Awake Duration
Sleep Duration
Floors Ascended
Floors Descended
Floors Ascended Goal
Min Heart Rate
Max Heart Rate
Resting Heart Rate
Avg Stress Level
Max Stress Level
Rest Stress Duration
Activity Stress Duration
Uncat. Stress Duration
Total Stress Duration
Low Stress Duration
Medium Stress Duration
High Stress Duration
Body Battery Charged
Body Battery Drained
Body Battery Highest
Body Battery Lowest
Body Battery Most Recent
Average SPO2
Lowest SPO2
Latest SPO2
```

기본 비활성 센서:

```text
Remaining KiloCalories
Net Remaining KiloCalories
Net Calorie Goal
Wellness Start Time
Wellness End Time
Wellness Description
Wellness Distance Mtr
Wellness Active KiloCalories
Wellness KiloCalories
Highly Active Time
Floors Ascended Mtr
Floors Descended Mtr
Min Avg Heart Rate
Max Avg Heart Rate
Abnormal HR Counts
Last 7 Days Avg Heart Rate
Stress Qualifier
Stress Duration
Stress Percentage
Rest Stress Percentage
Activity Stress Percentage
Uncat. Stress Percentage
Low Stress Percentage
Medium Stress Percentage
High Stress Percentage
Latest SPO2 Time
Average Altitude
Moderate Intensity
Vigorous Intensity
Intensity Goal
Latest Respiration Update
Highest Respiration
Lowest Respiration
Latest Respiration
```
