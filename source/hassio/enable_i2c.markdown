---
title: "HassOS에서 I2C 사용"
description: "Instructions on how to enable I2C on a Raspberry PI for Hass.io."
---

Hass.io는 제한된 환경으로 일반적인 방법으로 라즈베리파이의 I2C bus를 사용할 수 없습니다.

만일 직접 라즈베리파이에 외부 센서를 연결하려면 USB 메모리 스틱을 사용하여 [enable the I2C interface in the Hass.io configuration](https://github.com/home-assistant/hassos/blob/dev/Documentation/boards/raspberrypi.md#i2c) 를 실행해야 합니다.

## 단계별 적용 방법

필요한 것:

- USB drive
- USB drive에 파일을 복사할 방법
- Raspberry Pi에 USB 드라이브를 연결할 방법

### 1단계 - USB 드라이브 준비

- USB 드라이브 안에 파일을 편집 가능한 컴퓨터에 연결합니다.

- USB 드라이브를 FAT32/EXT4/NTFS 형식으로 포맷합니다. 그리고 드라이브의 이름을 `CONFIG`(모두 대문자)으로 만듭니다.

### 2단계 - I2C를 적용할 파일 생성

- USB 드라이브의 루트에 `/modules`이라는 이름의 폴더를 만듭니다.
- 해당 폴더 안에 `rpi-i2c.conf` 이름으로 텍스트 파일을 만들고 아래 내용을 입력합니다:
  ```txt
  i2c-bcm2708
  i2c-dev
  ```
- USB 드라이브 루트에 `config.txt` 이름으로 텍스트 파일을 만들고 아래 내용을 입력합니다:
  ```txt
  dtparam=i2c1=on
  dtparam=i2c_arm=on
  ```

### 3단계 - USB 드라이브로 설치

- 라즈베리파이에 USB 드라이브를 꼽습니다.
- 홈어시스턴트 웹페이지로 가서 **Hass.io** > **System** 을 클릭합니다.
- 이제 `Import from USB`를 클릭합니다.
- Hass.io를 재시작하면, 새로운 USB 설정을 반영합니다.

서버를 재시작 하면 I2C interface를 사용할 수 있습니다.
