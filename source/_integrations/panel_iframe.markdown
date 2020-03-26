---
title: 아이프레임 패널(iframe Panel)
description: Instructions on how to add iFrames in the frontend of Home Assistant.
logo: home-assistant.png
ha_category:
  - Front End
ha_release: 0.25
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/frontend'
---

`panel_iframe` 지원을 통해 홈어시스턴트 프론트 엔드에 패널을 추가할 수 있습니다. 패널은 사이드 바에 나열되며 라우터, 모니터링 시스템 또는 미디어 서버의 웹프런트엔드와 같은 외부 리소스를 포함할 수 있습니다.

<div class='note warning'>
SSL을 사용하여 HTTPS를 통해 Home Assistant에 액세스하는 경우 iframe 패널을 통해 HTTP 사이트에 액세스할 수 없습니다.
</div>

설치에서 패널 iFrame을 활성화하려면 `configuration.yaml`파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
panel_iframe:
  router:
    title: 'Router'
    url: 'http://192.168.1.1'
  fridge:
    title: 'Fridge'
    url: 'http://192.168.1.5'
  otherapp:
    title: 'Other App'
    url: '/otherapp'
```


{% configuration %}
panel_iframe:
  description: panel_iframe 구성 요소를 사용. 한 번만 허용.
  required: true
  type: map
  keys:
    panel_name:
      description: 패널의 이름. 한 번만 허용.
      required: true
      type: map
      keys:
        title:
          description: 패널의 친숙한 제목. 사이드 바에서 사용.
          required: true
          type: string
        url:
          description: 절대 경로 또는 절대 경로를 가진 상대 URL.
          required: true
          type: string
        icon:
          description: 아이콘 항목.
          required: false
          type: icon
        require_admin:
          description: iframe을 보려면 관리자 액세스 권한이 필요한 경우.
          required: false
          type: boolean
          default: false
{% endconfiguration %}

<div class='note warning'>

`lovelace`라는 이름의 iframe 패널을 **절대** 만들지 마십시오. lovelace라는 이름이로 덮어 쓰기 하면 절대 로드되지 않습니다.

</div>
