---
title: Jabber (XMPP)
description: Instructions on how to add Jabber (XMPP) notifications to Home Assistant.
logo: xmpp.png
ha_category:
  - Notifications
ha_release: pre 0.7
ha_codeowners:
  - '@fabaff'
  - '@flowolf'
---

`xmpp` 알림 플랫폼을 통해 Home Assistant에서 [Jabber (XMPP)](https://xmpp.org/) 계정으로 알림을 전달할 수 있습니다.

## 설정

설치에서 Jabber 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME  # e.g. jabber
    platform: xmpp
    sender: YOUR_JID
    password: YOUR_JABBER_ACCOUNT_PASSWORD
    recipient: YOUR_RECIPIENT
```

{% configuration %}
name:
  description: "Setting the optional parameter `name` allows multiple notifiers to be created. The default value is `notify`. The notifier will bind to the service `notify.NOTIFIER_NAME`."
  required: false
  type: string
  default: notify
sender:
  description: "The Jabber ID (JID) that will act as origin of the messages. Add your JID including the domain, e.g. your_name@jabber.org."
  required: true
  type: string
resource:
  description: "Resource part of JID, e.g., your_name@jabber.org/`HA-cabin`."
  required: false
  type: string
  default: home-assistant
password:
  description: The password for your given Jabber account.
  required: true
  type: string
recipient:
  description: The Jabber ID (JID) that will receive the messages.
  required: true
  type: string
tls:
  description: Force TLS.
  required: false
  type: boolean
  default: true
verify:
  description: Allow disabling SSL certificate validity check, e.g., self-signed certificate.
  required: false
  type: boolean
  default: true
room:
  description: "Room's name (e.g., example@conference.jabber.org). If set, send a message to chatroom instead of the recipient."
  required: false
  type: string
{% endconfiguration %}

<div class='note'>

  Pre Home Assistant 0.81 `sleekxmpp`가 XMPP 서버에 연결하는데 사용되었습니다. 1.3.2 버전의 `sleekxmpp`는 > TLS v1을 지원하지 않습니다. 자체 XMPP 서버 (예: Prosody, ejabberd)를 실행중인 경우 TLS v1 사용을 허용해야합니다.

  0.81 이후의 홈어시스턴트는`slixmpp`를 사용하며 TLS v1.1 및 TLS v1.2도 지원합니다.

</div>

모든 Jabber ID (JID)는 도메인을 포함해야합니다. 비밀번호가 발신자로 제공된 계정과 일치하는지 확인하십시오.

Jabber를 통해 다른 파일뿐만 아니라 문자 메시지 및 이미지를 보낼 수 있습니다.

### Jabber 텍스트 메시지

다음은 자동화에서 실행할 수 있는 스크립트를 설정하는 방법에 대한 예입니다.

숫자 1은 고전적인 텍스트 전용 메시지입니다. 제목은 선택 사항이지만 생략하면 `Home-Assistant`가 설정됩니다. 비워 두려면 `""`로 설정하십시오.

```yaml
# Example script.yaml entry
1_send_jabber_message:
  alias: "Text only Jabber message"
  sequence:
    - service: notify.jabber  # from notify.NOTIFIER_NAME
      data:
        title: "Optional Title"
        message: "My funny or witty message"
```

### Jabber 이미지 메시지

Jabber의 HTTP 업로드 기능을 통해 로컬에 저장된 파일 또는 원격 웹 위치에서 이미지 또는 파일을 보낼 수 있습니다. 
파일 및 이미지를 보내려면 Jabber 서버가 [XEP_0363](https://xmpp.org/extensions/xep-0363.html)을 지원해야합니다.

<div class='note'>

이미지는 제공 업체의 Jabber 서버에 업로드됩니다. 암호화되지 않은 상태로 상주하며 서버 관리자가 액세스할 수 있습니다. 일반적으로 이미지는 며칠 후에 삭제됩니다.<br>
<br>
홈어시스턴트는 전송 암호화를 보장하기 위해 TLS 암호화를 지원합니다. TLS는 기본적으로 적용됩니다. [`tls`](#tls) 플래그를 사용하여 비활성화할 수 있으나 권장하지 않습니다.
</div>

숫자 2는 URL에서 검색한 이미지만 보냅니다. 이미지를 얻기위한 TLS 연결도 확인되지 않습니다 (주의해서 사용하십시오).

```yaml
# Example script.yaml entry
2_send_jabber_message_with_image_url:
  alias: "Send Image via Jabber from website"
  sequence:
    - service: notify.jabber
      data:
        title: ""
        message: ""
        data:
          url: "https://www.graz.at:8443/webcam_neu/getimg.php"
          verify: false
```

숫자 3은 로컬 경로에서 이미지를 보냅니다.

```yaml
# Example script.yaml entry
3_send_jabber_message_with_local_image_path:
  alias: "Send Image via Jabber from local file"
  sequence:
    - service: notify.jabber
      data:
        title: ""
        message: ""
        data:
          path: "/home/homeassistant/super_view.jpg"
```

### Jabber 파일 메시지


4 번은 Github에서 가져온 텍스트 파일을 `Hass_Cheatsheet.txt`로 이름을 바꾸어 모바일 안드로이드 기기에서 볼 수 있도록 이름을 바꿉니다. 대부분 `.md`파일을 볼 수 있는 응용 프로그램은 없습니다. 선택적으로 HTTP 업로드 시간 초과를 초 단위로 추가할 수 있습니다.

```yaml      
# Example script.yaml entry
4_send_jabber_message_with_file:
  alias: "Send text file via Jabber"
  sequence:
    - service: notify.jabber
      data:
        title: ""
        message: ""
        data:
          url: "https://raw.githubusercontent.com/arsaboo/homeassistant-config/master/HASS%20Cheatsheet.md"
          path: "Hass_Cheatsheet.txt"
          timeout: 10
```

### 템플레이팅

숫자 5는 URL에서 검색된 이미지와 `title`과 `message`가 포함된 추가 문자 메시지를 보냅니다.

```yaml
# Example script.yaml entry
5_send_jabber_message_with_image_and_text:
  alias: "Send Image and Text via Jabber"
  sequence:
    - service: notify.jabber
      data:
        title: "The Time is now"
        message: "{% raw %} {{ {% endraw %}now(){% raw %} }} {% endraw %}, templating works as well..."
        data:
          url: "https://github.com/home-assistant/home-assistant.io/raw/next/source/images/favicon-192x192.png"
```

번호 6은 템플릿 URL에서 이미지를 보냅니다.

```yaml
# Example script.yaml entry
6_send_jabber_message_with_image_from_url_template:
  alias: "Send Image from template URL via Jabber"
  sequence:
    - service: notify.jabber
      data:
        title: ""
        message: ""
        data:
          url_template: "https://www.foto-webcam.eu/webcam/dornbirn/{% raw %}{{ now().year }}/{{ '%02d' % now().month }}/{{ '%02d' % now().day }}/{{ '%02d' % now().hour }}{{ (now().minute + 58) % 60 // 10}}{% endraw %}0_hd.jpg"
```

파일의 가능한 소스가 우선 순위를 가지며 하나만 선택됩니다. `url_template`이 가장 높은 우선 순위를 가지고 있습니다. 다음은 `url`, `path_template` 그리고 마지막으로 아무것도 정의되지 않으면 `path`가 사용됩니다. `path`는 알 수 없는 URL 다운로드에 대한 파일 확장자 추측을 제거하는데 사용됩니다. 홈어시스턴트는 추가된 개인 정보 보호를 위해 파일 이름을 임의의 문자열로 변경하므로 파일 확장자만 남습니다.

알림에 대한 자세한 내용은 [getting started with automation page](/getting-started/automation/)를 참조하십시오.