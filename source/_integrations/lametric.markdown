---
title: 고급LED시계(LaMetric)
description: Instructions on how to integrate LaMetric with Home Assistant.
logo: lametric.png
ha_category:
  - Hub
  - Notifications
ha_release: 0.49
ha_codeowners:
  - '@robbiet480'
---

[LaMetric Time](https://lametric.com/)은 응용 프로그램에 액세스하고 웹 라디오를 듣고 알림을 표시하는 데 사용할 수있는 스마트 시계입니다.

<iframe width="700" height="437" src="https://www.youtube.com/embed/8J86MIBfAvo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Notify](#notifications)

LaMetric Time은 승인된 응용 프로그램에서만 액세스 할 수 있습니다. 따라서 LaMetric 시간에 액세스하려는 각 응용 프로그램은 LaMetric Developer 웹페이지에서 등록해야합니다. 개발자 웹페이지에 가입하고 로그인하십시오. 오른쪽 상단에서 생성 버튼을 클릭한 다음 알림 앱을 선택하고 생성을 다시 클릭하십시오. 앱 이름, 설명 및 리디렉션 URL을 입력하십시오. 마지막으로 저장을 클릭하여 응용 프로그램을 만듭니다. 새로 만든 앱의 경우 다음 설정에 필요한 클라이언트 ID와 클라이언트 암호를 얻습니다.

```yaml
# configuration.yaml example
lametric:
  client_id: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx
  client_secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## 셋업 단계

LaMetric은 Home Assistant와 함께 사용하려면 LaMetric 개발자 포털의 OAuth2 `client_id` 및 `client_secret`이 필요합니다.
다음 단계를 수행하십시오.

1. Log in with your LaMetric device account to [developer.lametric.com](https://developer.lametric.com).
2. Hit the Create button and choose [Notification](https://developer.lametric.com/applications/createsource).
3. Fill in the form. You can put almost anything in the fields, they just need to be populated:
  * App Name: Home Assistant 
  * Description: Home Assistant
  * Privacy Policy: `http://localhost/`
  * Check all permission boxes
  * Hit Save
4. You should be directed to your [Notification Apps list](https://developer.lametric.com/applications/sources), click on "Home Assistant", copy your client ID and client Secret and paste into the Home Assistant configuration block in the previous section.
5. Set up some notifications in Home Assistant by following the instructions on the [Lametric Notify](/integrations/lametric) page.
6. Save all configuration files and restart Home Assistant.

## 알림(Notifications)

`lametric` 알림 플랫폼을 통해 LaMetric 장치에 알림을 보낼 수 있습니다. LaMetric 플랫폼을 먼저 설정해야합니다.

설치에서 LaMetric 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  name: NOTIFIER_NAME
  platform: lametric
```

{% configuration %}
name:
  description: "The optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`."
  required: false
  type: string
  default: notify
lifetime:
  description: Defines how long the message remains in LaMetric notification queue (in seconds).
  required: false
  type: integer
  default: 10
icon:
  description: An icon or animation.
  required: false
  type: string
cycles:
  description: Defines how often the notification is displayed.
  required: false
  type: integer
  default: 1
priority:
  description: Defines the priority of the notification.
  required: false
  type: string
  default: warning
{% endconfiguration %}

Check out the list of all icons at [https://developer.lametric.com/icons](https://developer.lametric.com/icons). Note that icons always begin with "i" while animations begin with "a". This is part of the name, you can't just use the number!

## 사례

### 전체 설정 사례

```yaml
# Example configuration.yaml entry
notify:
  name: NOTIFIER_NAME
  platform: lametric
  lifetime: 20
  icon: a7956
  cycles: 3
  priority: info
```

### 소리 및 아이콘 변경

알림 sound, icon, cycles 혹은 priority override를 추가하려면 서비스 데이터를 통해 수행해야합니다.

```yaml
- alias: "Send notification on arrival at school"
  trigger:
    platform: state
    entity_id: device_tracker.son_mobile
    from: 'not_home'
    to: 'school'
  action:
    service: notify.lametric
    data:
      message: "Son has arrived at school!"
      data:
        sound: 'notification'
        icon: 'i51'
        cycles: 0
        priority: 'critical'
```

### 특정 기기에만 알리기

La Metric 장치가 둘 이상있는 경우 서비스 데이터에 `target :`을 추가하여 메시지를 받을 장치를 지정할 수 있습니다. :

```yaml
  action:
    service: notify.lametric
    data:
      message: "Son has arrived at school!"
      target: "Office LaMetric"
      data:
        sound: 'notification'
        icon: 'i51'
 ```

target을 지정하지 않으면 모든 LaMetric 장치에 알립니다.