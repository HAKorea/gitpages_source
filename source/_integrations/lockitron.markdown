---
title: 탈착형도어락(Lockitron)
description: Instructions on how to integrate Lockitron locks into Home Assistant.
logo: lockitron.png
ha_category:
  - Lock
ha_iot_class: Cloud Polling
ha_release: 0.42
---

`lockitron` 플랫폼을 사용하면 Home Assistant 내에서 [Lockitron](https://lockitron.com/) lock을 제어할 수 있습니다.

<iframe width="650" height="437" src="https://www.youtube.com/embed/AWo1YjBF1Z8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## 셋업

올바른 `access_token` 및 `id`를 얻으려면 [developer page](https://api.lockitron.com/)에 로그온하여 새 앱을 작성한 후 그들이 제공 한 access_token을 받으십시오. 그런 다음 페이지에서 모든 lock 검색 기능을 호출하고 lock ID를 가져 오십시오 (lock ID가 생성되고 가상 lock이 아닌 lock ID를 가져 오십시오).

## 설정

lock을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
lock:
  - platform: lockitron
    access_token: YOUR_ACCESS_TOKEN
    id: YOUR_ID
```

{% configuration %}
access_token:
  description: The security token provided by Lockitron to lock and unlock your lock.
  required: true
  type: string
id:
  description: The lock id given by Lockitron (should be a GUID).
  required: true
  type: string
{% endconfiguration %}
