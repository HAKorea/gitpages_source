---
title: "Picture Card"
sidebar_label: Picture
description: "A very simple card that allows you to set an image to use for navigation to various paths in your interface or to call a service."
---

인터페이스의 다양한 경로를 탐색하거나 서비스를 호출하는데 사용할 이미지를 설정할 수 있는 매우 간단한 카드입니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_picture.png' alt='Screenshot of the picture card'>
그림 카드의 스크린 샷.
</p>

{% configuration %}
type:
  required: true
  description: picture
  type: string
image:
  required: true
  description: 이미지의 URL.
  type: string
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
tap_action:
  required: false
  description: 탭할시 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`none`"
    navigation_path:
      required: false
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출 할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시하십시오. 아래의 `confirmation` 개체를 참조"
      type: [boolean, map]
      default: "false"
hold_action:
  required: false
  description: 길게 눌렀을 때의 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`none`"
    navigation_path:
      required: false
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출 할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`)"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시하십시오. 아래의 `confirmation` 개체를 참조."
      type: [boolean, map]
      default: "false"
double_tap_action:
  required: false
  description: 더블탭을 눌렀을 때의 액션
  type: map
  keys:
    action:
      required: true
      description: "액션 수행 (`more-info`, `toggle`, `call-service`, `navigate`, `url`, `none`)"
      type: string
      default: "`more-info`"
    navigation_path:
      required: false
      description: "`action`이 `navigate` 로 정의된 경우 탐색 할 경로 (예: `/lovelace/0/`)"
      type: string
      default: none
    url_path:
      required: false
      description: "`action`이 `url` 로 정의된 경우 (예: `https://www.home-assistant.io`)"
      type: string
      default: none
    service:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 호출 할 서비스 (예 :`media_player.media_play_pause`)"
      type: string
      default: none
    service_data:
      required: false
      description: "`action`이 `call-service` 로 정의된 경우 포함할 서비스 데이터 (예: `entity_id: media_player.bedroom`"
      type: string
      default: none
    confirmation:
      required: false
      description: "작업을 컨펌하는 확인 대화 상자를 표시하십시오. 아래의 `confirmation` 개체를 참조."
      type: [boolean, map]
      default: "false"
{% endconfiguration %}

## Confirmation 옵션

boolean 대신 객체로 확인을 정의하면 더 많은 사용자 정의 및 설정을 추가 할 수 있습니다
{% configuration %}
text:
  required: false
  description: Confirmation 대화 상자에 표시 할 텍스트.
  type: string
exemptions:
  required: false
  description: "`exemption` 리스트 객체. 아래 참조"
  type: list
{% endconfiguration %}

## 면제 옵션 (Exemptions 옵션)

{% configuration badges %}
user:
  required: true
  description: 보기 탭을 볼 수있는 사용자 ID.
  type: string
{% endconfiguration %}

## 사례

다른보기로 이동 :

```yaml
type: picture
image: /local/home.jpg
tap_action:
  action: navigate
  navigation_path: /lovelace/home
```

사용자 정의 ID를 설정하는 방법은 [views](/lovelace/views/) 설정을 확인하십시오.

Toggle 엔티티를 사용하는 서비스 :

```yaml
type: picture
image: /local/light.png
service: light.toggle
service_data:
  entity_id: light.ceiling_lights
```
