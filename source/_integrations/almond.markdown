---
title: 아몬드(Almond)
description: Instructions on how to setup Almond within Home Assistant.
logo: almond.png
ha_category:
  - Voice
ha_iot_class: Local Polling
ha_release: '0.102'
ha_config_flow: true
ha_codeowners:
  - '@gcampax'
  - '@balloob'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/vmNp2RTGY6Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Almond](https://almond.stanford.edu/)는 [Stanford Open Virtual Assistant Lab](https://oval.cs.stanford.edu/)의 개인 정보 보호를 하는 가상 오픈소스 어시스턴트입니다. 무엇보다도 자연어를 사용하여 홈어시스턴트를 제어할 수 있습니다. 일단 설치되면, 오른쪽 상단의 마이크 아이콘을 통해 Lovelace에서 사용할 수 있습니다.

아몬드는 세 부분으로 구성됩니다.

- Almond Server: 홈어시스턴트 및 데이터에 대해 알고 있습니다. 문장을 실행합니다.
- LUInet: 문장을 Thingtalk 프로그램으로 변환하는 신경망(Neural network).
- Thingpedia: Thingtalk 프로그램의 빌딩 블록(building blocks)을 제공하는 기술.

<a href='/images/integrations/almond/almond-architecture.svg'><img src='/images/integrations/almond/almond-architecture.svg' alt='Architectural overview of how all pieces fit together.' style='border: 0;box-shadow: none;'></a>

## 설치

### Hass.io 설치

Hass.io에 Almond Server를 설치하려면 Hass.io App Store로 이동하여 Almond를 검색하고 설치를 클릭하십시오. 일단 시작되면, 홈어시스턴트에서 설정을 완료하기 위해 설치 단계를 시작합니다. **설정 패널의 통합구성요소 페이지**에서 찾을 수 있습니다.

### 수동 설치

[README](https://github.com/stanford-oval/almond-server#running-almond-server)의 지침에 따라 Almond Server를 설치할 수 있습니다.

Home Assistant에 연결하기 전에 아몬드 UI를 한 번 방문하여 비밀번호를 만들어야합니다. 기본적으로 포트 3000에서 사용 가능합니다.

일단 설치되면 다음과 같이 아몬드를 설정하십시오.

```yaml
# Example configuration.yaml entry
almond:
  type: local
  host: http://127.0.0.1:3000
```

Almond 통합구성요소는 아직 설정 항목을 업데이트하지 않습니다. configuration.yaml을 변경하면 설정 항목을 제거한 다음 Home Assistant를 다시 시작해야합니다.

### Almond Web

Stanford는 Almond Web이라는 호스팅된 버전의 Almond Server를 제공합니다. 이를 사용하려면 통합구성요소 페이지로 이동하여 추가 설정 과정를 사용하여 아몬드를 추가하십시오.

Almond Web이 Home Assistant를 제어 할 수 있게하려면 Home Assistant 설치에 외부에서 액세스 할 수 있어야합니다.

### Almond Web - 수동 설치

Almond Web을 수동으로 설정할 수 있습니다. 웹인터페이스에서 자신의 클라이언트 ID와 비밀정보를 작성해야합니다.

```yaml
# Example configuration.yaml entry
almond:
  type: oauth2
  client_id: AAAAAAAAAAAAA
  client_secret: BBBBBBBBBBBBBBBBB
```

이제 통합구성요소 페이지로 이동하여 설정 과정을 시작할 수 있습니다.

## 지원 언어

아몬드는 현재 영어로 제한되어 있습니다. 이것은 기술적 제한이 아니지만 전문적인 엔지니어링 노력이 필요합니다. 아몬드에는 현재 다른 언어를 추가 할 수있는 공개 일정이 없습니다.

## 장치 지원

아몬드는 지속적으로 개선되고 있습니다. 현재 모든 기기를 지원하지는 않지만 Almond와 협력하여 개선하고 있습니다.