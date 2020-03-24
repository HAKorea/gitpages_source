---
title: 메일알림(SMTP)
description: Instructions on how to add e-mail notifications to Home Assistant.
logo: smtp.png
ha_category:
  - Notifications
ha_release: pre 0.7
ha_codeowners:
  - '@fabaff'
---

<div class='videoWrapper'>
<iframe width="692" height="388" src="https://www.youtube.com/embed/je8PyfILgLk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`smtp` 플랫폼을 사용하면 홈어시스턴트에서 이메일 수신자에게 알림을 전달할 수 있습니다.

설치시 전자 우편으로 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: smtp
    sender: YOUR_SENDER
    recipient: YOUR_RECIPIENT
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  type: string
  default: notify
sender:
  description: E-mail address of the sender.
  required: true
  type: string
recipient:
  description: E-mail address of the recipient of the notification. This can be a recipient address or a list of addresses for multiple recipients.
  required: true
  type: [list, string]
server:
  description: SMTP server which is used to end the notifications.
  required: false
  type: string
  default: localhost  
port:
  description: The port that the SMTP server is using.  
  required: false
  type: integer
  default: 587
timeout:
  description: The timeout in seconds that the SMTP server is using.
  required: false
  type: integer
  default: 5
username:
  description: Username for the SMTP account.
  required: false
  type: string
password:
  description: Password for the SMTP server that belongs to the given username. If the password contains a colon it need to be wrapped in apostrophes.
  required: false
  type: string
encryption:
  description: Set mode for encryption, `starttls`, `tls` or `none`.
  required: false
  type: string
  default: starttls
sender_name:
  description: "Sets a custom 'sender name' in the emails headers (*From*: Custom name <example@mail.com>)."
  required: false
  type: string
debug:  
  description: Enables Debug, e.g., True or False.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

A sample configuration entry for Google Mail.
Google Mail의 샘플 설정 항목

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: smtp
    server: smtp.gmail.com
    port: 587
    timeout: 15
    sender: john@gmail.com
    encryption: starttls
    username: john@gmail.com
    password: thePassword
    recipient:
      - james@gmail.com
      - bob@gmail.com
    sender_name: My Home Assistant
```

Google에는 특별한 주의가 필요한 추가 보호 계층이 있습니다 (힌트: 'Less secure apps'). Google 계정에서 2 단계 인증을 사용하도록 설정한 경우 [an application-specific password](https://support.google.com/mail/answer/185833?hl=en)를 사용해야합니다.

SMTP 알림을 사용하려면 다음 예와 같이 자동화 또는 스크립트에서 SMTP 알림을 참조하십시오.

```yaml
  burglar:
    alias: Burglar Alarm
    sequence:
      - service: shell_command.snapshot
      - delay:
            seconds: 1
      - service: notify.NOTIFIER_NAME
        data:
            title: 'Intruder alert'
            message: 'Intruder alert at apartment!!'
            data:
                images:
                    - /home/pi/snapshot1.jpg
                    - /home/pi/snapshot2.jpg
```

선택적인 `images` 필드는 이메일에 인라인 이미지 첨부 파일을 추가합니다. 일반 텍스트 기본값 대신 텍스트/HTML 멀티 파트(multi-part) 메시지를 보냅니다.

선택적인 `html` 필드는 커스텀 텍스트/HTML 멀티 파트 메시지를 만들어 풍부한 HTML 이메일을 자유롭게 보낼 수 있습니다. 이미지를 첨부해야하는 경우, 인수(`html` 및 `images`)를 모두 전달할 수 있으며, 첨부 파일은 이미지의 기본 이름과 결합되므로 `src="cid:image_name.ext"`를 사용하여 html 페이지에 포함시킬 수 있습니다.

```yaml
  burglar:
    alias: Burglar Alarm
    sequence:
      - service: shell_command.snapshot
      - delay:
            seconds: 1
      - service: notify.NOTIFIER_NAME
        data_template:
            message: 'Intruder alert at apartment!!'
            data:
              images:
                - /home/pi/snapshot1.jpg
                - /home/pi/snapshot2.jpg
              html: >
                <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
                <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
                    <head>
                        <meta charset="UTF-8">
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Intruder alert</title>
                        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css">
                        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
                        <style type="text/css">
                            @font-face {
                              font-family: 'Open Sans';
                              font-style: normal;
                              font-weight: 300;
                              src: local('Open Sans Light'), local('OpenSans-Light'), url(http://fonts.gstatic.com/s/opensans/v13/DXI1ORHCpsQm3Vp6mXoaTZS3E-kSBmtLoNJPDtbj2Pk.ttf) format('truetype');
                            }
                            h1,h2,h3,h4,h5,h6 {
                                font-family:'Open Sans',Arial,sans-serif;
                                font-weight:400;
                                margin:10px 0
                            }
                        </style>
                    </head>
                    <body>
                      <div class="jumbotron jumbotron-fluid" style="background-color: #f00a2d; color: white;">
                          <div class="container py-0">
                              <h1>Intruder alert at apartment!!</h1>
                          </div>
                      </div>
                      <div class="container-fluid">
                        <div class="row">
                          <div class="col-xs-12 col-md-6 px-0">
                            <img class="rounded" style="width: 100%;"
                                alt="snapshot1" src="cid:snapshot1.jpg" />
                          </div>
                          <div class="col-xs-12 col-md-6 px-0">
                            <img class="rounded" style="width: 100%;"
                                alt="snapshot2" src="cid:snapshot2.jpg" />
                          </div>
                        </div>
                        <br>
                      </div>
                    </body>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/js/bootstrap.min.js"></script>
                </html>

```
분명히 이런 종류의 복잡한 HTML 이메일 보고는 예를 들어 [AppDaemon app](/docs/ecosystem/appdaemon/tutorial/)같은 에서 Jinja2 템플릿을 사용하여 훨씬 더 편리하게 수행됩니다.

이 플랫폼은 취약하며 가능한 많은 설정 조합으로 인해 모든 예외사항들을 현명하게 잡아내기 어려울 수 있습니다.

올바르게 작동하는 조합은 포트 587과 STARTTLS입니다. 가능하면 STARTTLS를 활성화하는 것이 좋습니다.

암호에 콜론이 포함되어 있으면 `configuration.yaml` 파일에서 아포스트로피로 묶어야합니다.

Google Mail (smtp.gmail.com)의 경우 설정 프로세스의 추가 단계가 필요합니다. Google에는 특별한 주의가 필요한 추가 보호 계층이 있습니다. 기본적으로 외부 응용 프로그램, 특히 스크립트의 사용은 제한됩니다. [Less secure apps](https://www.google.com/settings/security/lesssecureapps) 페이지를 방문하여 활성화하십시오.

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.