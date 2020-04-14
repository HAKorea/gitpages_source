---
title: 구글 캐스트(Google Cast)
description: Instructions on how to integrate Google Cast into Home Assistant.
logo: google_cast.png
ha_category:
  - Media Player
featured: true
ha_release: pre 0.7
ha_iot_class: Local Polling
ha_config_flow: true
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/4KMJDOWa_ao" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

홈어시스턴트에서 설정 - 통합구성요소로 이동하여 Cast 통합구성요소를 추가하여 사용할 수 있습니다.

**참고 : HA카페 [지영파님의 Nest Hub를 깨우자](https://cafe.naver.com/koreassistant/120)의 글을 활용하시면 HA화면을 구글 NEST 허브에 나타나게 할 수 있습니다.

## Home Assistant Cast

홈어시스턴트에는 Chromecast 기기에 홈어시스턴트 UI를 표시하는 고유한 전송 애플리케이션이 있습니다. [Cast entity row](/lovelace/entities/#cast)를 Lovelace UI에 추가하여 사용하거나 `cast.show_lovelace_view` 서비스를 호출해서 사용할 수 있습니다. 해당 서비스는 Cast 장치의 entity와 Lovelace 화면의 경로를 통해서 view로 화면에 노출시킬 수 있습니다. [views documentation](/lovelace/views/#path)에서 제시하였듯이 `path`는 각 view 화면을 위한 Lovelace YAML에서 정의되어야 합니다.  


```json
{
  "entity_id": "media_player.office_display_4",
  "view_path": "lights"
}
```

홈어시스턴트 설치가 `https://` 를 경유하여 설치되어야 홈어시스턴트 캐스트를 통해 액세스할 수 있습니다.  홈어시스턴트 Cloud를 사용하는 경우 별도의 작업을 수행할 필요가 없습니다. 그렇지 않으면 확실히 [`http` 통합구성요소](/integrations/http/)를 위한 `base_url`로 설정되어있는지 확인해야합니다.

## 고급 사용

Cast 장치는 홈어시트턴트와 동일한 서브넷에 있는 경우에만 검색할 수 있습니다. 그렇지 않은 경우 Cast 장치의 IP 주소를 직접 설정해야합니다:

```yaml
# Example configuration.yaml entry
cast:
  media_player:
    - host: 192.168.1.10
```

{% configuration %}
media_player:
  description: 모든 Cast 장치가 포함된 목록입니다.
  required: true
  type: list
  keys:
    host:
      description: 장치를 검색하지 않으려는 경우에만 사용하십시오.
      required: false
      type: string
    ignore_cec:
      description: >
        유효한 입력신호를 결정하기 위해 CEC 데이터를 무시해야하는 Chromecast 목록입니다. [See the upstream documentation for more information.](https://github.com/balloob/pychromecast#ignoring-cec-data)
      required: false
      type: list
{% endconfiguration %}
