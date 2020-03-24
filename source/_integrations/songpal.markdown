---
title: 소니 오디오제어(Sony Songpal)
description: Instructions on how to integrate Sony Songpal devices into Home Assistant.
logo: sony.png
ha_category:
  - Media Player
ha_iot_class: Local Push
ha_release: 0.65
ha_codeowners:
  - '@rytilahti'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/xtTnFYGyNbc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`songpal` 플랫폼을 사용하면 홈어시스턴트의 사운드 바, AV 리시버 및 무선 스피커와 같은 Sony의 Songpal("[Audio Control API](https://developer.sony.com/develop/audio-control-api/)") 호환 장치를 제어 할 수 있습니다.

API가 공식적으로 소수의 장치 (HT-ST5000, HT-MT500, HT-CT800, SRS-ZR5 및 STR-DN1080) 만 지원하더라도 다른 장치에서도 작동하는 것으로 확인되었습니다. Sony Songpal 웹 사이트의 [The list of supported devices](https://vssupport.sony.net/en_ww/device.html)에는 이 플랫폼과 호환될 수 있는 장치가 나열되어 있습니다.

플랫폼이 목록에 없는 장치와 작동하거나 버그가 발생하면 [report them upstream](https://github.com/rytilahti/python-songpal)로 문의하십시오.

몇 가지 참고 사항 :

- 장치를 켜려면 quick start-up mode를 활성화해야합니다.
- 현재 하나의 출력 터미널만 지원합니다. 즉, 볼륨 컨트롤은 백엔드 라이브러리에서 보고한 첫 번째 볼륨 컨트롤러에서만 작동합니다.
- HT-XT3과 같은 일부 장치는 볼륨을 단계별로 정확하게 감소시키는 기능을 지원하지 않습니다.
- 사용 가능한 서비스가 개선될겁니다 !

## 설정

discovery 구성 요소가 플랫폼을 자동으로 로드합니다. 수동으로 설정하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
media_player:
  - platform: songpal
    name: my soundbar
    endpoint: http://IP_ADDRESS:10000/sony
```

{% configuration %}
name:
  description: The name to display for this device.
  required: false
  type: string
endpoint:
  description: API endpoint of the device.
  required: true
  type: string
{% endconfiguration %}

API 엔드 포인트를 얻는 방법은 [python-songpal's documentation](https://github.com/rytilahti/python-songpal#locating-the-endpoint)를 참조하십시오.

## 서비스

일반적인 [media player services](/integrations/media_player/#services) 외에 다음 서비스가 제공됩니다.

### `songpal/set_sound_setting` 서비스

사용 가능한 설정 및 값 목록을 보려면 [`songpal sound`](https://github.com/rytilahti/python-songpal#sound-settings) 명령을 사용하십시오.

| Service data attribute | Optional | Description                                      |
|------------------------|----------|--------------------------------------------------|
| `entity_id`            |      yes | Target entity, leave unset for all devices       |
| `name`                 |       no | Configuration variable, e.g., `nightmode`         |
| `value`                |       no | New configuration value, e.g., `on`               |
