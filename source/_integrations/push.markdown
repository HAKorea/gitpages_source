---
title: 푸시 카메라(push)
description: Instructions how to use Push Camera within Home Assistant.
logo: camcorder.png
ha_category:
  - Camera
ha_iot_class: Local Push
ha_release: 0.74
ha_codeowners:
  - '@dgomes'
---

`push` 카메라 플랫폼을 사용하면 HTTP POST를 통해 전송된 이미지를 카메라로 Home Assistant에 연동할 수 있습니다. 따라서 외부 applications/daemons/scripts는 Home Assistant를 통해 이미지를 "stream"할 수 있습니다.

선택적으로 푸시 카메라는 여러 이미지를 **buffer**하여 이벤트가 기록된 후 감지된 동작의 애니메이션을 만들 수 있습니다. 

새 이벤트에서 이미지가 지워지고 이벤트는 소프트(설정가능한) **timeout**로 분리됩니다.

## motionEye와 연동

`push` 카메라는 모션 데몬의 웹 프론트엔드 [motionEye](https://github.com/ccrisan/motioneye/wiki)와 함께 사용할 수 있습니다. motionEye는 일반적으로 움직임이 감지될 때 ***파일만***을 저장/기록하도록 설정됩니다. 이미지를 저장할 때마다 명령을 실행하는 후크를 제공합니다. 이 예제는 cURL과 함께 사용하여 모션 감지 이미지를 `push` 카메라로 전송합니다 (아래 예 참조).

motionEye에서, **File Storage -> Run A Command** 아래 다음을 입력합니다. :
```bash
curl -X POST -F "image=@%f" http://my.hass.server.com:8123/api/webhoo\k/my_custom_webhook_id
# inserting a backslash in the middle of "webhook" stops Motion to move the command to a webhook
```

선택적으로 **Still Images -> Capture Mode**로 이동하여 **Motion Triggered**를 설정하여 모션 트리거 이미지만 저장하도록 motionEye를 설정하십시오. **Motion Detection**에서 환경 설정을 조정하십시오.

이 설정에서는 다음과 같은 설정을 사용하여 마지막 모션 트리거 이벤트를 지속적으로 재생하도록 푸시 카메라를 구성 할 수 있습니다.

```yaml
camera:
  - platform: push
    name: MotionEye Outdoor
    buffer: 3
    timeout: 5
    webhook_id: my_custom_webhook_id
```

## 설정

설치시 이 카메라를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: push
    name: My Push Camera
    webhook_id: my_custom_webhook_id
```

{% configuration %}
name:
  description:  The name you would like to give to the camera.
  required: false
  type: string
  default: Push Camera
buffer:
  description: Number of images to buffer per event. Be conservative, large buffers will starve your system memory.
  required: false
  type: string
  default: 1
timeout:
  description: Amount of time after which the event is considered to have finished.
  required: false
  type: time
  default: 5 seconds
webhook_id:
  description: User provided string acting as camera identifier and access control, should be a large string (more then 8 chars).
  required: true
  type: string
field:
  description: HTTP POST field containing the image file
  required: false
  type: string
  default: image
{% endconfiguration %}
