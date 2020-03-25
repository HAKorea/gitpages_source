---
title: 비지오 TV(Vizio SmartCast TV)
description: Instructions on how to integrate Vizio SmartCast TVs and sound bars into Home Assistant.
logo: vizio-smartcast.png
ha_category:
  - Media Player
ha_release: 0.49
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@raman325'
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/n1KNQfmgI8A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

Vizio SmartCast 장치는 **설정** -> **통합구성요소** -> **Vizio SmartCast** 로 쉽게 설정 가능합니다. 

`vizio` 통합구성요소를 통해 [SmartCast](https://www.vizio.com/smartcast-app) 호환 TV 및 사운드 바(2016+ 모델)를 제어할 수 있습니다.

## 장치 찾기

`pip`를 사용하여 command line tool으로 설치하거나 수동으로 다운로드하십시오. : 

```bash
$ pip3 install pyvizio
```

or

```bash
$ pip3 install git+https://github.com/vkorn/pyvizio.git@master
```

or

```bash
$ pip3 install -I .
```

Find your device using the following command:
```txt
pyvizio --ip=0 discover
```

IP 주소를 기록해 두십시오. IP 주소 자체를 사용할 수 없는 경우 다음 명령에서 매개 변수로 사용할 때 `:9000` 또는 `:7345`를 추가해야합니다.

## 페어링

장치를 Home Assistant에 추가하기 전에 수동으로 페어링해야 할 수 있습니다. 특히, 사운드 바가 유효한 인증 토큰을 어떻게 알리는지 확실하지 않습니다. 이 경우 먼저 페어링 프로세스를 완전히 건너 뛰고 설정에서 `speaker`로 `device_class`를 지정한 다음 엔터티와 상호 작용하여 성공 여부를 확인하는 것이 가장 좋습니다. 미디어 플레이어 컨트롤이 작동하지 않고 위에서 언급 한대로 다른 포트를 지정해도 작동하지 않으면 이 프로세스 중에 인증 토큰을 얻는 방법을 찾아야합니다.

인증 토큰을 얻으려면 다음 단계를 수행하십시오. : 

계속하기 전에 장치가 켜져 있는지 확인하십시오.

| Parameter       | Description          |
|:----------------|:---------------------|
| `ip`            | IP address (possibly including port) obtained from the previous section |
| `device_type`   | The type of device you are connecting to. Options are `tv` or `speaker` |

페어링을 시작하려면 다음 명령을 입력하십시오. : 

```bash
$ pyvizio --ip={ip} --device_type={device_type} pair
```

시작하면 두 가지 다른 값이 표시됩니다. : 

| Value           | Description          |
|:----------------|:---------------------|
| Challenge type  | Usually it should be `"1"`. If not, use the additional parameter `--ch_type=your_type` in the next step |
| Challenge token | Token required to finalize pairing in the next step |

이때 TV 상단에 PIN 코드가 표시되어야합니다. 이 모든 값을 사용하여 페어링을 완료할 수 있습니다.

```bash
$ pyvizio --ip={ip} --device_type={device_type} pair-finish --token={challenge_token} --pin={pin}
```

Home Assistant를 설정하려면 이 명령으로 리턴된 인증 토큰이 필요합니다.

## 설정

Vizio TV를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
vizio:
  - host: IP_ADDRESS
    access_token: AUTH_TOKEN
```

{% configuration %}
host:
  description: IP address of your device.
  required: true
  type: string
name:
  description: Nickname for your device that will be used to generate the device's entity ID. If multiple Vizio devices are configured, the value must be unique for each entry.
  required: false
  type: string
  default: Vizio SmartCast
access_token:
  description: Authentication token you received in the last step of the pairing process (if applicable).
  required: false
  type: string
device_class:
  description: The class of your device. Valid options are `tv` or `speaker`
  required: false
  type: string
  default: tv
volume_step:
  description: The number of steps that the volume will be increased or decreased by at a time.
  required: false
  type: integer
  default: 1
{% endconfiguration %}

## 참고사항과 한계점

### 장치 켜기

장치의 `Power Mode`가 `Eco Mode`로 설정되어 있으면 장치를 켤 수 없습니다.

### 트랙 변경

트랙 변경은 채널 전환처럼 작동합니다. 현재 입력이 일반 TV 이외의 것이면 이 명령은 아무 것도 수행하지 않을 수 있습니다.

### 입력 신호(Sources)

입력 목록에는 HDMI를 통해 Vizio 장치에 연결된 모든 외부 장치와 내부 장치 (TV mode, Chromecast 등) 목록이 표시됩니다.