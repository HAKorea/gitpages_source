---
title: 데모(Demo)
description: Instructions on how to use the Platform demos with Home Assistant.
logo: home-assistant.png
ha_category:
  - Other
ha_release: 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`demo` 플랫폼을 사용하면 데모 구현을 제공하는 통합구성요소를 사용할 수 있습니다. 데모 엔티티는 가상이지만 실제 플랫폼이 어떻게 보이는지 보여줍니다. 이 방법으로 온라인 [Home Assistant demo](/demo/) 또는 `hass --demo-mode`와 같은 자체 데모 인스턴스를 실행할 수 있지만 자신의 실제 기능을 하는 플랫폼과 결합할 수도 있습니다.

사용 가능한 데모 플랫폼 :

- [Air Quality](/integrations/air_quality/) (`air_quality`)
- [Alarm control panel](/integrations/alarm_control_panel/) (`alarm_control_panel`)
- [Binary sensor](/integrations/binary_sensor/) (`binary_sensor`)
- [Camera](/integrations/camera/) (`camera`)
- [Climate](/integrations/climate/) (`climate`)
- [Cover](/integrations/cover/) (`cover`)
- [Fan](/integrations/fan/) (`fan`)
- [Geolocation](/integrations/geo_location/) (`geo_location`)
- [Image Processing](/integrations/image_processing/) (`image_processing`)
- [Light](/integrations/light/) (`light`)
- [Lock](/integrations/lock/) (`lock`)
- [Mailbox](/integrations/mailbox/) (`mailbox`)
- [Media Player](/integrations/media_player/) (`media_player`)
- [Notification](/integrations/notify/) (`notify`)
- [Remote](/integrations/remote/) (`remote`)
- [Sensor](/integrations/sensor/) (`sensor`)
- [Switch](/integrations/switch/) (`switch`)
- [Text-to-speech](/integrations/tts/) (`tts`)
- [Weather](/integrations/weather/) (`weather`)


Home Assistant에서 데모 플랫폼을 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가 하십시오.

```yaml
# Example configuration.yaml entry
[component]:
  - platform: demo
```

{% configuration %}
"[component]":
  description: 설정 예제 위의 목록에 명시된 통합구성요소의 이름입니다.
  required: true
  type: string
{% endconfiguration %}
