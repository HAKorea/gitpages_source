---
title: "고급 환경 설정"
description: "Instructions to get Home Assistant configured."
---

지금까지의 첫만남 과정은 공간의 이름을 설정하고 위치를 정하는 등 홈어시스턴트의 초기설정을 맛보는 것이였습니다. 첫만남이 끝나면 설정했던 옵션들을 왼쪽 메뉴의 설정(Configuration)을 클릭하고 UI를 통해 변경할 수 있습니다. 또는 `configuration.yaml` 파일을 직접 편집하여 홈어시스턴트 환경 설정을 진행 할 수 있습니다. 이번 과정은 파일을 직접 편집하는 것에 대해 설명합니다.

또한 [**레이군님의 홈어시스턴트에 대한 기본적인 이해**](https://cafe.naver.com/stsmarthome/10204)를 정독해보시길 강력히 추천드립니다. 

<div class='note'>

아래 과정은 홈어시스턴트를 Home Assistant Core로 설치한 경우에는 해당하지 않습니다. 만일 다른 방법으로 설치했다면 [이 곳](/docs/configuration/)을 참고하세요.

</div>

이제 처음으로 `configuration.yaml` 파일을 편집 해봅시다. 이를 위해 Home Assistant 애드온 스토어에서 File Editor  애드온을 설치해야 합니다. 왼쪽 메뉴에서 File Editor를 선택하고 화면 상단에서 애드온 스토어(add-on store) 탭을 누릅니다.

<p class='img'>
<img src='/images/hassio/screenshots/main_panel_addon_store.png' />
Supervisor 메인 패널에서 애드온 스토어를 엽니다
</p>

공식 애드온(official add-ons) 섹션에서 File editor를 찾을 수 있습니다.
 - File Editor를 선택하여 INSTALL을 클릭합니다. 설치가 완료되면 화면에서 INSTALL이 UNINSTALL로 바뀌고 애드온 상세 설정 페이지가 아래쪽에 나타납니다. 사용하는 장치 성능에 따라 시간이 오래 걸릴 수도 있습니다.
 - 설치가 완료되면 START 버튼을 눌러 애드온을 실행합니다.
 - 애드온이 실행되면 OPEN WEB UI라는 버튼이 나타납니다. 이것을 눌러 편집기로 이도하세요.

이제 File Editor를 통해 설정을 변경할 수 있습니다. 홈어시스턴트를 사용하는 공간의 이름, 타임존, 위치, 단위 시스템 등을 바꿔봅시다.

 - 좌측 상단에서 폴더 아이콘을 눌러 파일 브라우저를 실행합니다.
 - `/config/` 폴더 안에서 `configuration.yaml` 파일을 선택하면 편집창에 내용이 나타납니다.
 - 다음 내용을 편집창에 입력합니다. (이 내용은 일반적으로 파일의 제일 위쪽에 입력하지만 어떤 위치여도 상관은 없습니다):
 ```yaml
     homeassistant:
       name: Home
       latitude: xx.xxxx
       longitude: xx.xxxx
       unit_system: metric
       time_zone: Asia/Seoul
  ```
<div class='note'>

  `unit_system`은 `imperial` 또는 `metric`만 사용가능합니다. 타임존은 [여기서](https://timezonedb.com/time-zones) 여러분의 시간대를 확인하세요. 위도와 경도(latitude/longitude)는 구글맵 등에서 찾을 수 있습니다.

</div>

 - 화면 우측 상단에 저장 아이콘을 눌러 변경 내용을 저장합니다(저장 아이콘은 변경 내용이 있을 때만 나타납니다).
 - `configuration.yaml` 파일의 수정은 홈어시스턴트를 재시작해야만 적용됩니다. 그 전에 확인해야 할 사항은 변경 내용이 유효한지 여부입니다. 왼쪽 메뉴에서 설정(Configuration)을 눌러 "서버 제어(Server Control)"을 클릭합니다. 화면에서 "구성 내용 확인(CHECK CONFIG)" 버튼을 눌러 변경 내용에 문제가 없다면 "구성 내용이 모두 올바릅니다!(Configuration valid!)"라고 표시됩니다.  
 - 구성 내용이 올바르다면 서버를 재시작 합니다. 서버 제어 화면 하단에서 재시작을 실행합니다. "구성 내용 확인" 버튼은 "고급 모드(Advanced Mode)"를 활성화한 경우에만 나타납니다. 왼쪽 하단에서 현재 사용자 이름을 선택해서 고급 모드를 켜주세요.

<p class='img'>
<img src='/images/screenshots/configuration-validation.png' />
설정 패널의 서버 제어 페이지
</p>

<div class='note'>

configuration.yaml을 편집하여 홈어시스턴트를 설정하는 동영상(일반적으로 구버전을 다루는 영상)을 시청했다면, 동영상에서 다루는 내용보다 기본 configuration.yaml 파일의 내용이 매우 간결하다고 생각할 수 있습니다. 이 점 개의치 않아도 됩니다. 구버전을 다루는 영상들에서 이야기하는 많은 설정 내용들이 이제는 `default_config:` 안에 포함되어 있습니다. 보다 자세한 내용은 [이 곳](/integrations/default_config/)을 확인하세요.

</div>

### 삼바와 내부 네트워크를 통한 편집

우리가 제공하는 웹 에디터가 불편할 수도 있고, 여러분이 주로 사용하는 에디터 프로그램으로 편집하고 싶을 수도 있습니다. 네트워크로 접속해서 편집하는 방법은 삼바 애드온(Samba add-on)으로 가능합니다. 애드온 스토어로 이동하여 Core 섹션에서 Samba를 찾으십시오. 애드온을 설치한 후 START를 클릭하십시오. 컴퓨터의 탐색기에서 네트워크 탭을 통해 `/config/` 폴더에 접근할 수 있습니다.

 `configuration.yaml`의 편집은 무료인 [Visual Studio Code](https://code.visualstudio.com/)을 추천하며  [Home Assistant Config Helper extension](https://marketplace.visualstudio.com/items?itemName=keesschollaart.vscode-home-assistant)을 함께 사용할 수 있습니다. 
