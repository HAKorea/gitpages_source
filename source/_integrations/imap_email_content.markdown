---
title: IMAP Email Content
description: Instructions on how to integrate IMAP email content sensor into Home Assistant.
logo: smtp.png
ha_category:
  - Mailbox
ha_iot_class: Cloud Push
ha_release: 0.25
---

`imap_email_content` 통합구성요소는 IMAP 이메일 서버에서 이메일을 읽고 Home Assistant 내에서 상태 변경으로 보고합니다. 전자 메일을 통해서만 상태를 보고하는 장치가 있는 경우 유용합니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: imap_email_content
    server: imap.gmail.com
    port: 993
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    folder: YOUR_FOLDER
    senders:
      - example@gmail.com
```

{% configuration %}
server:
  description: The IP address or hostname of the IMAP server.
  required: true
  type: string
port:
  description: The port where the server is accessible.
  required: false
  default: 993
  type: integer
name:
  description: Name of the IMAP sensor.
  required: false
  type: string
username:
  description: Username for the IMAP server.
  required: true
  type: string
password:
  description: Password for the IMAP server.
  required: true
  type: string
folder:
  description: Folder to get mails from.
  required: false
  default: INBOX
  type: string
senders:
  description: A list of sender email addresses that are allowed to report state via email. Only emails received from these addresses will be processed.
  required: true
  type: string
value_template:
  description: If specified this template will be used to render the state of the sensor. If a template is not supplied the message subject will be used for the sensor value. The following attributes will be supplied to the template.
  required: false
  type: template
  keys:
    from:
      description: The from address of the email.
    body:
      description: The body of the email.
    subject:
      description: The subject of the email.git.
    date:
      description: The date and time the email was sent.
{% endconfiguration %}

## 사례

다음 예는 IMAP 이메일 컨텐츠 센서를 사용하여 이메일의 주제를 텍스트로 스캔하는 경우 (이 경우 APC SmartConnect 서비스의 이메일을 사용하여 UPS가 배터리로 실행 중인지 여부를 알려줍니다)를 보여줍니다.

{% raw %}
```yaml
sensor:
  - platform: imap_email_content
    server: imap.gmail.com
    name: house_electricity
    port: 993
    username: MY_EMAIL_USERNAME
    password: MY_EMAIL_PASSWORD
    senders:
      - no-reply@smartconnect.apc.com
    value_template: >-
      {% if 'UPS On Battery' in subject %}
        power_out
      {% elif 'Power Restored' in subject %}
        power_on
      {% endif %}
```
{% endraw %}

동일한 템플릿 구조는 센서의 상태를 설정하기 전에 날짜, 본문 또는 발신자가 일치하는 텍스트를 스캔 할 수 있습니다.