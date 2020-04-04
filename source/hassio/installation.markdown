---
title: "홈어시스턴트 설치"
description: "Instructions on how to install Hass.io."
---

**참고** : 더 상세한 설치기는 [HA 네이버카페 설치가이드](https://cafe.naver.com/ArticleList.nhn?search.clubid=29860180&search.menuid=7&search.boardtype=L)를 참고하세요.  

Home Assistant를 설치하는 과정을 단계별로 따라하세요.

1. 적합한 설치 파일을 다운 받으세요:

   - 본인의 장비에 따른 이미지:

     - [Raspberry Pi 3 Model B and B+ 32bit][pi3-32] (추천)
     - [Raspberry Pi 3 Model B and B+ 64bit][pi3-64]
     - [Raspberry Pi 4 Model B 32bit][pi4-32] (추천)
     - [Raspberry Pi 4 Model B 64bit][pi4-64]
     - [Tinkerboard][tinker]
     - [Odroid-C2][odroid-c2]
     - [Odroid-N2 (Beta)][odroid-n2]
     - [Odroid-XU4][odroid-xu4]
     - [Intel-Nuc][intel-nuc]

   - virtual appliance 따른 이미지:

     - [VMDK][vmdk] (VMWare Workstation)
     - [VHDX][vhdx]
     - [VDI][vdi]
     - [OVA][Virtual Appliance] (not available at this time!)

   - 비추천 하드웨어용:

     - [Raspberry Pi][pi1]
     - [Raspberry Pi Zero-W][pi0-w]
     - [Raspberry Pi 2][pi2]

2. Home Assistant 설치:

   - 다운 받은 이미지 파일을 [balenaEtcher][balenaEtcher]를 사용하여 SD카드에 플래싱합니다. 추천하는 라즈베리파이를 사용한다면 용량 부족을 피하기 위해 최소 32기가 이상의 SD카드를 사용하세요. 버추얼 머신에 설치한다면 VM의 디스크 공간을 32기가 이상으로 설정하세요.
   - 버추얼 소프트웨어가 설치된 장비 이미지를 사용하려면 64-bit 리눅스와 UEFI boot를 선택하세요.

3. 옵션 - 무선 와이파이를 설정하거나 고정IP를 부여하려면 2가지 방법이 존재합니다.
   - FAT32로 포맷한 USB 메모리 스틱을 준비하고 디스크 볼륨명은 `CONFIG`으로 정합니다. 최상위 폴더에 `network/my-network`라는 이름의 파일을 생성하거나
   - Home Assistant SD카드의 첫번째 부팅 파티션( `hassio-boot` 레이블로 리눅스에서 자동으로 마운트는 안됩니다)에 `CONFIG/network/my-network` 파일을 생성합니다.

   이렇게 만든 파일의 환경 설정은 [Home Assistant Operating System howto][hassos-network]를 참고하여 입력합니다.

4. 이미지로 만든 SD카드를 장비에 꼽아주세요(옵션으로 만든 USB를 같이 꼽습니다).

5. 장비의 전원 또는 버추얼 기기의 전원을 켭니다. 처음 부팅을 하면 최신 버전의 홈어시스턴트를 다운받아 설치하기 시작하며 인터넷 환경이나 장비의 성능에 따라 최대 20분 정도 소요됩니다.

   <img src='/images/hassio/screenshots/first-start.png' style='clear: right; border:none; box-shadow: none; float: right; margin-bottom: 12px;' width='150' />

6. 웹브라우저에서 `http://homeassistant.local:8123`로 접근합니다 (만일 접속이 안되면 아래 Note를 참고하세요).

7. 환경 설정을 하기 위해서는 Home Assistant CLI tools 같은 것이 필요합니다. [삼바 애드온][samba] 또는 [SSH 애드온][ssh]이 첫번째로 설치할 애드온들입니다. 이들 애드온을 통해 `/config/` 폴더에 접근하여 환경 설정을 수정할 수 있습니다.웹 UI에서 **Supervisor** 를 클릭하세요. 그 다음 애드온 스토어(add-on store)를 선택하고 해당 애드온을 찾아서 설치합니다. [HA 카페 다모아님의 글](https://cafe.naver.com/koreassistant/137)을 참조하세요.  

<div class='note warning'>

이전에는`hassio.local`을 사용했지만 이름 변경 전에 설치된 시스템이 있는 경우 `homeassistant.local` 대신 `hassio.local`을 사용해야합니다.

</div>

<div class='note'>

공유기가 mDNS를 지원하지 않는다면 `homeassistant.local` 대신에 `http://192.168.0.9:8123` 와 유사한 IP주소를 통해 접근해야 합니다. 라즈베리파이 또는 설치한 기기의 IP주소를 찾을 수 없다면 공유기 업체나 인터넷 관리 업체에 문의하세요.

</div>

<div class='note warning'>

라즈베리파이 사용자라면 적절한 [전원 어댑터][pi-power]를 사용해야 합니다. 스마트폰 충전기는 충분한 전력을 제공하지 못하므로 라즈베리파이에는 적합하지 않습니다. **절대로** 라즈베리파이를 TV나 컴퓨터 또는 그와 유사한 다른 장비의 USB 포트에 연결하지 마세요.

</div>

이제 [환경 설정][configure]을 할 차례입니다.

## Home Assistant 업데이트

Home Assistant 업데이트 설치를 위한 추천 방법:

1. 환경 구성을 백업하세요. Home Assistant가 제공하는 스냅샷(Snapshot)을 이용하면 손쉽게 백업 가능합니다.
2. [홈어시스턴트 릴리즈 노트](https://github.com/home-assistant/home-assistant/releases)에서 어떤 변경 사항이 반영됐는지 살펴봅니다. 기존에 쓰는 버전과 신규로 설치할 버전의 차이가 어떤지 꼼꼼히 살펴봅니다. 브라우저에서 (`CTRL + f`)를 눌러 **Breaking Changes** 단어들을 검색합니다.
3. [Check Home Assistant configuration](/addons/check_config/) 애드온으로 업데이트할 버전과 호환성을 체크해볼 수도 있습니다.
4. 체크가 끝나면 안전하게 업데이트를 설치합니다. 만일 문제가 있다면 업데이트 버전에 맞춰 환경 설정을 수정합니다.
5. _Supervisor_ 메뉴에서 _Dashboard_ 를 선택하고 신규 업데이트가 표시된 카드창에서 _Update_ 를 누르면 새로운 버전을 설치합니다.

## 특정 버전의 Home Assistant 설치

Home Assistant 시스템에 SSH로 접속하거나 도커 등 다른 환경에서 콘솔로 접속하여 아래 명령을 실행하면 특정 버전의 Home Assistant를 이용할 수 있습니다.

```bash
ha core update --version=0.XX.X
```

## 베타버전 Home Assistant 설치
새로운 버전이 릴리즈 되기전에 먼저 사용해보고 싶다면 3주마다 배포되는 베타버전을 사용해볼 수 있습니다:

1. Home Assistant에서 제공하면 스냅샷 기능으로 환경 설정을 백업하세요.
2. [Home Assistant Beta release notes](https://rc.home-assistant.io/latest-release-notes/)  버전에서 breaking changes를 확인하세요. 릴리즈 노트에서 현재 운영하는 버전과의 차이점을 잘 살펴봅니다. 브라우저에서 (`CTRL + f`) **Breaking Changes** 를 꼼꼼히 확인합니다.
3. _Supervisor_ 의 _System_ 탭에서 _Supervisor_ 아래 있는 _Join Beta Channel_ 을 선택합니다. 그리고 _Reload_ 를 누릅니다.
4. _Supervisor_ 메뉴의 _Dashboard_ 탭에서 _Update_ 를 누릅니다.

## 다른 방법: 일반적인 리눅스 컴퓨터에 Supervised Home Assistant 설치

Home Assistant Supervised라는 Linux 운영 체제에 Home Assistant를 설치할 수도 있습니다.

Home Assistant Supervised는 애드온을 포함하여 Home Assistant가 제공하는 대부분의 기능에 계속 액세스할 수 있도록합니다.

### 지원되는 시스템과 제한 사항

Home Assistant Supervised는 거의 모든 Linux 시스템에서 실행될 수 있지만 Home Assistant 프로젝트는 이 설치 방법에 대한 지원을 제한합니다. 

Debian 또는 Ubuntu 사용만 지원됩니다. 다른 Linux 기반 시스템은 작동할 수 있지만 테스트에 포함되지 않으므로 지원되지 않습니다.

또한 Home Assistant Supervised를 실행하기로 선택한 경우 시스템 업그레이드과 시스템 설정 측면에서 있어서 선택한 운영 체제(Debian/Ubuntu 포함)는 당신의 책임입니다. 

사용자 정의 운영 체제에 대한 커스텀 설정은 홈어시스턴트를 방해할 수 있습니다. 따라서 선택한 운영 체제를 관리, 설정, 유지 보수하는데 필요한 지식이 있어야합니다.

확실하지 않은 경우 위에 제공된대로 홈어시스턴트를 정기적으로 설치하는 것이 좋습니다. 이 경우 Home Assistant가 Home Assistant 운영 체제를 관리하고 업데이트합니다.

### 사전 준비

홈어시스턴트 설치를 위해 시스템을 준비하려면 다음 명령을 실행하십시오. : 

Ubuntu를 실행하는 경우 먼저 다음 명령을 실행하십시오. : 

```bash
sudo add-apt-repository universe
```

그 다음 명령을 실행하십시오 (Debian과 Ubuntu 모두). : 

```bash
sudo -i
apt-get update
apt-get install -y software-properties-common apparmor-utils apt-transport-https avahi-daemon ca-certificates curl dbus jq network-manager socat
systemctl disable ModemManager
systemctl stop ModemManager
curl -fsSL get.docker.com | sh
```

### 홈어시스턴트 Supervised 설치 

다음 스크립트는 다양한 운영 체제와 컴퓨터 유형에 Home Assistant를 설치합니다.

```bash
curl -sL "https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh" | bash -s
```

일부 설치 유형에는 컴퓨터 유형을 식별하기 위한 플래그가 필요합니다. 예를 들어, Raspberry Pi 4를 사용할 때 `--m raspberrypi4` 플래그가 필요합니다. 설치 스크립트는 다음과 같습니다.

```bash
curl -sL "https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh" | bash -s -- -m raspberrypi4
```

#### 다양한 machine types

- `intel-nuc`
- `raspberrypi`
- `raspberrypi2`
- `raspberrypi3`
- `raspberrypi3-64`
- `raspberrypi4`
- `raspberrypi4-64`
- `odroid-c2`
- `odroid-n2`
- `odroid-xu`
- `tinker`
- `qemuarm`
- `qemuarm-64`
- `qemux86`
- `qemux86-64`

지원되는 machine types의 최신 목록은 [installer](https://github.com/home-assistant/supervised-installer) GitHub 페이지를 참조하십시오.

리스트에서 머신 타입을 찾을 수 없다면 `qemu` 릴리즈를 선택해야합니다. 즉, 일반적인 64 비트 Linux 배포의 경우 `qemux86-64` 또는 Raspberry Pi 클론 또는 TV 박스와 같은 최신 ARM 기반 대상의 경우 qemuarm-64입니다.

## 또 다른 방법: 시놀로지 NAS에서의 설치

HA 네이버카페 멀더요원님의 [시놀로지 NAS에 Home Assistant 설치하기](https://cafe.naver.com/koreassistant/95)를 참고하십시오. 

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/QdBYUbj0B5Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## 또 다른 방법: 가상 머신에서의 설치 

일반 PC에서 가상머신 Virualbox를 이용해서 설치하는 방법입니다. 영상을 잘따라서 설치하십시오. ST 네이버카페 마이토이님의 [VirtualBox 설치기](https://cafe.naver.com/stsmarthome/12789)를 참조하세요. 

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/sVqyDtEjudk?start=242" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[balenaEtcher]: https://www.balena.io/etcher
[Virtual Appliance]: https://github.com/home-assistant/operating-system/blob/dev/Documentation/boards/ova.md
[hassos-network]: https://github.com/home-assistant/operating-system/blob/dev/Documentation/network.md
[pi0-w]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_rpi0-w-3.12.img.gz
[pi1]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_rpi-3.12.img.gz
[pi2]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_rpi2-3.12.img.gz
[pi3-32]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_rpi3-3.12.img.gz
[pi3-64]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_rpi3-64-3.12.img.gz
[pi4-32]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_rpi4-3.12.img.gz
[pi4-64]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_rpi4-64-3.12.img.gz
[tinker]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_tinker-3.12.img.gz
[odroid-c2]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_odroid-c2-3.12.img.gz
[odroid-n2]: https://github.com/home-assistant/operating-system/releases/download/4.4/hassos_odroid-n2-4.4.img.gz
[odroid-xu4]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_odroid-xu4-3.12.img.gz
[intel-nuc]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_intel-nuc-3.12.img.gz
[vmdk]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_ova-3.12.vmdk.gz
[vhdx]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_ova-3.12.vhdx.gz
[vdi]: https://github.com/home-assistant/operating-system/releases/download/3.12/hassos_ova-3.12.vdi.gz
[linux]: https://github.com/home-assistant/supervised-installer
[local]: http://homeassistant.local:8123
[samba]: /addons/samba/
[ssh]: /addons/ssh/
[pi-power]: https://www.raspberrypi.org/help/faqs/#powerReqs
[configure]: /getting-started/configuration/

