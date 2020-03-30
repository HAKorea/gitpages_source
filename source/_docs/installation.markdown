---
title: "다양한 설치 방법"
description: "Instructions on how to install Home Assistant to launch on start."
redirect_from: /getting-started/installation/
---

<div class='note'>

초급자는 [시작하기](/getting-started/) 문서를 확인하십시오.

</div>

홈 어시스턴트는 다양한 설치 방법을 제공합니다. 최초 부팅시에 필요한 패키지를 다운받고 설치하는 과정에서 약 20분 정도가 소요될 수 있습니다. 홈 어시스턴트가 실행되면 웹브라우저로 `http://ip.add.re.ss:8123/`에 접속하십시오. `ip.add.re.ss`는 홈 어시스턴트를 설치한 장비의 IP 주소입니다.

<div class='note warning'>

  설치가 끝난 후에는 [보안 점검](/docs/configuration/securing/)을 확인하십시오.

</div>

## 하드웨어

아래는 **최소** 하드웨어 요구 사항입니다.

유형 | 최소치
-- | --
저장 공간 | 32 GB
메모리 | 1 GB
네트워크 | 100 Mb/s 유선
파워 (라즈베리파이) | 2.5A 이상

### 성능 기대치

아래 리스트는 하드웨어 플랫폼과 기대치를 나타냅니다.

플랫폼 | 기대치
-- | --
Raspberry Pi Zero/Pi 2 | **오직** 테스팅 용도로만 사용하세요.
Raspberry Pi 3/3+/4 | 입문하기에 좋은 장비입니다. 연결된 기기가 적절하다면 충분한 성능을 발휘합니다. 가능하다면 [A2 class SD 카드](https://amzn.to/2X0Z2di)를 사용하세요.
NUC i3 | 많은 장치를 연결할 수 있고 라즈베리 파이보다 조금 더 나은 성능을 기대할 수 있습니다.
NUC i5 | 홈 어시스턴트 뿐만 아니라 다양한 서비스를 구동시킬 수 있습니다. 집안에 연구소를 차릴 수도 있죠.
NUC i7/i9 | 최고의 성능, **어떤** 성능이슈도 없습니다.

## 추천
아래 설치 방법은 홈 어시스턴트 문서 지원을 최대한 받을 수 있습니다. 예를들어 장치를 추가할 때 홈 어시스턴트와 통합 구성할 경우의 방법들을 지원 문서를 통해 참고할 수 있습니다.

<div class='note'>

Hass.io 애드온을 사용하기 위해서는 Hass.io 이미지로 설치하거나(HassOs 설치) 도커에서 직접 설치해야 합니다. 이 밖에 다른 방법은 홈 어시스턴트 Python 패키지를 설치하는 것입니다. 하지만 이 경우 애드온은 사용할 수 없으며 일반적인 프로그램을 설치하듯이 사용자가 직접 설치해야 합니다.

</div>

**설치 방법**|**현재 보유중**|**추천 대상**
:-----|:-----|:-----
[Home Assistant](/hassio/installation/)|Raspberry Pi<br>VM|누구나
[Docker](/docs/installation/docker/)|Docker|도커를 사용중인 유저

## 다른 설치 방법

아래 설치 방법을 이용하려면 현재 운용중인 OS의 시스템 관리자이거나 관리 방법에 대해 상세히 아는 이용자여야 합니다. 플랫폼에 관한 지식이 다양해서 설치 또는 장비를 추가하는 방법들이 상이 할 수 있기에 이곳에서 핵심 포인트만을 알려줄 수 있습니다. 상세한 설치 방법은 인터넷 검색을 통해 해결하세요.

**설치 방법**|**현재 보유중**|**추천 대상**
:-----|:-----|:-----
[venv<BR>(as another user)](/docs/installation/raspberry-pi/)|리눅스, Python 3.7 or later| 리눅스 관리 지식을 보유한 유저
[venv<BR>(as your user)](/docs/installation/virtualenv/)|Python 3.7 or later|개발자

## 커뮤니티에서 제공하는 설치 방법들

아래 제공한 가이드는 위에서 기술한 설치 방법보다 다소 제한적일 수 있습니다. 장비를 추가하는 통합 설치 과정에서 플랫폼의 제약사항 또는 플랫폼에 따른 Python 패키지의 존재 여부에 따라 동작하지 않을 수 있습니다.

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
