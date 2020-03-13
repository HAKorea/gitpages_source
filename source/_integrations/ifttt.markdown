---
title: IFTTT
description: Instructions on how to setup IFTTT within Home Assistant.
logo: ifttt.png
ha_category:
  - Automation
featured: true
ha_iot_class: Cloud Push
ha_release: 0.8
ha_config_flow: true
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/pQpz_Ms8tiU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[IFTTT](https://ifttt.com) 는 사용자가 소위 "애플릿"이라는 간단한 조건문 체인을 만들 수있는 웹 서비스입니다. IFTTT 구성 요소를 사용하면 **Webhooks** 서비스 (이전의 **Maker** 채널)를 통해 애플릿을 트리거 할 수 있습니다 

## IFTTT에서 홈어시스턴트로 이벤트 보내기

FTTT에서 이벤트를 수신하려면 웹에서 홈어시스턴트 인스턴스에 액세스 할 수 있어야하고 ([Hass.io instructions](/addons/duckdns/)), HTTP 통합을 위해 `base_url`을 구성해야합니다 (참고 : [docs](/integrations/http/#base_url)).

### 통합 설정 (Setting up the integration)

이를 설정하려면 설정 화면의 통합구성요소 페이지로 이동하여 IFTTT를 찾으십시오. 설정을 클릭하십시오. 화면의 지시 사항에 따라 IFTTT를 구성하십시오.

### 수신 데이터 사용 (Using the incoming data)

IFTTT에서 들어오는 이벤트는 홈어시스턴트 이벤트로 사용 가능하며 `ifttt_webhook_received`로 시작됩니다. 
IFTTT에 지정된 데이터는 이벤트 데이터로 사용 가능합니다. 이 이벤트를 사용하여 자동화를 트리거 할 수 있습니다.

예를 들어, IFTTT 웹 후크 본문을 다음과 같이 설정하십시오. :

```json
{ "action": "call_service", "service": "light.turn_on", "entity_id": "light.living_room" }
```

그런 다음 다음 자동화를 통해 수신 정보를 이용해야합니다. :

{% raw %}
```yaml
automation:
- id: this_is_the_automation_id
  alias: The optional automation alias
  trigger:
  - event_data:
      action: call_service
    event_type: ifttt_webhook_received
    platform: event
  condition: []
  action:
  - data_template:
      entity_id: '{{ trigger.event.data.entity_id }}'
    service_template: '{{ trigger.event.data.service }}'
```
{% endraw %}

## IFTTT로 이벤트 보내기 (Sending events to IFTTT)

```yaml
# Example configuration.yaml entry
ifttt:
  key: YOUR_API_KEY
```

`key`는 [Webhooks applet](https://ifttt.com/services/maker_webhooks/settings)의 **Settings**을 확인하여 얻을 수있는 API 키입니다. URL의 마지막 부분 (예 : https://maker.ifttt.com/use/MYAPIKEY)은 **My Applets** > **Webhooks** > **Settings**에서 찾을 수 있습니다.


<p class='img'>
<img src='/images/integrations/ifttt/finding_key.png' />
Maker Channel의 property 화면
</p>

`configuration.yaml` 파일에 키를 추가하면 홈어시스턴트 서버를 다시 시작하십시오. 그러면 IFTTT 통합구성요소가 로드되고 IFTTT에서 이벤트를 트리거하는 서비스가 제공됩니다.

<div class='note'>
서버를 다시 시작한 후 콘솔에 빨간색, 흰색 또는 노란색으로 나타나는 로깅 오류가 있는지 확인하십시오.
</div>

### 여러개의 IFTTT의 키 (Multiple IFTTT keys)

여러 IFTTT 사용자가있는 경우 다음을 사용하여 여러 IFTTT 키를 지정할 수 있습니다. :

```yaml
# Example configuration.yaml entry
ifttt:
  key: 
    YOUR_KEY_NAME1: YOUR_API_KEY1
    YOUR_KEY_NAME2: YOUR_API_KEY2
```


### 트리거 테스트 (Testing your trigger)

**개발자 도구**를 사용하여 [Webhooks](https://ifttt.com/maker_webhooks) 트리거를 테스트 할 수 있습니다. 이렇게하려면 홈어시스턴트 사이드 바를 열고 개발자 도구를 클릭 한 다음 **서비스** 탭을 클릭하십시오. 그리고 다음 값을 입력하십시오 

Field | Value
----- | -----
domain | `ifttt`
service | `trigger`
Service Data | `{"event": "EventName", "value1": "Hello World"}`

<p class='img'>
<img src='/images/integrations/ifttt/testing_service.png' />
다음 화면과 같이 'call service' 버튼을 클릭하십시오.
</p>

기본적으로 트리거는`configuration.yaml`에서 모든 API 키로 전송됩니다. 트리거를 특정 키로 보내려면 `target` 필드를 사용하십시오. : 

Field | Value
----- | -----
domain | `ifttt`
service | `trigger`
Service Data | `{"event": "EventName", "value1": "Hello World", "target": "YOUR_KEY_NAME1"}`

`target` 필드는 단일키 이름 또는 키 이름 목록을 포함 할 수 있습니다.

### 레시피 설정 (Setting up a recipe)

*새 애플릿* 단추를 누르고 *Webhooks*를 검색하십시오.

<p class='img'>
<img src='/images/integrations/ifttt/setup_service.png' />
"Webhooks"를 서비스로 선택하십시오.
</p>

<p class='img'>
<img src='/images/integrations/ifttt/setup_trigger.png' />
IFTTT로 보낸 각 이벤트에 대해 고유한 트리거를 설정해야합니다.
</p>

{% raw %}
```yaml
# Example configuration.yaml Automation entry
automation:
  alias: Startup Notification
  trigger:
    platform: homeassistant
    event: start
  action:
    service: ifttt.trigger
    data: {"event":"TestHA_Trigger", "value1":"Hello World!"}
```
{% endraw %}

IFTTT는 스크립트와 `data_template`에서도 사용할 수 있습니다.  변수와 data_templates를 사용하여 자동화와 스크립트로 나눈 것이 위의 자동화입니다.

{% raw %}
```yaml
# Example configuration.yaml Automation entry
automation:
  alias: Startup Notification
  trigger:
    platform: homeassistant
    event: start
  action:
    service: script.ifttt_notify
    data_template:
      value1: 'HA Status:'
      value2: "{{ trigger.event.data.entity_id.split('_')[1] }} is "
      value3: "{{ trigger.event.data.to_state.state }}"
```
{% endraw %}

{% raw %}
```yaml
#Example Script to send TestHA_Trigger to IFTTT but with some other data (homeassistant UP).
ifttt_notify:
  sequence:
    - service: ifttt.trigger
      data_template: {"event":"TestHA_Trigger", "value1":"{{ value1 }}", "value2":"{{ value2 }}", "value3":"{{ value3 }}"}
```
{% endraw %}

### 추가 채널 사례 (Additional Channel Examples)

IFTTT 채널 사용에 대한 추가 예는 아래에서 확인할 수 있습니다.

Channel | Description
----- | -----
[Manything](/integrations/ifttt.manything/) | 홈어시스턴트 AWAY 및 HOME 값을 기반으로 녹화를 켜고 끄는 것을 자동화합니다..
