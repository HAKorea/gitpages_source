---
title: facebook 메신저
description: Instructions on how to add Facebook user notifications to Home Assistant.
logo: facebook.png
ha_category:
  - Notifications
ha_release: 0.36
---

`facebook` 알림 플랫폼은 Facebook 메신저로 알림을 보낼 수 있습니다. powered by [Facebook](https://facebook.com).


설치시 이 알림 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: facebook
    page_access_token: FACEBOOK_PAGE_ACCESS_TOKEN
```

{% configuration %}
page_access_token:
  description: "Facebook 페이지의 액세스 토큰. 자세한 내용은 [Facebook Messenger Platform](https://developers.facebook.com/docs/messenger-platform/guides/setup)을 확인하십시오." 
  required: true
  type: string
name:
  description: 선택적 매개 변수 `name`을 세팅하면 여러 알리미(notifier)를 만들수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME`에 바인딩합니다.
  required: false
  default: "`notify`"
  type: string
{% endconfiguration %}

### 사용법

Facebook 알림 서비스를 사용하면 Facebook 페이지를 통해 Facebook 메신저에 알림을 보낼 수 있습니다. 이 서비스를 위해 [Facebook Page and App](https://developers.facebook.com/docs/messenger-platform/guides/quick-start)을 만들어야합니다. notify 서비스 [as described here](/integrations/notify/)를 호출하여 제어할 수 있습니다.
**target**에 사용된 전화 번호는 Facebook 메신저에 등록되어 있어야합니다. 수신자의 전화 번호는 +1(212)555-2368 형식이어야합니다. Facebook에서 앱을 승인하지 않은 경우 수신자는 Facebook 앱의 관리자, 개발자 또는 테스터가 해야합니다. [More information](https://developers.facebook.com/docs/messenger-platform/send-api-reference#phone_number) 전화 번호에 대한 정보입니다.

```yaml
# Example automation notification entry
automation:
  - alias: Evening Greeting
    trigger:
      platform: sun
      event: sunset
    action:
      service: notify.facebook
      data:
        message: 'Good Evening'
        target:
          - '+919413017584'
          - '+919784516314'
```

Facebook에 전화 번호를 저장하지 않은 사용자에게 메시지를 보낼 수도 있지만 약간의 작업이 필요합니다. 메신저 플랫폼은 글로벌 사용자 ID 대신 페이지 별 사용자 ID를 사용합니다. Facebook 개발자 콘솔에서 "message" 이벤트에 대해 웹 후크를 활성화해야합니다. 사용자가 페이지에 메시지를 작성하면 해당 웹 후크는 웹후크 페이로드의 일부로 사용자의 페이지 특정 ID를 받습니다. 다음은 "get my id"메시지에 반응하고 사용자의 ID가 포함된 회신을 보내는 간단한 PHP 스크립트입니다. :

```php
<?php

$access_token = "";
$verify_token = "";

if (isset($_REQUEST['hub_challenge'])) {
    $challenge        = $_REQUEST['hub_challenge'];
    $hub_verify_token = $_REQUEST['hub_verify_token'];

    if ($hub_verify_token === $verify_token) {
        echo $challenge;
    }
}

$input   = json_decode(file_get_contents('php://input'), true);
$sender  = $input['entry'][0]['messaging'][0]['sender']['id'];
$message = $input['entry'][0]['messaging'][0]['message']['text'];

if (preg_match('/get my id/', strtolower($message))) {
    $url      = 'https://graph.facebook.com/v2.10/me/messages?access_token=' . $access_token;
    $ch       = curl_init($url);
    $jsonData = '{
        "recipient":{
            "id":"' . $sender . '"
        },
        "message":{
            "text":"Your ID: ' . $sender . '"
        }
      }';

    $jsonDataEncoded = $jsonData;
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonDataEncoded);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);

    if (!empty($input['entry'][0]['messaging'][0]['message'])) {
        $result = curl_exec($ch);
    }
}

```

### Rich messages
카드, 버튼, 이미지, 비디오 등 풍부한 메시지를 보낼 수 있습니다. [Info](https://developers.facebook.com/docs/messenger-platform/send-api-reference) 메시지 유형 및 작성 방법

```yaml
# Example script with a notification entry with a rich message

script:
  test_fb_notification:
    sequence:
      - service: notify.facebook
        data:
          message: Some text before the quick replies
          target: 0034643123212
          data:
            quick_replies:
              - content_type: text
                title: Red
                payload: DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_RED
              - content_type: text
                title: Blue
                payload: DEVELOPER_DEFINED_PAYLOAD_FOR_PICKING_BLUE
```

또한 Facebook 공개 베타 브로드 캐스트 API를 사용하여 번호를 수집하지 않고도 페이지에서 챗봇과 상호작용 한 모든 사용자에게 메시지를 푸시 할 수 있습니다. 이것은 수천 명의 사용자로 확장됩니다. Facebook은 비상업적 인 용도로만 사용해야하며 사용자가 보내는 모든 메시지의 유효성을 검사합니다. 또한 Facebook 봇은 모두 "page_subscritions"에 대한 권한을 부여 받아야하지만 선택한 테스터 그룹에게 바로 사용할 수 있습니다.

브로드 캐스트를 활성화하려면 "BROADCAST" 키워드를 대상으로 사용하십시오. 아래와 같이 하나의 대상 방송(BROADCAST)만 넣으십시오.

```yaml
- alias: Facebook Broadcast
  trigger:
    platform: sun
    event: sunset
  action:
    service: notify.facebook
    data:
      message: Some text you want to send
      target:
        - BROADCAST
```
