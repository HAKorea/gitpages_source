---
title: 이퓨(eufy)
description: Instructions on how to integrate Eufy devices into Home Assistant.
logo: eufy.png
ha_category:
  - Hub
  - Light
  - Switch
ha_release: 0.68
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/NYalEpeqJTk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

우리나라는 **eufy 로봇청소기**만 와디즈에서 펀딩을 받아 판매했습니다. 
해당 로봇청소기를 홈어시스턴트에 연동하려면, [여기](https://github.com/mitchellrj/eufy_robovac)를 참조해서 커스텀 컴포넌트를 설치하십시오. 

`eufy` 통합구성요소는 다양한 [eufy](https://www.eufylife.com/) 장치를 Home Assistant와 연동하기위한 메인 통합구성요소입니다.

현재 홈어시스턴트에는 다음 장치 유형이 지원됩니다.

- Light
- Switch

`eufy` 통합구성요소가 설정된 후 지원되는 장치가 발견됩니다.

```yaml
# Example configuration.yaml entry
eufy:
  username: EMAIL_ADDRESS
  password: PASSWORD
```

여기서 username 및 password는 EufyHome 앱에서 설정한 것입니다. 또는 검색할 수 없는 Eufy 장치를 정적으로 설정할 수 있습니다.

```yaml
eufy:
  devices:
    - address: 192.168.1.10
      access_token: 1234567890abcdef
      type: T1012
      name: Smart Light
    - address: 192.168.1.11
      access_token: abcdef1234567890
      type: T1201
      name: Smart Switch
```

`access_token`은 다음을 실행하여 얻을 수 있습니다 : 

```bash
$ curl -H "Content-Type: application/json" \
   -d '{"client_id":"eufyhome-app", "client_Secret":"GQCpr9dSp3uQpsOMgJ4xQ", "email":"USERNAME", "password":"PASSWORD"}' \
   https://home-api.eufylife.com/v1/user/email/login
```

USERNAME 및 PASSWORD를 Eufy 사용자 이름 및 비밀번호로 바꿉니다. 이는 `access_token`을 줄 것입니다. 그런 후 다음을 실행하십시오.

```bash
$ curl -H token:TOKEN -H category:Home \
   https://home-api.eufylife.com/v1/device/list/devices-and-groups
```

이전 명령에서 TOKEN을 `access_token`으로 바꿉니다. 이는 각 장치에 대한 local_code를 제공합니다.