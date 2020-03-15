---
title: FFmpeg
description: Instructions on how to integrate FFmpeg within Home Assistant.
logo: ffmpeg.png
ha_category:
  - Image Processing
ha_release: 0.29
---

`ffmpeg` 통합구성요소를 통해 다른 Home Assistant 통합구성요소가 비디오 및 오디오 스트림을 처리 할 수 ​​있습니다. 이 통합구성요소는 3.0.0 이후의 모든 FFmpeg 버전을 지원합니다. 이전 버전인 경우 업데이트하십시오.

<div class='note'>

시스템 경로에`ffmpeg` 바이너리가 필요합니다. 데비안 8 또는 Raspbian (Jessie)에서는 [debian-backports](https://backports.debian.org/Instructions/)에서 설치할 수 있습니다. Raspberry Pi에서 [hardware acceleration](https://trac.ffmpeg.org/wiki/HWAccelIntro) 지원을 원한다면 직접 소스에서 빌드해야합니다. Windows 바이너리는 [FFmpeg] (http://www.ffmpeg.org/) 웹 사이트에서 제공됩니다.
</div>

<div class='note'>

[Hass.io](/hassio/)를 사용하는 경우 모든 요구 사항이 이미 충족되었으므로 설정으로 이동하십시오.

</div>

## 설정

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
ffmpeg:
```

{% configuration %}
ffmpeg_bin:
  description: The name or path to the `ffmpeg` binary.
  required: false
  default: ffmpeg
  type: string
{% endconfiguration %}

### Raspbian Debian Jessie Lite 설치
RPi의 Raspbian Debian Jessie Lite에서 바이너리를 가져오려면 다음을 수행해야합니다.

```bash
sudo echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get -t jessie-backports install ffmpeg
```

설정에서 다음을 사용할 수 있습니다.

```yaml
ffmpeg:
  ffmpeg_bin: /usr/bin/ffmpeg
```

### 문제 해결

대부분의 경우, ffmpeg는 비디오 또는 오디오 스트림 또는 파일을 읽는 데 필요한 모든 옵션을 자동으로 감지합니다. 그러나 드문 경우이지만 `ffmpeg`를 돕기 위해 옵션을 설정해야 할 수도 있습니다.

먼저, 홈어시스턴트 외부의 `ffmpeg`에서 스트림을 재생할 수 있는지 확인하십시오 (비디오 또는 오디오 스트림을 비활성화하려면 `-an` 또는`-vn` 옵션 사용).

```bash
ffmpeg -i INPUT -an -f null -
```

이제 무엇이 잘못되었는지 확인할 수 있습니다. 다음 목록에는 몇 가지 일반적인 문제와 해결책이 있습니다. : 

- `[rtsp @ ...] UDP timeout, retrying with TCP`: You need to set an RTSP transport in the configuration with: `input: -rtsp_transport tcp -i INPUT`
- `[rtsp @ ...] Could not find codec parameters for stream 0 (Video: ..., none): unspecified size`: FFmpeg needs more data or time for autodetection (the default is 5 seconds). You can set the `analyzeduration` and/or `probesize` options to experiment with giving FFmpeg more leeway. If you find the needed value, you can set it with: `input: -analyzeduration xy -probesize xy -i INPUT`. More information about this can be found [here](https://www.ffmpeg.org/ffmpeg-formats.html#Description).

#### USB 카메라

`INPUT`의 경우 유효한 소스가 필요합니다. USB 카메라를 사용하면 비디오 설정을 쉽게 테스트 할 수 있습니다. 예를 들어, 사용 가능한 모든 USB 카메라를 시스템에 연결하려면 Linux 시스템에서 v4l2 도구를 사용하십시오.

```bash
$ v4l2-ctl --list-devices
UVC Camera (046d:0825) (usb-0000:00:14.0-1):
  /dev/video1

Integrated Camera (usb-0000:00:14.0-10):
  /dev/video0
```

Record a test video with your USB device `/dev/video1`:

```bash
$ ffmpeg -i /dev/video1 -codec:v libx264 -qp 0 lossless.mp4
[...]
Input #0, video4linux2,v4l2, from '/dev/video1':
  Duration: N/A, start: 43556.376974, bitrate: 147456 kb/s
    Stream #0:0: Video: rawvideo (YUY2 / 0x32595559), yuyv422, 640x480, 147456 kb/s, 30 fps, 30 tbr, 1000k tbn, 1000k tbc
[...]
Output #0, mp4, to 'lossless.mp4':
  Metadata:
    encoder         : Lavf57.41.100
    Stream #0:0: Video: h264 (libx264) ([33][0][0][0] / 0x0021), yuv422p, 640x480, q=-1--1, 30 fps, 15360 tbn, 30 tbc
    Metadata:
      encoder         : Lavc57.48.101 libx264
    Side data:
      cpb: bitrate max/min/avg: 0/0/0 buffer size: 0 vbv_delay: -1
Stream mapping:
  Stream #0:0 -> #0:0 (rawvideo (native) -> h264 (libx264))
Press [q] to stop, [?] for help
frame=  223 fps= 40 q=-1.0 Lsize=   16709kB time=00:00:07.40 bitrate=18497.5kbits/s dup=58 drop=0 speed=1.32x
```
