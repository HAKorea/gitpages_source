---
title: "Configurator"
description: "Instructions on how to install and use the Configurator"
redirect_from: /ecosystem/hass-configurator/
---

### 홈어시스턴트 Configuration UI

현재 홈어시스턴트가 프론트 엔드를 통해 사용하는 YAML 파일을 편집할 수있는 좋은 방법이 없기 때문에 여기에는 설정을 보다 쉽게 ​​해주는 작은 웹앱이 있습니다. 홈어시스턴트의 설정 파일에 사용되는 포맷인 YAML에 대한 문법 강조 표시가 있는 사용자 정의이며 시스템에 내장된 [Ace editor](https://ace.c9.io/) 입니다. 편집하려는 파일을 선택할 수있는 통합 파일 브라우저도 있습니다. 파일 편집을 마치면 저장 버튼을 클릭하기 만하면 변경 사항이 적용됩니다. 이것은 본질적으로 SSH, Windows + SMB, Github 등을 통해 설정을 수정하는 브라우저 기반의 대체 방법입니다.

<p class='img'>
<img src='/images/hassio/screenshots/addon-hass-configurator.png'>
Screenshot of the Configurator.
</p>

### 기능 목록

- 파일을 수정하는 웹 기반 편집기
- 파일 업로드 및 다운로드
- Git 연동
- 사용 가능한 트리거, 이벤트, 엔티티, 조건 및 서비스 목록 선택된 요소는 마지막 커서 위치에서 편집기에 삽입됩니다.
- 유효한 설정을 확인하고 버튼을 클릭하여 홈어시스턴트를 직접 다시 시작하십시오.
- SSL 지원
- 추가 보안을 위한 선택적 인증 및 IP 필터링
- 홈어시스턴트 문서 및 아이콘에 대한 직접 링크
- 쉘 명령 실행
- 홈어시스턴트가 실행할 수있는 거의 모든 컴퓨터에서 실행

<div class='note warning'>
이 도구를 사용하면 파일 시스템을 탐색하고 파일을 수정할 수 있습니다. 따라서 어떤 파일을 편집하는지 주의하십시오. 그렇지 않으면 시스템의 중요한 부분이 손상 될 수 있습니다.
가능한 손상을 제한하기 위해 제한된 권한을 가진 사용자로 configurator를 실행하십시오.
</div>

### 설치 (Linux, macOS)
표준 라이브러리의 일부가 아닌 Python 모듈에 대한 종속성은 없습니다. 모든 환상적인 JavaScript 라이브러리는 CDN에서로드됩니다 (오프라인 상태에서는 작동하지 않습니다).
- [configurator.py](https://github.com/danielperna84/hass-configurator/blob/master/configurator.py)를 홈어시스턴트 설정 디렉토리 (예 :`/home/homeassistant/.homeassistant`): `wget https://raw.githubusercontent.com/danielperna84/hass-configurator/master/configurator.py`에 복사 하십시오
- 실행파일로 변경 : `sudo chmod 755 configurator.py`
- (선택 사항) 시스템에 [GitPython](https://gitpython.readthedocs.io/) 이 설치된 경우 configurator.py 파일의 `GIT` 변수를  True로 설정 하십시오. Git 연동을 사용하려는 경우에 필요합니다. 
- 실행하십시오. : `sudo ./configurator.py`
- 프로세스를 종료하려면 `CTRL+C`를 한두 번 정도 수행하십시오.

### 설정 
`configurator.py` 파일 상단 쪽에 configurator를 사용자 정의하기 위해 변경할 수있는 일부 전역 변수가 있습니다. _문자열_ 유형의 변수를 설정할 때 문자열은 따옴표 안에 있어야합니다. 기본 설정은 configurator를 빠르게 체크 아웃하는 데 적합합니다. 보다 사용자 정의 된 설정의 경우 일부 설정을 변경하는 것이 좋습니다.  
업데이트를 통해 설정을 유지하려면 설정을 외부 파일에 저장할 수도 있습니다. 이 경우 원하는 위치에 [settings.conf](https://github.com/danielperna84/hass-configurator/blob/master/settings.conf)를 복사 하고 configurator를 시작할 때 파일의 전체 경로를 명령에 추가하십시오. 예: `sudo .configurator.py /home/homeassistant/.homeassistant/mysettings.conf`. 이 파일은 JSON 형식이므로 문법에 맞는지 확인하십시오 (설정의 문법 강조 표시를 위해 편집기를 JSON으로 설정할 수 있음). .py 파일의 세팅하는데 가장 큰 차이는 `None`이 `null` 되는 점입니다. 

#### LISTENIP (string)
서비스가 수신중인 IP. 기본적으로 0.0.0.0, 시스템의 모든 인터페이스에 바인딩됩니다 .
#### LISTENPORT (integer)
서비스가 수신하는 포트입니다. 기본적으로 `3218`을 사용하지만, 필요한 경우이를 변경할 수 있습니다.
#### BASEPATH (string)
configurator.py를 다른 곳에 배치 할 수 있습니다. `BASEPATH`를 `"/home/homeassistant/.homeassistant"`같은 곳으로 세팅하면, 어디에서 실행하든 해당 경로에서 파일을 읽어옵니다. systemd를 사용하여 configurator를 실행하거나 configurator를 데몬화하는 다른 방법을 사용하려는 경우에 필요합니다.
#### SSL_CERTIFICATE / SSL_KEY (string)
SSL을 사용하는 경우 여기에서 SSL 파일의 경로를 설정하십시오.  이는 홈어시스턴트에서 수행 할 수있는 SSL 설정과 유사합니다.
#### HASS_API (string)
configurator는 실행중인 홈어시스턴트 인스턴스에서 일부 데이터를 가져옵니다. API를 사용할 수 없는 경우이 변수를 수정하여 문제를 해결하십시오. 
#### HASS_API_PASSWORD (string)
다시 시작 버튼을 사용하려는 경우 API 비밀번호를 설정해야합니다. 인증없이 홈어시스턴트의 재시작 서비스를 호출하는 것은 금지되어 있습니다.
#### 자격증명(CREDENTIALS (string))
configurator에 액세스하기 위해 인증이 필요한 경우 `"username:password"` 양식으로 자격증명(CREDENTIAL) 정보를 설정하십시오.
#### ALLOWED_NETWORKS (list)
허용된 IP 주소 / 네트워크를 목록에 추가하여 configurator에 대한 액세스를 제한합니다. 예: `ALLOWED_NETWORKS = ["192.168.0.0/24", "172.16.47.23"]`
#### BANNED_IPS (list)
정적으로 금지된 IP 주소 목록. 예: `BANNED_IPS = ["1.1.1.1", "2.2.2.2"]`
#### BANLIMIT (integer)
`n`회 로그인 시도 실패 후 해당 IP 차단. 차단을 재설정하려면 서비스를 다시 시작하십시오. 기본값 0 은 이 기능 을 비활성화합니다.  이것이 작동하려면 `CREDENTIALS`을 설정해야합니다.
#### IGNORE_PATTERN (list)
특정 파일 및 폴더를 UI에서 무시합니다. 예: `IGNORE_PATTERN = [".*", "*.log", "__pycache__"]`
#### DIRSFIRST (bool)
`True`로 설정되면, 파일 브라우저 상단에 디렉토리가 표시됩니다.
#### GIT (bool)
 Git 연동을 사용 하려면이 `True` 변수를 설정하십시오. 이 기능을 사용하려면 configurator를 실행중인 시스템에 [GitPython](https://gitpython.readthedocs.io) 을 설치해야합니다. 기술적 인 이유로 이 기능은 정적 설정 파일로 활성화 할 수 없습니다.  

__`ALLOWED_NETWORKS`, `BANNED_IPS` 그리고 `BANLIMIT`에 대한 참고사항__:
구현되는 방식은 다음 순서로 작동합니다 :

1. (`CREDENTIALS`이 설정된 경우에만) 자격 증명 확인
  - fail: 420 에러가 반환되고 나서, `BANLIMIT` 숫자만큼 재시도 (브라우저의 개인 탭과 같이 인증 헤더를 설정하지 않고 다시 시도하지 않는 한)
  - success: 계속.. 
2.  `BANNED_IPS`에 클라이언트 IP 주소가 있는지 확인 
  - Yes: 420 에러 반환
  - No: 계속.. 
3. `ALLOWED_NETWORKS`에 클라이언트 IP 주소가 있는지 확인
  - Yes: 계속... 그리고 configurator UI 표시
  - No: 420 에러 반환

### 홈어시스턴트에 임베드
홈어시스턴트에는 [panel_iframe](/integrations/panel_iframe/) component가 있습니다. 이를통해 configuration를 홈어시스턴트에 직접 내장 할 수 있으므로 홈어시스턴트 프론트 엔드를 통해 설정을 수정할 수 있습니다. 설정 예는 다음과 같습니다.

```yaml
panel_iframe:
  configurator:
    title: Configurator
    icon: mdi:wrench
    url: http://123.123.132.132:3218
```

<div class='note warning'>
홈 어시스턴트에 임베드하는 동안 Configurator로 포트 전달을 설정할 때 주의하십시오. 클라이언트 IP 주소를 기반으로 인증 혹은 차단을 설정하여 액세스를 제한하지 않으면 설정이 인터넷에 노출됩니다!
</div>

### 데몬화 / configurator 실행 유지
configurator 스크립트 자체는 서비스가 아니므로, 실행을 유지하려면 몇 가지 추가 단계를 수행해야합니다. 다음은 다섯 가지 옵션 (Linux 용)이지만 사용 사례에 따라 더 있습니다.

1. 다음 명령을 사용하여 프로세스를 백그라운드로 포크하십시오.:
`nohup sudo ./configurator.py &`
2. 시스템에서 systemd를 사용하는 경우 (일반적으로 Raspberry Pi에서 찾을 수 있음), 사용할 수있는 [template file](https://github.com/danielperna84/hass-configurator/blob/master/hass-configurator.systemd)이 있고 [Home Assistant documentation](/docs/autostart/systemd/)에 언급 된 것과 동일한 프로세스를 적용하여 연동 할 수 있습니다. 이 방법을 사용한다면 환경에 따라`BASEPATH` 변수를 설정해야합니다.
3. 시스템에서 [supervisor](http://supervisord.org/)를 실행중인 경우, [hass-poc-configurator.supervisor](https://github.com/danielperna84/hass-configurator/blob/master/hass-configurator.supervisor)는 configurator를 제어하는 ​​데 사용할 수있는 설정 예가 있습니다.
4. TMUX라는 도구가 미리 설치되어 있어야합니다, [HASSbian](/docs/installation/hassbian/)은 사전 설치되야합니다.
5. [screen](http://ss64.com/bash/screen.html)이라는 도구 (tmux와 대체). 시스템에 아직 설치되어 있지 않은 경우 설치 `sudo apt-get install screen` 하거나 `sudo yum install screen`으로 가져올 수 있습니다. 설치되면 `screen`를 실행하여 스크린 세션을 시작하십시오. 그런 다음 홈어시스턴트 디렉토리로 이동하여 위에서 설명한대로 configurator를 시작하십시오. `CTRL+A`을 눌러 화면 세션을 백그라운드로 들어가고 `CTRL+D`를 누릅니다. 이제 SSH 세션에서 연결을 끊는 것이 안전합니다. 스크린 세션을 재개하려면 컴퓨터에 로그인하고 `screen -r`을 실행하십시오 . 

### 문제 해결, 문제 기타 
configurator를 설정하는 데 어려움이 있거나 가능한 버그를 발견 한 경우 configurator repository 의 [Issues](https://github.com/danielperna84/hass-configurator/issues)로 이동하십시오. 또한 홈어시스턴트 커뮤니티 에는 일반적인 문제에 대해 이미 논의한 스레드 가 있습니다. 그렇지 않은 경우라도 솔루션을 찾는 데 도움을주는 친절한 사람들이 항상 있습니다.