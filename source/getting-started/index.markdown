---
title: "홈어시스턴트 설치"
description: "Getting started: How to install Home Assistant."
---

{% comment %}

Note for contributors:

The getting started guide aims at getting new users get Home Assistant up and
running as fast as possible. Nothing else. All other things should not be
written down, as it creates a spaghetti of links and the user will lose focus.

So here are guidelines:

 - Focus on the bare necessities. No remote port, no securing installation. The
   defaults are good enough to get a system up and running for the first guide.
 - Avoid or explain technical terms.
 - Do not talk about YAML if it can be partially/fully done in UI.
 - Do not tell people about stuff they can do later. This can be added to a
   2nd tier guide.
 - The first page of the guide is for installation, hence Hass.io specific.
   Other pages should not refer to it except for the page introducing the last
   page that introduces `configuration.yaml`.

{% endcomment %}

본 문서는 라즈베리파이에 홈어시스턴트를 운용하는 것에 대한 가이드입니다. 가장 쉬운 방법은 [홈어시스턴트](/hassio/) 를 설치하는 것으로 라즈베리파이와 다른 기기들을 연결해주는 강력한 홈오토메이션 허브를 만들 수 있습니다.

리눅스에 대한 경험이 없거나 홈어시스턴트를 빨리 시작하려면 이 문서를 참고하세요. 숙련된 유저이거나 이 문서에서 [사용한 장비][supported]가 없다면 [다른 설치 방법](/docs/installation/)을 참고하길 바랍니다. 다른 설치 방법을 완료하신 분은 바로 [다음단계][next-step]로 넘어가세요.

[supported]: /hassio/installation/


<div class='videoWrapper'>
<iframe width="775" height="388" src="https://www.youtube.com/embed/XdiGdC7K4sI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

### 추천 하드웨어

홈어시스턴트를 설치하기 위해서는 몇가지 요구사항이 있습니다. 홈오토메이션을 구현하기 위한 첫 시작으로는 라즈베리파이 4B (모델B)를 추천합니다. 아래 링크에서 미국 아마존 사이트를 통해 구매할 수 있습니다.

- [Raspberry Pi 4 Model B (2GB)](https://amzn.to/2XULT2z) + [Power Supply](https://www.raspberrypi.org/help/faqs/#powerReqs) (2.5A 이상 추천)
- [Micro SD Card](https://amzn.to/2X0Z2di)는  [Application Class 2](https://www.sdcard.org/developers/overview/application/index.html) 종류의 카드가 수많은 읽고/쓰는 동작에 있어서 보다 안정적으로 동작합니다. 32 GB 이상의 용량을 추천합니다.
- SD 카드 리더기. 보통 노트북에 슬롯이 있으며, SD카드를 사면 어댑터가 들어있거나 [standalone USB adapter](https://amzn.to/2WWxntY)를 구매할 수 있습니다. 없다면 브랜드와 상관 없이 하나 구입하시기 바랍니다.
- 이더넷 케이블(랜선). 홈어시스턴트는 무선 와이파이로도 동작하지만 보다 안정적인 연결을 위해서 랜케이블로 유선 연결을 추천합니다.

### 소프트웨어 요구사항

- [구매한 하드웨어](/hassio/installation/)에 맞는 Home Assistant 이미지를 다운받고 압축을 해제합니다.
- SD카드에 이미지를 기록할 [balenaEtcher]를 다운 받아 설치합니다.

[balenaEtcher]: https://www.balena.io/etcher


### 설치

1. SD카드를 카드리더기에 삽입합니다.
2. balenaEtcher를 실행하고 Home Assisstant 이미지를 선택, SD카드에 flash 합니다.
3. SD card를 마운트해제(이동식 디스크 꺼내기)하고 카드리더기에서 뽑습니다.
4. 무선 와이파이를 설정하거나 고정IP를 부여하려면 다음 과정을 따라하시고 유선으로 랜케이블을 사용하면 5번 과정으로 진행하세요.
   - FAT32로 포맷한 USB 메모리 스틱을 준비합니다. USB 스틱의 디스크 볼륨명은 `CONFIG`으로 정합니다.
   - USB 스틱의 최상위 폴더로 `network` 이름의 폴더를 만듭니다.
   - 이 폴더에 `my-network`라는 이름의 파일을 생성합니다(텍스트 파일 형식). 이때 확장자는 없는 파일로 만듭니다.
   - [다음 예제] 중 본인이 필요한 내용을 `my-network` 파일 내용으로 복사하고 본인의 환경에 맞게 수정합니다.
   - 라즈베리파이에 USB 스틱을 꼽습니다.

5. SD 카드를 라즈베리파이에 꼽습니다. 유선 랜을 사용 하는 경우라면 랜 케이블을 연결합니다.
6. 라즈베리파이의 전원을 켭니다.
7. 이제 라즈베리파이를 부팅하고 인터넷에서 홈어시스턴트에 필요한 최신 파일들을 다운받습니다. 이 과정은 자동으로 실행되며 최대 약 20분 정도의 시간이 걸립니다.
8. 홈어시스턴트를 확인하기 위해 웹브라우저에서 `http://homeassistant.local:8123`로 접속하세요. 본인의 윈도우가 구버전이거나 네트웍에 따라서 접속이 불가한 경우도 있습니다. 그럴때는 `http://homeassistant:8123` 또는 공유기에서 라즈베리파이의 IP주소를 찾아서 `http://ip주소:8123` 으로 접속해보세요. 웹사이트가 보인다면 성공이며 화면에 잔여시간이 나타납니다.
9. 모든 설치가 끝나면 네트웍 설정을 위해 꼽아둔 USB 스틱을 제거하세요. 최초 부팅이 끝난 이후에는 더이상 필요하지 않습니다.

[다음 예제]: https://github.com/home-assistant/hassos/blob/dev/Documentation/network.md

### [다음 과정: 첫만남 &raquo;][next-step]

[next-step]: /getting-started/onboarding/

_위 아마존 링크에서 구입하는 경우 홈어시스턴트는 아마존으로부터 소정의 수수료를 받습니다_
