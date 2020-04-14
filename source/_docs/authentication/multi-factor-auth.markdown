---
title: "다단계 인증(Multi-factor authentication)"
description: "Guide on configuring different multi-factor authentication modules."
redirect_from: /integrations/auth/
---

MFA (Multi-factor Authentication) 모듈에서는 암호를 제공한 후 두 번째 도전을 해결해야합니다.

비밀번호는 여러 가지 방법으로 손상될 수 있습니다. 예를 들어 비밀번호가 단순한 비밀번호인지 추측할 수 있습니다. MFA는 다음을 요구하여 두 번째 수준의 방어를 제공합니다.

* 사용자 이름와 비밀번호와 같이 알고있는 것
* 휴대 전화로 보낸 일회용 비밀번호와 같은 정보

다른 인증 공급자와 함께 MFA를 사용할 수 있습니다. 둘 이상의 MFA 모듈이 활성화된 경우 로그인할 때 하나를 선택할 수 있습니다.

사용자 계정의 [프로필 페이지](/docs/authentication/#your-account-profile)에서 MFA를 켜거나 끌 수 있습니다 .

## 사용 가능한 MFA 모듈

### 시간 기반 일회용 암호 MFA 모듈

[시간 기반 일회용 암호](https://en.wikipedia.org/wiki/Time-based_One-time_Password_algorithm)는 최신 인증 시스템에서 널리 채택됩니다.

홈어시스턴트는 휴대폰앱과 동기화되는 비밀키를 생성합니다. 30 초마다 휴대폰앱은 임의의 6 자리 숫자를 생성합니다. 홈어시스턴트는 비밀키를 알고 있기 때문에 생성될 번호를 알고 있습니다. 정확한 숫자를 입력하면, 로그인할 수 있습니다.

#### TOTP 설정하기

`configuration.yaml`에서 다음과 같이 TOTP를 활성화하십시오 :

```yaml
homeassistant:
  auth_mfa_modules:
    - type: totp
```

`auth_mfa_modules` 설정 섹션이 `configuration.yaml`에 정의되어있지 않으면 "Authenticator app"이라는 TOTP 모듈이 자동으로 로드됩니다.

휴대전화에 인증앱이 필요합니다. [Google Authenticator](https://support.google.com/accounts/answer/1066447) 또는 [Authy](https://authy.com/)를 권장합니다. 둘 다 iOS 또는 Android에서 사용할 수 있습니다.

홈어시스턴트를 다시 시작한 후 [프로필 페이지](/docs/authentication/#your-account-profile)로 이동하여 "다단계 인증 모듈" 섹션이 있어야합니다.

_Enable_ 을 클릭하면 새로운 비밀키가 생성됩니다. QR 코드를 스캔하거나 QR 코드 아래의 키를 수동으로 입력하여 휴대폰앱으로 이동하여 키를 입력하십시오.

<img src='/images/docs/authentication/mfa.png' alt='Screenshot of setting up multi-factor authentication' style='border: 0;box-shadow: none;'>

<div class='note warning'>
비밀키를 암호처럼 취급하십시오. - 다른 사람에게 노출시키지 마십시오.
</div>

이제 휴대폰앱이 30 초마다 다른 6 자리 코드를 생성하기 시작합니다. QR 코드 아래에서 _Code_ 를 요청하는 홈어시스턴트로 이들 중 하나를 입력하십시오. 홈어시스턴트와 휴대폰앱이 동기화되었으며 이제 앱에 표시된 코드를 사용하여 로그인할 수 있습니다.

#### TOTP 사용하기

TOTP가 활성화되면 홈어시스턴트는 휴대폰앱의 최신 코드가 있어야 로그인할 수 있습니다.

<div class='note'>

TOTP는 _시간 기반_ 이므로 홈어시스턴트 시계가 정확해야합니다. 확인이 계속 실패하면 홈어시스턴트의 시계가 올바른지 확인하십시오.

</div>

### 다단계 인증 모듈 알림 (Notify multi-factor authentication module)

Notify MFA 모듈은 [notify 구성요소](/integrations/notify/)를 사용하여 [HMAC 기반 일회성 비밀번호](https://en.wikipedia.org/wiki/HMAC-based_One-time_Password_algorithm)를 보냅니다. 일반적으로 휴대전화로 전송되지만 `notify` 서비스가 지원하는 모든 대상으로 전송될 수 있습니다. 이 비밀번호를 사용하여 로그인하십시오.

#### TOTP 설정

다음과 같이 `configuration.yaml` 파일에 Notify MFA를 추가하십시오 :

```yaml
homeassistant:
  auth_mfa_modules:
    - type: notify
      include:
        - notify_entity
```

{% configuration %}
exclude:
  description: The list of notifying service entities you want to exclude.
  required: false
  type: list
include:
  description: The list of notifying service entities you want to include.
  required: false
  type: list
message:
  description: The message template.
  required: false
  type: template
{% endconfiguration %}

```yaml
# Example configuration, with a message template.
homeassistant:
  auth_mfa_modules:
    - type: totp
      name: Authenticator app
    - type: notify
      message: 'I almost forget, to get into my clubhouse, you need to say {}'
```

홈어시스턴트를 다시 시작한 후 [프로필 페이지](/docs/authentication/#your-account-profile)로 이동하여 "다단계 인증 모듈" 섹션이 있어야합니다. _Notify One-Time Password_ 옵션에서 _Enable_ 을 클릭하십시오.

로그아웃한 다음 다시 로그인하십시오. 통지(notify) 서비스에 전송된 6 자리 일회성 비밀번호를 입력하라는 메시지가 표시됩니다. 로그인 비밀번호를 입력하십시오.

유효성 검사에 실패하면 새로운 일회용 암호가 다시 전송됩니다.

<div class='note'>

Notify MFA 모듈은 일회용 암호가 성공적으로 전달되었는지 알 수 없습니다. 알림을 받지 못하면 로그인할 수 없습니다.

`[your_config_dir]/.storage/auth_module.notify` 파일을 편집하거나 제거하여 Notify MFA 모듈을 비활성화할 수 있습니다.

</div>
