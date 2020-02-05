---
title: "홈 어시스턴트 설정"
description: "홈 어시스턴트 설정."
---

Home Assistant는 처음 시작할 때 웹 인터페이스 및 장치 검색을 가능하게하는 기본 설정 파일을 만듭니다. 장치가 검색되어 사용자 인터페이스에 표시 되려면 시작 후 최대 1 분이 걸릴 수 있습니다.


웹 인터페이스는 `http://ip.ad.dre.ss:8123/` 
- 예를 들어 Home Assistant 시스템에 IP 주소를 `192.168.0.40`로 할당받아 설치했을 경우 웹으로 접속하고자 할때 `http://192.168.0.40:8123/`로 들어가면 됩니다.

폴더의 위치는 운영 체제마다 다릅니다.:

| OS | Path |
| -- | ---- |
| macOS | `~/.homeassistant` |
| Linux | `~/.homeassistant` |
| Windows | `%APPDATA%/.homeassistant` |
| Hass.io | `/config` |
| Docker | `/config` |

설정의 위치를 다른 폴더를 사용하려면 config 명령의 위치를 매개 변수를 사용하여 접근하려면 시작시: `hass --config path/to/config`로 실행하면 됩니다.

설정 폴더 안에 파일로서 `configuration.yaml`이 있습니다. 이것은 설정으로부터 로드된 통합 구성요소를 포함한 주요한 파일입니다.  문서 전체에서 기능을 사용하기 위해 설정 파일에 추가 할 수있는 snippet을 찾을 수 있습니다.

Home Assistant를 설정하는 동안 문제가 발생하면  [configuration troubleshooting page](/getting-started/troubleshooting-configuration/) 와 [configuration.yaml examples](/cookbook/#example-configurationyaml)를 살펴보십시오.

<div class='note tip'>

  `hass --script check_config`을 사용하여 명령 행에서 설정 파일의 변경 사항을 테스트하십시오. 이 스크립트를 사용하면 Home Assistant를 다시 시작할 필요없이 변경 사항을 테스트 할 수 있습니다. 홈 어시스턴트를 실행할 수 있는 사용자 계정으로 실행해야합니다..

</div>

## 변경 사항 새로 고침

대부분의 변경 사항을 적용하려면 `configuration.yaml`이 영향을 미치게 하기위해 Home Assistant를 다시 시작해야 합니다. 
다시 시작하지 않고 [automations](/docs/automation/), [core (customize)](/docs/configuration/customizing-devices/), [groups](/integrations/group/), 그리고 [scripts](/integrations/script/)는 적용 가능합니다. 

<div class='note warning'>

변경 한 경우 다시로드하거나 다시 시작하기 전 [check your configuration](/docs/configuration/troubleshooting/#problems-with-the-configuration) 을 확인하십시오. 
</div>

## 새로운 시스템으로 마이그레이션

구성을 새 시스템으로 마이그레이션하려는 경우 구성 폴더의 내용을 현재 시스템에서 새 시스템으로 복사 할 수 있습니다.  
. 로 시작하는 파일 중 일부는 (SSH의) Windows 탐색기 및 macOS Finder에서 기본적으로 숨겨져 있습니다. 파일을 복사하기 전에 모든 파일을보고 있는지 확인해야합니다.
