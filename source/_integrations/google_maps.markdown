---
title: Google Maps
description: Instructions how to use Google Maps Location Sharing to track devices in Home Assistant.
logo: google_maps.png
ha_release: 0.67
ha_category:
  - Presence Detection
ha_iot_class: Cloud Polling
---

이 `google_maps` 플랫폼을 사용하면 비공식 [Google Maps Location Sharing](https://myaccount.google.com/locationsharing) 를 사용하여 현재 상태를 감지 할 수 있습니다 .

## 셋업 (Setup)

먼저 추가 Google 계정을 만들고 위치를 해당 계정과 공유해야합니다. 이 통합구성요소는 해당 계정을 사용하여 장치의 위치를 ​​가져옵니다.

1. 휴대 전화에서 Google지도 앱을 통해 공유를 설정해야합니다. 내용은 [here](https://support.google.com/accounts?p=location_sharing) 를 참조 하십시오
2. 올바르게 인증 한 후 해당 계정의 쿠키를 사용해야합니다. 이 쿠키는 Firefox("접두사 HttpOnly 쿠키"가 선택 해제되어 있는지 꼭 확인) 용 [Export cookies](https://addons.mozilla.org/en-US/firefox/addon/export-cookies-txt/?src=search) 또는 Chrome / Chromium 용 [cookies.txt](https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg?hl=en-US)로 검색할 수 있습니다.
3. 쿠키 파일을 다음 이름으로 Home Assistant 설정 디렉토리에 저장하십시오. : 새 Google 계정의 간략 사용자 이름이 포함된 `.google_maps_location_sharing.cookies.` `.com` TLD (예 : maps.google.com)를 사용해야합니다. 그렇지 않으면 쿠키에서 유효한 세션을 제공할 수 없습니다.
   - 예를 들면: 이메일 주소가 `location.tracker@gmail.com`이면 파일이름은 : `.google_maps_location_sharing.cookies.location_tracker_gmail_com`.

## 설정

홈어시스턴트에서 Google지도 위치 공유를 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: google_maps
    username: YOUR_USERNAME
```

이 통합구성요소를 통해 검색된 장치를 활성화하고 재부팅 한 후에는 설정 디렉토리의 `known_devices.yaml` 파일에 리스트로 들어갑니다.

이 리스트들은 `google_maps_ <numeric_id>`와 같은 식별자로 만들어집니다. 엔티티를 올바르게 추적하려면 `track` 속성을 `true`로 설정해야합니다.

{% configuration %}
username:
  description: 공유 위치에 액세스 할 수있는 Google 계정의 이메일 주소입니다.
  required: true
  type: string
max_gps_accuracy:
   description: 때때로 Google지도는 매우 낮은 정확도 (몇 킬로미터)로 GPS 위치를보고 할 수 있습니다. 이는 잘못된 구역 보고를 유발할 수 있습니다. 이 매개 변수를 사용하면 이러한 잘못된 GPS 보고서를 필터링 할 수 있습니다. 숫자는 미터 단위 여야합니다. 예를 들어 200을 입력하면 200 미만의 정확도를 가진 GPS 보고서 만 고려됩니다. - 지정하지 않으면 기본값은 100km입니다.
   required: false
   type: float
scan_interval:
  description: 위치 업데이트를 확인하는 빈도 (초).
  required: false
  default: 60
  type: integer
{% endconfiguration %}

<div class='note'>
0.97 릴리스부터는 더 이상 설정에 Google 비밀번호가 필요하지 않습니다. 이전 릴리스의 사용자는 설정 파일에서 비밀번호 항목 만 제거하고 (사용자 이름은 여전히 ​​필요함) 홈어시스턴트를 다시 시작해야합니다. 이전에 생성 된 쿠키 파일은 여전히 ​​유효해야 하며 쿠키가 유효하지 않을 때까지 추적기(tracker)가 정상적으로 작동 할 수 있습니다.
</div>
