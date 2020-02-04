---
title: "Add-On Configuration"
---

각각의 애드온 폴더에는 일반적으로 다음과 같은 파일들이 들어있습니다:

```text
addon_name/
  apparmor.txt
  build.json
  CHANGELOG.md
  config.json
  Dockerfile
  icon.png
  logo.png
  README.md
  run.sh
```

## 애드온 스크립트

모든 도커 컨테이너는 컨테이너를 시작할때 실행되는 스크립트가 존재합니다. 사용자가 다수의 애드온을 운영한다면 모든 일을 간단하게 처리하기 위해 Bash 스크립트를 사용하게 됩니다.

HA가 제공하는 모든 도커 이미지에는 기본적으로 [bashio][bashio]가 들어있습니다. bashio는 애드온을 개발하는데 있어 편리한 기능과 코드의 중복을 줄이기 위해 사용하는 공통의 기능들을 미리 제작해 둔 스크립트입니다.

만일 직접 스크립트를 짠다면:

 - `/data` 폴더를 저장 공간으로 삼고
 - `/data/options.json` 파일이 애드온의 설정옵션을 담고 있어서 bashio를 활용하여 처리하거나 `jq` 명령어로 데이터처리를 위한 쉘 스크립트를 만들면됩니다.

 `options`에는 다음과 같은 설정이 있다고 가정하고:
 ```json
 { "target": "beer" }
 ```
 쉘 스크립트를 아래와 같이 만들면:
```shell
CONFIG_PATH=/data/options.json

TARGET="$(jq --raw-output '.target' $CONFIG_PATH)"
```

`TARGET`에는 `beer` 가 저장되어 이후 bash 스크립트로 사용할 수 있게 됩니다.

[bashio]: https://github.com/hassio-addons/bashio

## 애드온 도커파일

모든 애드온은 알파인 리눅스 최신 버전을 기초로 만듭니다. Hass.io는 컴퓨터(machine architecture)에 따라 적당한 알파인 리눅스의 베이스 이미지를 사용합니다. 타임존의 경우 필요에 따라 `tzdata`를 설정할 수도 있으며 HA가 제공하는 베이스 이미지에는 타임존에 따라 미리 설정되어있습니다.

```dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Install requirements for add-on
RUN apk add --no-cache jq

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
```

만일 Hass.io가 설치된 기기에서 빌드를 하지 않거나 제공된 빌드 스크립트를 사용하지 않는다면(다른 컴퓨터에서 애드온을 만든다면), Dockerfile 안에는 다음과 같은 레이블을 포함시켜야 합니다:
```
LABEL io.hass.version="VERSION" io.hass.type="addon" io.hass.arch="armhf|aarch64|i386|amd64"
```

 `build.json` 파일을 통해 직접 베이스 이미지를 사용할 수도 있고 다양한 아키텍쳐에 대한 지원이 필요없다면 토커파일의 `FROM`에 베이스 이미지에 대한 명칭을 바로 적용할 수도 있습니다.

### Build Args

다음과 같은 도커의 빌드 아규먼트를 사용할 수 있습니다:

| ARG | Description |
|-----|-------------|
| BUILD_FROM | 컴퓨터 시스템에 따라서 동적으로 베이스 이미지를 할당합니.
| BUILD_VERSION | 버전명 (`config.json` 파일에 명시된 버전).
| BUILD_ARCH | 현재 빌드하는 컴퓨터 시스템의 아키텍쳐명.

## 애드온 설정파일

애드온에 대한 도커 설정은 `config.json`파일에 기록합니다.

<div class='note'>
괄호 쌍의 매칭과 컴마( , )의 위치(중괄호를 닫기 전 "}" 앞에는 컴마가 없음) 그리고 오타에 주의하세요.
</div>

```json
{
  "name": "xy",
  "version": "1.2",
  "slug": "folder",
  "description": "long description",
  "arch": ["amd64"],
  "url": "website with more information about add-on (ie a forum thread for support)",
  "startup": "application",
  "boot": "auto",
  "ports": {
    "123/tcp": 123
  },
  "map": ["config:rw", "ssl"],
  "options": {},
  "schema": {},
  "image": "repo/{arch}-my-custom-addon"
}
```

| Key | Type | Required | Description |
| --- | ---- | -------- | ----------- |
| name | string | yes | 애드온 명칭
| version | string | yes | 애드온 버전 번호
| slug | string | yes | 애드온 저장 디렉토리명(소문자만 허용)
| description | string | yes | 애드온에 대한 상세 설명
| arch | list | yes | 지원하는 아키텍쳐 리스트: `armhf`, `armv7`, `aarch64`, `amd64`, `i386`.
| machine | list | no | Default it support any machine type. You can select that this add-on run only on specific machines.
| url | url | no | 애드온의 웹사이트 주소. 애드온에 대한 설명과 옵션에 대한 설명 등을 기술한 홈페이지
| startup | string | yes | `initialize`은 Hass.io가 시작되기 전에 실행, `system` 은 데이터베이스와 같이 다른 프로그램과 독립적으로 동작, `services`는 홈어이스턴트가 시작되기 전에 실행, `application`은 홈어이스턴트가 시작된 이후에 실행, `once`는 데몬이 아닌 한번만 실행
| webui | string | no | 애드온이 내부 웹페이지를 갖고 있을때 접근할 주소. `http://[HOST]:[PORT:2839]/dashboard`와 같이 설정하는데 포트는 내부 포트로 이후 유효한 포트로 변경됩니다. proto라는 명칭으로 프로토콜 옵션을 config 파일에 설정할 수도 있습니다: `[PROTO:option_name]://[HOST]:[PORT:2839]/dashboard` 이 설정에 따라 해당 프로토콜을 연결하거나 `https`로 연결합니다.
| boot | string | yes | 시스템에서 자동 실행이면 `auto`, 사용자가 수동으로 실행하면 `manual`
| ports | dict | no | 애드온 컨테이터가 외부로 연결되는 포트 설정. `"container-port/type": host-port`와 형식. 포트를 `null`로 설정하면 외부 연결 없음
| ports_description | dict | no | 네트워크 포트에 대한 상세 설명 형식은 `"container-port/type": "description of this port"`
| host_network | bool | no | 이 설정을 true로 하면 애드온은 호스트 네트워크를 사용
| host_ipc | bool | no | 기본값은 false. IPC namespace 공유하는 옵션
| host_dbus | bool | no | 기본값은 false. 호스트의 dbus service를 애드온에 매핑
| host_pid | bool | no | 기본값은 false. 애드온 컨테이너가 호스트의 PID 네임스페이스를 사용하도록 허용. Work only for not protected add-ons.
| devices | list | no | 디바이스 리스트를 애드온에 매핑. 형식은  `<path_on_host>:<path_in_container>:<cgroup_permissions>`와 같다. 사용예: `/dev/ttyAMA0:/dev/ttyAMA0:rwm`
| udev | bool | no | 기본값은 false. Set this True, if your container runs a udev process of its own.
| auto_uart | bool | no | 기본값은 false. 호스트의 UART/Serial 디바이스를 애드온에서 사용할 수 있게 허용
| homeassistant | string | no | 애드온이 동작하는 홈어시스턴트 최소 버전을 표기. `0.91.2`와 같은 버전 표기 문자열
| hassio_role | str | no | 기본값은 `default`. Hass.io API에 대한 접근 역할을 표기. 가능한 역할: `default`, `homeassistant`, `backup`, `manager`, `admin`.
| hassio_api | bool | no | true로 설정하면 Hass.io REST API에 대한 접근을 허용. 호스트 명칭은 `hassio`. `http://hassio/api`.
| homeassistant_api | bool | no | true로 설정하면  Home-Assistant REST API에 접근을 허용. `http://hassio/homeassistant/api`로 호출
| docker_api | bool | no | 애드온이 도커API에 대해 읽기 권한으로 접속 가능. Work only for not protected add-ons.
| privileged | list | no | 하드웨어나 시스템에 대한 접근을 허용. `NET_ADMIN`, `SYS_ADMIN`, `SYS_RAWIO`, `SYS_TIME`, `SYS_NICE`, `SYS_RESOURCE`, `SYS_PTRACE`, `SYS_MODULE`, `DAC_READ_SEARCH` 가능.
| full_access | bool | no | 도커의 privileged run 옵션과 동일하게 하드웨어에 대해 모든 접근 권한을 가짐. Work only for not protected add-ons.
| apparmor | bool/string | no | Enable or disable AppArmor support. If it is enable, you can also use custom profiles with the name of the profile.
| map | list | no | Hass.io의 기본 폴더들에 대한 접근을 허용.  `config`, `ssl`, `addons`, `backup`, `share` 폴더를 허용할 수 있으며 기본값은 읽기 전용인 `ro`이고 `:rw`를 붙여 읽기/쓰기로 설정 가능
| environment | dict | no | A dict of environment variable to run add-on.
| audio | bool | no | 애드온이 내장 오디오 사용여부를 설정. The ALSA configuration for this add-on will be mount automatic.
| gpio | bool | no | true로 설정하면 커널의 GPIO 인터페이스가 애드온의 `/sys/class/gpio` 매핑되어 사용 가능. Some library need also `/dev/mem` and `SYS_RAWIO` for read/write access to this device. On system with AppArmor enabled, you need disable AppArmor or better for security, provide you own profile for the add-on.
| devicetree | bool | no | Boolean. If this is set to True, `/device-tree` will map into add-on.
| kernel_modules | bool | no | Map host kernel modules and config into add-on (readonly).
| stdin | bool | no | Boolean. If that is enable, you can use the STDIN with Hass.io API.
| legacy | bool | no | Boolean. If the docker image have no hass.io labels, you can enable the legacy mode to use the config data.
| options | dict | yes | 애드온의 옵션 값들을 설정
| schema | dict | yes | 옵션의 값을 검사하는 스키마를 설정. It can be `False` to disable schema validation and use custom options.
| image | string | no | For use with Docker Hub and other container registries.
| timeout | integer | no | Default 10 (second). The timeout to wait until the docker is done or will be killed.
| tmpfs | string | no | Mount a tmpfs file system in `/tmpfs`. Valide format for this option is : `size=XXXu,uid=N,rw`. Size is mandatory, valid units (`u`) are `k`, `m` and `g` and `XXX` has to be replaced by a number. `uid=N` (with `N` the uid number) and `rw` are optional.
| discovery | list | no | A list of services they this Add-on allow to provide for Home Assistant. Currently supported: `mqtt`
| services | list | no | A list of services they will be provided or consumed with this Add-on. Format is `service`:`function` and functions are: `provide` (this add-on can provide this service), `want` (this add-on can use this service) or `need` (this add-on need this service to work correctly).
| auth_api | bool | no | Allow access to Home Assistent user backend.
| ingress | bool | no | 애드온의 인그레스 기능을 사용 가능하게 설정
| ingress_port | integer | no | 기본 포트는 `8099`. For Add-ons they run on host network, you can use `0` and read the port later on API.
| ingress_entry | string | no | 기본 실행 URL은 `/`. 실행 URL을 설정
| panel_icon | string | no | 패널에 나타나는 기본 아이콘은 mdi:puzzle. MDI icon for the menu panel integration.
| panel_title | string | no | 기본은 애드온 명칭을 사용
| panel_admin | bool | no | Default True. Make menu entry only available with admin privileged.
| snapshot_exclude | list | no | List of file/path with glob support they are excluded from snapshots.


### Options / Schema

`config.json`파일의 `options`은 애드온 안에서 `/data/options.json` 파일에 저장됩니다. 애드온을 실행하기전 사용자가 값을 입력해야 하고 기본값은 `null`로 초기화됩니다. nested arrays나 딕셔너리는 2단계까지만 허용됩니다. 옵션을  필수값이 아닌 것으로 설정할때는 스키마에서 데이터 형식 끝에 `?`를 표시합니다. 물음표가 없는 스키마의 옵션 값은 필수로 지정해야 하며 데이터 형식이 일치해야 합니다.

```json
{
  "message": "custom things",
  "logins": [
    { "username": "beer", "password": "123456" },
    { "username": "cheep", "password": "654321" }
  ],
  "random": ["haha", "hihi", "huhu", "hghg"],
  "link": "http://example.com/",
  "size": 15,
  "count": 1.2
}
```

`options`의 `schema`는 아래와 같으며 사용자가 설정한 값이 유효한지 여부를 체크합니다:

```json
{
  "message": "str",
  "logins": [
    { "username": "str", "password": "str" }
  ],
  "random": ["match(^\w*$)"],
  "link": "url",
  "size": "int(5,20)",
  "count": "float",
  "not_need": "str?"
}
```

스키마에 설정 가능한 데이터 형식:
- str / str(min,) / str(,max) / str(min,max)
- bool
- int / int(min,) / int(,max) / int(min,max)
- float / float(min,) / float(,max) / float(min,max)
- email
- url
- port
- match(REGEX)
- list(val1|val2|...)

## Add-on extended build

애드온의 추가적인 빌드옵션은 `build.json` 파일에 설정합니다. 이 파일은 해쇼의 빌드 시스템이 확인하고 빌드시 사용합니다. 제공하는 기본 이미지가 아닌 다른 베이스 이미지를 사용한다면 아래와 같이 설정하세요.

```json
{
  "build_from": {
    "armhf": "mycustom/base-image:latest"
  },
  "squash": false,
  "args": {
    "my_build_arg": "xy"
  }
}
```

| Key | Required | Description |
| --- | -------- | ----------- |
| build_from | no | A dictionary with the hardware architecture as the key and the base Docker image as value.
| squash | no | Default `False`. Be carfully with this option, you can not use the image for caching stuff after that!
| args | no | Allow to set additional Docker build arguments as a dictionary.

해쇼가 제공하는 [베이스 이미지][hassio-base]는 다양한 기능을 포함하고 있으며, 만일 다른 알파인 리눅스 버전을 쓰고 싶거나 특정 이미지를 사용하려면 `build_from` 옵션에 명시적으로 작성하면 됩니다.

[hassio-base]: https://github.com/home-assistant/hassio-base

### [다음 과정: 통신 방법 &raquo;][next-step]

[next-step]: /hassio/hassio_addon_communication/
