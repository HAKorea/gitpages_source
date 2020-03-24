---
title: 조아앱스 조인(Joaoapps Join)
description: Instructions for how to integrate the Join by Joaoapps service within Home Assistant.
logo: joaoapps_join.png
ha_category:
  - Hub
  - Notifications
ha_release: 0.24
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/0AC6odBhUiA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`joaoapps_join` 통합구성요소는 [Join](https://joaoapps.com/join)의 서비스를 노출해 놓았습니다. 홈어시스턴트에서 Join 기능은 Join 구성 요소 및 Join notify 플랫폼의 두가지로 나뉩니다.
알림 플랫폼을 통해 Join 장치에 메시지를 보낼 수 있으며, 구성 요소를 통해 Join이 제공하는 다른 특수 기능에 액세스 할 수 있습니다. 확실하지 않은 경우에는 이를 기반으로 하는 [API documentation](https://joaoapps.com/join/api/)을 참조하십시오.

`configuration.yaml` 파일에서 API 키와 장치 ID 또는 대상 장치의 이름을 제공해야합니다. 장치 ID와 API 키를 [here](https://joinjoaomgcd.appspot.com/)에서 찾을 수 있습니다

**HA 네이버 카페에서 깔롱미니ohminy**님의  [HA와 Joaopps Join 연동 후기](http://blog.naver.com/ohminy11/221468519502)를 참조하십시오. 

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
notify:
  - platform: joaoapps_join
    api_key: YOUR_API_KEY
    device_id: DEVICE_ID
    device_ids: DEVICE_ID_1,DEVICE_ID_2
    device_names: DEVICE_1_NAME,DEVICE_2_NAME
    name: NAME
joaoapps_join:
  - name: NAME_OF_GROUP
    device_id: GROUP.GROUP_NAME
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Join을 위한 API 키.
  required: true
  type: string
device_id:
  description: 기기 또는 그룹의 ID
  required: false
  type: string
device_ids:
  description: 장치 ID 또는 그룹의 쉼표로 구분 된 목록.
  required: false
  type: string
device_names:
  description: 쉼표로 구분된 장치 이름 목록.
  required: false
  type: string
name:
  description: name 매개 변수는 선택 사항이지만 여러 알림 플랫폼을 사용하려는 경우 필요합니다. 플랫폼은 `notify.<name>` 서비스로 노출됩니다. 제공하지 않으면 이름이 `notify`으로 기본값이 됩니다. 자세한 내용은 [Notifications Component](/integrations/notify)을 참조하십시오.
  required: false
  type: string
{% endconfiguration %}

`device_id`,`device_ids` 또는 `device_names` 중 하나만 사용하면 알림 수신자가 결정됩니다.

```yaml
# Example configuration.yaml entry
notify:
  - platform: joaoapps_join
    api_key: YOUR_API_KEY
    device_id: DEVICE_ID1
    name: NAME1
  - platform: joaoapps_join
    api_key: YOUR_API_KEY
    device_id: DEVICE_ID2
    name: NAME2
```

알림 서비스에는 `icon`, `smallicon`, `image`, `sound`, `url`, `notification_id`, `tts`, `tts_language` 및 `vibration`과 같은 몇 가지 선택적 매개 변수가 있습니다.

다음과 같이 사용할 수 있습니다. 

```json
{
	"message": "Hello from Home Assistant!",
	"title": "Home Assistant",
	"data": {
		"icon": "https://goo.gl/xeetdy",
		"smallicon": "https://goo.gl/xeetdy",
		"vibration": "0,65,706,86,657,95,668,100",
		"image": "https://www.home-assistant.io/images/favicon-192x192-full.png",
		"sound": "https://goo.gl/asasde.mp3",
		"url": "https://home-assistant.io",
		"notification_id": "hass-notification",
		"tts": "Notification from Home Assistant",
		"tts_language": "english"
	}
}
```

`joaoapps_join` 통합구성요소에 노출된 서비스는 아래 설명된 서비스 데이터와 함께 사용할 수 있습니다.

| Service                       | Data                                                              |
|------------------------------ |------------------------------------------------------------------ |
| joaoapps_join/ring            |                                                                   |
| joaoapps_join/send_sms        | `{"number":"5553334444", "message":"Hello!"}`                       |
| joaoapps_join/send_tasker     | `{"command":"test"}`                                                |
| joaoapps_join/send_url        | `{"url":"http://google.com"}`                                       |
| joaoapps_join/send_wallpaper  | `{"url":"http://www.planwallpaper.com/static/images/ZhGEqAP.jpg"}`  |
| joaoapps_join/send_file       | `{"url":"http://download.thinkbroadband.com/5MB.zip"}`              |
