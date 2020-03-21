---
title: IMAP
description: Instructions on how to integrate IMAP unread email into Home Assistant.
logo: smtp.png
ha_category:
  - Mailbox
ha_release: 0.25
ha_iot_class: Cloud Push
---

`imap` 통합구성요소는 [IMAP server](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol)를 관찰하고 읽지 않은 이메일의 양을 보고합니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: imap
    server: YOUR_IMAP_SERVER
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
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
  description: The IMAP folder to watch.
  required: false
  default: inbox
  type: string
search:
  description: The IMAP search to perform on the watched folder.
  required: false
  default: UnSeen UnDeleted
  type: string
charset:
  description: The character set used for this connection.
  required: false
  default: utf-8
  type: string
{% endconfiguration %}

### IMAP 검색 설정

기본적으로 이 통구성요소는 읽지 않은 이메일을 계산합니다. 검색 문자열을 설정하면 다음과 같은 다른 결과를 계산할 수 있습니다.

* `ALL` 폴더의 모든 이메일을 계산
* `FROM`, `TO`, `SUBJECT` 폴더에서 이메일을 찾기 ([IMAP RFC for all standard options](https://tools.ietf.org/html/rfc3501#section-6.4.4) 참조)
* [Gmail's IMAP extensions](https://developers.google.com/gmail/imap/imap-extensions)은 `X-GM-RAW "in: inbox older_than:7d"` 와 같은 raw Gmail 검색을 통해 받은 편지함에 1 주일이 지난 이메일을 표시할 수 있습니다. raw Gmail 검색은 폴더 설정을 무시하고 계정의 모든 이메일을 검색합니다. ! 


#### 검색이 가능한 전체 설정 샘플

```yaml
# Example configuration.yaml entry for gmail
sensor:
  - platform: imap
    server: imap.gmail.com
    port: 993
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    search: FROM <sender@email.com>, SUBJECT <subject here>

# Example configuration.yaml entry for Office 365
sensor:
  - platform: imap
    server: outlook.office365.com
    port: 993
    username: email@address.com
    password: password
    search: FROM <sender@email.com>, SUBJECT <subject here>
    charset: US-ASCII
```
