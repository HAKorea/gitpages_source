---
title: AI스피커(Mycroft)
description: Instructions on how to setup Mycroft AI within Home Assistant.
logo: mycroft.png
ha_category:
  - Voice
  - Notifications
ha_release: 0.53
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/inkBNhzOGTU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Mycroft](https://mycroft.ai)는 Home Assistant에서 Mycroft로 알림 등을 보낼 수있는 오픈 소스 음성 도우미입니다.

현재 홈 어시스턴트에는 다음 장치 유형이 지원됩니다.

- **Notifications** - 홈어시스턴트에서 [Mycroft AI](https://mycroft.ai/)로 알림을 전달할 수 있습니다.


## 설정

설치에서 Mycroft를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
mycroft:
  host: 0.0.0.0
```

{% configuration %}
host:
  description: Mycroft 인스턴스의 IP 주소.
  required: true
  type: string
{% endconfiguration %}
