---
title: "기본 정보 설정"
description: "Setting up the basic info of Home Assistant."
redirect_from: /getting-started/basic/
---

기본적으로 처음시작할 때의 일부 기능으로, Home Assistant는 IP 주소 지리적 위치에서 사용자의 위치를 ​​감지 할 수 있습니다. 홈 어시스턴트는이 위치를 기준으로 온도 단위 및 시간대를 자동으로 선택합니다. 처음 시작할 때 또는 나중에 일반에서 설정에 들어가면 조정할 수 있습니다. 

YAML을 선호하는 경우  `configuration.yaml` 파일에 다음 정보를 추가 할 수 있습니다  :

```yaml
homeassistant:
  latitude: 32.87336
  longitude: 117.22743
  elevation: 430
  unit_system: metric
  time_zone: America/Los_Angeles
  name: Home
  whitelist_external_dirs:
    - /usr/var/dumping-ground
    - /tmp
```

{% configuration %}
latitude:
  description: 해가 뜨고지는 시간을 계산하는 데 필요한 위치의 위도.
  required: false
  type: float
longitude:
  description: 해가 뜨고지는 시간을 계산하는 데 필요한 위치의 경도.
  required: false
  type: float
elevation:
  description: 해발 고도 (미터) 날씨 / 일출 데이터에 영향을 줍니다.
  required: false
  type: integer
unit_system:
  description: "`metric` 미터법, `imperial` 영국식."
  required: false
  type: string
time_zone:
  description: "컬럼에서 당신의 **TZ**을 [Wikipedia's list of tz database time zones](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones) 중에서 선택"
  required: false
  type: string
name:
  description: 홈어시스턴트가 실행중인 위치의 이름입니다.
  required: false
  type: string
customize:
  description: "[Customize](/docs/configuration/customizing-devices/) entity들."
  required: false
  type: string
customize_domain:
  description: "[Customize](/docs/configuration/customizing-devices/) domain에 모든 entity."
  required: false
  type: string
customize_glob:
  description: "[Customize](/docs/configuration/customizing-devices/) 패턴이 매칭되는 모든 entities."
  required: false
  type: string
whitelist_external_dirs:
  description: 파일을 보내기 위한 소스로 사용할 수 있는 폴더 목록
  required: false
  type: list
{% endconfiguration %}

### Core Service 재로드

홈어시스턴트는 `homeassistant.reload_core_config` 서비스가 실행되는 동안 핵심 설정을 다시로드하는 서비스를 제공합니다. 이를 통해 위의 섹션을 변경하고 홈어시스턴트를 다시 시작할 필요없이 적용되는 것을 확인할 수 있습니다. 이 서비스를 호출하려면 개발자 도구 아래의 "서비스"탭으로 이동하여 `homeassistant.reload_core_config` 서비스를 선택 하고 "서비스 요청"버튼을 클릭하십시오. 또는 구성 > 서버 제어에서 "위치 및 사용자 정의 다시로드" 버튼을 누를 수 있습니다.