---
title: 나노리프(Nanoleaf)
description: Instructions how to integrate Nanoleaf Light Panels into Home Assistant.
logo: nanoleaf_light.png
ha_category:
  - Light
ha_iot_class: Local Polling
ha_release: 0.67
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/o41emqmX6ds" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

### 설정 샘플

`nanoleaf` 플랫폼을 사용하면 Home Assistant에서 [Nanoleaf Light Panels](https://nanoleaf.me)를 제어 할 수 있습니다.

이 플랫폼을 설정하는 바람직한 방법은 [discovery component](/integrations/discovery/)를 활성화하는 것입니다.
홈어시스턴트가 시작되는 동안 Nanoleaf 표시 등에서 *ON* 버튼을 5 초 동안 누르고 있습니다 (LED가 깜박이기 시작함).

Nanoleaf 조명을 수동으로 설정하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
light:
  - platform: nanoleaf
    host: 192.168.1.10
    token: xxxxxxxxxxxxxxxxxxxxx
```

{% configuration %}
host:
  description: "장치의 IP 주소 또는 호스트 이름 (예 : 192.168.1.10)"
  required: true
  type: string
token:
  description: "*POST*를 통해 */api/v1/new*에 제공하는 *auth* 토큰"
  required: true
  type: string
name:
  description: 구성 요소 이름, 여러 개의 라이트 패널이있는 경우 고유한 이름으로 지정하십시오.
  required: false
  type: string
  default: Nanoleaf
{% endconfiguration %}

### 인증 토큰 받기

1. Make sure that your Nanoleaf Light Panel is fully patched (as of the time of writing the latest version was 3.0.8 for Aurora and 1.2.0 for Canvas)
2. Hold down the *ON* button on the Panel for 5 seconds; the LED will start flashing
3. Issue a *POST* request to the API endpoint, e.g., via `$ curl -i -X POST http://192.168.1.155:16021/api/v1/new`
4. The output should include the auth token like *{"auth_token":"xxxxxxxxxxxxxxxxxxxxx"}*, copy the resulting token into your configuration

403 Forbidden 메시지가 표시되면 *ON* 단추를 충분히 길게 누르지 않았을 수 있습니다. 유효한 토큰을 얻는데 걸리는 시간은 30 초에 불과하므로 curl 요청을 신속하게 발행해야합니다.