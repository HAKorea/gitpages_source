---
title: 로지 써클(Logi Circle)
description: Instructions on how to integrate your Logi Circle cameras within Home Assistant.
logo: logi_circle.png
ha_category:
  - Camera
  - Sensor
ha_release: 0.79
ha_iot_class: Cloud Polling
ha_config_flow: true
ha_codeowners:
  - '@evanjd'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/gLuCCAnr34A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`logi_circle` 구현을 통해 [Logi Circle](https://circle.logi.com/) 카메라를 Home Assistant에 연동할 수 있습니다. Logi Circle을 연결하려면 [sign up for API access](#requesting-api-access)하고 `client_id`, `client_secret`, `api_key`를 가져와야합니다.

## API 액세스 요청 

1. Navigate to the [Circle OAuth2 Client Request Form](https://docs.google.com/forms/d/184FUILJ10rVxotyOQR5DAiu6GcCbK31AZszUdzT1ybs).
2. Fill out your contact name and e-mail address.
3. For the User Visible Client Name, specify "Home Assistant"
3. Request the following scopes:
    * `circle:activities`
    * `circle:accessories`
    * `circle:live_image`
    * `circle:live`
    * `circle:notifications`
    * `circle:summaries`
4. Request the `authorization_code` grant type.
5. For the redirect URI, specify your Home Assistant URL followed by `/api/logi_circle`. For example, if your Home Assistant URL is `https://abc123.ui.nabu.casa`, then request `https://abc123.ui.nabu.casa/api/logi_circle`. The redirect URI must meet the following criteria:
 * The URL must be HTTPS with a SSL certificate issued by a trusted CA (i.e., trusted by normal browsers).
 * At the time you submit your request to Logitech, you need to demonstrate that you have exclusive control of the fully qualified domain name in your redirect URI. An active Home Assistant instance at the redirect URI will suffice. If you don't want to expose your Home Assistant instance publicly, you may also place a static page at the redirect URI with a short message that you will manage redirection of the authorization token to your local Home Assistant instance. Free static hosts that issue subdomains for hosting (e.g., Netlify) are permitted.
 * As the redirect URI must be public facing, no local/reserved TLDs are permitted (eg. .local, .localhost, .example, etc. are not allowed).

Please note that the turn-around time for API access takes a few business days after which you will be contacted by Logitech using the email address you provided in the form.

## 설정

[Logi Circle](https://circle.logi.com/) 계정에 연결된 카메라를 연동하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
logi_circle:
  client_id: YOUR_CLIENT_ID
  client_secret: YOUR_CLIENT_SECRET
  api_key: YOUR_API_KEY
  redirect_uri: YOUR_REDIRECT_URI
```

{% configuration %}
client_id:
  description: Logitech이 발행한 클라이언트 ID
  required: true
  type: string
client_secret:
  description: Logitech이 고객에게 발급한 클라이언트 암호.
  required: true
  type: string
api_key:
  description: Logitech이 발행 한 API 키.
  required: true
  type: string
redirect_uri:
  description: > 
    Home Assistant 인스턴스에 해당하는 리디렉션 URI입니다. Logitech에서 API 액세스를 요청할 때 지정된 경로 재 지정 URI 중 하나와 일치해야합니다.
  required: true
  type: string
{% endconfiguration %}

### 카메라

`logi_circle` 카메라 플랫폼을 사용하면 Home Assistant의 [Logi Circle](https://circle.logi.com/) 카메라 라이브 스트림에서 스틸 프레임을 볼 수 있습니다.

Logi Circle 카메라는 `camera.turn_on` 및 `camera.turn_off` 서비스를 지원합니다. 이에 따라 카메라의 스트리밍 모드 속성이 설정되어 라이브 스트림을 사용할 수 있는지 여부와 활동 기록이 캡처되는지 여부를 제어합니다.

### 센서

`logi_circle` 센서 플랫폼을 사용하면 Home Assistant의 [Logi Circle](https://circle.logi.com) 카메라에 연결된 센서를 모니터링 할 수 있습니다.

설정할 센서를 사용자 정의하려면 다음 세팅으로 `configuration.yaml` 파일에서 Logi Circle 연동 설정으로 확장 할 수 있습니다.

```yaml
# Example configuration.yaml entry
logi_circle:
  sensors:
    monitored_conditions:
      - battery_level
      - last_activity_time
      - recording
      - signal_strength_category
      - signal_strength_percentage
      - streaming
```

기본적으로 Logi Circle 장치에서 사용 가능한 모든 센서가 모니터링됩니다. Logi Circle 구성 요소에 대한 모든 센서를 비활성화하려면 `monitored_conditions`를 비워 두십시오. 내장 배터리가 없는 장치는 배터리 레벨 센서를 노출시키지 않습니다.

{% configuration %}
sensor:
  description: Configuration to pass to all sensors.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: The conditions to create sensors from.
      required: false
      type: list
      default: all
      keys:
        battery_level:
          description: Returns the battery level percentage from the camera.
        last_activity_time:
          description: Return the timestamp from the last time the Logi Circle camera detected any activity.
        recording:
          description: The camera's recording mode. If false, the camera will not capture activities.
        signal_strength_category:
          description: Return the WiFi signal level from the camera.
        signal_strength_percentage:
          description: Return the WiFi signal percentage from the camera.
        streaming:
          description: The soft on/off status of the camera.
{% endconfiguration %}

## 서비스

`logi_circle` 플랫폼은 Logi Circle 장치와 상호 작용하기 위한 3 가지 서비스를 제공합니다. 하나 이상의 엔티티 ID로 서비스를 호출할 때는 카메라 엔티티를 대상으로 해야합니다 (예 :`camera.living_room_camera`).

### `logi_circle.livestream_record` 서비스

카메라의 라이브 스트림 녹화를 시작합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      yes | Name(s) of entities to initiate a recording for, e.g., `camera.living_room_camera`. If blank, targets all Logi Circle cameras. |
| `filename `            |      no  | Template of a file name. Variable is `entity_id`, e.g., {% raw %}`/tmp/recording_{{ entity_id }}.mp4`{% endraw %}. |
| `duration`             |      no  | Duration of recording, in seconds.

`filename`의 경로 부분은 `configuration.yaml` 파일의 [`homeassistant:`](/docs/configuration/basic/) 섹션에 있는 `whitelist_external_dirs`의 항목이어야합니다.

### `logi_circle.livestream_snapshot` 서비스

카메라의 라이브 스트림에서 스냅샷을 찍습니다. 이는 Logi Circle의 API에서 새로운 이미지를 명시적으로 요청한다는 점에서 일반적인 [snapshot](/integrations/camera/#service-snapshot) 서비스와 다릅니다. 이렇게하면 수면 상태의 카메라가 강제로 깨어납니다.

캐시된 스냅샷이 30초보다 오래된 경우에만 새 스냅샷이 생성됩니다. 연속해서 여러 스냅샷을 요청하면 동일한 이미지가 반환 될 수 있습니다. 마찬가지로, 적극적으로 스트리밍 중인 카메라에서 스냅샷을 요청하면 (즉, 최대 절전 상태가 아닌) 30초 이전의 캐시 된 이미지를 반환합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      yes | Name(s) of entities to create a live stream snapshot from, e.g., `camera.living_room_camera`. If blank, targets all Logi Circle cameras. |
| `filename`             |      no  | Template of a file name. Variable is `entity_id`, e.g., {% raw %}`/tmp/snapshot_{{ entity_id }}.jpg`{% endraw %}. |

`filename`의 경로 부분은 `configuration.yaml` 파일의 [`homeassistant:`](/docs/configuration/basic/) 섹션에 있는 `whitelist_external_dirs`의 항목이어야합니다.

### `logi_circle.set_config` 서비스

카메라의 설정 속성을 세팅합니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |      yes | Name(s) of entities to set the operation mode for, e.g., `camera.living_room_camera`. If blank, targets all Logi Circle cameras. |
| `mode`                 |      no  | Configuration property to set. Allowed values: `LED`, `RECORDING_MODE` |
| `value`                |      no  | Mode value. Allowed values: `true`, `false` |
