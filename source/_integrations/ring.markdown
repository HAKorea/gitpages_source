---
title: 링(Ring)
description: Instructions on how to integrate your Ring.com devices within Home Assistant.
logo: ring.png
ha_category:
  - Doorbell
  - Binary Sensor
  - Camera
  - Sensor
  - Switch
  - Light
ha_release: 0.42
ha_iot_class: Cloud Polling
ha_config_flow: true
ha_codeowners:
  - '@balloob'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/fAqfqQZiQlE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`ring` 구현을 통해 [Ring.com](https://ring.com/) 장치를 Home Assistant에 통합 할 수 있습니다.

현재 홈 어시스턴트에는 다음 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Camera](#camera)
- [Sensor](#sensor)
- [Switch](#switch)

<p class='note'>
이 구성 요소는 Home Assistant 내에서 Ring 카메라를 실시간으로 볼 수 없습니다.
</p>

## 설정

설정의 통합구성요소 페이지로 이동하여 새 통합구성요소-> 링을 클릭하십시오.

## YAML 설정

YAML 설정은 YAML을 선호하는 사람들을 위한 것이지만 바람직하지 않습니다! YAML 방법은 2번째로 인증에서 작동하지 않으며 사용자 이름/암호를 저장해야합니다. 일반적인 방법은 사용자 이름/암호를 한 번만 입력하면됩니다.

[Ring.com](https://ring.com/) 계정에 링크 된 장치를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
ring:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The username for accessing your Ring account.
  required: true
  type: string
password:
  description: The password for accessing your Ring account.
  required: true
  type: string
{% endconfiguration %}

## Binary Sensor

[Ring integration](/integrations/ring)을 활성화하면 이진 센서를 사용할 수 있습니다. 현재이 제품은 초인종, 외부 차임 및 스틱업 카메라를 지원합니다.

## Camera

<div class='note'>
Ring 비디오를 다운로드하고 재생하려면 Ring Protect 계획이 필요합니다.
</div>

[Ring integration](/integrations/ring)을 활성화하면 카메라 플랫폼 사용을 시작할 수 있습니다. 현재는 초인종 및 스틱 업 카메라를 지원합니다.

## Ring Door Bell에서 캡처 한 비디오 저장

[downloader](/integrations/downloader)와 [automation](/integrations/automation) 또는 [python_script](/integrations/python_script)를 사용하여 Ring Door Bell에서 캡처한 최신 비디오를 로컬로 저장할 수 있습니다.
먼저 `configuration.yaml`에 다음을 추가하여 설정에서 [downloader](/integrations/downloader) 통합구성요소를 활성화하십시오.

```yaml
downloader:
  download_dir: downloads
```

그런 다음 자동화에서 다음 `action`을 사용할 수 있습니다 (`<config>/downloads/ring_<camera_name>/`에 비디오 파일이 저장 됨). : 

{% raw %}
```yaml
action:
  - service: downloader.download_file
    data_template:
      url: "{{ state_attr('camera.front_door', 'video_url') }}"
      subdir: "{{state_attr('camera.front_door', 'friendly_name')}}"
      filename: "{{state_attr('camera.front_door', 'friendly_name')}}"
```
{% endraw %}

`python_script`를 사용하려면 먼저 `configuration.yaml` 파일을 활성화하십시오 :

```yaml
python_script:
```

그런 다음 `python_script`를 사용하여 비디오 파일을 저장할 수 있습니다.

```python
# obtain ring doorbell camera object
# replace the camera.front_door by your camera entity
ring_cam = hass.states.get("camera.front_door")

subdir_name = f"ring_{ring_cam.attributes.get('friendly_name')}"

# get video URL
data = {
    "url": ring_cam.attributes.get("video_url"),
    "subdir": subdir_name,
    "filename": ring_cam.attributes.get("friendly_name"),
}

# call downloader integration to save the video
hass.services.call("downloader", "download_file", data)
```

## Sensor

[Ring integration](/integrations/ring)을 활성화하면 센서 플랫폼 사용을 시작할 수 있습니다. 현재 이 제품은 초인종, 외부 차임 및 스틱업 카메라를 지원합니다.

## Switch

[Ring integration](/integrations/ring)을 활성화하면 스위치 플랫폼 사용을 시작할 수 있습니다. 사이렌은 자동으로 꺼지기 전에 30 초 동안만 켜집니다.

## Light

[Ring integration](/integrations/ring)을 활성화하면 light 플랫폼 사용을 시작할 수 있습니다. 이렇게하면 조명을 지원하는 모든 카메라 (예 : floodlight)에 조명이 추가됩니다.