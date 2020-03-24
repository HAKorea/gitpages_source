---
title: Enigma2(OpenWebif)
description: Instructions on how to integrate an Enigma2 based box running OpenWebif into Home Assistant.
logo: openwebif.png
ha_category:
  - Media Player
ha_release: '0.90'
ha_iot_class: Local Polling
ha_codeowners:
  - '@fbradyirl'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/1VasQu_yoBo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`enigma2` 플랫폼을 사용하면 OpenWebif 플러그인이 설치된 [Enigma2](https://github.com/oe-alliance/oe-alliance-enigma2)를 실행하는 Linux 기반 셋톱 박스를 제어할 수 있습니다.

[OpenWebif](https://github.com/E2OpenPlugins/e2openplugin-OpenWebif)는 Enigma2 기반 셋톱 박스를 위한 오픈 소스 웹 인터페이스입니다.

Enigma2 장치는 [the discovery component](/integrations/discovery/)를 사용하여 자동으로 검색해야합니다.

셋톱 박스를 설치에 수동으로 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: enigma2
    host: IP_ADDRESS
```

{% configuration %}
  host:
    description: The IP/hostname of the Enigma2 set-top box on your home network.
    required: true
    type: string
  use_channel_icon:
    description: By default, a screen grab of the current channel is shown. If you prefer the channel icon to be shown instead, set this to true.
    required: false
    type: boolean
    default: false
  deep_standby:
    description: If set to true, when the user selects Turn Off, the box will go into "deep standby" mode, meaning it can be only awoken by the remote control or via Wake On Lan (if box supports that).
    required: false
    type: boolean
    default: false
  mac_address:
    description: If specified, a Wake On Lan packet is sent to this MAC address, when Turn On is selected.
    required: false
    type: string
    default: empty
  source_bouquet:
    description: Provide a specific bouquet reference for the bouquet you would like to see loaded into the media player "Sources" interface.
    required: false
    type: string
    default: empty
  port:
    description: Port which OpenWebif is listening on.
    required: false
    type: integer
    default: 80
  username:
    description: The username of a user with privileges to access the box. This is only required if you have enabled the setting "Enable HTTP Authentication" in OpenWebif settings. _(e.g., on the remote by pressing `Menu`>`Plugins`>`OpenWebif`)_.
    required: false
    type: string
    default: root
  password:
    description: The password for your given account. Again, this is only required if you have enabled the setting "Enable HTTP Authentication" in OpenWebif settings. _(e.g., on the remote by pressing `Menu`>`Plugins`>`OpenWebif`)_.
    required: false
    type: string
    default: dreambox
  ssl:
    description: Use HTTPS instead of HTTP to connect. This is only required if you have enabled the setting "Enable HTTPS" in OpenWebif settings. _(e.g., on the remote by pressing `Menu`>`Plugins`>`OpenWebif`)_. You will need to ensure you have a valid CA certificate in place or SSL verification will fail with this component.
    required: false
    type: boolean
    default: false
  name:
    description: A name for easy identification of the device.
    required: false
    type: string
    default: Enigma2 Media Player
{% endconfiguration %}
