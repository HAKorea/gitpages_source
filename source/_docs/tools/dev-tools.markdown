---
title: "개발자 도구"
description: "Description of the Developer Tools."
---

프론트 엔드에는 "개발자 도구"라는 섹션이 있습니다.

<p class='img'>
<img src='/images/screenshots/developer-tools.png' />
Screenshot of Home Assistant's Developer Tools.
</p>

| Section |Description |
| ------- |----- |
| States | entity의 state을 설정 |
| Services | 통합구성요소로부터의 서비스 호출 |
| Logs | 홈어시스턴트 로그 파일의 내용을 표시 |
| Events | 이벤트 발생 |
| Templates | 템플릿 렌더링 |
| Info | 홈어시스턴트에 대한 세부 사항 |

## 개발자 도구로 무엇을 할 수 있습니까?
개발자 도구는 **모든 것**을 빠르게 시험해 볼 수 있도록 고안되었습니다(개발자만을 위한 것이 아님). - 서비스 호출, 상태 업데이트, 이벤트 발생, mqtt 등의 메시지 게시 등. 또한 사용자 지정 자동화 및 스크립트를 직접 작성하는 사람들에게 필요한 도구입니다. 다음은 각 섹션에 대해 자세히 설명합니다.

## 서비스

이 섹션은 ServiceRegistry에서 사용 가능한 서비스를 호출하는 데 사용됩니다.

"서비스" 드롭 다운의 서비스 목록은 설정, 자동화 및 스크립트 파일에있는 연동을 기반으로 자동으로 채워집니다. 원하는 서비스가 존재하지 않으면 연동이 올바르게 설정되지 않았거나 설정, 자동화 또는 스크립트 파일에 정의되지 않았음을 의미합니다.

서비스를 선택하고 해당 서비스 `entity_id`를 살펴보면 "Entity" 드롭 다운에 해당 entity들이 자동으로 채워집니다.

서비스는 또한 추가 입력을 전달해야 할 수도 있습니다. 일반적으로 "서비스 데이터"라고합니다. 서비스 데이터는 YAML 형식으로 허용되며 서비스에 따라 선택적 일 수 있습니다.

엔터티 드롭 다운에서 엔터티를 선택하면 해당 `entity_id`로 서비스 데이터가 자동으로 채워집니다. 서비스 데이터 YAML은 추가 \[optional\] 매개 변수를 전달하도록 수정할 수 있습니다.  다음은 서비스를 호출하는 방법에 대한 설명입니다. 

전구를 켜려면 다음 단계를 수행합니다. :
1.	서비스 드롭 다운에서 `light.turn_on` 선택
2.	엔터티 드롭 다운에서 엔터티 (일반적으로 전구)를 선택합니다. (entity_id를 선택하지 않으면 모든 조명이 켜집니다)
3.	엔티티를 선택하면 서비스 데이터가 서비스에 전달 될 기본 JSON으로 채워집니다. 아래와 같이 JSON을 업데이트하여 추가 데이터를 전달할 수도 있습니다.

```yaml
entity_id: light.bedroom
brightness: 255
rgb_color: [255, 0, 0]
```

## States

이 섹션에는 사용 가능한 모든 엔티티, 해당 상태 및 속성 값이 표시됩니다. 상태 및 속성 정보는 Home Assistant가 런타임에 보는 것입니다. 새로운 상태 또는 새로운 속성 값으로 엔티티를 업데이트하려면 엔티티를 클릭하고 상단으로 스크롤 한 후 값을 수정하고 "상태 설정"버튼을 클릭하십시오.

홈어시스턴트 내의 장치 상태를 나타냅니다. 즉, 홈어시스턴트가 보는 것이므로 어떤 식 으로든 실제 장치와 통신하지 않습니다. 업데이트 된 정보는 여전히 이벤트 및 상태 변경을 트리거하는 데 사용될 수 있습니다. 실제 장치와 통신하려면 상태를 업데이트하는 대신 위의 서비스 섹션에서 서비스를 호출하는 것이 좋습니다.

사례 : `light.bedroom` 상태를 `off` 에서 `on`으로 변경해도 전등이 켜지지 않습니다. `light.bedroom`의`state` 변경에 대해 트리거되는 자동화가있는 경우 트리거됩니다. - 실제 전구가 켜져 있지 않더라도. 또한 전구 상태가 변경되면 - 상태 정보가 무시됩니다. 즉, "상태"섹션을 통해 변경 한 내용은 일시적이므로 테스트 목적으로 만 사용하는 것이 좋습니다.

## Events

This Events section is as basic as it can get. It does only one thing – fires events on the event bus.
To fire an event, simply type the name of the event, and pass the event data in JSON format.
For ex: To fire a custom event, enter the `event_type` as `event_light_state_changed` and the event data JSON as
이벤트 섹션은 기본적으로 단순합니다. 이벤트 버스에서 이벤트만를 발생시킵니다. 이벤트를 시작하려면 간단히 이벤트 이름을 입력하고 이벤트 데이터를 JSON 형식으로 전달하십시오. 예: 커스텀 이벤트를 발생 시키려면 `event_type`을 `event_light_state_changed`로 입력하고 이벤트 데이터를 JSON로 씁니다. 

```yaml
state: on
```

해당 이벤트를 처리하는 자동화가 있으면 자동으로 트리거됩니다. 아래를 보십시오 :

```yaml
- alias: Capture Event
  trigger:
    platform: event
    event_type: event_light_state_changed
  action:
    - service: notify.notify
      data_template:
        message: "Light is turned {{ trigger.event.data.state }}"
```

## 템플릿 편집기

템플릿 편집기는 템플릿 코드를 빠르게 테스트하는 방법을 제공합니다. 템플릿 편집기 페이지가 로드되면 코드 작성 및 테스트 방법을 보여주는 샘플 템플릿 코드가 함께 제공됩니다.

두 개의 섹션이 있으며 코드는 왼쪽으로 가고 출력은 오른쪽으로 나타납니다. 코드를 제거하고 교체 할 수 있으며 페이지가 로드/갱신 될 때 기본 샘플 코드가 다시로드됩니다.

자동화 및 스크립트에 넣기 전에 템플릿 편집기에서 템플릿 코드를 테스트하는 것이 좋습니다.

jinja2에 대한 자세한 내용은 [jinja2 documentation](http://jinja.pocoo.org/docs/dev/templates/)을 방문 하고 [here](/topics/templating/)에서 템플릿 문서를 읽으십시오.

## MQTT

이 섹션은 MQTT 연동이 설정된 경우에만 표시됩니다. MQTT를 설정하려면, `mqtt:`를 `configuration.yaml`파일에 써넣습니다. 자세한 정보는 [mqtt](/integrations/mqtt/) component를 참조하십시오.

MQTT는 일반적으로 더 깊은 기능을 제공하지만 MQTT의 개발자 도구 섹션은 주어진 topic에 메시지를 공개하는 것으로 제한됩니다. payload에 대한 템플릿을 지원합니다. 메시지를 publish하려면 topic 이름과 payload를 지정하고 "publish"버튼을 클릭하십시오.

## Logs

이 섹션에는 `syslog` 정보와 로그 내용을 지우고 새로 고치는 옵션이 있는 `home-assistant.log` 자료를 보여줍니다.

## Info

정보 탭은 단순히 현재 설치된 버전, [system health](/integrations/system_health/) (활성화 된 경우), 추가 링크 및 크레딧에 대한 정보를 제공합니다 .