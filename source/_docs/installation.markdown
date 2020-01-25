---
title: "Installation of Home Assistant"
description: "Instructions on how to install Home Assistant to launch on start."
redirect_from: /getting-started/installation/
---

<div class='note'>

초급자는 [시작하기](/getting-started/) 문서를 보시기 바랍니다.

</div>

홈어시스턴트는 다양한 설치 방법을 제공합니다. 최초 부팅시에는 약 20분 정도가 소요되는데 이것은 필요한 패키지를 인터넷에서 다운받고 설치하는 과정입니다. 홈어시스턴트가 실행되면 웹브라우저로 `http://ip.add.re.ss:8123/` 로 접속합니다. `ip.add.re.ss` 홈어시스턴트를 설치한 장비의 IP 주소입니다.

<div class='note warning'>

  설치가 끝난 후에는 [보안 설치 확인](/docs/configuration/securing/) 을 해보시기 바랍니다.

</div>

## 하드웨어

아래는 **최소** 스펙입니다.

Type | Minimum
-- | --
Storage | 32 GB
Memory | 1 GB
Network | 100 Mb/s 유선
Power (라즈베리파이) | 2.5A 이상

### 성능 기대치

아래 리스트는 플랫폼과 기대치를 나타냅니다.

Platform | Notes
-- | --
Raspberry Pi Zero/Pi 2 | **단지** 테스팅 용도로만 사용하세요.
Raspberry Pi 3/3+/4 | 입문하기에 좋은 장비입니다. 연결된 기기가 적절하다면 충분한 성능을 발휘합니다. 가능한 [A2 class SD 카드](https://amzn.to/2X0Z2di)를 사용하세요.
NUC i3 | 많은 장치를 연결할 수 있고 라즈베리 파이보다 조금 더 나은 성능을 기대할 수 있습니다.
NUC i5 | 홈어시스턴트 뿐만 아니라 다양한 서비스를 구동시킬 수 있습니다. 집안에 연구소를 차릴 수도 있죠.
NUC i7/i9 | 최고의 성능, **어떤** 성능이슈도 없습니다.

## 추천
아래 설치 방법은 홈어시스턴트 문서 지원을 최대한 받을 수 있습니다. 예를 들어 장치를 추가할 때 홈어시스턴트와 통합 구성할 경우의 방법들을 지원 문서를 통해 참고할 수 있습니다. 

<div class='note'>

The only installation methods that allow you to use Hass.io Add-ons are the Hass.io image and manual installer. All other methods only install the base Home Assistant packages, however the software from the add-ons may still usually be installed manually like any other program.

</div>

**Method**|**You have**|**Recommended for**
:-----|:-----|:-----
[Hass.io](/hassio/installation/)|Raspberry Pi<br>VM|Anybody
[Docker](/docs/installation/docker/)|Docker|Anybody already running Docker

## Alternative installs

If you use these install methods, we assume that you know how to manage and administer the operating system you're using. Due to the range of platforms on which these install methods can be used, integration documentation may only tell you what you have to install, not how to install it.

**Method**|**You have**|**Recommended for**
:-----|:-----|:-----
[venv<BR>(as another user)](/docs/installation/raspberry-pi/)|Any Linux, Python 3.7 or later|Those familiar with their operating system
[venv<BR>(as your user)](/docs/installation/virtualenv/)|Any Python 3.7 or later|Developers

## Community provided guides

These guides are provided as-is. Some of these install methods are more limited than the methods above. Some integrations may not work due to limitations of the platform or because required Python packages aren't available for that platform.

<div class="text-center hass-option-cards" markdown="0">
  <a class='option-card' href='/docs/installation/armbian/'>
    <div class='img-container'>
      <img src='/images/supported_brands/armbian.png' />
    </div>
    <div class='title'>armbian</div>
  </a>
  <a class='option-card' href='/docs/installation/archlinux/'>
    <div class='img-container'>
      <img src='/images/supported_brands/archlinux.png' />
    </div>
    <div class='title'>ArchLinux</div>
  </a>
  <a class='option-card' href='/docs/installation/fedora/'>
    <div class='img-container'>
      <img src='/images/supported_brands/fedora.png' />
    </div>
    <div class='title'>Fedora</div>
  </a>
  <a class='option-card' href='/docs/installation/centos/'>
    <div class='img-container'>
      <img src='/images/supported_brands/centos.png' />
    </div>
    <div class='title'>CentOS/RHEL</div>
  </a>
  <a class='option-card' href='/docs/installation/macos/'>
    <div class='img-container'>
      <img src='/images/supported_brands/apple.png' />
    </div>
    <div class='title'>macOS</div>
  </a>
  <a class='option-card' href='/docs/installation/synology/'>
    <div class='img-container'>
      <img src='/images/supported_brands/synology.png' />
    </div>
    <div class='title'>Synology</div>
  </a>
  <a class='option-card' href='/docs/installation/freenas/'>
    <div class='img-container'>
      <img src='/images/supported_brands/freenas.png' />
    </div>
    <div class='title'>FreeNAS</div>
  </a>
  <a class='option-card' href='/hassio/installation/#alternative-install-on-a-generic-linux-host'>
    <div class='img-container'>
      <img src='/images/supported_brands/home-assistant.png' />
    </div>
    <div class='title'>Hass.io <br> on generic Linux server</div>
  </a>
</div>
