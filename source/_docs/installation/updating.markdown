---
title: "홈어시스턴트 업데이트"
description: "Step to update Home Assistant."
redirect_from: /getting-started/updating/
---

<div class='note warning'>

업그레이드 프로세스는 설치에 따라 다르므로 설치 관련 설명서 ([Home Assistant](/hassio/) 또는 [Home Assistant Core](/docs/installation/virtualenv/#upgrading-home-assistant)) 를 검토하십시오 .

</div>

최신 버전의 새로운 기능을 확인하고 [Home Assistant 릴리즈 노트](https://github.com/home-assistant/home-assistant/releases) 에서 시스템에 영향을 줄 수 있습니다. 이 릴리스 노트를 검토하고 여기에 나열된 **Breaking Changes**에 주의를 기울이는 것이 좋습니다. 한동안 업데이트를 수행하지 않은 경우 이전 릴리스 노트에도 관련 **Breaking Changes**이 포함될 수 있으므로 확인해야합니다 . 이러한 **Breaking Changes**에는 구성 요소에 대한 설정 업데이트가 필요할 수 있습니다. 이를 놓치고 홈어시스턴트가 시작을 거부하면 [configuration](/docs/configuration/) 디렉토리 (예: `.homeassistant/home-assistant.log`)의 로그 파일에서 깨진 구성 요소에 대한 세부사항을 확인하십시오.

<div class='note'>

권한 오류를 피하려면 초기설치 중에 사용한 것과 동일한 사용자로 업그레이드를 실행해야합니다. [Home Assistant](/hassio/) 또는 [Home Assistant Core](/docs/installation/virtualenv) 설치와 관련된 설명서를 다시 검토하십시오.

</div>

사용 가능한 경우 Home Assistant를 최신 릴리스로 업데이트하는 기본 방법은 다음과 같습니다.

```bash
pip3 install --upgrade homeassistant
```

For a Docker container, simply pull the latest one:

```bash
sudo docker pull homeassistant/home-assistant:latest
```

For a Raspberry Pi Docker container, simply pull the latest one:
Raspberry Pi Docker 컨테이너의 경우 최신 컨테이너를 pull 하십시오. : 

```bash
sudo docker pull homeassistant/raspberrypi3-homeassistant:latest
```

업데이트 후 변경사항을 적용하려면 Home Assistant를 시작/다시시작 해야합니다. 즉, `hass` 자체 또는 [autostarting](/docs/autostart/) 데몬(해당되는 경우)을 다시 시작해야합니다. 장치에 따라 시작하는데 상당한 시간(예: 분)이 걸릴 수 있습니다. 모든 요구사항도 업데이트되기 때문입니다.

[BRUH 자동화](https://www.bruhautomation.io/)가 Home Assistant 업그레이드 방법을 설명하는 [튜토리얼 비디오](https://www.youtube.com/watch?v=tuG2rs1Cl2Y)를 만들었습니다.

#### 특정 버전을 실행

Home Assistant 버전이 하드웨어 설정에서 제대로 작동하지 않는 경우 이전 릴리스로 다운그레이드 할 수 있습니다.

```bash
pip3 install homeassistant==0.XX.X
```

#### 베타 버전을 실행

다른 사람보다 먼저 다음 릴리스를 테스트하려면 2 주마다 릴리스된 베타 버전을 설치할 수 있습니다.


```bash
pip3 install --pre --upgrade homeassistant
```

#### 개발 버전을 실행

최첨단 홈어시스턴트 개발 브랜치를 유지하려면 `dev`로 업그레이드하면됩니다.

<div class='note warning'>
  "dev" 브랜치가 불안정할 수 있습니다. 데이터 손실과 인스턴스 손상이 발생할 수 있습니다.
</div>

```bash
$ pip3 install --upgrade git+git://github.com/home-assistant/home-assistant.git@dev
```

### HOME ASSISTANT 설치 업데이트

Home Assistant 설치 업데이트 모범 사례 : 

1. Home Assistant가 제공하는 스냅샷 기능을 사용하여 설치를 백업하십시오.
2. [Home Assistant 릴리스 정보](https://github.com/home-assistant/home-assistant/releases)의 변경 사항을 해제하려면 릴리스 정보를 확인하십시오. 실행중인 버전과 업그레이드하려는 버전 사이의 모든 릴리스 정보를 확인하십시오. 브라우저에서 검색 기능 (`CTRL + f`)을 사용하고 **Breaking Changes**을 검색하십시오.
3. [Home Assistant 설정 확인](/addons/check_config/) 애드온을 사용하여 설정을 확인하십시오.
4. 확인이 통과되면 안전하게 업데이트할 수 있습니다. 그렇지 않은 경우 적절하게 설정을 업데이트하십시오.
5. 홈어시스턴트를 업데이트하십시오.