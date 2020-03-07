---
title: Yi 홈 카메라
description: Instructions on how to integrate a video feed (via FFmpeg) as a camera within Home Assistant.
logo: yi.png
ha_category:
  - Camera
ha_release: 0.56
ha_iot_class: Local Polling
ha_codeowners:
  - '@bachya'
---

`yi` 카메라 플랫폼을 사용하면 Home Assistant 내에서 [Yi Home Cameras](https://www.yitechnology.com/)를 활용할 수 있습니다. 특히 이 플랫폼은 Hi3518e 칩셋을 기반으로하는 Yi Home 카메라 제품군을 지원합니다. 여기에는 다음이 포함됩니다.

* Yi Home 17CN / 27US / 47US
* Yi 1080p Home
* Yi Dome
* Yi 1080p Dome

이 플랫폼을 성공적으로 구현하려면 Home Assistant 호스트가 여러개의 동시 읽기를 수행 할 수 있어야합니다. 동시 홈어시스턴트 사용자마다 10 초마다 카메라에 연결됩니다. 이는 일반적으로 문제가 되지 않습니다.

## 장치 준비 

### 대체 펌웨어 설치

카메라를 홈어시스턴트와 연동하려면 장치에 커스텀 펌웨어를 설치해야합니다. 이를 위한 지침은 [yi-hack-v3 GitHub 프로젝트](https://github.com/shadow-1/yi-hack-v3) 또는 2019 버전 카메라가있는 경우 [yi-hack- 6FUS_4.5.0 GitHub 프로젝트](https://github.com/roleoroleo/yi-hack-6FUS_4.5.0).

설치한 후에는 장치에서 FTP 및 Telnet을 활성화했는지 확인하십시오.

<div class='note warning'>

현재, 커스텀 펌웨어 버전 0.1.4-beta2는 추가 수정없이 지원되는 최고 수준입니다. 이 버전보다 높은 펌웨어는 FFmpeg가 비디오 파일을 올바르게 렌더링하지 못하게하는 버그가 있는데 [Pure-FTPd] (https://www.pureftpd.org/project/pure-ftpd)를 사용합니다. 더 높은 펌웨어 버전을 사용하려면 [this workaround](https://github.com/shadow-1/yi-hack-v3/issues/129#issuecomment-361723075)을 따라 ftpd로 되돌려 야합니다.

</div>

<div class='note warning'>

0.1.4-beta2보다 높은 버전을 사용한다면 `/home/yi-hack-v4` 디렉토리에 `/ tmp`에 대한 심볼릭 링크를 만들어 FTP 문제를 간단히 해결할 수 있습니다 (디렉토리 이름은 사용하는 버전). 예를 들어 SSH를 통해 Yi 카메라에 액세스하고 `ln -s /tmp tmp` 명령을 입력하십시오.

</div>

<div class='note warning'>
Raspbian 사용자 : 플랫폼에 ffmpeg 지원을 설치하는 것을 잊지 마십시오. 그렇지 않으면 비디오가 표시되지 않습니다.
</div>

<div class='note warning'>

일부 대체 Yi 펌웨어는 실험용 RTSP 서버를 활성화하여 다른 홈어시스턴트 카메라 플랫폼을 통해 카메라에 연결할 수 있습니다. 그러나 이 RTSP 서버는 가장 유용한 Yi Home 앱을 사용하는 기능을 비활성화시킵니다. 홈어시스턴트 호환성과 기본 앱을 모두 유지하기 위해 이 플랫폼은 FTP를 통해 비디오를 검색하는 것이 좋습니다. 

</div>

### FTP 비밀번호 변경

커스텀 펌웨어가 설치되면 FTP 서버에 비밀번호를 추가해야합니다. 그렇게 하려면 :

1. Telnet into your camera: `telnet <IP ADDRESS>`.
3. Type `passwd` and hit `<Enter>`.
4. Enter your new password twice.
5. Log out of Telnet.

## 플랫폼 설정

플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
camera:
  - platform: yi
    name: Camera
    host: '192.168.1.100'
    password: my_password_123
```

{% configuration %}
name:
  required: true
  type: string
host:
  required: true
  type: string
password:
  required: true
  type: string
path:
  required: false
  type: string
  default: /media/mmcblk0p1/record
username:
  required: false
  type: string
  default: root
ffmpeg_arguments:
  description: Extra options to pass to `ffmpeg` (e.g., image quality or video filter options).
  required: false
  type: string
{% endconfiguration %}

## 화질

[`ffmpeg` camera](/integrations/camera.ffmpeg/)가 지원하는 모든 옵션은 `ffmpeg_arguments` 설정 매개 변수를 통해 활용할 수 있습니다.

특히 유용한 조정 중 하나는 비디오 크기를 처리합니다. Yi 비디오는 상당히 크기 때문에 (특히 1080p 카메라에서) 다음 설정을 통해 관리 가능한 크기로 줄일 수 있습니다.

```yaml
camera:
  - platform: yi
    name: My Camera
    host: '192.168.1.100'
    password: my_password_123
    path: /home/camera/feed
    ffmpeg_arguments: '-vf scale=800:450'
```
