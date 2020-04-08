---
title: 인증 제공자(Authentication Providers)
description: "Guide on configuring different auth providers."
redirect_from: /integrations/auth/
---

로그인하면  _auth provider_ 가 자격증명(credentials)을 확인하여 인증된 사용자인지 확인합니다.

<div class='note'>

최근 인증 시스템이 변경되었습니다. 이전에는 로그인할 수 있는 단일 "_API password_"가 있었지만 이제 여러 인증 제공자(auth providers) 중에서 선택할 수 있습니다.<br/> <br/>

API 비밀번호에서 쉽게 전환할 수 있도록 _Legacy API Password_ 인증 제공자(auth provider)를 추가했습니다 . API 비밀번호가 설정되어 있어도 로그인할 수 있는 경우 기본적으로 사용됩니다.

그러나 이 기능은 더 이상 사용되지 않으며 향후 릴리스에서 제거될 예정이므로 최신 인증 기술 중 하나를 설정해야합니다.
</div>

## 인증 제공자 설정 (Configuring auth providers)

<div class='note warning'>

홈어시스턴트는 표준 인증 제공자를 자동으로 설정하므로 둘 이상을 설정하지 않는 한 `configuration.yaml` 파일에 `auth_providers`를 지정할 필요가 없습니다. `auth_providers`를 지정하면 숨겨져있던 모든 인증 공급자가 비활성화되므로 보안이 올바르게 설정되지 않으면 보안이 저하되거나 로그인이 어려워질 수 있습니다.
</div>

인증 제공자는 `homeassistant:` 블록 아래 `configuration.yaml`에서 설정됩니다. 예를 들어, 둘 이상을 제공할 수 있습니다. : 

```yaml
homeassistant:
  auth_providers:
    - type: homeassistant
    - type: legacy_api_password
      api_password: !secret http_password
```

## 사용 가능한 인증 제공자 (Available auth providers)

### 홈어시스턴트 인증제공자 

이는 기본 인증 제공자입니다. 작성된 첫 번째 사용자는 _소유자_ 로 지정되며 다른 사용자를 생성할 수 있습니다.

사용자 세부 사항은 `[your config]/.storage` 디렉토리에 저장됩니다. 모든 암호는 해시된 특별한 값으로 저장되므로 공격자가 파일에 액세스할 수 있는 경우에도 암호를 알아내는 것이 거의 불가능합니다. 

소유자는 Home Assistant에서 사용자를 관리할 수 ​​있습니다. 설정 패널로 이동하여 _사용자_ 를 클릭하십시오.

이는 홈어시스턴트 인증을 위한 `configuration.yaml`의 항목입니다. :

```yaml
homeassistant:
  auth_providers:
    - type: homeassistant
```

`configuration.yaml` 파일에 `auth_providers` 섹션을 지정하지 않으면 이 제공자가 자동으로 설정됩니다.

### 신뢰할 수 있는 네트워크 (Trusted Networks)

Trusted Networks 인증 제공자는 인증이 필요하지 않은 IP 주소 범위를 정의합니다("화이트리스트" 라고도 함). 예를 들어, 집 안에서 홈어시스턴트에 액세스할 때 암호를 입력하라는 메시지가 표시되지 않도록 로컬 네트워크를 허용 목록에 추가할 수 있습니다. 

이러한 네트워크 중 하나에서 로그인하면 사용할 사용자 계정을 묻는 메시지가 표시되며 암호를 입력할 필요가 없습니다.

<div class='note info'>

이 인증 공급자를 사용하는 경우 [다단계 인증 모듈](/docs/authentication/multi-factor-auth/)은 로그인 프로세스에 참여하지 않습니다.

</div>

신뢰할 수있는 네트워크를 설정하는 `configuration.yaml`의 예는 다음과 같습니다. : 

```yaml
homeassistant:
  auth_providers:
    - type: trusted_networks
      trusted_networks:
        - 192.168.0.0/24
        - fd00::/8
```

{% configuration %}
trusted_networks:
  description: A list of IP address or IP network you want to whitelisted. It accepts both IPv4 and IPv6 IP address or network
  required: true
  type: list
trusted_users:
  description: You can also assign which users are available to select when user access login page from certain IP address or network.
  required: false
  type: map
  keys:
    IP_ADDRESS:
      description: List of users available to select on this IP address or network.
      required: false
      type: [list, string]
allow_bypass_login:
  description: You can bypass login page if you have only one user available for selection.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

#### 신뢰할 수 있는 사용자의 사례 (Trusted Users Examples)

```yaml
homeassistant:
  auth_providers:
    - type: trusted_networks
      trusted_networks:
        - 192.168.0.0/24
        - 192.168.10.0/24
        - fd00::/8
      trusted_users:
        192.168.0.1: user1_id
        192.168.0.0/24:
          - user1_id
          - user2_id
        "fd00::/8":
          - user1_id
          - group: system-users
```

첫째, trusted_users 설정의 경우 `user id`를 사용해야합니다. `user id`는 설정 -> 사용자 -> 사용자 자세히 보기를 통해 찾을 수 있습니다. `trusted_users` 설정은 사용자의 존재를 검증하지 않으므로, 올바른 사용자 ID를 직접 입력했는지 확인하십시오.

둘째, IPv6 주소를 가진 신뢰할 수 있는 사용자는 그림과 같이 IPv6 주소를 따옴표로 묶어야합니다.

위의 예에서 사용자가 192.168.0.1에서 홈어시스턴트에 액세스하려고 하면 한 명의 사용자만 선택할 수 있습니다. 192.168.0.38 (192.168.0.0/24 네트워크)에서 액세스할 경우 두 명의 사용자를 사용할 수 있습니다. 192.168.10.0/24 네트워크에서 액세스하는 경우 사용 가능한 모든 사용자(non-system과 활성 사용자) 중에서 선택할 수 있습니다.

특히, `group: GROUP_ID`를 사용하여 특정 `user group`의 모든 사용자가 선택할 수 있도록 할당할 수 있습니다. 그룹과 사용자를 혼합하여 매치할 수 있습니다.

#### 로그인 페이지 건너 뛰기 사례 (Skip Login Page Examples)

이것은 사용자 시스템이 구현되기 전에 약간의 경험을 되찾을 수 있는 기능입니다. 신뢰할 수 있는 네트워크에서 액세스하고 `allow_bypass_login`이 켜져 있고 로그인 양식에서 한 명의 사용자만 선택할 수 있는 경우 기본 페이지로 바로 이동할 수 있습니다.

```yaml
# assuming you have only one non-system user
homeassistant:
  auth_providers:
    - type: trusted_networks
      trusted_networks:
        - 192.168.0.0/24
        - 127.0.0.1
        - ::1
      allow_bypass_login: true
    - type: homeassistant
```

온보딩 프로세스를 통해 생성된 소유자만 있다고 가정하면 다른 사용자는 만들지 않습니다. 내부 네트워크 (192.168.0.0/24) 또는 로컬 호스트 (127.0.0.1)에서 액세스하는 경우 위의 설정 사례를 통해 Home Assistant 기본 페이지에 직접 액세스할 수 있습니다. 로그인 중단 오류가 발생하면 외부 네트워크에서 Home Assistant 인스턴스에 액세스하는 경우 HomeAsssitant 인증 제공자를 사용하여 로그인하도록 변경할 수 있습니다.

### Command Line

Command Line 인증 제공자는 설정 가능한 shell command을 실행하여 사용자 인증을 수행합니다. 두 개의 환경 변수 `username`와 `password`가 명령에 전달됩니다. 명령이 성공적으로 종료되면(종료 코드 0으로) 액세스 권한이 부여됩니다.

이 공급자는 LDAP를 통한 일반 텍스트 데이터베이스에서 RADIUS에 이르기까지 Home Assistant를 임의의 외부 인증 서비스와 연동하는데 사용할 수 있습니다. 예를 들어 LDAP 인증을 위한 호환 스크립트는 [이 스크립트](https://github.com/efficiosoft/ldap-auth-sh)입니다.

설정 사례는 다음과 같습니다.

```yaml
homeassistant:
  auth_providers:
    - type: command_line
      command: /absolute/path/to/command
      # Optionally, define a list of arguments to pass to the command.
      #args: ["--first", "--second"]
      # Uncomment to enable parsing of meta variables (see below).
      #meta: true
```

인증 제공자의 설정에서 `meta: true`가 설정되면 명령이 일부 데이터를 표준 출력에 기록하여 홈어시스턴트에서 작성된 사용자 계정을 추가 데이터로 채울 수 있습니다. 이러한 변수는 다음과 같은 형식으로 인쇄해야합니다. : 

```txt
name = John Doe
```

앞뒤 공백과 `#`로 시작하는 줄은 무시됩니다. 다음과 같은 변수가 지원됩니다. 앞으로 더 추가될 수 있습니다.

* `name`: 프로필에 표시될 사용자의 실제 이름.

Stderr는 전혀 읽히지 않고 홈어시스턴트 프로세스로 전달되므로 상태 메시지 등에 사용할 수 있습니다.

<div class='note'>
앞뒤 공백은 설정된 명령으로 전달되기 전에 사용자 이름에서 제거됩니다. 예를 들어 " hello  "는 "hello"로 다시 작성됩니다.
</div>

<div class='note'>
현재 메타 변수는 특정 사용자가 처음 인증될 때만 존중됩니다. 동일한 사용자에 대한 후속 인증시 이전 값으로 이전에 작성된 사용자 오브젝트가 재사용됩니다.
</div>

### Legacy API password

<div class='note warning'>
이것은 이전 버전과의 호환성을 위한 레거시 기능이며 향후 릴리스에서 제거될 예정입니다. 다른 인증 제공자 중 하나로 이동해야합니다.
</div>

이 인증 제공자를 활성화하면 HTTP 구성 요소에 설정된 API 비밀번호로 인증할 수 있습니다.

```yaml
homeassistant:
  auth_providers:
   - type: legacy_api_password
     api_password: !secret http_password
```

`api_password`는 0.90 릴리스 이후 필수 옵션입니다.

이 인증 제공자를 활성화하면 홈어시스턴트 API에 대해 요청하기 위해 인증 헤더를 사용하여 API 비밀번호를 제공할 수도 있습니다. 이 기능은 향후 장기 액세스 토큰에 맞춰서 제거될 것입니다.

`configuration.yaml` 파일에 `auth_providers` 섹션을 지정하지 않으면 `http` 섹션에서 `api_password`가 설정된 경우 이 제공자가 자동으로 설정됩니다.

<div class='note warning'>

[Issue 16441](https://github.com/home-assistant/home-assistant/issues/16441): API 비밀번호가 패키지에 있는 경우 기존 API 비밀번호 인증 공급자는 자동으로 설정되지 않습니다. 이는 홈어시스턴트가 `packages` 처리보다 빠른 `core` 섹션 로딩중에 `auth_provider`를 처리하기 때문입니다.

</div>
