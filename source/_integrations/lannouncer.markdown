---
title: 안드로이드음성알리미(LANnouncer)
description: Instructions on how to add Lannouncer notifications to Home Assistant.
logo: lannouncer.png
ha_category:
  - Notifications
ha_release: 0.36
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/VMA9ZqgLNIA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`lannouncer` 알림 플랫폼을 사용하면 [Lannouncer](https://www.keybounce.com/lannouncer/)를 실행하는 Android 기기에서 음성 메시지 (TTS) 또는 사운드를 재생할 수 있습니다. 벽에 장착 된 Android 태블릿 또는 영구적으로 전원이 켜져 있고 켜져 있고 알림을 재생하는 데 사용하는 Android 장치가있는 경우에 유용합니다. 

최근 유튜버의 영상 설정기를 참조하십시오. https://www.youtube.com/watch?v=VMA9ZqgLNIA

설치시 Lannouncer 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.



```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: lannouncer
    host: HOSTNAME_OR_IP
```

{% configuration %}
name:
  description: 선택적 매개 변수 `name`을 설정하면 여러 알리미를 만들 수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME` 에 바인딩합니다.
  required: false
  default: notify
  type: string
host:
  description: Lannouncer를 실행하는 Android 장치의 호스트 이름 또는 IP 주소.
  required: true
  type: string
port:
  description: Lannouncer가 실행중인 포트.
  required: false
  default: 1035
  type: integer
{% endconfiguration %}

### 설치

Lannouncer 앱을 설치하고 *Network (TCP) Listener* 및 *Auto-Start Network Listener* 를 활성화해야합니다. 이 통합구성요소에서는 *GCM (Google Cloud) and WAN Messaging* 및 *SMS Listener*를 사용하지 않을 수 있습니다.

Lannouncer는 기본 Android TTS 음성을 사용합니다. Android 설정에서 이를 조정하거나 Play 스토어와 다른 TTS 엔진을 설치할 수 있습니다. 실제 하드웨어 장치에 따라 앱 설정에서 볼륨을 높이고 싶을 수 있습니다.

자세한 내용은 [here](https://www.keybounce.com/lannouncer/configuring-lannouncer/)를 참조. 

### 메시지 보내기

Lannouncer는 두 가지 유형의 메시지를 지원합니다.

음성 메시지가 기본 방법입니다 (`speak`). 다음 json으로 `notify` 서비스를 호출하면 장치가 지정된 메시지를 말합니다.

```json
{
  "message": "I'm sorry, I cannot do that Dave."
}
```

두 번째 방법은 알림(`alarm`)을 재생하는 것입니다. 내장 소리는 4 가지가 있습니다 (`chime`, `doorbell`, `alarm`, `siren`).

```json
{
  "message": "chime",
  "data": {
    "method": "alarm"
  }
}
```

설정된 추가 사운드 파일 (`FILE1`,`FILE2`,`FILE3`,`FILE4` 또는 `FILE5`) 재생을 요청할 수도 있습니다. 앱 설정에서 이 파일을 설정할 수 있습니다.

```json
{
  "message": "FILE1",
  "data": {
    "method": "alarm"
  }
}
```

<div class='note info'>
 무료 버전은 하나의 추가 사운드 파일 만 지원합니다.
</div>

알림을 사용하려면 [자동화 시작 페이지](/getting-started/automation/)를 참조하십시오.
