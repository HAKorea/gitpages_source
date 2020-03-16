---
title: 애플 Push Notification Service (APNS)
description: Instructions on how to add APNS notifications to Home Assistant.
logo: apple.png
ha_category:
  - Notifications
ha_release: 0.31
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/qNUU3vBffvc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`apns` 플랫폼은 APNS (Apple Push Notification Service)를 사용하여 Home Assistant에서 알림을 전달합니다.

## 셋업

APNS 서비스를 사용하려면 Apple 개발자 계정이 필요하며 푸시 알림을 수신하려면 앱을 만들어야합니다. 자세한 내용은 Apple 개발자 설명서를 참조하십시오.

## 설정

APNS 알림을 사용하려면 `configuration.yaml`에 다음 행을 추가하십시오  :

```yaml
# Example configuration.yaml entry
notify:
  name: NOTIFIER_NAME
  platform: apns
  cert_file: cert_file.pem
  topic: topic
```

{% configuration %}
name:
  description: 알리미의 이름. 알리미는 서비스 `notify.NOTIFIER_NAME`에 바인딩합니다.
  required: true
  type: string
cert_file:
  description: APNS 서비스를 인증하는데 사용할 인증서.
  required: true
  type: string
topic:
  description: 인증서에 지정된 app bundle ID.
  required: true
  type: string
sandbox:
  description: true일 경우 알림이 sandbox (test) 알림 서비스로 전송
  required: false
  default: false
  type: boolean
{% endconfiguration %}

APNS 플랫폼은 `notify.NOTIFIER_NAME` 과 `apns.apns_NOTIFIER_NAME`의 두 가지 서비스를 등록합니다.

### apns.apns_NOTIFIER_NAME

이 서비스는 홈어시스턴트로 장치 ID를 등록합니다. 알림을 받으려면 장치를 등록해야합니다. 장치의 앱은 이 서비스를 사용하여 시작하는 동안 홈어시스턴트로 ID를 보낼 수 있으며, ID는 `[NOTIFIER_NAME]_apns.yaml`에 저장됩니다.

장치 ID를 얻는 방법에 대한 자세한 내용은 [Apple developer documentation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/#//apple_ref/occ/intfm/UIApplicationDelegate/application:didRegisterForRemoteNotificationsWithDeviceToken:)에서 `didRegisterForRemoteNotificationsWithDeviceToken`를 참조하십시오.

### notify.NOTIFIER_NAME

이 서비스는 등록된 장치로 메시지를 보냅니다. 다음과 같은 파라미터를 사용할 수 있습니다.

- **message**: The message to send.

- **target**: The desired state of the device, only devices that match the state will receive messages. To enable state tracking a registered device must have a `tracking_device_id` attribute added to the `[NOTIFIER_NAME]_apns.yaml` file. If this ID matches a device in `known_devices.yaml` the device state will be tracked.

- **data**:
  * **badge**: The number to display as the badge of the app icon.
  * **sound**: The name of a sound file in the app bundle or in the Library/Sounds folder.
  * **category**: Provide this key with a string value that represents the identifier property of the `UIMutableUserNotificationCategory`.
  * **content_available**: Provide this key with a value of 1 to indicate that new content is available.
