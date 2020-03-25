---
title: 샤오미 카메라
description: Instructions on how to integrate a video feed (via FFmpeg) as a camera within Home Assistant.
logo: xiaomi.png
ha_category:
  - Camera
ha_release: 0.72
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/OqUI1GHc4As" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Xiaomi` 카메라 플랫폼은 홈어시스턴트에서 샤오미 카메라를 활용할 수 있습니다

이 플랫폼을 성공적으로 구현하려면 Home Assistant 호스트가 여러개 카메라를 동시에 읽을 수 있어야합니다. 동시에 접속한 홈어시스턴트 사용자마다 10 초간격으로 카메라에 연결됩니다. 이는 일반적으로 문제가 되진 않습니다. 

## 장치 준비

카메라를 홈어시스턴트와 연동하려면 장치에 사용자 정의 펌웨어를 설치해야합니다. 각 모델에 대한 지침을 찾을 수 있습니다.

* [Yi 720p](https://github.com/fritz-smh/yi-hack)
* [Yi Home 17CN / 27US / 47US / 1080p Home / Dome / 1080p Dome](https://github.com/shadow-1/yi-hack-v3)
* [Xiaofang 1080p Camera](https://github.com/samtap/fang-hacks)

일단 설치되면 FTP를 활성화했는지 확인하십시오.

<div class='note warning'>

현재 사용자 지정 펌웨어 버전 0.1.4-beta2가 가장 많이 지원됩니다. 이 버전보다 높은 펌웨어는 [Pure-FTPd](https://www.pureftpd.org/project/pure-ftpd)를 사용하는데, 이는 FFmpeg가 비디오 파일을 올바르게 렌더링하지 못하게하는 버그가 있습니다.

</div>

<div class='note warning'>

Raspbian 사용자 : 플랫폼에 `ffmpeg` 지원을 설치하는 것을 잊지 마십시오. 그렇지 않으면 비디오가 나오지 않습니다.

</div>

<div class='note warning'>
Yi 720p 및 Xiaofang Cameras에서 FTP를 통해 읽은 경우 카메라에서 실시간 스트림 쓰기가 지원되는 형식이 아니므로 이 플랫폼은 1 분 전에 저장된 비디오를 검색합니다.
</div>

<div class='note warning'>
RTSP 서버를 활성화한 경우 다른 Home Assistant 카메라 플랫폼을 통해 카메라에 연결할 수 있습니다. 그러나 이 RTSP 서버는 가장 유용한 Mi Home 앱을 사용하는 기능을 비활성화합니다. 홈어시스턴트 호환성과 기본앱을 모두 유지하기 위해 이 플랫폼은 FTP를 통해 비디오를 검색합니다.
</div>

## 플랫폼 설정 

플랫폼을 사용 가능하게하려면 `configuration.yaml` 파일에 다음 행을 추가 하십시오.

```yaml
camera:
  - platform: xiaomi
    name: Camera
    host: '192.168.1.100'
    model: 'yi'
    password: YOUR_PASSWORD
```

{% configuration %}
name:
  description: 친숙한 카메라 이름
  required: true
  type: string
host:
  description: 카메라의 IP 주소 또는 호스트 이름
  required: true
  type: template
model:
  description: 현재 yifang과 xiaofang을 지원하는 Xiaomi Camera의 모델
  required: true
  type: string
password:
  description: 현재 펌웨어에서 ftp 비밀번호를 설정할 수 없으므로 카메라의 FTP 서버 비밀번호(위에서)는 임의의 문자열이 될 수 있습니다.
  required: true
  type: string
path:
  description: raw MP4 파일의 경로
  required: false
  type: string
  default: /media/mmcblk0p1/record
username:
  description: FTP 서버에 액세스할 수 있는 사용자
  required: false
  type: string
  default: root
ffmpeg_arguments:
  description: "`ffmpeg`에 전달할 추가 옵션"
  required: false
  type: string
{% endconfiguration %}

<div class='note'>

`path :`의 기본값은 모든 카메라에서 작동하지 않습니다. 장치의 정확한 경로와 함께 해당 키를 추가해야 할 수도 있습니다.

</div>

## 화질 

[`ffmpeg` camera](/integrations/camera.ffmpeg/)가 지원하는 모든 옵션은 `ffmpeg_arguments` 설정 매개 변수를 통해 활용할 수 있습니다.

특히 유용한 조정 중 하나는 비디오 크기를 변경하는 기능입니다. Yi 비디오는 상당히 크기 때문에 (특히 1080p 카메라에서) 다음 설정을 통해 관리 가능한 크기로 줄일 수 있습니다.

```yaml
camera:
  - platform: xiaomi
    name: My Camera
    host: '192.168.1.100'
    model: 'xiaofang'
    password: YOUR_PASSWORD
    path: /home/camera/feed
    ffmpeg_arguments: '-vf scale=800:450'
```
## 호스트 이름 템플릿

호스트 이름/IP 주소는 값 또는 기존 엔티티 속성에서 제공될 수 있습니다.

```yaml
camera:
  - platform: xiaomi
    name: Front Camera
    host: "{{ states.device_tracker.front_camera.attributes.ip }}"
    model: 'yi'
    password: 1234
    path: /tmp/sd/record
```
