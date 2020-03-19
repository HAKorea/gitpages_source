---
title: "샤오미 로봇청소기 Mi Robot Vacuum"
description: "Instructions on how to integrate your Xiaomi Mi Robot Vacuum within Home Assistant."
logo: xiaomi.png
ha_category:
  - Vacuum
ha_release: 0.51
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/5-IslDGfzAQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
<br><br>


`xiaomi_miio` 진공청소기 플랫폼을 사용하면 [Xiaomi Mi Robot Vacuum](https://www.mi.com/roomrobot/)의 상태를 제어 할 수 있습니다

*Note* : **샤오미 2019 LDS 모델**은 [여기](https://github.com/nqkdev/home-assistant-vacuum-styj02ym?files=1)에서 custom component를 사용하십시오.  


현재 지원되는 서비스 :

- `start`
- `pause`
- `stop`
- `return_to_base`
- `clean_spot`
- `set_fan_speed` 
  팬속도 : `Silent`, `Standard`, `Medium`, `Turbo`, `Gentle` (걸레 전용).
- `remote_control_*` (로봇용)
- `xiaomi_clean_zone`

## 설정

`configuration.yaml` 에서 사용할 API 토큰을 검색 하려면 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token) 을 따르십시오.

설비에 진공을 추가하려면 `configuration.yaml`에 다음을 추가하십시오 :

```yaml
vacuum:
  - platform: xiaomi_miio
    host: 192.168.1.2
    token: YOUR_TOKEN
```

{% configuration %}
host:
  description: 로봇의 IP 주소.
  required: true
  type: string
token:
  description: 로봇의 API 토큰.
  required: true
  type: string
name:
  description: 로봇의 이름.
  required: false
  type: string
  default: Xiaomi Vacuum cleaner
{% endconfiguration %}

## 플랫폼 서비스


- `xiaomi_miio.vacuum_remote_control_start`
- `xiaomi_miio.vacuum_remote_control_stop`
- `xiaomi_miio.vacuum_remote_control_move`
- `xiaomi_miio.vacuum_remote_control_move_step`
- `xiaomi_miio.vacuum_clean_zone`

### `xiaomi_miio.vacuum_remote_control_start` 서비스

로봇의 원격 제어 모드를 시작하십시오. 그런 다음 `remote_control_move`로 이동할 수 있습니다; 완료되면 `remote_control_stop`을 호출하십시오. 

| Service data attribute    | Optional | Description                                       |
|---------------------------|----------|---------------------------------------------------|
| `entity_id`               |       no | 특정 로봇에서만 작동                     |

### `xiaomi_miio.vacuum_remote_control_stop` 서비스

로봇의 원격 제어 모드를 종료하십시오.

| Service data attribute    | Optional | Description                                       |
|---------------------------|----------|---------------------------------------------------|
| `entity_id`               |       no | 특정 로봇에서만 작동                      |

### `xiaomi_miio.vacuum_remote_control_move` 서비스

로봇을 원격 제어하십시오. `remote_control_start` 로 리모컨 모드에서 먼저 설정하십시오. 

| Service data attribute    | Optional | Description                                               |
|---------------------------|----------|-----------------------------------------------------------|
| `entity_id`               |       no | 특정 로봇에서만 작동                             |
| `velocity`                |       no | 속도 : -0.29와 0.29 사이                             |
| `rotation`                |       no | 회전 : -179도에서 179도 사이            |
| `duration`                |       no | 로봇이 움직일 수 있는 시간 (밀리 초) |

### `xiaomi_miio.vacuum_remote_control_move_step` 서비스

원격 제어 모드로 들어가서, 한 번 움직이고 멈춘뒤, 원격 모드를 종료하십시오.

| Service data attribute    | Optional | Description                                               |
|---------------------------|----------|-----------------------------------------------------------|
| `entity_id`               |       no | 특정 로봇에서만 작동                              |
| `velocity`                |       no | 속도 : -0.29와 0.29 사이                            |
| `rotation`                |       no | 회전 : -179도에서 179도 사이           |
| `duration`                |       no | 로봇이 움직일 수 있는 시간 (밀리 초) |

### `xiaomi_miio.vacuum_clean_zone` 서비스

표시된 반복 횟수로 선택한 영역에서 청소 작업을 시작하십시오.

| Service data attribute    | Optional | Description                                           |
|---------------------------|----------|-------------------------------------------------------|
| `entity_id`               |       no | 특정 로봇에서만 작동                         |
| `zone`                    |       no | 구역 목록. 각 구역은 4 개의 정수 값으로 구성된 배열입니다. 예시: [[23510,25311,25110,26361]] |
| `repeats`                 |       no | 1에서 3 사이의 각 영역에 대한 청소 반복 횟수. |

`xiaomi_miio.vacuum_clean_zone` 사용예 :

인라인 배열 (inline array) :
{% raw %}

```yaml
automation:
  - alias: Test vacuum zone3
    trigger:
    - event: start
      platform: homeassistant
    condition: []
    action:
    - service: xiaomi_miio.vacuum_clean_zone
      data_template:
        entity_id: vacuum.xiaomi_vacuum
        repeats: '{{states('input_number.vacuum_passes')|int}}'
        zone: [[30914,26007,35514,28807], [20232,22496,26032,26496]]
```

{% endraw %}

인라인 영역이 있는 배열 :
{% raw %}

```yaml
automation:
  - alias: Test vacuum zone3
    trigger:
    - event: start
      platform: homeassistant
    condition: []
    action:
    - service: xiaomi_miio.vacuum_clean_zone
      data_template:
        entity_id: vacuum.xiaomi_vacuum
        repeats: '{{states('input_number.vacuum_passes')|int}}'
        zone:
        - [30914,26007,35514,28807]
        - [20232,22496,26032,26496]
```

{% endraw %}

배열 모드 :

```yaml
automation:
  - alias: Test vacuum zone3
    trigger:
    - event: start
      platform: homeassistant
    condition: []
    action:
    - service: xiaomi_miio.vacuum_clean_zone
      data:
        entity_id: vacuum.xiaomi_vacuum
        repeats: 1
        zone:
        - - 30914
          - 26007
          - 35514
          - 28807
        - - 20232
          - 22496
          - 26032
          - 26496
```

## 속성

[all of the attributes provided by the `vacuum` component](/integrations/vacuum/#attributes)에 추가로, (`battery_icon`, `cleaned_area`, `fan_speed`, `fan_speed_list`, `params`) 사용가능합니다 
`xiaomi` 플랫폼의 특정 속성을 다음 내용에 소개합니다. 

- `cleaning_time`
- `do_not_disturb`
- `main_brush_left`
- `side_brush_left`
- `filter_left`
- `sensor_dirty_left`
- `cleaning_count`
- `total_cleaned_area`
- `total_cleaning_time`
- `clean_start`
- `clean_end`

다음 표는 각 속성의 측정 단위를 보여줍니다. : 

| Attribute                 | Unit of measurement | Description                                                    |
|---------------------------|---------------------|----------------------------------------------------------------|
| `do_not_disturb`          |                     | DND 모드 켜기 / 끄기                                              |
| `cleaning_time`           | minutes             | 마지막/실제 청소 시간 (분) minutes                         |
| `cleaned_area`            | square meter        | 평방 미터 단위의 마지막/실제 청소 영역 meters                    |
| `main_brush_left`         | hours               | 메인 브러시를 교체해야 할 때까지 남은 시간          |
| `side_brush_left`         | hours               | 사이드 브러시 교체가 필요할 때까지 남은 시간          |
| `filter_left`             | hours               | 필터 교환이 필요할 때까지 남은 시간              |
| `sensor_dirty_left`       | hours               | 벽면 및 클리프 센서를 청소해야 할 때까지 남은 시간  |
| `cleaning_count`          |                     | 총 청소 횟수                                |
| `total_cleaned_area`      | square meter        | 평방 미터 단위의 총 청소 면적                            |
| `total_cleaning_time`     | minutes             | 총 청소 시간 (분)                                 |
| `clean_start`             | datetime            | 진공 청소기가 청소를 시작한 마지막 날짜/시간 (offset naive)  |
| `clean_end`               | datetime            | 진공 청소기의 마지막 날짜/시간 (offset naive) |

## 액세스 토큰 검색

<div class='note'>

안드로이드 장치를 사용하여 Mi Home `v5.4.49`로 액세스 토큰을 검색하는 경우 작동합니다 (2019 년 12 월).  Mi Home `v5.4.49`을 사용하여 Smarthome/logs를 찾아 32글자 토큰이 저장된 폴더에서 텍스트 파일을 찾습니다 . 이 디렉토리에는 여러 개의 텍스트 파일이 있을 수 있습니다. 모든 파일에서 'Token'이라는 단어를 검색하면 찾을 수 있습니다. Mi Home의 최신 버전은 일반 텍스트로 토큰을 저장하지 않습니다.
<br/> <br/>
iPhone 앱은 여전히 `v4.23.4` 2019년 11월 17일부터 SQLite DB에 토큰을 저장합니다.
<br/> <br/>
Xiaomi 로봇 진공청소기의 WiFi 설정을 재설정 한 후 새로운 액세스 토큰이 생성되므로 이 지침을 다시 따라야합니다.
<br/> <br/>
이 지침은 새로운 RoboRock 앱이 아닌 Mi Home 앱용으로 작성되었습니다.
<br/> <br/>
이 토큰(16진수 32자)은 Xiaomi Mi Robot Vacuum, Mi Robot 2 (Roborock) Vacuum, Xiaomi Philips Lights 및 Xiaomi IR Remote에 필요합니다. Xiaomi Gateway는 다른 보안 방법을 사용하며 `key`(16자의 영숫자 문자)가 필요합니다 이는 Mi-Home 앱의 숨겨진 메뉴 항목 또는 `miio` command line 도구를 사용하여 쉽게 얻을 수 있습니다. 
</div>

### 안드로이드 (루팅안된)

> 안드로이드 장치를 사용하여 `v5.4.49` Mi Home 의 액세스 토큰을 검색하는 경우 작동합니다 (2019 년 12 월).


1. 시작하려면 기본 Android 기기에서 평소와 같이 최신 버전의 Mi Home으로 Robovac을 설정하십시오.
2. 이 디렉토리에 여러 개의 텍스트 파일이 있을 수 있습니다. 모든 파일에서 'Token'이라는 단어를 검색하면 찾을 수 있습니다. Mi Home의 최신 버전은 일반 텍스트로 토큰을 저장하지 않습니다.

### 리눅스 및 루팅된 안드로이드

1. 시작하려면 기본 Android 기기에서 평소와 같이 최신 버전의 Mi Home으로 Robovac을 설정하십시오.
2. 최신 Mi Home 앱을 사용하여 성공적으로 작동하고 라우터에서 진공청소기에 고정 IP를 제공하거나 LAN에서 수행하십시오.
3. 루팅 된 Android 기기에 Mi Home의 `v5.4.54` 버전을 설치하고 로그인합니다 (두 개의 Mi Home 버전을 동시에 설치할 수 없음)
4. 매번 같은 서버를 사용하고 있는지 확인하십시오
5. 5.4.54를 사용하여 성공적인 작동을 보장하십시오 (locate는 좋은 간단한 테스트입니다)
6. adb를 사용하여 루팅 된 전화에서 토큰을 추출합니다.
7. adb 쉘을 사용하여 장치에 연결하고 루트권한을 가집니다 (Magsck 루트를 사용하는 경우 루트 액세스를 위해 `adb shell-> su-> whoami`를 수행하십시오).
8. 그런 다음 grep -R '"token"' /data/data/com.xiaomi.smarthome 을 실행하고 토큰을 가져옵니다

### iOS

1. Mi Home 앱으로 로봇을 설정하십시오. Xiaomi는 지역마다 다른 제품 이름을 사용하므로 올바른 지역을 선택하십시오. 새로운 RoboRock 앱은 현재 이 방법을 지원하지 않습니다.
2. iTunes를 사용하여 암호화되지 않은 iPhone 백업을 생성하십시오. 
3. [iBackup Viewer](https://www.imactools.com/iphonebackupviewer/)를 설치 하고 연 다음 백업을 여십시오.
4. "Raw Data" 모듈을 Open 합니다.
5. `com.xiaomi.mihome`로 이동하십시오 
6. 다음과 같은 파일을 검색하십시오. : `123456789_mihome.sqlite` (참고 :`_mihome.sqlite`는 올바른 파일이 *아닙니다*. 보통 이 파일은 `Documents` 폴더에 있습니다.)
7. 이 파일을 파일 시스템에 저장하십시오.
8. [DB Browser for SQLite](https://sqlitebrowser.org/) 설치하십시오. 
9. DB 브라우저를 열고 `.sqlite` 백업에서 저장 한 파일을 로드하십시오.
10. `Execute SQL`탭을 클릭 하십시오.
11. 이 쿼리를 입력하고 실행하십시오. :

    ```sql
    SELECT ZTOKEN FROM ZDEVICE WHERE ZMODEL LIKE "%vacuum%"
    ```

12. 반환된 96자리 16진수 문자열을 클립 보드에 복사하십시오.
13. `Terminal`을 열고 명령을 실행하십시오. :

    ```bash
    echo '0: <YOUR HEXADECIMAL STRING>' | xxd -r -p | openssl enc -d -aes-128-ecb -nopad -nosalt -K 00000000000000000000000000000000
    ```

14. 결과값으로 나온 32자리 문자열을 토큰으로 사용하십시오. (맥의 터미널 세션에서)

### 블루스택 (Bluestacks)

1. Mi-Home 앱으로 로봇을 구성하십시오. Xiaomi는 지역마다 다른 제품 이름을 사용하므로 올바른 지역을 선택하십시오. 새로운 RoboRock 앱은 현재이 방법을 지원하지 않습니다.
2. [BlueStacks](https://www.bluestacks.com)를 설치하십시오 .
3. BlueStacks에서 [Mi Home version 5.0.30](https://www.apkmirror.com/apk/xiaomi-inc/mihome/mihome-5-0-30-release/)을 셋업하고 로그인하여 장치를 동기화하십시오.
4. [BlueStacks Tweaker](https://forum.xda-developers.com/general/general/bluestacks-tweaker-2-tool-modifing-t3622681)를 사용하여 파일 시스템에 액세스하고 토큰을 검색하십시오.
5. Bluestacks Tweakers 파일 시스템 도구를 사용하여 `/data/data/com.xiaomi.smarthome/databases/miio2.db` 파일을 컴퓨터에 복사하십시오.
6. [DB Browser for SQLite](https://sqlitebrowser.org/)를 설치하십시오. 
7. DB 브라우저를 열고 컴퓨터에서 `miio2.db`를 로드하십시오
8. DB 브라우저에서 `Browse Data` 탭을 선택하고 `devicerecord`라는 테이블로 전환하십시오
9. 연결된 모든 장치 정보가 토큰과 함께 표시됩니다.

### Miio 컴맨드 라인 도구 (Miio command line tool)

진공 청소기가 Mi Home에 연결되기 전에 Miio를 사용해야합니다. 이미 앱에 연결 한 경우 앱을 삭제 한 다음 Vacuum이 생성하는 Ad-hoc Wi-Fi 네트워크에 가입해야합니다. 진공 상태가 이미 페어링 된 경우이 방법은 `???` 토큰으로만 반환될 수 있습니다.

다음 명령을 사용하여 command line 도구를 설치할 수 있습니다. : 

```bash
npm install -g miio
```

현재 네트워크에서 장치 검색 :

```bash
miio discover
```

컴퓨터와 동일한 네트워크에 연결된 장치가 표시됩니다. 모든 장치가 응답하는데 1 ~ 2 분이 걸릴 수 있으므로 잠시 동안 실행하여 모든 장치에 도달 할 수 있도록 하십시오.

이 명령은 각 장치를 다음 형식으로 출력합니다. : 

```text
Device ID: 48765421
Model info: zhimi.airpurifier.m1
Address: 192.168.100.9
Token: token-as-hex-here via auto-token
Support: At least basic
```

정보 출력은 다음과 같습니다. : 

- `Device ID` - 장치의 고유 식별자는 장치를 재설정해도 변경되지 않습니다..
- `Model ID`- 모델 ID가 결정될 수 있는 경우 모델 유형을 나타냅니다.
- `Address` - 장치의 IP 주소
- `Token` - 장치의 토큰 또는 자동으로 확인할 수 없는 경우 `???`.


## 특정 방을 청소하는 방법에 대한 예

특정 방을 청소하는 데 사용하는 [`vacuum.send_command`](/integrations/vacuum/) 스크립트 예 :

```yaml
vacuum_kitchen:
  alias: "Clean the kitchen"
  sequence:
    - service: vacuum.send_command
      data:
        entity_id: vacuum.xiaomi_vacuum_cleaner
        command: app_segment_clean
        params: [18]
```

params가 룸번호를 지정하는 경우 여러 룸에 대해 params는 `[17,18]`처럼 지정할 수 있습니다

miio command-line 도구를 사용하여 유효한 회의실 번호를 검색 할 수 있습니다. 방 번호만 제공하고 방 이름은 제공하지 않습니다. 방 이름을 얻으려면 app_segment_clean 명령을 테스트하고 어떤 방을 청소하는지 확인할 수 있습니다.

```bash
miio protocol call <ip of the vacuum> get_room_mapping
```

## 유지 보수 시간을 재설정하는 방법에 대한 예 (brushes, filter, sensors)

진공청소기 엔티티는 브러시, 필터 및 센서를 청소하거나 교체해야 할 때의 속성값을 저장합니다 (`main_brush_left`,`side_brush_left`,`filter_left` 및`sensor_dirty_left`). 값은 시간 단위로 측정됩니다. 부품을 청소하거나 교체하면 해당 값을 진공으로 재설정 할 수 있습니다. 다음은 [`vacuum.send_command`](/integrations/vacuum/)를 사용하여 기본 브러시의 시간을 재설정하는 스크립트 예입니다. : 

```yaml
reset_main_brush_left:
  alias: "Reset hours for main brush replacement"
  sequence:
    - service: vacuum.send_Command
      data:
        entity_id: vacuum.xiaomi_vacuum_cleaner
        command: reset_consumable
        params: ['main_brush_work_time']
```

허용 가능한 `params`' `reset_consumable` 명령 :
* `['main_brush_work_time']`
* `['side_brush_work_time']`
* `['filter_work_time']`
* `['sensor_dirty_time']`

## 구역 청소 좌표 검색

### FloleVac(안드로이드) 사용

1. [FloleVac](https://play.google.com/store/apps/details?id=de.flole.xiaomi) 다운로드
2. Xiaomi 자격 증명으로 로그인
3. 지도 열기 (진공 청소기와 동일한 네트워크에 있는지 확인)
4. “Zone cleanup”를 선택하고 청소하려는 구역 주위에 상자를 그립니다. 
5. “Cleanup”을 길게 누르면 영역 좌표가 클립 보드에 복사됩니다.

### ROBOROCK 제어 센터 사용 (VALTUDO 펌웨어 필요)

[RRCC](https://github.com/LazyT/rrcc)는 루팅된 진공청소기 및 루팅되지 않은 진공청소기 모두 지원하며 클라우드없이 로컬로 작동하는 Mi Home을 대체 할 수있는 모든 기능을 갖춘 대체품입니다. 루팅 된 펌웨어 [Valetudo](https://github.com/Hypfer/Valetudo) 를 설치 한 경우 진공청소기로 SSH를 설정하고 MQTT를 활성화하고 클라우드 요구 사항없이 맵 기능을 사용할 수 있습니다.

맵 편집기를 사용하면 영역 정리에 필요한 좌표를 얻을 수 있습니다. 다음은 영역 정리를위한 예제 스크립트입니다. :

```yaml
vacuum_kitchen:
  alias: "vacuum kitchen"
  sequence:
    - service: vacuum.send_command
      data:
        entity_id: 'vacuum.xiaomi_vacuum_cleaner'
        command: app_zoned_clean
        params: [[23084,26282,27628,29727,1]]
```
