---
title: HTTP
description: Offers a web framework to serve files.
logo: http.png
ha_category:
  - Other
  - Binary Sensor
  - Sensor
ha_release: pre 0.7
ha_iot_class: Local Push
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`http` 통합구성요소는 홈 어시스턴트 프론트 엔드에 필요한 모든 파일과 데이터를 제공합니다. 기본 설정을 변경하려는 경우 설정 파일에만 추가하면됩니다.

현재 홈 어시스턴트에서 다음 장치 유형이 지원됩니다. :

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)

<div class='note'>

Hass.io 설치에서 `server_host` 옵션을 사용하지 마십시오!

</div>

```yaml
# Example configuration.yaml entry
http:
```

{% configuration %}
server_host:
  description: "특정 IP/호스트에서 들어오는 요청만 듣습니다. 기본적으로 모든 IPv4 연결을 수락합니다. IPv6을 듣고 싶다면 `server_host : :: 0`을 사용하십시오."
  required: false
  type: string
  default: 0.0.0.0
server_port:
  description: 사용할 포트를 설정하십시오.
  required: false
  type: integer
  default: 8123
base_url:
  description: "인터넷에서 홈 어시스턴트를 사용할 수있는 URL. 예: `https://hass-example.duckdns.org:8123`. iOS 앱은 로컬 설치를 찾습니다. 외부 URL이 있는 경우 이를 사용하여 앱에서 발견 될 때 자동으로 채울 수 있습니다. 이 설정에는 프로토콜, 호스트 이름 및 포트만 포함될 수 있습니다. 경로를 사용하는 것은 현재 *지원되지 않습니다.*"
  required: false
  type: string
  default: Your local IP address
ssl_certificate:
  description: 보안 연결을 통해 Home Assistant에 제공하기위한 TLS/SSL 인증서 경로.
  required: false
  type: string
ssl_peer_certificate:
  description: 보안 연결을 수락 할 클라이언트/피어 TLS/SSL 인증서의 경로.
  required: false
  type: string
ssl_key:
  description: 보안 연결을 통해 Home Assistant를 제공하기위한 TLS/SSL 키 경로.
  required: false
  type: string
cors_allowed_origins:
  description: "[CORS] (https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) 요청을 허용하는 원래 도메인 이름 목록입니다. 이를 활성화하면 목록에 있는 경우 `Access-Control-Allow-Origin` 헤더가 Origin 헤더로 설정되고 `Access-Control-Allow-Headers`헤더는 `Origin, Accept, X-Requested-With Content-type, Authorization`로 설정됩니다. 정확한 출발지(Origin)를 제공해야합니다. 예로서 `https : // www.home-assistant.io`는 `https://www.home-assistant.io`의 요청을 허용하지만 `http://www.home-assistant.io`의 요청을 허용하지 __않습니다__."
  required: false
  type: [string, list]
use_x_forwarded_for:
  description: "프록시 설정에서 클라이언트의 올바른 IP 주소를 전달하여 `X-Forwarded-For` 헤더의 구문 분석을 활성화하십시오. 이 작업을 수행하려면 `trusted_proxies`'설정을 사용하여 신뢰할 수 있는 프록시를 허용 **해야합니다.** 이 헤더가 있지만 화이트리스트에 없는 요청은 IP 스푸핑 공격으로 간주되므로 헤더가 무시됩니다."
  required: false
  type: boolean
  default: false
trusted_proxies:
  description: "`X-Forwarded-For` 헤더를 설정할 수 있는 IP주소 또는 네트워크로 구성된 신뢰할 수있는 프록시 목록.`use_x_forwarded_for`를 사용할 때는 소스에 관계없이 홈어시스턴트에 대한 모든 요청이 리버스 프록시 IP주소에서 도착하기 때문에 필요합니다. 따라서 리버스 프록시 시나리오에서이 옵션은주의해서 설정해야합니다. "
  required: false
  type: [string, list]
trusted_networks:
  description: "**0.89 릴리스부터 사용되지 않습니다. 설정은 [Trusted Networks auth provider](/docs/authentication/providers/#trusted-networks)로 이동하였습니다.**"
  required: false
  type: [string, list]
ip_ban_enabled:
  description: 추가 IP필터링 사용 여부를 나타내는 플래그입니다.
  required: false
  type: boolean
  default: false
login_attempts_threshold:
  description: "`ip_ban_enabled`가 `true` 인 경우 단일 IP에서 실패한 로그인 시도 횟수입니다. -1로 설정하면 새로운 자동 금지가 추가되지 않습니다. "
  required: false
  type: integer
  default: -1
ssl_profile:
  description: 사용할 [Mozilla SSL 프로파일](https://wiki.mozilla.org/Security/Server_Side_TLS). The [Mozilla SSL profile](https://wiki.mozilla.org/Security/Server_Side_TLS) to use. SSL 핸드 셰이크 오류를 일으키는 연동이 발생하는 경우에만 써보십시오. 
  required: false
  type: string
  default: modern
{% endconfiguration %}

<div class='note'>

`http` 통합구성요소를 통한 trusted_networks 구성은 더 이상 사용되지 않으며 대신 `auth_providers`로 이동합니다. 예로서 <a href="/docs/authentication/providers/#trusted-networks">trusted networks</a>를 참조하세요.

</div>

아래 샘플은 가능한 값을 가진 설정 항목을 보여줍니다. :

```yaml
# Example configuration.yaml entry
http:
  server_port: 12345
  ssl_certificate: /etc/letsencrypt/live/hass.example.com/fullchain.pem
  ssl_key: /etc/letsencrypt/live/hass.example.com/privkey.pem
  cors_allowed_origins:
    - https://google.com
    - https://www.home-assistant.io
  use_x_forwarded_for: true
  trusted_proxies:
    - 10.0.0.200
  ip_ban_enabled: true
  login_attempts_threshold: 5
```

[Let's Encrypt를 사용하여 암호화 설정](/블로그/2015/12/13/setup-encryption-using-lets-encrypt/) 블로그 게시물은 [Let's Encrypt](https://letsencrypt.org/)의 무료 인증서를 사용하여 트래픽 암호화에 대한 세부 정보를 제공합니다. 

또는 여기 지침에 따라 자체 서명 된 인증서를 사용하십시오. [SSL/TLS 용 자체 서명 인증서](/docs/ecosystem/certificates/tls_self_signed_certificate/).

## APIs

`http` 통합구성요소 외에도 [REST API](/developer/rest_api/), [Python API](/developer/python_api/) 및 [WebSocket API](/developer/websocket_api/)를 사용할 수 있습니다.

`http` 플랫폼은 홈어시스턴트 주변에서 사용되는 용어의 의미 내에서 실제 플랫폼이 아닙니다. 홈어시스턴트의 [REST API](/developer/rest_api/)는 HTTP를 통해 메시지를 보내고 받습니다.

## HTTP sensors

설치에서 이러한 종류의 [sensors](#sensor) 또는 [binary sensors](#binary-sensor)를 사용하려면 Home Assistant에서 설정 할 필요가 없습니다. 즉, 대상 URL 또는 엔드포인트 및 페이로드를 편집 할 수 있어야합니다. 첫 번째 메시지가 도착하면 엔티티가 작성됩니다.

HTTP 센서를 사용하려면 프로파일 맨 아래의 Home Assistant UI에서 [Long-Lived Access Tokens](https://developers.home-assistant.io/docs/en/auth_api.html#long-lived-access-token)을 작성하십시오.

모든 [requests](/developers/rest_api/#post-apistatesltentity_id)은 장치의 엔드 포인트로 전송되어야 하며 **POST** 여야합니다.

## IP 필터링과 추방 (IP filtering and banning)

추가 IP 필터링을 적용하고 무차별 강제 시도를 자동으로 금지하려면 `ip_ban_enabled`를 `true`로 설정하고 최대 시도 횟수를 설정하십시오. 첫 번째 추방 후에 루트 설정 폴더에`ip_bans.yaml` 파일이 생성됩니다. 추방된 IP 주소와 시간이 추가 될 때 UTC로 표시됩니다.

```yaml
127.0.0.1:
  banned_at: '2016-11-16T19:20:03'
```

추방이 추가 된 후 홈 어시스턴트 프론트 엔드에 지속적 알림(Persistent Notification)이 채워집니다.

<div class='note warning'>

'trusted_networks'의 소스는 자동으로 추방당하지 않습니다.

</div>

## 파일 호스팅 (Hosting files)

Home Assistant를 사용하여 정적 파일을 호스트하거나 제공하려면 설정 경로 아래에 `www`라는 디렉토리를 작성하십시오 (Hass.io의`/ config`, 이외는 `.homeassistant`). `www /`의 정적 파일은 다음 URL`http://your.domain: 8123/local/`에서 액세스 할 수 있습니다. 예를 들어 `audio.mp3`은 `http://your.domain:8123/local/audio.mp3`로 액세스합니다. 

<div class='note'>

  `www /`폴더를 처음으로 만들어야한다면 Home Assistant를 다시 시작해야합니다.

</div>

<div class='note warning'>

  `www` /`local` 폴더에서 제공되는 파일은 Home Assistant 인증으로 보호되지 않습니다. 이 폴더에 저장된 파일은 URL을 알고있는 경우 인증없이 누구나 액세스 할 수 있습니다.

</div>

## Binary Sensor

HTTP binary sensor는 URL에 대한 첫 번째 요청으로 동적으로 생성됩니다. 먼저 설정에서 정의하지 않아도됩니다.

그러면 홈어시스턴트가 실행되는 한 센서가 존재합니다. Home Assistant를 다시 시작하면 센서가 다시 트리거 될 때까지는 센서가 사라집니다.

binary sensor의 URL은 아래 예와 같습니다. :

```bash
http://IP_ADDRESS:8123/api/states/binary_sensor.DEVICE_NAME
```

<div class='note'>
다른 장치와의 충돌을 피하려면 고유 한 장치 이름 (DEVICE_NAME)을 선택해야합니다.
</div>

JSON 페이로드에는 새로운 상태가 포함되어야하며 친숙한 이름을 가질 수 있습니다. 친숙한 이름은 프런트 엔드에서 센서 이름을 지정하는 데 사용됩니다.

```json
{"state": "on", "attributes": {"friendly_name": "Radio"}}
```

빠른 테스트를 위해`curl`은 "장치를 시뮬레이션"하는 데 유용 할 수 있습니다.

```bash
$ curl -X POST -H "Authorization: Bearer LONG_LIVED_ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"state": "off", "attributes": {"friendly_name": "Radio"}}' \
    http://localhost:8123/api/states/binary_sensor.radio
```

센서가 작동하는지 확인하려면 `curl`을 다시 사용하여 [current state](/developers/rest_api/#get-apistatesltentity_id)를 검색하십시오.

```bash
$ curl -X GET -H "Authorization: Bearer LONG_LIVED_ACCESS_TOKEN" \
       -H "Content-Type: application/json" \
       http://localhost:8123/api/states/binary_sensor.radio
{
    "attributes": {
        "friendly_name": "Radio"
    },
    "entity_id": "binary_sensor.radio",
    "last_changed": "16:45:51 05-02-2016",
    "last_updated": "16:45:51 05-02-2016",
    "state": "off"
}
```

### 사용예 (Examples)

이 섹션에서는 앞에서 보여준 `curl` 외에도 이 센서를 사용하는 방법에 대한 실제 예를 찾을 수 있습니다.

#### 파이선 요청 모듈 사용법 (Using Python request module)

[API](/developers/rest_api/) 페이지에 이미 표시된 것처럼 Python과 [Requests](https://requests.kennethreitz.org/en/latest/) 모듈을 사용하여 매우 간단하게 홈어시스턴트와 상호작용합니다. 

```python
response = requests.post(
    "http://localhost:8123/api/states/binary_sensor.radio",
    headers={
        "Authorization": "Bearer LONG_LIVED_ACCESS_TOKEN",
        "content-type": "application/json",
    },
    data=json.dumps({"state": "on", "attributes": {"friendly_name": "Radio"}}),
)
print(response.text)
```

#### `httpie` 사용하기 (Using `httpie`)

[`httpie`] (https://github.com/jkbrzt/httpie)는 사용자 친화적 인 CLI HTTP 클라이언트입니다.

```bash
$ http -v POST http://localhost:8123/api/states/binary_sensor.radio \
      'Authorization:Bearer LONG_LIVED_ACCESS_TOKEN' content-type:application/json state=off \
      attributes:='{"friendly_name": "Radio"}'
```

## 센서 (Sensor)

HTTP 센서는 URL에 대한 첫 번째 요청으로 동적으로 작성됩니다. 먼저 설정에서 정의하지 않아도 됩니다.

그러면 홈어시스턴트가 실행되는 한 센서가 존재합니다. 홈어시스턴트를 다시 시작하면 센서가 다시 트리거 될 때까지 센서가 나타나지 않습니다.

센서의 URL은 아래 예와 같습니다.

```bash
http://IP_ADDRESS:8123/api/states/sensor.DEVICE_NAME
```

<div class='note'>
다른 장치와의 충돌을 피하려면 고유 한 장치 이름 (DEVICE_NAME)을 선택해야합니다.
</div>

 JSON 페이로드에는 새로운 상태가 포함되어야하며 측정 단위와 이름이 포함되어야합니다. 친숙한 이름은 프런트 엔드에서 센서 이름을 지정하는 데 사용됩니다.

```json
{"state": "20", "attributes": {"unit_of_measurement": "°C", "friendly_name": "Bathroom Temperature"}}
```

빠른 테스트를 위해`curl`은 "장치를 시뮬레이션"하는 데 유용 할 수 있습니다.

```bash
$ curl -X POST -H "Authorization: Bearer LONG_LIVED_ACCESS_TOKEN" \
       -H "Content-Type: application/json" \
       -d '{"state": "20", "attributes": {"unit_of_measurement": "°C", "friendly_name": "Bathroom Temp"}}' \
       http://localhost:8123/api/states/sensor.bathroom_temperature
```

그런 다음`curl`을 다시 사용하여 [current sensor state](/developers/rest_api/#get-apistatesltentity_id)를 검색하고 센서가 작동하는지 확인할 수 있습니다.

```bash
$ curl -X GET -H "Authorization: Bearer LONG_LIVED_ACCESS_TOKEN" \
       -H "Content-Type: application/json" \
       http://localhost:8123/api/states/sensor.bathroom_temperature
{
    "attributes": {
        "friendly_name": "Bathroom Temp",
        "unit_of_measurement": "\u00b0C"
    },
    "entity_id": "sensor.bathroom_temperature",
    "last_changed": "09:46:17 06-02-2016",
    "last_updated": "09:48:46 06-02-2016",
    "state": "20"
}
```

더 많은 예제를 보려면 [HTTP Binary Sensor](#examples) 페이지를 방문하십시오.