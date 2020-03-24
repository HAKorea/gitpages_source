---
title: 프로젝트링크(PJLink)
description: Instructions on how to integrate PJLink enabled projectors into Home Assistant.
logo: pjlink.png
ha_category:
  - Media Player
ha_release: 0.76
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/uQfbgsuY7RY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`pjlink` 플랫폼을 사용하면 [PJLink protocol](https://pjlink.jbmia.or.jp/english/index.html)을 지원하는 프로젝터 인 Home Assistant에서 제어 할 수 있습니다.

## 설정

PJLink 프로젝터를 설치에 추가하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: pjlink
    host: 192.168.1.2
```

{% configuration %}
host:
  description: "장치의 IP 주소 또는 호스트 이름. 예 : 192.168.1.2."
  required: true
  type: string
port:
  description: 장치에서 PJLink 서비스가 실행되는 포트.
  required: false
  type: integer
  default: 4352
name:
  description: 장치 이름
  required: false
  type: string
  default: name of the device as returned by PJLink.
encoding:
  description: 장치와 통신하는데 사용되는 문자 인코딩
  required: false
  type: string
  default: utf-8
password:
  description: 프로젝터 인증을위한 비밀번호
  required: false
  type: string
{% endconfiguration %}
