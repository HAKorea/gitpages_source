---
title: "React를 이용한 사용자 정의 패널"
description: ""
ha_category: User Interface
---

이는 [TodoMVC](http://todomvc.com/)의 [React](https://facebook.github.io/react/) 구현이지만 항목을 확인하는 대신 조명과 스위치를 켜거나 끕니다. (아래 영상참조)

- React를 사용하여 데이터를 렌더링합니다.
- Home Assistant JS에 연결되어 서버에서 푸시된 업데이트가 즉시 렌더링됩니다.
- Polymer에서 제공하는 속성에 액세스합니다.
- 렌더링을 하기위해 `configuration.yaml` 파일에 연동할 사용자 설정을 사용합니다.
- 사이드바를 토글할 수 있습니다.

[React Starter Kit 소스 다운로드](https://github.com/home-assistant/custom-panel-starter-kit-react). 파일을 `<config dir>/panels/`에 복사하십시오 (없는 경우 디렉토리를 만들어야 할 수도 있습니다).

`configuration.yaml` 파일에서 패널에 대한 항목을 생성하여 활성화하십시오.

```yaml
panel_custom:
  - name: react
    sidebar_title: TodoMVC
    sidebar_icon: mdi:work
    url_path: todomvc
    config:
      title: hello
```

이 비디오는 실제 사례를 보여줍니다.

<div class='videoWrapper'>
<iframe width="560" height="315" src="https://www.youtube.com/embed/2200UutdXlo" frameborder="0" allowfullscreen></iframe>
</div>

