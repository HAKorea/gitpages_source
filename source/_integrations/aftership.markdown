---
title: 해외배송추적(Aftership)
description: Instructions on how to set up AfterShip sensors within Home Assistant.
logo: aftership.png
ha_category:
  - Postal Service
ha_release: 0.85
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/5cdcq_Hxyao" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`aftership` 플랫폼을 통해 전세계 490개 이상의 택배를 지원하는 [AfterShip](https://www.aftership.com)을 통해 배송을 추적할 수 있습니다. 한 달에 최대 100 개의 추적 패키지를 사용할 수 있으며, 그 이후에는 요금이 부과됩니다.

센서값은 `Delivered` 상태가 아닌 패키지 수를 나타냅니다. 속성은 상태당 패키지 갯수입니다.

## 셋업

이 센서를 사용하려면 [AfterShip Account](https://accounts.aftership.com/register)가 필요하고 API 키를 설정하십시오. API 키를 설정하려면 [AfterShip API](https://accounts.aftership.com/register) 페이지로 이동하여 기존 키를 복사하거나 새 키를 생성하십시오.

<div class='note info'>
AfterShip은 최근 무료 요금제만 사용하더라도 파일에 신용 카드를 요구하기 시작했습니다. 플랫폼의 기능을 변경하는 것이 아니라 알아야 할 사항입니다.
</div>

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
sensor:
  - platform: aftership
    api_key: AFTERSHIP_APIKEY
```

{% configuration %}
name:
  description: 프론트 엔드에서 사용할 센서 이름
  required: false
  default: "aftership"
  type: string
api_key:
  description: AfterShip의 API 키.
  required: true
  type: string
{% endconfiguration %}

## `add_tracking` 서비스

 `afterafter.add_tracking` 서비스를 사용하여 Aftership에 추적을 추가할 수 있습니다.

| Service data attribute | Required | Type | Description |
| ---------------------- | -------- | -------- | ----------- |
| `tracking_number` | `True` | string | Tracking number
| `slug` | `False` | string | Carrier e.g. `fedex`
| `title` | `False` | string | Friendly name of package

## `remove_tracking` 서비스

 `afterafter.remove_tracking` 서비스을 사용하여 Aftership에서 추적을 제거할 수 있습니다.

| Service data attribute | Required | Type | Description |
| ---------------------- | -------- | -------- | ----------- |
| `tracking_number` | `True` | string | Tracking number
| `slug` | `True` | string | Carrier e.g. `fedex`

<div class='note info'>
본 통합구성요소는 AfterShip 공개 REST API에서 데이터를 검색하지만 이 연동과정은 AfterShip과 별다른 제휴관계는 없습니다.
</div>
