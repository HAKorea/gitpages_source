---
title: "인증"
description: "Guide on authentication in Home Assistant."
redirect_from:
  - /integrations/auth/
---


홈어이스턴트로 로그인하는 인증 과정은 안전한 접근을 보장합니다.
홈어시스턴트를 처음 실행하거나 로그아웃을 한 상태에서 접속하면 로그인 사용자 계정과 비밀번호를 다음과 같이 물어봅니다.

<img src='/images/docs/authentication/login.png' alt='Screenshot of the login screen' style='border: 0;box-shadow: none;'>

## 사용자 계정

홈어시스턴트를 처음 실행하면 _관리자_ 계정을 만들게 됩니다. 이 계정은 특별한 권한을 갖는데:

 - 다른 사용자 계정을 만들거나 관리합니다.
 - 통합구성요소를 설정하고 다른 기기들을 관리합니다.
 - Hass.io를 관리합니다.

<div class='note'>
아직까지는 다른 사용자 계정도 관리자 계정과 동일한 권한을 갖습니다. 향후에는 일반 사용자 계정의 권한은 관리자 권한과 다르게 제한될 것입니다.
</div>

### 사용자 프로필

로그인이 성공하면 왼쪽 사이드바에서 동그란 원안에 표시된 계정의 첫글자를 누르면 자신의 프로필 페이지에 접속해 상세한 내용을 설정할 수 있습니다(현재 버전에서는 왼쪽 하단에 사용자 계정이 나타납니다)

<img src='/images/docs/authentication/profile.png' alt='Screenshot of the profile page' style='border: 0;box-shadow: none;'>

변경 가능한 것들:

* 홈어시스턴트의 언어설정
* 비밀번호 변경
* 홈어시스턴트 웹 화면에서 사용할 [테마](/integrations/frontend/#defining-themes) 변경
* [multi-factor authentication](/docs/authentication/multi-factor-auth/) 설정
* _Refresh Tokens_ 의 삭제. 이것은 홈어시스턴트 앱이나 웹브라우저로 접속할때 저장된 기기의 접속 토큰입니다. 이 토큰을 삭제하면 기기에서 강제로 로그아웃됩니다.
* [Long Lived Access Tokens](https://developers.home-assistant.io/docs/en/auth_api.html#long-lived-access-token)을 생성하여 홈어시스턴트와 안전하게 연결하는 프로그램을 작성/이용할 수 있습니다.
* 홈어시스턴트 로그아웃

### 보안 유의 사항

**비밀번호를 안전하게 생성하세요!** 떄론 집이나 생활 공간이 아닌 다른 장소에서 홈어시스턴트에 접속하는 경우가 생깁니다. 이것은 다른 사람이 여러분의 비밀번호를 훔쳐볼 수 있다는 뜻이기도 합니다. 여러분의 집을 안전하게 보호한다는 생각으로 비밀번호를 만드시기 바랍니다.

보안을 강화하기 위해 [multi-factor authentication](/docs/authentication/multi-factor-auth/)를 사용할 수도 있습니다.

## 다른 인증 기술

홈어시스턴트는 몇가지 인증 방법을 제공합니다. [Auth Providers](/docs/authentication/providers/) 섹션을 참고하세요.

## 문제해결

### `127.0.0.1` 인증 실패

만일 `127.0.0.1` 인증 실패를 보게 된다면 `nmap` 디바이스 트래커를 사용하는 경우입니다. [홈어시스턴트 IP 제외하기](/integrations/nmap_tracker#exclude) 문서를 참고하세요.

### Bearer token 경고

새로운 인증 시스템은 [legacy API password](/docs/authentication/providers/#legacy-api-password)를 설정한 경우 다음과 같은 경고를 보여줍니다.

```txt
WARNING (MainThread) [homeassistant.components.http.auth] You need to use a bearer token to access /blah/blah from 192.0.2.4
```

이 경우 `configuration.yaml`에서 `http:` 설정에  [`api_password`](/integrations/http/#api_password) 항목을 추가해야 합니다.

### Bearer token 안내 메시지

다음과 같은 안내 메시지가 나온다면 통합구성요소 개발자에게 연락하여 홈어시스턴트 인증과 관련해서 업데이트가 필요하다고 알려야 합니다. 일반 사용자에게 해당하는 메시지는 아닙니다:

```txt
INFO (MainThread) [homeassistant.components.http.auth] You need to use a bearer token to access /blah/blah from 192.0.2.4
```

### 비밀번호 분실

패스워드 매니저와 같은 툴을 사용하다가 안타깝게도 비밀번호를 분실했다면 홈어시스턴트를 정지시킨 다음 아래 목록에 나온 파일을 **모두** 삭제해야 비밀번호를 초기화 할 수 있습니다. 이 파일들은 홈어시스턴트의 [기본 설정 디렉토리](/docs/configuration/)에서 `.storage/`폴더 안에 들어있습니다. :

* `auth`
* `auth_provider.homeassistant`
* `onboarding`
* `hassio` (Hass.io 사용자)
* `cloud` (nabucasa 사용자)


파일 삭제후 홈어시스턴트를 재시작하면 새로운 관리자 계정을 처음부터 다시 설정할 수 있습니다.

### 에러: invalid client id or redirect url

<img src='/images/docs/authentication/error-invalid-client-id.png' alt='Screenshot of Error: invalid client id or redirect url'>

IP 주소가 아닌 도메인으로 접속하는 경우  **Error: invalid client id or redirect url** 에러가 로그인 화면에 나타날 수 있습니다. 이 경우 로컬 네트워크 상의 IP 주소로는 접속이 가능합니다.

이런 경우가 발생하는 이유는 IP 주소가 내부 IP(예, `192.168.0.1`)이거나 loopback address(예, `127.0.0.1`) 일때 client ID를 IP 주소로 허용하기 때문입니다.

유효한 도메인명이 아니라면 `hosts` 파일을 편집하면 되는데, 윈도우의 `C:\Windows\System32\Drivers\etc\hosts` 파일이나 리눅스의 `/etc/hosts` 파일에 다음과 같이 추가합니다:

```text
12.34.56.78 homeassistant.home
```

`12.34.56.78`은 여러분의 공인 IP로 바꾸셔야 합니다.

이렇게 하면 `http://homeassistant.home:8123/`로 접속이 가능합니다.

### 데이터로드로 멈춤

Wipr과 같은 일부 광고 차단 소프트웨어가 웹 소켓을 차단합니다. 데이터로드 화면이 멈춘 경우 광고 차단 소프트웨어 사용을 중지 해보십시오.

### 0.77 이전 버전에서 마이그레이션

만일 0.77 이전 버전을 사용하고 있다면  `auth:` 또는 `auth_providers:` 추가돼 있을 것입니다. 이것을 제거하고 홈어시스턴트가 [자동으로 설정하는 방법](/docs/authentication/providers/#configuring-auth-providers)을 참고하세요.
