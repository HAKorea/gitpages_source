---
title: "첫번째 애드온: 무작정 따라해보기"
---

홈어시스턴트에 익숙해지고 빌트인 애드온들을 능숙하게 다루다보면 몇가지 아쉬운 점들이 생깁니다. 이럴땐 직접 애드온을 만들어야겠죠! 해쇼 버전 0.24부터 여러분의 서버에서 로컬 애드온을 만들수 있게 됐습니다. 이것은 각자가 새로운 애드온을 만들어 쓸 수 있는 멋진 기능입니다.

애드온 만들기를 시작하려면 해쇼가 로컬 애드온을 어떻게 발견하는지를 살펴봐야합니다. 이를 위해 삼바 애드온이나 SSH 애드온이 필요합니다.

삼바 애드온을 설치하고 실행했다면 탐색기로 접근할 때 addons 폴더로 접근할 수 있습니다. 이 폴더는 여러분의 애드온들을 저장한 공간입니다.

MacOS 사용자라면 네트워크 폴더가 자동으로 나타나진 않습니다. 파인더에서 `cmd + K`키를 눌러 `smb://hassio.local` 또는 `smb://192.168.1.166`과 유사한 홈어시스턴트의 IP주소로 접근합니다.

![윈도우 탐색기로 홈어시스턴트를 설치한 서버로 연결](/images/hassio/tutorial/samba.png)

SSH 연결을 하려면 애드온 설정에서 private/public 키를 저장해야 합니다. 애드온 설정에 대한 [상세한 설명][ssh]을 참고하세요. SSH 애드온을 실행하면 Putty와 같은 프로그램으로 접속하여 "/addons" 디렉토리로 이동하면 됩니다.

![Putty 프로그램을 이용하여 Hassio에 SSH 연결 화면](/images/hassio/tutorial/ssh.png)

addons 디렉토리에 도착했다면 이제 출발선에 도착한 것입니다!

[ssh]: https://www.home-assistant.io/addons/ssh/

<div class='note'>
addons 디렉토리에는 core, data, git, local이라는 4개의 서브 디렉토리가 존재합니다. core는 홈어시스턴트와 함꼐 배포되는 빌트인 애드온이며 git은 커뮤니티 애드온이나 zigbe2mqtt와 같은 서드파티 애드온을 설치하면 소스코드를 다운받는 곳입니다. data에는 애드온을 설치/실행하면 각 애드온들의 설정 또는 옵션 파일들이 저장됩니다.
이 튜토리얼에서 만드는 애드온은 local 디렉토리에 저장해야 합니다. /addons/local/hello_world/ 가 전체 경로입니다.
</div>

## 1단계 : 준비

 - `hello_world`라는 디렉토리를 만듭니다.
 - 이 디렉토리에 Dockerfile , config.json , run.sh 라는 이름으로 3개의 파일을 아래와 같이 만듭니다.

`Dockerfile`:
```dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
```

`config.json`:
```json
{
  "name": "Hello world",
  "version": "0.1",
  "slug": "hello_world",
  "description": "My first real add-on!",
  "arch": ["armhf", "armv7", "aarch64", "amd64", "i386"],
  "startup": "before",
  "boot": "auto",
  "options": {},
  "schema": {}
}
```

`run.sh`:
```shell
echo Hello world!
```
이들 파일은 모두 텍스트 형식으로 UNIX 스타일의 line breaks (LF)를 사용해야 합니다. Dos/Windows 형식 (CRLF)이면 오류가 발생합니다. 여러분의 텍스트 에디터의 옵션을 참고하세요.

## 2단계: 애드온을 설치하고 테스트하기

이제 보다 흥미로운 단계로 넘어갑니다. 해쇼 패널로 가서 애드온을 설치해보겠습니다.

 - 홈어시스턴트 웹페이지로 접속하세요.
 - Hass.io 패널을 선택합니다.
 - 상단의 ADD-ON STORE를 클릭합니다.

![해쇼 메인 패널](/images/hassio/screenshots/main_panel_addon_store.png)

 - 오른쪽 상단 코너에 있는 리프레시 버튼을 누릅니다.
 - "Local add-ons"이란 리스트가 보이고 좀 전에 만든 애드온이 카드 형태로 나타납니다.

![로컬 애드온 카드](/images/hassio/screenshots/local_repository.png)

 - 애드온 카드를 클릭하여 상세 페이지로 들어갑니다.
 - INSTALL을 눌러 설치합니다.
 - 설치가 완료되면 START 버튼을 누릅니다.
 - 해드온 하단의 logs 섹션에서 REFRESH를 눌러보면 "Hello world!"라고 로그에 출력됩니다.

![애드온 로그 화면](/images/hassio/tutorial/addon_hello_world_logs.png)

### 애드온 카드가 보이지 않아요?!

잘 따라했는데 애드온 카드가 보이지 않거나 애드온이 잘 보이다가 우측 상단의 리프레시 버튼을 눌렀는데 애드온 카드가 사라지는 경우가 있습니다. 또는 설정을 변경했는데 애드온의 option이 바뀌지 않는 경우도 있네요.

이런 문제가 발생한 경우는 거의 대부분 `config.json` 파일에 오류가 있기 때문입니다. 유효한 JSON 형식이 아니거나 설정한 내용이 애드온 옵션 규칙에 어긋나기 때문에 에러가 발생합니다. 무언가 잘못됐다면 Hass.io 패널에서 System log를 살펴보기 바랍니다. 리프레시 버튼을 눌렀을때 문제가 발생하면 이곳 로그에 에러 내용이 출력됩니다. 이것을 잘 살펴보면 무엇이 잘못됐는지를 알 수 있습니다.

<div class='note'>
SSH로 접속한 경우에는 cat config.json | jq '.' 명령으로 JSON의 유효성 테스트를 진행할 수 있습니다. 오류가 발생하면 몇번째 라인이 문제인지 알려줍니다.
</div>

## 3단계: 간단한 서버 생성

hello_world 애드온은 화면에 출력만 하는 맛보기 였습니다. 하지만 무엇이 필요한지 파악할 수 있었지요. 여기서 한걸음 더 나아가 간단한 서버를 만들어 보도록 하겠습니다. 파이썬 3에서 제공하는 http 서버를 애드온으로 만들어 보겠습니다.

앞선 도커 파일을 이렇게 업데이트 합니다:

 - `Dockerfile`: Python 3 설치
 - `config.json`: 연결 가능한 포트 오픈
 - `run.sh`: Python 3 명령으로 http 서버 생성

`Dockerfile` 파일을 다음과 같이 바꿉니다:

```dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Copy data for add-on
COPY run.sh /
# Install requirements for add-on
RUN apk add --no-cache python3
RUN chmod a+x /run.sh

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
WORKDIR /data

CMD [ "/run.sh" ]
```

`config.json`에 ports 옵션을 아래와 같이 추가합니다. 이것은 TCP 포트 8000번을 오픈하는 것으로 호스트 컴퓨터의 8000번 포트를 애드온에서 사용합니다.

```json
{
  "name": "Hello world",
  "version": "0.2",
  "slug": "hello_world",
  "description": "My first real add-on!",
  "arch": ["armhf", "armv7", "aarch64", "amd64", "i386"],
  "startup": "before",
  "boot": "auto",
  "options": {},
  "schema": {},
  "ports": {
    "8000/tcp": 8000
  }
}
```

`run.sh` 파일을 업데이트 합니다. Python 3 으로 서버를 실행합니다:

```shell
python3 -m http.server 8000
```

## 4단계: 업데이트 설치

 `config.json`을 잘 보면 버전이 바뀌었습니다. 0.1에서 0.2로 변경된 버전 표시는 홈어시스턴트가 새로운 버전으로 변경된 것을 알게 만들며, 애드온 상세페이지에서 업데이트가 있음을 알려줍니다. 브라우저를 새로고침 하거나 애드온 스토어의 리프레시 버튼을 누르면 새버전이 있음을 알려줍니다. 버전 넘버가 같은 경우 애드온을 언인스톨 후 인스톨 과정을 진행하세요. 파일 수정 내용이 반영 안되는 경우는 앞에서 이야기한 `config.json`에 문제가 생긴 것입니다.

애드온을 업데이트하고 재실행 한다음 http://hassio.local:8000 주소로 접속하면 파이썬 웹서버가 실행된 것을 알 수 있습니다.

![애드온으로 만들어본 웹서버](/images/hassio/tutorial/python3-http-server.png)

## 보너스: 애드온의 옵션 설정

위에서 웹서버의 스크린샷을 살펴보면 `options.json`라는 하나의 파일이 존재합니다. 이 파일은 애드온 설정파일의 옵션을 저장한 것입니다. 앞에서 `config.json`에 어떤 옵션도 넣지 않았으므로 현재 이 `options.json`파일은 빈 파일입니다.

이 파일에 데이터가 저장되도록 만들어 봅시다. 그렇게 하기 위해서는 options과 schema를 설정해야 합니다.

`config.json` 파일에 아래와 같은 내용을 추가합니다:

```json
{
  …

  "options": {
    "beer": true,
    "wine": true,
    "liquor": false,
    "name": "world",
    "year": 2017
  },
  "schema": {
    "beer": "bool",
    "wine": "bool",
    "liquor": "bool",
    "name": "str",
    "year": "int"
  },

  …
}
```

새로운 config.json을 스토어에 반영하기 위해 애드온 스토어에서 리프레시 버튼을 누르고 애드온을 재설치 합니다. 파이썬 웹서버가 실행되고 `options.json` 파일을 다운 받으면 앞서 텅빈 파일이었던 `options.json` 파일에는 config.json에서 입력한 options 부분이 저장돼있습니다. 이러한 옵션 내용은 애드온 내부에서 필요에 의해 사용할 수 있습니다. mqtt 서버에서 어떻게 [options.json 를 이용하여 `run.sh`를 실행 시키는지](https://github.com/home-assistant/hassio-addons/blob/master/mosquitto/data/run.sh#L4-L5) 참고해보세요.

<div class='note'>
로컬에서 애드온을 제작할때 config.json을 자주 변경하게 됩니다. 하지만 변경 사항이 자동으로 해쇼 스토어에 적용되지 않습니다. 애드온 스토어 우측 상단에 있는 리프레시를 눌러야 비로소 변경 내용을 반영하는데 이것은 해쇼 내부에 애드온 파일을 보관하고 있고 일정시간마다 새로운 내용을 체크하기 때문입니다. 따라서 개발 도중 수정했을때는 꼭 리프레시 버튼을 눌러주세요!
</div>

### [다음 과정: 애드온 설정 &raquo;][next-step]

[next-step]: /hassio/hassio_addon_config/
