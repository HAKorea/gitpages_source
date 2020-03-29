---
title: 에코백스 로봇청소기(Ecovacs Vacuum)
description: Instructions on how to integrate Ecovacs vacuums within Home Assistant.
logo: ecovacs.png
ha_category:
  - Hub
  - Vacuum
ha_iot_class: Cloud Push
ha_release: 0.77
ha_codeowners:
  - '@OverloadUT'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/hAweR1-2GeY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`ecovacs` 통합구성요소는 모든 [Ecovacs](https://www.ecovacs.com) (Deebot) vacuum(로봇청소기)을 연동하는 주요 통합구성요소입니다. 계정에서 vacuum을 감지하고 제어하려면 Ecovacs 계정 정보 (사용자 이름, 비밀번호)가 필요합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Vacuum](#vacuum)

## 설정

Ecovacs 장치를 Home Assistant 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
ecovacs:
  username: YOUR_ECOVACS_USERNAME
  password: YOUR_ECOVACS_PASSWORD
  country: YOUR_TWO_LETTER_COUNTRY_CODE
  continent: YOUR_TWO_LETTER_CONTINENT_CODE
```

{% configuration %}
username:
  description: Ecovacs 계정에 로그인하기위한 사용자 이름.
  required: true
  type: string
password:
  description: Ecovacs 계정에 로그인하기위한 비밀번호
  required: true
  type: string
country:
  description: 2 자리 국가 코드 (미국, 영국 등)
  required: true
  type: string
continent:
  description: 2 글자 대륙 코드 (na, eu 등)
  required: true
  type: string
{% endconfiguration %}

참고: 일부 국가의 경우 `continent`을 `ww` (전세계 의미)로 설정해야합니다. 불행히도 추측 및 확인 이외의 올바른 설정을 알 수있는 방법은 없습니다. Ecovacs 서버에 대해 파악된 내용에 대한 자세한 내용은 [sucks library protocol documentation](https://github.com/wpietri/sucks/blob/master/protocol.md)를 참조하십시오.

### 안정성 및 알려진 버그

Ecovacs 서버와 통신하는 라이브러리는 매우 초기 상태이며 아직 개발 중입니다. 따라서 현재 일부 지역 및 장치가 작동하지 않을 수 있습니다.

테스트 대상에 대한 자세한 내용은 [sucks library documentation](https://github.com/wpietri/sucks)을 참조하십시오. GitHub 문제를 확인하여 현재 발생하고있는 문제가 알려지거나 진행 중인지 확인하십시오.

Ecovacs 구성 요소에 문제가있는 경우 [GitHub 문제] (https://github.com/home-assistant/home-assistant/issues)를 제출하고 홈어시스턴트 로그를 보고서에 포함하십시오. Ecovacs 연동 및 기본 `sucks` 라이브러리에서 전체 디버그 출력을 얻으려면 `configuration.yaml` 파일에 배치하십시오.

```yaml
logger:
  logs:
    homeassistant.components.ecovacs: debug
    homeassistant.components.vacuum.ecovacs: debug
    sucks: debug
```

경고: 이렇게하면 인증 토큰이 로그 파일에 표시됩니다. 문제를 게시하기 전에 로그에서 토큰 및 기타 인증 세부 정보를 제거하십시오.

## Vacuum

`ecovacs` vacuum 플랫폼을 사용하면 Ecovacs Deebot vacuum을 모니터링하고 제어할 수 있습니다.

### Component 수명

Deebot vacuum에서 구성 요소의 남은 수명은 vacuum 엔티티의 속성으로 보고됩니다. 값은 남은 수명의 백분율을 나타내는 정수입니다.

다음은 [template sensor](/integrations/template)를 사용하여 필터 수명을 자체 센서로 추출하는 방법의 예입니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: template
    sensors:
      vacuum_filter:
        friendly_name: "Vacuum Filter Remaining Lifespan"
        unit_of_measurement: '%'
        value_template: "{{ state_attr('vacuum.my_vacuum_id', 'component_filter') }}"
```
{% endraw %}

또는 필터를 교체해야 할 때 `On`이 되는 간단한 이진 센서를 원할 경우 (5 % 이하) : 

{% raw %}
```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: template
    sensors:
      vacuum_filter_replace:
        friendly_name: "Vacuum Filter"
        device_class: problem
        value_template: "{{ state_attr('vacuum.my_vacuum_id', 'component_filter') <= 5 }}"
```
{% endraw %}

### 오류 처리

vacuum 엔티티는 vacuum에서 온 _most recent_ 오류 메시지를 포함하는 `error` 속성을 가집니다. 모든 오류 메시지의 전체 목록이 없으므로 vacuum이 보낼 수 있는 오류 메시지를 확인하기 위해 몇 가지 실험을 수행해야 할 수도 있습니다. 

vacuum이 "no error" 이벤트를 발생 시키면 `error` 속성이 다시 `None`으로 변경됩니다. 그러나 모든 유형의 오류에 대해서는 이 문제가 발생하지 않습니다.

또는 `ecovacs_error` 이벤트를 사용하여 오류를 감시할 수 있습니다. 이 이벤트에는 다음과 같은 데이터 페이로드가 포함됩니다.

```json
{
  "entity_id": "vacuum.deebot_m80",
  "error": "an_error_name"
}
```

마지막으로, vacuum이 쓸 수 없는 상태가 되면(일반적으로 충전기가 완전히 꺼질 수 있을 정도로 충전기가 유휴 상태가 되어 오랫동안 꺼진 경우) vacuum의 상태인 `status` 속성은 다시 켜질 때까지 `offline`으로 변경됩니다.