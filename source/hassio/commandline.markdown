---
title: "Home Assistant 명령어 모드 사용"
description: "Command line utility to control Home Assistant."
---

<p class='img'>
<img src='/images/hassio/screenshots/ssh-upgrade.png'>
SSH로 접속하여 명령어로 Home Assistant로 업그레이드 실행 화면 hassio대신 ha로 바뀌었습니다.<br>
또한 ha homeassistant 명령어는 ha code 로 변경되었습니다.
</p>

SSH로 접속하면 `ha` 명령어로 로그를 보거나 사용중인 하드웨어 정보 등을 살펴볼 수 있습니다.

## Core

```bash
ha core check
ha core info
ha core logs
ha core options
ha core rebuild
ha core restart
ha core start
ha core stats
ha core stop
ha core update
```

## Supervisor

```bash
ha supervisor info
ha supervisor logs
ha supervisor reload
ha supervisor update
```

## Host

```bash
ha host reboot
ha host shutdown
ha host update
```

## Hardware

```bash
ha hardware info
ha hardware audio
```

## 사용 예제

홈어시스턴트를 특정 버전으로 설치하고 싶다면 다음 명령어를 실행하세요:
```bash
ha core update --version=x.y.z
```
x.y.z 를 버전 숫자로 바꾸세요 `--version=0.74.2`

명령어의 상세한 옵션을 알고 싶다면 `ha help`라고 쳐보세요:

```bash
The Home Assistant CLI is a small and simple command line utility that allows
you to control and configure different aspects of Home Assistant

Usage:
  ha [command]

Available Commands:
  addons         Install, update, remove and configure Home Assistant add-ons
  audio          Audio device handling.
  authentication Authentication for Home Assistant users.
  cli            Get information, update or configure the Home Assistant cli backend
  core           Provides control of the Home Assistant Core
  dns            Get information, update or configure the Home Assistant DNS server
  hardware       Provides hardware information about your system
  help           Help about any command
  host           Control the host/system that Home Assistant is running on
  info           Provides a general Home Assistant information overview
  multicast      Get information, update or configure the Home Assistant Multicast
  os             Operating System specific for updating, info and configuration imports
  snapshots      Create, restore and remove snapshot backups
  supervisor     Monitor, control and configure the Home Assistant Supervisor

Flags:
      --api-token string   Home Assistant Supervisor API token
      --config string      Optional config file (default is $HOME/.homeassistant.yaml)
      --endpoint string    Endpoint for Home Assistant Supervisor (default is 'supervisor')
  -h, --help               help for ha
      --log-level string   Log level (defaults to Warn)
      --no-progress        Disable the progress spinner
      --raw-json           Output raw JSON from the API

Use "ha [command] --help" for more information about a command.

```

## 콘솔 연결

Home Assistant Operating System을 설치한 라즈베리파이에 키보드와 모니터를 연결하면 콘솔로 직접 접근이 가능합니다. 로그인 과정에서 username을 `root`로 비밀번호는 입력하지 않습니다. 
