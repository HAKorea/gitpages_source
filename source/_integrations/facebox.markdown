---
title: 페이스박스(Facebox)
description: Detect and recognize faces with Facebox.
logo: machine-box.png
ha_category:
  - Image Processing
ha_release: 0.7
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/k7u97Pm2tT4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`facebox` 이미지 처리 플랫폼을 사용하면 [Facebox](https://machinebox.io/docs/facebox)를 사용하여 카메라 이미지에서 얼굴을 감지하고 인식할 수 있습니다. 엔티티의 상태는 감지된 얼굴의 수이며 인식된 얼굴은 `matched_faces` 속성에 나열됩니다. 인식된 각 얼굴에 대해 `image_processing.detect_face` 이벤트가 발생하며 이벤트 `data`는 해당 인식의 `confidence`을 제공하며, 사람의 `name`, 사진과 매치되어 연관된 `image_id`, 이미지에 얼굴을 포함한 `bounding_box`, `entity_id` 프로세싱이 수행됩니다.  

## 셋업

Facebox는 Docker 컨테이너에서 실행되며 최소 2GB RAM이있는 시스템에서 이 컨테이너를 실행하는 것이 좋습니다.  Docker가있는 머신에서 다음을 사용하여 Facebox 컨테이너를 실행하십시오.

```bash
MB_KEY="INSERT-YOUR-KEY-HERE"

sudo docker run --name=facebox --restart=always -p 8080:8080 -e "MB_KEY=$MB_KEY"  machinebox/facebox
```

or using `docker-compose`:

```yaml
version: '3'
services:
  facebox:
    image: machinebox/facebox
    container_name: facebox
    restart: unless-stopped
    ports:
      - 8080:8080
    environment:
      - MB_KEY=${MB_KEY}
      - MB_FACEBOX_DISABLE_RECOGNITION=false
```

`-e "MB_BASICAUTH_USER=my_username" -e "MB_BASICAUTH_PASS=my_password"`를 추가하여 사용자 이름 및 비밀번호로 Facebox를 실행할 수 있지만 연동시 이러한 신뢰 정보(credentials)가 암호화되지 않으며 보안이 없는 네트워크에서는 보안이 보장되지 않습니다.

[Machinebox](https://machinebox.io/account)에서 계정을 생성한 후에는 [your Account page](https://developer.veritone.com/machinebox/overview) 에서 `MB_KEY`를 가져올 수 있습니다.

얼굴 인식(얼굴 수)만 필요한 경우 `docker run` 명령에 `-e "MB_FACEBOX_DISABLE_RECOGNITION = true"`를 추가하여 얼굴 인식을 비활성화 할 수 있습니다.

호스트 컴퓨터가 [AVX](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions)를 지원하지 않고 `machinebox/facebox` 이미지를 실행하는 데 문제가 있는 경우 `machinebox/facebox_noavx`에서 AVX 지원이 없는 대체 이미지가 있습니다. (*힌트* : 이 이미지는 현재 machinebox에서 지원되지 않으며 필요한 경우에만 사용해야 합니다.)

## 설정

이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: facebox
    ip_address: 192.168.0.1
    port: 8080
    source:
      - entity_id: camera.local_file
        name: my_custom_name
```

{% configuration %}
ip_address:
  description: Facebox를 호스팅하는 컴퓨터의 IP 주소.
  required: true
  type: string
port:
  description: Facebox가 노출된 포트.
  required: true
  type: string
username:
  description: Facebox 사용자 이름을 설정한 경우.
  required: false
  type: string
password:
  description: Facebox 비밀번호를 설정한 경우.
  required: false
  type: string
source:
  description: 이미지 소스 목록.
  required: true
  type: map
  keys:
    entity_id:
      description: 사진을 가져올 카메라 엔티티 ID.
      required: true
      type: string
    name:
      description: 이 매개 변수를 사용하면 `image_processing` 엔티티 이름을 대체할 수 있습니다 
      required: false
      type: string
{% endconfiguration %}

## 자동화

`image_processing.detect_face` 이벤트를 사용하여 자동화를 트리거하고 [data_template](/docs/automation/templating/)을 사용하여 `trigger.event.data` 를 분류하십시오. 다음 예제 자동화는 Ringo Star가 인식될 때 알림을 보냅니다.

{% raw %}
```yaml
- id: '12345'
  alias: Ringo Starr recognised
  trigger:
    platform: event
    event_type: image_processing.detect_face
    event_data:
      name: 'Ringo_Starr'
  action:
    service: notify.platform
    data_template:
      message: Ringo_Starr recognised with probability {{ trigger.event.data.confidence }}
      title: Door-cam notification
```
{% endraw %}

## `facebox.teach_face` 서비스

`facebox.teach_face` 서비스는 Facebox 얼굴을 가르치는데 사용될 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | Entity ID of Facebox entity.
| `name` | no | The name to associate with a face.
| `file_path` | no | The path to the image file.

유효한 서비스 데이터 예시:

{% raw %}
```yaml
{
  "entity_id": "image_processing.facebox_local_file",
  "name": "superman",
  "file_path": "/images/superman_1.jpeg"
}
```
{% endraw %}

얼굴인식을 훈련시킬 때 자동화를 사용하여 알림을 받을 수 있습니다.

{% raw %}
```yaml
- id: '1533703568569'
  alias: Face taught
  trigger:
  - event_data:
      service: facebox.teach_face
    event_type: call_service
    platform: event
  condition: []
  action:
  - service: notify.pushbullet
    data_template:
      message: '{{ trigger.event.data.service_data.name }} taught
      with file {{ trigger.event.data.service_data.file_path }}'
      title: Face taught notification
```
{% endraw %}

얼굴을 가르칠때 오류는 로그에 보고됩니다. [system_log](/integrations/system_log/) 이벤트를 사용하는 경우 :

```yaml
system_log:
  fire_event: true
```

Facebox 오류에 대한 알림을 받도록 자동화를 만들 수 있습니다.

{% raw %}
```yaml
- id: '1533703568577'
  alias: Facebox error
  trigger:
    platform: event
    event_type: system_log_event
  condition:
    condition: template
    value_template: '{{ "facebox" in trigger.event.data.message }}'
  action:
  - service: notify.pushbullet
    data_template:
      message: '{{ trigger.event.data.message }}'
      title: Facebox error
```
{% endraw %}
