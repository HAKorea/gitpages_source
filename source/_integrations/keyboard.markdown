---
title: 키보드(Keyboard)
description: Instructions on how to simulate key presses with Home Assistant.
logo: keyboard.png
ha_category:
  - Automation
ha_release: pre 0.7
---

`keyboard` 통합구성요소는 호스트 시스템의 키 누름을 시뮬레이션합니다. 현재 다음과 같은 BaaS (Buttons as a Service)를 제공합니다.

- `keyboard/volume_up`
- `keyboard/volume_down`
- `keyboard/volume_mute`
- `keyboard/media_play_pause`
- `keyboard/media_next_track`
- `keyboard/media_prev_track`

이 컴포넌트를 불러 오려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
keyboard:
```

## 의존성

키보드 구성 요소를 사용하려면 플랫폼 별 [PyUserInput에 대한 종속성](https://github.com/PyUserInput/PyUserInput#dependencies)을 설치해야 할 수 있습니다. 대부분의 경우 다음을 실행하여 수행 할 수 있습니다.

```bash
pip3 install [package name]
```

### 윈도우

x64 Windows 사용자는 pip를 통한 pywin 설치에 문제가 있을 수 있습니다. [executable installer](https://sourceforge.net/projects/pywin32/files/pywin32/)를 사용하면이 문제를 해결할 수 있습니다.

[Similar installers](https://www.lfd.uci.edu/~gohlke/pythonlibs/#pyhook) (비공식) pyhook은 python 3.4로 포팅되었으며 pyhook의 x64 pip 문제를 해결하는 데 도움이됩니다.