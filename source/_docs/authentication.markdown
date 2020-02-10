---
title: "인증"
description: "Guide on authentication in Home Assistant."
redirect_from:
  - /integrations/auth/
---

인증 시스템은 Home Assistant에 대한 접속을 보호합니다.

홈어시스턴를 처음 시작하거나 로그 아웃 한 경우 로그인하기 전에 자격 증명을 묻는 메시지가 나타납니다.

<img src='/images/docs/authentication/login.png' alt='Screenshot of the login screen' style='border: 0;box-shadow: none;'>

## 사용자 계정

홈어시스턴트를 처음 시작하면 _소유자 전용 계정_ 이 생성됩니다. 이 계정에는 몇 가지 특별한 권한이 있으며 다음을 수행 할 수 있습니다. :

 - 다른 사용자 계정을 만들고 관리합니다. 
 - 통합구성요소 및 기타 세팅을 설정합니다. (coming soon).
 - Hass.io를 설정합니다. (coming soon).

<div class='note'>
현재 다른 사용자 계정은 소유자 계정과 동일한 액세스 권한을 갖습니다. 향후 비 소유자 계정에는 제한이 적용될 수 있습니다.
</div>

### 당신의 계정 프로필

로그인 하면 사이드 바의 홈 어시스턴트 제목 옆에있는 원형 배지를 클릭하여 _profile_ 페이지 에서 계정 세부 정보를 볼 수 있습니다

<img src='/images/docs/authentication/profile.png' alt='Screenshot of the profile page' style='border: 0;box-shadow: none;'>

당신이 할 수 있는 것들 :

* 홈어시스턴트에서 선호하는 언어를 변경.
* 비밀번호 변경. 
* 홈어시스턴트 인터페이스의 [theme](/integrations/frontend/#defining-themes) 선택.
* [multi-factor authentication](/docs/authentication/multi-factor-auth/) 활성화 혹은 비활성화.
* _Refresh Tokens_ 삭제. 장치에서 로그인 할 때 생성됩니다. 장치를 강제로 로그 아웃하려면 삭제.
* 스크립트가 홈어시스턴트와 안전하게 상호 작용할 수 있도록 [Long Lived Access Tokens](https://developers.home-assistant.io/docs/en/auth_api.html#long-lived-access-token)를 만듬. 
* 홈어시스턴트에서 로그 아웃. 

### 로그인 보안

_미래를 위해 안전한 비밀번호를 선택하십시오 !_ 나중에 언젠가는 로컬 네트워크 외부에서 홈어시스턴트에 접근하려고 할 것입니다. 즉, 동일한 작업을 시도하는 임의의 해커들에게도 노출됩니다. 집 열쇠와 같은 비밀번호를 사용하십시오. 

추가 보안 수준으로, [multi-factor authentication](/docs/authentication/multi-factor-auth/)을 켤 수 있습니다. 

## 다른 인증 기술

홈어시스턴트는 여러 가지 인증 방법을 제공합니다.  [Auth Providers](/docs/authentication/providers/) 를 참조하세요. 

## 문제 해결

### `127.0.0.1` 에서의 인증 실패

만일에 `127.0.0.1`에서 인증에 하고, `nmap` 장치 추적기를 사용하는 경우, [홈어이스턴트 IP를 제외](/integrations/nmap_tracker#exclude) 하고 IP를 검사해야 합니다.

### Bearer 토큰 경고

새 인증 시스템에서 [legacy API password](/docs/authentication/providers/#legacy-api-password)가 제공되었지만 홈어시스턴트에는 구성되지 않은 경우 다음 경고가 로그에 나타납니다. :

```txt
WARNING (MainThread) [homeassistant.components.http.auth] You need to use a bearer token to access /blah/blah from 192.0.2.4
```

이 메시지가 표시되면 `http:` 설정에 [`api_password`](/integrations/http/#api_password) 를 추가해야합니다.

### Bearer 토큰 정보 메시지

다음이 표시되면 개발자(관리자)에게 홈어시스턴트 인증 방법을 업데이트해야한다는 메시지입니다. 사용자는 어떤것도 할 필요가 없습니다. :

```txt
INFO (MainThread) [homeassistant.components.http.auth] You need to use a bearer token to access /blah/blah from 192.0.2.4
```

### 소유자 비밀번호 분실

비밀번호 메니저로 비밀번호를 저장해야하지만, 소유자 계정과 연관된 비밀번호를 잊어 버린 경우이를 해결하는 유일한 방법은 *모든* 인증 데이터 를 삭제 하는 것입니다. 
홈어시스턴트를 종료하고 [configuration folder](/docs/configuration/) 에서 다음 파일을 삭제하면 됩니다. 

* `auth`
* `auth_provider.homeassistant`
* `onboarding`
* `hassio` (Hass.io 사용자)
* `cloud` (nabucasa 사용자)

홈어시스턴트를 다시 시작하면 인증을 다시 설정해야합니다.

### 에러: 잘못된 클라이언트 ID 또는 리디렉션 URL

<img src='/images/docs/authentication/error-invalid-client-id.png' alt='Screenshot of Error: invalid client id or redirect url'>

홈 어시스턴트에 원격 액세스하려면 IP 주소가 아닌 도메인 이름을 사용해야합니다, 그렇지 않으면 로그인 양식에 **Error: invalid client id 또는 redirect url** 오류가 표시됩니다. 그러나 IP 주소를 사용하여 홈 네트워크의 Home Assistant에 액세스 할 수 있습니다.

IP 주소가 내부 네트워크 주소 (예: `192.168.0.1`) 또는 루프백 주소 (예 :`127.0.0.1`) 인 경우 IP 주소를 클라이언트 ID로만 허용하기 때문입니다.  

홈어시스턴트 인스턴스에 유효한 도메인 이름이 없으면, 컴퓨터 에서 `hosts` 파일을 수정하여 파일을 페이크로 만들 수 있습니다. Windows에서 관리자권한으로 `C:\Windows\System32\Drivers\etc\hosts` 파일을 편집하거나 리눅스에서는 `/etc/hosts`를 편집하고 다음 항목을 추가하십시오. 

```text
12.34.56.78 homeassistant.home
```

`12.34.56.78` 홈 어시스턴트의 Public IP 주소로 변경하십시오.

그러면 홈 어시스턴트를 `http://homeassistant.home:8123/`에서 열 수 있습니다. 

### 데이터로드로 멈춤

Wipr과 같은 일부 광고 차단 소프트웨어가 웹 소켓을 차단합니다. 데이터로드 화면이 멈춘 경우 광고 차단기를 사용 중지 해보십시오.

### 0.77 이전에서 마이그레이션

당신이 0.77 전에 인증 시스템을 사용한다면, 지정한 `auth:` 와 `auth_providers:`를 갖고있을 것입니다. 이들을 제거하고 홈 어시스턴트가 [자동으로 처리](/docs/authentication/providers/#configuring-auth-providers)하도록 해야합니다.
