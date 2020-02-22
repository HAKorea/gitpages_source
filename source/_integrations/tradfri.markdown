---
title: IKEA TRÅDFRI (TRADFRI)
description: Access and control your IKEA Trådfri Gateway and its connected Zigbee-based devices.
featured: true
logo: ikea.svg
ha_iot_class: Local Polling
ha_config_flow: true
ha_release: 0.43
ha_category:
  - Cover
  - Light
  - Sensor
  - Switch
ha_codeowners:
  - '@ggravlingen'
---

현재 이케아 TRADFRI 제품은 별도의 [지그비 게이트웨이](https://www.ikea.com/ca/en/p/tradfri-gateway-white-00337813/) 가 필요합니다. 허나 Zigbee2mqtt 활용시 한개의 허브로 동작시킬 수 있습니다. 이에 이케아 통합구성요소에 임시로 Zigbee2mqtt 연동 방식을 올려둡니다. 

그중에서 **현재 가장 많이 쓰는 통신방식은 Zigbee 제품**임으로 [Zigbee2mqtt 설치방법](https://hakorea.github.io/integrations/zha/)를 통해 필립스 Hue 제품군들을 설치하시길 권장합니다. 

zigbee2mqtt의 [이케아 장치들의 지원 목록](https://www.zigbee2mqtt.io/information/supported_devices.html#ikea) 을 참조하십시오. 

이외에도 Zigbee2mqtt는 2020년 2월 17일 현재 **112개 회사의 584개 장치**들을 공식 지원합니다. 



The `tradfri` integration allows you to connect your IKEA Trådfri Gateway to Home Assistant. The gateway can control compatible Zigbee-based lights (certified Zigbee Light Link products) connected to it. Home Assistant will automatically discover the gateway's presence on your local network if `discovery:` is present in your `configuration.yaml` file.

You will be prompted to configure the gateway through the Home Assistant interface. The configuration process is very simple: when prompted, enter the security key printed on the sticker on the bottom of the IKEA Trådfri Gateway, then click *configure*.

<div class='note'>
If you see an "Unable to connect" message, restart the gateway and try again. Don't forget to assign a permanent IP address to your IKEA Trådfri Gateway on your router or DHCP server.
</div>

## Configuration

You can add the following to your `configuration.yaml` file if you are not using the [`discovery:`](/integrations/discovery/) component:

```yaml
# Example configuration.yaml entry
tradfri:
  host: IP_ADDRESS
```

{% configuration %}
host:
  description: "The IP address or hostname of your IKEA Trådfri Gateway."
  required: true
  type: string
allow_tradfri_groups:
  description: "Set this to `true` to allow Home Assistant to import the groups defined on the IKEA Trådfri Gateway."
  required: false
  type: boolean
  default: false
{% endconfiguration %}

## Troubleshooting

### Firmware updates

After updating your IKEA Trådfri Gateway firmware it might be necessary to repeat the configuration process. One error you might experience after a firmware update is `Fatal DTLS error: code 115`. If you encounter problems:
- when configured using the integration: remove the integration through Settings > Integrations > Tradfri > delete (trash can icon)
- with manual configuration: delete the `.tradfri_psk.conf` file in your `/.homeassistant` directory (`/config` directory if using Hass.io or Docker)

Then restart Home Assistant. When prompted, enter the security key and click *configure*, just like during initial setup.

### Compilation issues

<div class='note'>
  This does not apply to Hass.io or Docker.
</div>

Please make sure you have `autoconf` installed (`$ sudo apt-get install autoconf`) if you want to use this component. Also, installing some dependencies might take considerable time (more than one hour) on slow devices.

### Setting the `api_key`

Do not use the `api_key` variable in `configuration.yaml`. The API key is only needed once at initial setup and will be stored.
