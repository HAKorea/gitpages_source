---
title: 브로드링크
description: Instructions on how to integrate Broadlink within Home Assistant.
logo: broadlink.png
ha_category:
  - Remote
  - Switch
  - Sensor
ha_release: 0.35
ha_iot_class: Local Polling
ha_codeowners:
  - '@danielhiversen'
  - '@felipediel'
---

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.:

- [Remote](#remote)
- [Sensor](#sensor)
- [Switch](#switch)

<iframe width="690" height="437" src="https://www.youtube.com/embed/CEwuMh80CSA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Remote

`broadlink` 원격 플랫폼은 Broadlink 원격 제어 장치와 상호 작용할 수 있습니다.

### 설정

활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
remote:
  - platform: broadlink
    host: IP_ADDRESS
    mac: MAC_ADDRESS
```

{% configuration %}
host:
  description: 연결할 호스트 이름 / IP 주소입니다.
  required: true
  type: string
mac:
  description: 장치 MAC 주소.
  required: true
  type: string
timeout:
  description: 장치 연결에 대한 시간 초과.
  required: false
  default: 5
  type: integer
name:
  description: 장치 이름.
  required: false
  default: Broadlink
  type: string
{% endconfiguration %}
  
### 명령어 학습

`remote.learn_command` 서비스를 사용하여 새로운 명령을 익히십시오..

| Service data attribute | Optional | Description                               |
| ---------------------- | -------- | ----------------------------------------- |
| `entity_id`            | no       | 리모컨의 ID입니다.                         |
| `device`               | no       | 제어 할 장치의 이름입니다.                  |
| `command`              | no       | 배울 명령의 이름.                          |
| `alternative`          | yes      | 명령을 토글 여부.                          |
| `timeout`              | yes      | 각 명령을 익히는 시간 (초).                |

예 1 : 단일 명령 배우기

```yaml
script:
  learn_mute_tv:
    sequence:
      - service: remote.learn_command
        data:
          entity_id: remote.bedroom
          device: television
          command: mute
```

예 2 : 일련 명령 학습

```yaml
script:
  learn_tv_commands:
    sequence:
      - service: remote.learn_command
        data:
          entity_id: remote.bedroom
          device: television
          command:
            - turn on
            - turn off
            - volume up
            - volume down
```

예 3 : 토글 명령 배우기

`alternative` 플래그는 TV를 켜고 끌 수있는 전원 버튼과 같은 여러 버튼에 동일한 버튼을 사용하는 명령을 캡처하는 데 유용합니다.

```yaml
script:
  learn_tv_power_button:
    sequence:
      - service: remote.learn_command
        data:
          entity_id: remote.bedroom
          device: television
          command: power
          alternative: True
```

위의 예에서 power 명령에 대해 두 개의 코드가 캡처되며 명령이 호출 될 때마다 교차로 전송됩니다.

### 명령어 전송

`remote.send_command` 서비스를 사용하여 명령을 보냅니다.

| Service data attribute | Optional | Description                                          |
| ---------------------- | -------- | ---------------------------------------------------- |
| `entity_id`            | no       | 리모컨의 ID입니다.                                    |
| `device`               | no       | 제어 할 장치의 이름입니다.                             |
| `command`              | no       | 전송할 명령의 이름.                                   |
| `num_repeats`          | yes      | 명령을 반복 할 횟수입니다.                             |
| `delay_secs`           | yes      | 한 명령과 다른 명령 사이의 간격 (초).                   |

예 1 : 단일 명령 보내기

```yaml
script:
  mute_tv:
    sequence:
      - service: remote.send_command
        data:
          entity_id: remote.bedroom
          device: television
          command: mute
```

예 2 : 명령을 반복적으로 전송

```yaml
script:
  turn_up_tv_volume_20:
    sequence:
      - service: remote.send_command
        data:
          entity_id: remote.bedroom
          device: television
          command: volume up
          num_repeats: 20
```

예 3 : 명령 시퀀스 전송

```yaml
script:
  turn_on_ac:
    sequence:
      - service: remote.send_command
        data:
          entity_id: remote.bedroom
          device: air conditioner
          command:
            - turn on
            - turn off display
```

## Sensor

The `broadlink` 센서 플랫폼은 브로드링크 RM2와 A1 E-air 제품에서 데이터를 모니터링 할 수 있습니다. 현재 클라우드 API는 지원되지 않습니다.

활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: broadlink
    host: IP_ADDRESS
    mac: 'MAC_ADDRESS'
    monitored_conditions:
      - 'temperature'
```

{% configuration %}
host:
  description: 연결할 호스트 이름 / IP 주소입니다.
  required: true
  type: string
mac:
  description: "장치 MAC 주소. 다음 형식을 사용하십시오: `AA:BB:CC:DD:EE:FF`."
  required: true
  type: string
name:
  description: 센서 이름.
  required: false
  default: Broadlink sensor
  type: string
scan_interval:
  description: 센서에서 데이터를 가져 오는 시간 (초)입니다.
  required: false
  default: 300
  type: integer
timeout:
  description: 장치 연결에 대한 시간 초과 (초).
  required: false
  default: 10
  type: integer
monitored_conditions:
  description:
  required: true
  type: list
  keys:
    "'temperature'":
      description: Temperature
    "'humidity'":
      description: Humidity
    "'air_quality'":
      description: Air quality
    "'light'":
      description: Light
    "'noise'":
      description: Noise
{% endconfiguration %}

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가 하십시오.:

A1에서 센서 데이터 설정 방법.:

```yaml
sensor:
  - platform: broadlink
    scan_interval: 60
    host: IP_ADDRESS
    mac: 'MAC_ADDRESS'
    monitored_conditions:
      - temperature
      - humidity
      - air_quality
      - light
      - noise
```

RM2에서 온도 데이터 설정 방법:

```yaml
sensor:
  - platform: broadlink
    scan_interval: 60
    host: IP_ADDRESS
    mac: 'MAC_ADDRESS'
    monitored_conditions:
      - temperature
```

### MS 윈도우 설치

<div class='note'>

pycrypto 라이브러리를 사용할 수 있어야합니다.  일반적인 Windows `pip install pycrypto` 명령으로는 동작하지 않습니다. 컴파일러를 먼저 설치해야 합니다.

</div>

이 문제를 해결하는 가장 빠른 방법은 [https://github.com/sfbahr/PyCrypto-Wheels](https://github.com/sfbahr/PyCrypto-Wheels)에서 사전 빌드 된 바이너리를 사용하는 방법입니다. 

시스템에 맞는 64 비트 또는 32 비트 바이너리를 가져 오십시오. 전체 명령 행은 64 비트 시스템의 경우 다음 샘플과 유사합니다.:

```bash
pip install --use-wheel --no-index --find-links=https://github.com/sfbahr/PyCrypto-Wheels/raw/master/pycrypto-2.6.1-cp35-none-win_amd64.whl pycrypto
```

## Switch

`Broadlink` 스위치 플랫폼을 사용하면 Broadlink [devices](https://www.ibroadlink.com/).를 제어할 수 있습니다. 

### 설정

활성화하려면 `configuration.yaml` 파일에 다음 행을 추가하십시오:

```yaml
# Example configuration.yaml entry
switch:
  - platform: broadlink
    host: IP_ADDRESS
    mac: 'MAC_ADDRESS'
```

{% configuration %}
host:
  description: 연결할 호스트 이름 / IP 주소입니다..
  required: true
  type: string
mac:
  description: "장치 MAC 주소. 다음 형식을 사용하십시오 `AA:BB:CC:DD:EE:FF`."
  required: true
  type: string
timeout:
  description: 장치 연결에 대한 시간 초과 (초).
  required: false
  type: integer
retry:
  description: 실패한 경우 데이터 fetch에 대한 재시도 시간
  required: false
  type: integer
  default: 2
friendly_name:
  description: 프런트 엔드에 스위치를 표시하는데 사용되는 이름입니다.
  required: false
  type: string
type:
  description: "스위치 타입 중 다음중 하나를 선택: `rm`, `rm2`, `rm_mini`, `rm_pro_phicomm`, `rm2_home_plus`, `rm2_home_plus_gdt`, `rm2_pro_plus`, `rm2_pro_plus2`, `rm2_pro_plus_bl`, `rm_mini_shate`, `sp1`, `sp2`, `honeywell_sp2`, `sp3`, `spmini2`, `spminiplus` 혹은 `mp1`. `SC1` 는 `sp2`로 등록할 수 있습니다."
  required: true
  type: string
switches:
  description: 모든 스위치를 포함하는 배열입니다.
  required: false
  type: map
  keys:
    identifier:
      description: slug로서 커맨드 스위치의 이름. 다중 entry 적용 가능합니다.
      required: true
      type: string
      keys:
        command_on:
          description: ON 시키고자 하는 RM 장치의 Base64 인코딩 패킷
          required: true
          type: string
        command_off:
          description: OFF 시키고자 하는 RM 장치의 Base64 인코딩 패킷
          required: true
          type: string
        friendly_name:
          description: 프런트 엔드에 스위치를 표시하는 데 사용되는 이름입니다.
          required: false
          type: string
slots:
  description: MP1 파워 스트립의 4 개 슬롯의 이름. 별도로 설정하지 않은 경우 슬롯 이름은 `switch's friendly_name + 'slot {slot_index}'`. 입니다.  예) 'MP1 slot 1'
  required: false
  type: map
  keys:
    slot_1:
      description: slot 1 사용자정의 이름
      required: false
      type: string
    slot_2:
      description: slot 2 사용자정의 이름
      required: false
      type: string
    slot_3:
      description: slot 3 사용자정의 이름
      required: false
      type: string
    slot_4:
      description: slot 4 사용자정의 이름
      required: false
      type: string
{% endconfiguration %}

Windows에 설치하는 방법에 대한 정보는 [here](/integrations/broadlink#sensor#microsoft-windows-installation)를 참조하십시오.

### IR/RF 패킷을 습득하는 방법

**Available services:**에서 broadlink.learn Service를 선택하고 "host": "your_broadlink_IP" , "Service Data" JSON 스크립트를 작성하고 **CALL SERVICE**를 누르십시오 . 20 초 안에 리모컨의 버튼을 누르십시오. 패킷은 웹의 States (상태) 페이지에 지속적인 알림으로 표시됩니다.

`rm`, `rm2`, `rm_mini`, `rm_pro_phicomm`, `rm2_home_plus`, `rm2_home_plus_gdt`, `rm2_pro_plus`, `rm2_pro_plus2`, `rm2_pro_plus_bl` 와 `rm_mini_shate` 기기의 설정 예:

```yaml
switch:
  - platform: broadlink
    host: 192.168.1.2
    mac: 'B4:43:0D:CC:0F:58'
    timeout: 15
    retry: 5
    switches:
      # Will work on most Phillips TVs:
      tv_phillips:
        friendly_name: "Phillips Tv Power"
        command_on: 'JgAcAB0dHB44HhweGx4cHR06HB0cHhwdHB8bHhwADQUAAAAAAAAAAAAAAAA='
        command_off: 'JgAaABweOR4bHhwdHB4dHRw6HhsdHR0dOTocAA0FAAAAAAAAAAAAAAAAAAA='
      # Will work on most LG TVs
      tv_lg:
        friendly_name: "LG Tv Power"
        command_on: 'JgBYAAABIJISExETETcSEhISEhQQFBETETcROBESEjcRNhM1EjcTNRMTERISNxEUERMSExE2EjYSNhM2EhIROBE3ETcREhITEgAFGwABH0oSAAwzAAEfShEADQU='
        command_off: 'JgBYAAABIJISExETETcSEhISEhQQFBETETcROBESEjcRNhM1EjcTNRMTERISNxEUERMSExE2EjYSNhM2EhIROBE3ETcREhITEgAFGwABH0oSAAwzAAEfShEADQU='
      tv_lg_hdmi1_hdmi2:
        friendly_name: "LG Tv HDMI12"
        command_on: 'JgBIAAABIZMRExITEjYSExMRERURExEUEDkRNxEUEjYSNhM3ETcSNxITETgSNhI2ExMQExE4ETYSNxIUERMSExE4ETcRFBETEQANBQ=='
        command_off: 'JgBQAAABJJMSEhISETgSEhITEBMSEhMSETcSNxMREjcSNxI3EjcSOBETERITNhM2EhITERM2EzcRNxI3ExISEhI3EjcRExETEgAFLQABJEoRAA0FAAAAAAAAAAA='
      tv_lg_hdmi3:
        friendly_name: "LG Tv HDMI3"
        command_on: 'JgBIAAABIZMSFBISETgRExEUERQQFBETEjcTNhMSETgRNxE3EjcROBM2ERMSFBE4ERMSNxM2EjUSFBE2ETgRExM2ExITEhATEwANBQ=='
      tv_lg_av1_av2:
        friendly_name: "LG Tv AV12"
        command_on: 'JgBIAAABIpQPFBITETgSEw8UEhQSEhEVDzgSOBAUETgQOQ84EjgRNxITETgSExA5EDgREhI3EhMROBMSEDkQFBETEjYTEhE4EQANBQ=='
        command_off: 'JgBIAAABH5YPFBETETgUERAUEBURFBATETgROBEUETcSNxE4ETcSOBISEBUQFREUEjUSFBA5ETcRNxE4ETkQOBAUEjcRFRAUEQANBQ=='
  - platform: broadlink
    host: 192.168.1.2
    mac: 'B4:43:0D:CC:0F:58'
    timeout: 15
    switches:
    # Will work on most Phillips TVs:
      tv:
        friendly_name: "Phillips Tv"
        command_on: 'JgAcAB0dHB44HhweGx4cHR06HB0cHhwdHB8bHhwADQUAAAAAAAAAAAAAAAA='
        command_off: 'JgAaABweOR4bHhwdHB4dHRw6HhsdHR0dOTocAA0FAAAAAAAAAAAAAAAAAAA='
```

`sp1`, `sp2`, `honeywell_sp2`, `sp3`, `spmini2` 및 `spminiplus` 기기들의 설정 예:

```yaml
switch:
  - platform: broadlink
    host: IP_ADDRESS
    mac: 'MAC_ADDRESS'
    type:  sp1
    friendly_name: 'Humidifier'
  - platform: broadlink
    host: IP_ADDRESS
    mac: 'MAC_ADDRESS'
    type:  sp2
    retry: 5
    friendly_name: 'Humidifier'
```

`mp1`의 설정예:

```yaml
switch:
  - platform: broadlink
    host: IP_ADDRESS
    mac: 'MAC_ADDRESS'
    type: mp1
    friendly_name: 'MP1'
    slots:
      # friendly name of slots - optional
      # if not set, slot name will be switch's friendly_name + 'slot {slot_index}'. e.g 'MP1 slot 1'
      slot_1: 'TV slot'
      slot_2: 'Xbox slot'
      slot_3: 'Fan slot'
      slot_4: 'Speaker slot'
```

### Service `broadlink.send`

`broadlink.send` 를 사용하면 각 명령에 스위치 엔터티를 할당 할 필요없이 IR 패킷을 직접 보낼 수 있습니다 .

| Service data attribute | Optional | Description                                             |
| ---------------------- | -------- | ------------------------------------------------------- |
| `host`                 | no       | 명령을 보낼 IP 주소입니다.                                |
| `packet`               | no       | 패킷 데이터를 포함하는 문자열 또는 문자열 목록.             |

예:

```yaml
script:
  tv_select_source:
    sequence:
      - service: broadlink.send
        data:
          host: 192.168.0.107
          packet:
            - "JgCMAJSSFDYUNhQ2FBEUERQRFBEUERQ2FDYUNhQRFBEUERQRFBEUERQRFDYUERQRFBEUERQRFDYUNhQRFDYUNhQ2FDYUNhQABfWUkhQ2FDYUNhQRFBEUERQRFBEUNhQ2FDYUERQRFBEUERQRFBEUERQ2FBEUERQRFBEUERQ2FDYUERQ2FDYUNhQ2FDYUAA0FAAAAAAAAAAAAAAAA"
            - "JgBGAJSTFDUUNhM2ExITEhMSExITEhM2EzYTNhQRFBEUERQRFBEUNRQ2ExITNhMSExITNhMSExITEhM2ExITNhQ1FBEUNhMADQUAAA=="
```

### E-Control remotes 사용시

E-Control 앱에서 리모컨을 이미 익힌 경우, 이 방법을 사용하여 홈 어시스턴트로 원격복사 할 수 있습니다.

먼저 E-Control의 홈 어시스턴트에 추가하려는 모든 리모컨을 얻거나 배우십시오.

1. 다운로드

    [여기](https://github.com/NightRang3r/Broadlink-e-control-db-dump)서 스크립트를 다운로드 받으세요.

2. 앱에서 데이터를 가져오기

    모바일 장치에서 E-Control 앱을 엽니 다. 왼쪽 메뉴에서 "공유"를 선택한 다음 "WLAN의 다른 전화기와 공유"를 선택하십시오. 스크립트에 필요한 파일을 생성합니다.

3. Android 기기에서 데이터 가져 오기

    Android 기기를 컴퓨터에 연결하고 SD 카드 / 외부 저장 폴더“/ broadlink / newremote / SharedData /”를 찾습니다. 다음 파일을 가져 와서이 스크립트와 같은 폴더에 넣어야합니다.:

    jsonSubIr
    jsonButton
    jsonIrCode

4. 설치 요구 사항

    `pip install simplejson` 실행. 스크립트를 실행하는 데 사용할 동일한 Python 버전으로 simplejson을 설치해야합니다. 다시 설치를 시도하고 “요구 사항이 이미 충족되었습니다” 라는 메시지가 표시되면 현재 버전이 설치되어 있는지 확인할 수 있습니다.

5. 장치에서 데이터를 가져 오기

   다운로드 한 폴더로 이동하여 `python getBroadlinkSharedData.py`를 실행하십시오. 화면의 단계를 따르십시오. 참고 :이 스크립트는 Python 2.7에서만 테스트되었습니다.

6. python-broadlink 라이브러리를 설치:

    ```bash
    git clone https://github.com/mjg59/python-broadlink.git
    cd python-broadlink
    sudo python setup.py install
    ```

7. 코드 테스트 하기 

    테스트 장치에서 얻은 코드를 테스트하려면 이미 다운로드 한 `sendcode` 스크립트를 사용하십시오.
    RM Pro IP 주소 및 MAC 주소와 HEX 형식의 코드를 사용하여 스크립트를 편집해야합니다.
    스크립트를 실행할 때 메시지를받을 때 코드가 작동한다는 것을 알게됩니다.
    코드가 전송되었습니다… 모든 코드가 작동하는 것은 아닙니다.

8. 16 진수 코드를 base64로 변환

    [이것](https://tomeko.net/online_tools/hex_to_base64.php?lang=en1)의 도구를 사용 하여 16 진 코드를 base64로 변환하여 Home Assistant와 함께 사용하십시오.

### IOS와 WINDOWS를 사용하여 코드 얻기

1. E-Control 앱을 사용하여 모든 적합한 리모콘에서 코드를 학습하십시오.  리모컨에 따라 버튼 및 / 또는 리모컨에 유용한 이름을 추가하십시오. 결국 이 프로세스를 한 번만 실행하면 Home Assistant로 빠르게 가져갈 수 있습니다. 햄버거 아이콘으로 이동하여 앱에서 파일을 덤프하고 `share and select`를 선택한 후 `Share to other phones on WLAN`을 선택하십시오.

2. 설치 요구 사항

   - Windows PC에 Python 2.7을 다운로드하여 설치하십시오.
   - `pip install simplejson` 실행. 스크립트를 실행하는 데 사용할 동일한 Python 버전으로 simplejson을 설치해야합니다. 다시 설치를 시도하고“요구 사항이 이미 충족되었습니다”라는 메시지가 표시되면 현재 버전이 설치되어 있는지 확인할 수 있습니다.
   - [iBackup Viewer](https://www.imactools.com/iphonebackupviewer/)를 다운로드하여 설치하십시오 ..
   - [이것](https://github.com/NightRang3r/Broadlink-e-control-db-dump)을 github에서 다운로드하십시오. Windows의 \ Python27 경로에 배치하십시오. 다운로드의 getBroadlinkSharedData.py가이 디렉토리에 있는지 확인하십시오.

3. iPhone을 Windows PC에 연결하고 iTunes를 열고 암호화되지 않은 장치 백업을 만듭니다.

4. iBackup 뷰어를 열고 작성한 iOS 백업을 선택하십시오. 앱 아이콘으로 이동 한 다음 e-control.app를 찾을 때까지 스크롤하여 선택하십시오.  jsonButton, jsonIrCode 및 jsonSublr 파일을 선택하고 추출하십시오. 그것들은 Documents/SharedData 섹션에 있습니다. 이것을 getBroadlinkSharedData.py와 같은 위치에 두십시오.

5. 이제 명령 프롬프트를 열고 위에서 언급한 파일이있는 디렉토리 (예 : C:\Python27)로 이동하십시오. 이제 python getBroadlinkSharedData.py 명령을 실행하면 다음과 같은 내용이 표시됩니다.:

    ```bash
    C:\Python27>python getBroadlinkSharedData.py
    ID: 1 | Name: TV
    ID: 2 | Name: Upstairs
    ID: 3 | Name: Sort in order
    ID: 4 | Name: Soundbar
    ID: 5 | Name: TV
    ID: 6 | Name: Xbox One
    ID: 7 | Name: User-Defined Aircon
    ID: 8 | Name: Sort in order
    ID: 9 | Name: User-Defined Aircon
    ID: 10 | Name: Kids Fan
    ID: 11 | Name: Downstairs
    ID: 12 | Name: Ceiling Fan
    ID: 13 | Name: Samsung TV
    ID: 14 | Name: Xbox One
    ID: 15 | Name: SONY SoundBar
    ID: 16 | Name: Fire TV
    ID: 17 | Name: New RF Remote
    ```

   추출하려는 원격 ID를 선택하십시오.:

    ```bash
    Select accessory ID: 5
    [+] You selected:  TV
    [+] Dumping codes to TV.txt
    ```

6. 이제 같은 디렉토리에서 선택한 `.txt`의 리모콘의 이름을 가진 파일이 있어야합니다. 이를 열어 보면 Home Assistant에 필요한 Base64 코드가 있습니다. 이러한 코드가 올바르게 작동하도록하려면 config.yaml 파일의 코드 끝에 `==`를 추가해야 합니다. (또는 스위치가있는 위치에).

### BROADLINK MANAGER로 코드를 얻기 위해 WINDOWS 사용

1. [여기](https://sourceforge.net/projects/broadlink-manager/) SourceForge 링크에서 Broadlink Manager를 설치.
2. 응용 프로그램을 열고 “스캔” 을 눌러 broadlink 장치를 활성화하십시오.
3. “Learn New Command”를 누르고 화면의 지시 사항을 따르십시오.
4. "OnRawData Base64"는 홈 어시스턴트와 함께 사용되는 값입니다.


### NODE-RED를 사용하여 코드 얻기

1. Node-RED에 Broadlink Control 팔레트를 설치하십시오 (오른쪽 상단 모서리에있는 햄버거 메뉴를 클릭하고 설정> 팔레트> 설치 및 Broadlink를 입력 한 후 node-red-contrib-broadlink-control에서 install을 클릭하십시오.
2. 설치가 완료되면 노드 메뉴에서 Broadlink라는 새 팔레트를 사용할 수 있는지 확인하십시오.
3. RM 노드를 빈 플로우로 끌어 두 번 클릭하여 노드를 구성하십시오.
   ```bash
   a. give your RM device a name for easy identification
   b. click on the pencil to edit the device information
   c. enter the MAC address of the Broadlink RM PRO or RM Mini
   d. enter the IP address of the Broadlink RM PRO or RM mini
   e. leave the Catalog field empty.
   ```
4. 업데이트를 클릭하면 장치 필드에 새로 추가 된 장치의 MAC 주소가 표시됩니다. 그렇지 않은 경우라도 그냥 선택하십시오.
5. 액션 필드에서, 학습을 선택한 후 완료를 클릭하세요.
6. Inject 노드를 RM 노드의 왼쪽으로 끌어서 연결하십시오. Inject 유형은 중요하지 않습니다. 기본값으로 두십시오
7. 플로우에서 템플리트 노드를 RM 노드 오른쪽으로 끌어서 RM 노드에 링크하십시오.
8. 템플리트 노드를 더블클릭하여 편집하고 다음을 선택하십시오.:
   ```bash
   Property: msg.payload
   Format: Mustache template
   Template field: enter '{% raw %}{{payload.data}}{% endraw %}'.
   Output as: Plain text
   ```
9. 디버그 노드를 템플리트 노드 오른쪽으로 끌어서 연결하십시오.
10. 디버그 메시지를 표시하고 플로우를 배치 한 후 Inject 단추를 클릭하십시오.
11. 디버그 창에 메시지가 표시됩니다:
    ```bash
    3/23/2019, 9:56:53 AMnode: RM_Mini1
    msg : string[47]
    "Please tap the remote button within 30 seconds."
    ```
12. IR 리모콘을 RM 장치를 가리키고 원하는 버튼을 약 2 초간 클릭하십시오. 숫자 배열이 디버그 창에 표시됩니다. 예를 들면 다음과 같습니다.:
    ```bash
    '38,0,132,3,19,18,19,18,19,18,19,17,20,54,20,54,20,54,19,18,19,18,19,18,19,17,20,17,20,17,20,54,20,17,19,18,19,18,19,18,19,17,20,17,20,54,20,17,20,54,19,55,19,54,20,54,20,54,19,55,19,0,6,6,150,146,20,54,20,54,20,54,19,18,19,18,19,18,19,17,20,17,20,54,20,54,19,55,19,18,19,17,20,17,20,17,20,17,20,17,20,54,19,18,19,18,19,18,19,17,20,17,20,17,20,54,19,18,19,55,19,54,20,54,20,54,20,54,19,55,19,0,6,6,150,146,20,54,20,54,19,55,19,18,19,17,20,17,20,17,20,17,20,54,19,55,19,54,20,17,20,17,20,17,20,17,20,17,19,18,19,55,19,17,20,17,20,17,20,17,20,17,19,18,19,55,19,18,19,54,20,54,20,54,19,55,19,54,20,54,20,0,6,5,150,146,20,54,20,54,20,54,19,18,19,18,19,18,19,17,20,17,20,54,20,54,19,55,19,18,19,17,20,17,20,17,20,17,20,17,20,54,19,18,19,18,19,18,19,17,20,17,20,17,20,54,19,18,19,55,19,54,20,54,20,54,19,55,19,54,20,0,6,6,149,147,20,54,19,55,19,54,20,17,20,17,20,17,20,17,20,17,19,55,19,54,20,54,20,17,20,17,20,17,19,18,19,18,19,18,19,54,20,17,20,17,20,17,20,17,19,18,19,18,19,54,20,17,20,54,20,54,20,54,19,...'
    ```
이것은 동일한 원격 기능을 복제하기 위해 다시 전송해야하는 코드입니다.

### Node red를 이용한 코드 전송

1. 앞에서 만든 것과 동일한 절차에서 다른 RM 노드를 끕니다. RM 노드는 기본적으로 앞에서 만든 RM 장치로 설정되어야합니다.
2. Action 필드에서, - Set from msg.payload - 를 선택하십시오.
3. 인 젝트 노드를 드래그하여“TV On”또는“TV Source”와 같이 리모콘 버튼 기능과 관련된 의미있는 이름을 지정하십시오.
4. 템플리트 노드를 끌어서 두 번 클릭하여 구성하십시오.:
   ```bash
   Property: msg.payload
   Format: Mustache template
   Template: enter the following:
   '{
      "action" : "send",
      "data" : [ 38, 0, 34, 1, 40, 15, 40, 15 ] // Here you must enter the entire code from point 12 above, without the trailing "."
   }'
   In the Output as field, "select Parsed JSON".
   ```
5. 완료를 클릭.
6. 디버그 노드를 드레그해서 RM 노드의 출력에 연결하십시오.
7. Inject 노드를 템플리트 노드에 연결하고 템플리트 노드를 RM 노드에 연결하십시오.
8. 배포를 클릭하여 흐름을 활성화 한 다음 주입 단추를 클릭하십시오. 디버그 창에 디버그 메시지가 표시되어야합니다. 예를 들면 다음과 같습니다.:
   ```bash
   {"action":"send","data":   [38,0,152,0,0,1,39,148,19,18,18,19,18,55,19,18,18,19,18,19,18,19,18,55,18,56,18,19,18,55,18,19,18,56,18,18,19,55,18,19,18,19,18,18,18,56,18,19,18,18,19,55,18,56,18,18,19,18,18,19,18,19,18,55,19,18,18,19,18,19,18,19,18,18,18,19,18,19,18,55,19,55,18,19,18,19,18,18,19,18,18,56,18,19,18,18,19,55,18,56,18,18,19,18,18,19,18,19,18,19,18,18,19,18,18,56,18,55,18,19,18,19,18,19,18,18,19,55,18,19,18,55,19,18,18,56,18,19,18,18,19,18,18,19,18,19,18,19,18,18,18,56,18,0,13,5],"status":"OK"}
   ```
"status" : "OK" 확인”은 Broadlink RM 장치가 연결되어 페이로드를 전송 한 피드백입니다.

이제 각각 특정 코드가있는 템플릿 노드를 여러 개 추가하고 모든 유형의 입력 노드를 추가하여 템플릿을 활성화하고 코드를 전송할 수 있습니다.

### BROADLINK_CLI를 사용하여 코드 얻기

[python-broadlink](https://github.com/mjg59/python-broadlink) project 에서 `broadlink_cli`를 통해 코드를 얻을 수도 있습니다.
먼저 검색을 사용하여 Broadlink 장치를 찾으십시오.:

```bash
./broadlink_discovery 
Discovering...
###########################################
RM2
# broadlink_cli --type 0x2737 --host 192.168.1.137 --mac 36668342f7c8
Device file data (to be used with --device @filename in broadlink_cli) : 
0x2737 192.168.1.137 36668342nnnn
temperature = 0.0
```

그런 다음 cli-command에서 이 정보를 사용하십시오.:

```bash
./broadlink_cli  --learn --device "0x2737 192.168.1.137 36668342nnnn"
Learning...
```

리모컨의 버튼을 누르면 코드가 나타납니다:

```txt
260058000001219512131114113910141114111411141114103911391114103911391139103911391039113911141039111411391015103911141114113910141139111410391114110005250001274b11000c520001274b11000d05
Base64: b'JgBYAAABIZUSExEUETkQFBEUERQRFBEUEDkROREUEDkRORE5EDkRORA5ETkRFBA5ERQRORAVEDkRFBEUETkQFBE5ERQQOREUEQAFJQABJ0sRAAxSAAEnSxEADQU='
```

###  다른 프로젝트로의 코드 변환

오래되거나 안될것같던 장치들도 LIRC 프로젝트에서 수집 한 데이터를 사용하여 코드를 가져 오는 것도 가능합니다.

귀하의 (또는 유사한) 장치가 다음 데이터베이스 중 하나에 있다고 가정합니다.:

- https://sourceforge.net/p/lirc-remotes/code/ci/master/tree/
- https://github.com/probonopd/irdb/tree/master/

[irdb2broadlinkha](https://github.com/molexx/irdb2broadlinkha)프로젝트에서 `irdb2broadlinkha.sh` 프로젝트 코드로 Home Assistant에 적합한 형식으로 변환 할 수 있습니다 .
