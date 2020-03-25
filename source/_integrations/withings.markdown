---
title: 헬스케어전문기기(Withings)
description: Instructions on how to integrate Withings health products within Home Assistant.
logo: withings.png
ha_category:
  - Health
  - Sensor
ha_release: 0.99
ha_iot_class: Cloud Polling
ha_config_flow: true
ha_codeowners:
  - '@vangorra'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/e5Cem5oahho" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`withings` 센서 플랫폼은 [Withings](https://www.withings.com)에서 생산된 다양한 헬스케어 제품의 데이터를 가져옵니다.

## 셋업

### 1 단계 - WITHINGS 계정 만들기

데이터를 배포하려면 개발자 계정이 있어야합니다. [Create a free development account](https://account.withings.com/partner/add_oauth2).

계정을 위한 제출자료 : 

- Logo: 적당한 그림이면 충분합니다.
- Description: 데이터를 수집하기 위한 개인앱.
- Contact Email: 이메일 주소
- Callback Uri: `https://your-domain-name/auth/external/callback`- Withings는 양식을 제출할 때, 이 URL에 액세스 할 수 있는지 확인합니다 (HTTP HEAD).
- Company: Home Assistant

저장되면 "Client Id" 및 "Consumer Secret" 필드가 채워집니다. 다음 단계에서 이것들이 필요합니다.

### 2 단계 - 홈어시스턴트 설정

```yaml
# Example configuration.yaml entry
withings:
  client_id: CLIENT_ID
  client_secret: CONSUMER_SECRET
  profiles:
    - USER_PROFILE_NAME
```

Withings는 계정당 여러 프로필을 지원합니다. 각 프로필에는 보고있는 데이터를 쉽게 구별할 수 있도록 개인의 이름이 있습니다. 여기에 제공된 프로파일은 임의적일 수 있지만 Withings 프로파일과 동일한 이름을 사용하는 것이 좋습니다. 이렇게하면 데이터를 보다 쉽게 ​​구별할 수 있습니다.

### 3 단계 - 홈어시스턴트 권한 부여

- `Check Config ` 도구를 사용하여 YAML 설정이 유효한지 확인하십시오 (note 참조).
  - Note: "Check Config"가 표시되도록 하려면 사용자 프로필에서 "Advanced Mode"를 활성화해야합니다. 사이드바(cog 아이콘)에서 "설정"을 클릭한 다음 "Server Control"를 클릭하여 "Check Config" 도구를 찾을 수 있습니다.
- 홈어시스턴트를 재시작하십시오.
- 통합구성요소 페이지로 이동하십시오.
- Withings 통합구성요소를 추가하십시오. withings 사이트에 새 탭/창이 열립니다.
- Withings 사이트에서 동기화하려는 데이터의 프로필을 선택하십시오.
- 응용 프로그램을 승인하십시오. 브라우저는 계정 설정 중에 제공한 리디렉션 경로로 리디렉션합니다.
  - Note: 사이트에 액세스할 수 없다는 브라우저 오류가 발생하면 URL의 `http://domain` 부분을 로컬 또는 공개적으로 액세스할 수 있도록 수정할 수 있습니다. 예를 들어,`http://localhost:8123`
  이는 홈어시스턴트가 Withings에 제공한 기본 URL에 외부 세계가 액세스할 수 없는 경우 발생합니다.
  도메인을 변경해도 데이터 동기화 방법에는 영향을 미치지 않습니다.
- 인증되면 탭/창이 닫히고 통합구성요소 페이지에 프로파일을 선택하라는 메시지가 표시됩니다. withings 사이트에서 선택한 프로필을 선택하십시오.
  - Note: 이전 단계에서 동일한 프로필을 선택하는 것이 중요합니다. 다른 것을 선택하면 홈어시스턴트가 잘못된 데이터를 표시합니다.
- 데이터는 즉시 동기화되고 5 분마다 업데이트됩니다.

## 설정

```yaml
# Example configuration.yaml entry
withings:
    client_id: CLIENT_ID
    client_secret: CONSUMER_SECRET
    profiles:
        - USER_PROFILE_NAME
```
{% configuration %}
client_id:
  description: OAuth client ID (https://account.withings.com/partner/add_oauth2 에서 가져옴)
  required: true
  type: string
client_secret:
  description: OAuth secret (https://account.withings.com/partner/add_oauth2 에서 가져옴)
  required: true
  type: string
profiles:
  description: Withings는 계정당 여러 프로필을 지원합니다. 홈어시스턴트 엔티티와 연관시킬 사람의 이름을 제공하십시오 (이름만 있으면 됩니다, 완벽할 필요는 없습니다). 인증 단계 동안 Withings 웹 사이트에서 이 사용자를 선택하라는 메시지가 표시됩니다
  required: true
  type: map
{% endconfiguration %}
