---
title: "홈어시스턴트 설정"
description: "홈어시스턴트 설정."
---

홈어시스턴트는 처음 시작할 때 웹인터페이스와 장치 검색을 가능하게 하는 기본 설정 파일을 만듭니다. 장치가 검색되어 사용자 인터페이스에 표시되려면 시작 이후 최대 1분이 걸릴 수 있습니다.


웹 인터페이스는 `http://ip.ad.dre.ss:8123/`로 접속할 수 있습니다.
- 예를 들어 홈어시스턴트 시스템에 IP 주소를 `192.168.0.40`로 할당받아 설치했을 경우 `http://192.168.0.40:8123/`에 접속하면 됩니다.

폴더의 위치는 운영 체제마다 다릅니다.:

| OS | 경로 |
| -- | ---- |
| macOS | `~/.homeassistant` |
| Linux | `~/.homeassistant` |
| Windows | `%APPDATA%/.homeassistant` |
| Hass.io | `/config` |
| Docker | `/config` |

다른 폴더에 설정 파일을 저장하려면: `hass --config path/to/config`로 실행하십시오.

설정 폴더 안에 `configuration.yaml`이 있습니다. 이것은 설정으로부터 로드된 통합구성요소를 포함한 주요한 파일입니다. 문서 전체에서 기능을 사용하기 위해 설정 파일에 추가할 수 있는 스니펫을 찾을 수 있습니다.

홈어시스턴트를 설정하는 동안 문제가 발생하면  [설정 문제해결 페이지](/getting-started/troubleshooting-configuration/) 와 [configuration.yaml 예시](/cookbook/#example-configurationyaml)를 살펴보십시오.

<div class='note tip'>

  `hass --script check_config`을 사용하여 command line에서 설정 파일의 변경 사항을 테스트하십시오. 이 스크립트를 사용하면 홈어시스턴트를 다시 시작할 필요없이 변경 사항을 테스트할 수 있습니다. 홈어시스턴트를 실행할 수 있는 사용자 계정으로 실행해야합니다.

</div>

## 변경 사항 새로 고침

대부분의 변경 사항을 적용하려면 `configuration.yaml`이 영향을 미치도록 홈어시스턴트를 다시 시작해야 합니다. 
[자동화](/docs/automation/), [core (customize)](/docs/configuration/customizing-devices/), [그룹](/integrations/group/), 그리고 [스크립트](/integrations/script/)는 다시 시작하지 않고 적용 가능합니다. 

<div class='note warning'>

설정을 변경한 경우, 다시 불러오기 전에 [설정 확인](/docs/configuration/troubleshooting/#problems-with-the-configuration)을 확인하십시오. 
</div>

## 새로운 시스템으로 마이그레이션

새 시스템으로 마이그레이션하려는 경우, 설정 폴더의 내용을 현재 시스템에서 새 시스템으로 복사할 수 있습니다.  
`.` 으로 시작하는 파일 중 일부는 (SSH의) Windows 탐색기와 macOS Finder에서 기본적으로 숨겨져 있습니다. 파일을 복사하기 전에 모든 파일을 보고있는지 확인해야 합니다.
