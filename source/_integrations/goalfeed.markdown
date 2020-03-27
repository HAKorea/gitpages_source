---
title: 득점알림(Goalfeed)
description: Instructions on how to setup Goalfeed events within Home Assistant.
logo: goalfeed.png
ha_category:
  - Other
ha_release: 0.63
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/lp-hJwIQoKg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`goalfeed` 통합구성요소를 통해 Goalfeed 계정을 사용하여 NHL 또는 MLB 팀이 득점할 때마다 홈어시스턴트에서 이벤트를 트리거할 수 있습니다.

최근에는 영국 프리미어 리그도 베타로 지원하고 있습니다. 응원하는 팀을 등록해서 사용하실 수 있습니다. 
손흥민같은 우리나라 선수의 골도 따로 자동화하면 더 재밌겠네요 :)

[직접 등록하러가기](https://goalfeed.ca/home-assistant)

이 구성 요소를 사용하려면 `configuration.yaml` 파일에 goalfeed.ca 계정의 이메일 주소와 비밀번호를 입력하십시오.

```yaml
# Example configuration.yaml entry
goalfeed:
  username: YOUR_E_MAIL_ADDRESS
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  required: true
  description: goalfeed.ca 계정의 이메일 주소
  type: string
password:
  required: true
  description: goalfeed.ca 계정의 비밀번호.
  type: string
{% endconfiguration %}

이제 자동화에서 골 이벤트 유형을 사용할 수 있습니다.

```yaml
- alias: 'Jets Goal'
  trigger:
    platform: event
    event_type: goal
    event_data:
      team_name: "Winnipeg Jets"
```

목표 이벤트에는 다음과 같은 이벤트 데이터가 있습니다. :

- **team**: 팀을 나타내는 세 글자 코드. 이는 리그 내에서 고유하지만 리그 전체에서 고유하지는 않습니다 (예: 'WPG' 또는 'TOR').
- **team_name**: 득점 한 팀 (예: 'Winnipeg Jets' 또는 'Toronto Blue Jays').
- **team_hash**: 팀을 위한 고유한 해시 (이 값은 https://goalfeed.ca/get-teams 에서 찾을 수 있습니다.).
- **league_id**: 리그의 고유 번호입니다.
- **league_name**: 리그의 짧은 이름 (예: 'NHL', 'MLB').
