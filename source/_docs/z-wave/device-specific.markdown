---
title: "Z-Wave 장치별 설정"
description: "Notes for specific Z-Wave devices."
redirect_from: /getting-started/z-wave-device-specific/
---

## 장치 카테고리

### 모션 또는 알람 센서

홈어시스턴트가 센서를 올바르게 인식하려면 설정을 `Basic Set (default)`에서 `Binary Sensor report` 또는 `Alarm report`로 변경해야합니다.
이러한 장치는 이진 센서 또는 `Alarm xxxx`라는 센서로 표시되며 숫자값을 보고합니다. 어떤 값이 무엇인지 테스트하십시오. 때로는 장치 설명서에 나와 있습니다.

Z-Wave 제어판을 통해 Z-Wave 장치의 설정을 지정할 수 있습니다.

### 잠금 장치와 기타 보안 장치 (Locks and other secure devices)

이러한 장치는 **Add Node Secure** 옵션을 사용하여 Z-Wave 네트워크에 대해 네트워크 키를 설정해야합니다.

홈어시스턴트는 홈어시스턴트 설정 디렉토리의 OZW_log.txt에 Z-Wave의 로그를 저장합니다. 보안 장치를 페어링할 때 장치가 보안 연결과 성공적으로 페어링되면 `OZW_log.txt`의 `info: NONCES`로 시작하는 라인으로 노드와 통신하는 것이 보일 것입니다.

### 특정 장치들

### Aeotec Z-Stick

Z-Wave 스틱이 시스템에 연결되어있는 동안 LED(노란색, 파란색 및 빨간색)가 순환하는 것은 완전히 정상입니다. 이 동작이 마음에 들지 않으면 끌 수 있습니다.

Z-Wave 스틱이 연결된 Pi의 터미널 세션에서 다음 예제 명령을 사용하십시오.

**참고:** 홈어시스턴트가 중지된 경우에만 이 작업을 수행해야합니다.

"Disco 조명"을 끕니다. : 

```bash
$ echo -e -n "\x01\x08\x00\xF2\x51\x01\x00\x05\x01\x51" > /dev/serial/by-id/usb-0658_0200-if00
```

Turn on "Disco lights":

```bash
$ echo -e -n "\x01\x08\x00\xF2\x51\x01\x01\x05\x01\x50" > /dev/serial/by-id/usb-0658_0200-if00
```

위의 두 명령으로 해당 장치가 없는 오류가 발생하면 `/dev/serial/by-id/usb-0658_0200-if00`를 `/dev/ttyACM0` 혹은 `/dev/ttyACM1`로 바꿔보십시오.((Aeotec 스틱이 어느 tty에 연결되어 있는지에 따라.)

macOS와 같은 일부 시스템에서는 보드를 올바르게 설정하기 위해 serial 장치로 리디렉션하는 대신 `echo` 명령의 출력을 `cu`(`/dev/zstick` 대체)로 연결하고 baud rate를 115200bps 속도로 적당히 세팅해줘야합니다. :

```bash
echo -e -n "...turn on/off string from examples above..." | cu -l /dev/zstick -s 115200
```

### Razberry Board

보드에 하드웨어 UART를 사용해야하고 Pi3에는 하드웨어가 하나만 있기 때문에 온보드 Bluetooth를 비활성화해야합니다. `/boot/config.txt`의 끝에 다음을 추가하면됩니다 :

```text
dtoverlay=pi3-disable-bt
```

그런 다음 Bluetooth 모뎀 서비스를 비활성화하십시오. : 

```bash
$ sudo systemctl disable hciuart
```

Bluetooth가 꺼지면 `raspi-config` 도구를 통해 serial 인터페이스를 활성화하십시오. 재부팅 후 :

```bash
$ sudo systemctl mask serial-getty@ttyAMA0.service
```

serial 인터페이스는 다음과 같습니다.

```text
crw-rw---- 1 root dialout 204, 64 Sep  2 14:38 /dev/ttyAMA0
```
이 시점에서 간단히 사용자 (homeassistant)를 dialout 그룹에 추가하십시오.

```bash
$ sudo usermod -a -G dialout homeassistant
```

<div class='note'>

  Z-Way 소프트웨어를 설치한 경우 Home Assistant를 설치하기 전에 소프트웨어를 비활성화해야합니다. 그렇지 않으면 보드에 액세스할 수 없습니다. `sudo /etc/init.d/z-way-server stop; sudo update-rc.d z-way-server disable`를 실행하십시오. 

</div>

### Aeon Minimote

다음은 가능한 모든 버튼 누름을 정의하는 Aeon Labs Minimote의 편리한 설정입니다. `automation.yaml`에 넣으십시오.

```yaml
  - id: mini_1_pressed
    alias: 'Minimote Button 1 Pressed'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 1
  - id: mini_1_held
    alias: 'Minimote Button 1 Held'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 2
  - id: mini_2_pressed
    alias: 'Minimote Button 2 Pressed'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 3
  - id: mini_2_held
    alias: 'Minimote Button 2 Held'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 4
  - id: mini_3_pressed
    alias: 'Minimote Button 3 Pressed'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 5
  - id: mini_3_held
    alias: 'Minimote Button 3 Held'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 6
  - id: mini_4_pressed
    alias: 'Minimote Button 4 Pressed'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 7
  - id: mini_4_held
    alias: 'Minimote Button 4 Held'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.aeon_labs_minimote_1
          scene_id: 8
```

### Zooz Toggle Switches

Zooz 토글 스위치의 일부 모델에는 Z-Wave 포함/제외에 대한 지침이 잘못된 사용 설명서가 함께 제공됩니다. 지침에 따르면 스위치를 신속하게 on-off-on를 누르면 포함되고 off-on-off를 누르면 제외하도록 되어 있습니다. 그러나 올바른 방법은 포함을 위해 on-on-on이고 제외를 위해 off-off-off 입니다.

## Central Scene configuration

Central Scene을 지원하려면 **shutdown Home Assistant** 를 종료하고 다음 안내서에 따라 `zwcfg_*.xml` 파일을 수정해야합니다.

### Inovelli Scene Capable On/Off and Dimmer Wall Switches

Inovelli 스위치의 경우, 다음과 같이 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 업데이트하거나 추가해야합니다.

```xml
			<CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="0">
				<Instance index="1" />
				<Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="2" />
				<Value type="int" genre="user" instance="1" index="1" label="Bottom Button Scene" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="3" />
				<Value type="int" genre="user" instance="1" index="2" label="Top Button Scene" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="3" />
			</CommandClass>
```

이것이 완료되면 다음과 같은 `zwave.scene_activated` 이벤트가 나타납니다.

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Double tap off|1|3
Double tap on|2|3
Triple tap off|1|4
Triple tap on|2|4
4x tap off|1|5
4x tap on|2|5
5x tap off|1|6
5x tap on|2|6

### Zooz Scene Capable On/Off and Dimmer Wall Switches (Zen26 & Zen27 - Firmware 2.0+)

판매된 많은 Zooz Zen26/27 스위치에는 펌웨어 2.0 이상이 없습니다. 무선 펌웨어 업데이트 지침과 스위치에 대한 새로운 사용 설명서를 얻으려면 Zooz에 문의하십시오.

펌웨어가 업데이트되면 새로운 구성 매개 변수를 `zwcfg` 파일에 추가해야합니다. 기존 `COMMAND_CLASS_CONFIGURATION`을 다음 옵션 중 하나로 바꿉니다 (스위치 모델에 따라 다름). : 

Zen26 (On/Off Switch):
```xml
<CommandClass id="112" name="COMMAND_CLASS_CONFIGURATION" version="1" request_flags="4" innif="true">
	<Instance index="1" />
	<Value type="list" genre="config" instance="1" index="1" label="Paddle Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="2" vindex="0" size="1">
		<Help>Normal mode: Upper paddle turns the light on, lower paddle turns the light off. Reverse will reverse those functions. Any will toggle the light regardless of which button is pushed.</Help>
		<Item label="Normal" value="0" />
		<Item label="Reverse" value="1" />
		<Item label="Any" value="2" />
	</Value>
	<Value type="list" genre="config" instance="1" index="2" label="LED Indication Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="3" vindex="0" size="1">
		<Help>LED Indication light function. Normal has the LED Indication on when the switch is off, off when the switch is on.</Help>
		<Item label="Normal" value="0" />
		<Item label="Reverse" value="1" />
		<Item label="Always Off" value="2" />
		<Item label="Always On" value="3" />
	</Value>
	<Value type="list" genre="config" instance="1" index="3" label="Enable Turn-Off Timer" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="0" size="1">
		<Help>Enable or disable the auto turn-off timer function.</Help>
		<Item label="Disabled (Default)" value="0" />
		<Item label="Enabled" value="1" />
	</Value>
	<Value type="int" genre="config" instance="1" index="4" label="Turn-Off Timer Duration" units="minutes" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="1" max="65535" value="1">
		<Help>Time, in seconds, for auto-off timer delay. 60 (default).</Help>
	</Value>
	<Value type="list" genre="config" instance="1" index="5" label="Enable Turn-On Timer" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="0" size="1">
		<Help>Enable or disable the auto turn-on timer function.</Help>
		<Item label="Disabled (Default)" value="0" />
		<Item label="Enabled" value="1" />
	</Value>
	<Value type="int" genre="config" instance="1" index="6" label="Turn-On Timer Duration" units="minutes" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="1" max="65535" value="55">
		<Help>Time, in minutes, for auto-on timer delay. 60 (default).</Help>
	</Value>
	<Value type="list" genre="config" instance="1" index="8" label="On Off Status After Power Failure" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="2" vindex="2" size="1">
		<Help>Status after power on after power failure. OFF will always turn light off. ON will always turn light on. Restore will remember the latest state and restore that state.</Help>
		<Item label="OFF" value="0" />
		<Item label="ON" value="1" />
		<Item label="Restore" value="2" />
	</Value>
	<Value type="list" genre="config" instance="1" index="10" label="Scene Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="0" size="1">
		<Help>Enable or disable scene control functionality for quick double tap triggers.</Help>
		<Item label="Disabled (Default)" value="0" />
		<Item label="Enabled" value="1" />
	</Value>
	<Value type="list" genre="config" instance="1" index="11" label="Enable/Disable Paddle Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="1" size="1">
		<Help>Enable or disable local on/off control. If enabled, you&apos;ll only be able to control the connected light via Z-Wave.</Help>
		<Item label="Disabled" value="0" />
		<Item label="Enabled (Default)" value="1" />
	</Value>
</CommandClass>
```

Zen27 (Dimmer):
```xml
<CommandClass id="112" name="COMMAND_CLASS_CONFIGURATION" version="1" request_flags="4" innif="true">
	<Instance index="1" />
	<Value type="list" genre="config" instance="1" index="1" label="Paddle Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="2" vindex="0" size="1">
		<Help>Normal mode: Upper paddle turns the light on, lower paddle turns the light off. Reverse will reverse those functions. Any will toggle the light regardless of which button is pushed.</Help>
		<Item label="Normal" value="0" />
		<Item label="Reverse" value="1" />
		<Item label="Any" value="2" />
	</Value>
	<Value type="list" genre="config" instance="1" index="2" label="LED Indication Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="3" vindex="0" size="1">
		<Help>LED Indication light function. Normal has the LED Indication on when the switch is off, off when the switch is on.</Help>
		<Item label="Normal" value="0" />
		<Item label="Reverse" value="1" />
		<Item label="Always Off" value="2" />
		<Item label="Always On" value="3" />
	</Value>
	<Value type="list" genre="config" instance="1" index="3" label="Enable Auto Turn-Off Timer" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="0" size="1">
		<Item label="Disabled" value="0" />
		<Item label="Enabled" value="1" />
	</Value>
	<Value type="int" genre="config" instance="1" index="4" label="Auto Turn-Off Timer Duration" units="minutes" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="1" max="65535" value="60">
		<Help>Time, in minutes, for auto-off timer delay.</Help>
	</Value>
	<Value type="list" genre="config" instance="1" index="5" label="Enable Auto Turn-On Timer" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="0" size="1">
		<Item label="Disabled" value="0" />
		<Item label="Enabled" value="1" />
	</Value>
	<Value type="int" genre="config" instance="1" index="6" label="Auto Turn-On Timer Duration" units="minutes" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="1" max="65535" value="60">
		<Help>Time, in minutes, for auto-off timer delay.</Help>
	</Value>
	<Value type="list" genre="config" instance="1" index="8" label="On Off Status After Power Failure" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="2" vindex="2" size="1">
		<Help>Status after power on after power failure. OFF will always turn light off. ON will always turn light on. Restore will remember the latest state and restore that state.</Help>
		<Item label="OFF" value="0" />
		<Item label="ON" value="1" />
		<Item label="Restore" value="2" />
	</Value>
	<Value type="byte" genre="config" instance="1" index="9" label="Ramp Rate Control" units="seconds" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="1" max="99" value="3">
		<Help>Adjust the ramp rate for your dimmer (fade-in / fade-out effect for on / off operation). Values correspond to the number of seconds it take for the dimmer to reach full brightness or turn off when operated manually.</Help>
	</Value>
	<Value type="byte" genre="config" instance="1" index="10" label="Minimum Brightness" units="%" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="1" max="99" value="99">
		<Help>Set the minimum brightness level for your dimmer. You won&apos;t be able to dim the light below the set value.</Help>
	</Value>
	<Value type="byte" genre="config" instance="1" index="11" label="Maximum Brightness" units="%" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="1" max="99" value="99">
		<Help>Set the maximum brightness level for your dimmer. You won&apos;t be able to add brightness to the light beyond the set value. Note: if Parameter 12 is set to value &quot;Full&quot;, Parameter 11 is automatically disabled.</Help>
	</Value>
	<Value type="list" genre="config" instance="1" index="12" label="Double Tap Function Brightness" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="0" size="1">
		<Help>Double Tap action. When set to Full, turns light on to 100%. If set to Maximum Level, turns light on to % set in Parameter 11.</Help>
		<Item label="Full" value="0" />
		<Item label="Maximum Level" value="1" />
	</Value>				
	<Value type="list" genre="config" instance="1" index="13" label="Scene Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="0" size="1">
		<Help>Enable or disable scene control functionality for quick double tap triggers.</Help>
		<Item label="Disabled" value="0" />
		<Item label="Enabled" value="1" />
	</Value>
	<Value type="list" genre="config" instance="1" index="14" label="Enable Double Tap Function" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="2" vindex="0" size="1">
		<Help>Enable the double tap or disable the double tap function and assign brightness level to single tap.</Help>
		<Item label="Enabled" value="0" />
		<Item label="Disabled - Single Tap To Last Brightness" value="1" />
		<Item label="Disabled - Single Tap To Max Brightness" value="2" />
	</Value>
	<Value type="list" genre="config" instance="1" index="15" label="Enable/Disable Paddle Control" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="0" max="1" vindex="1" size="1">
		<Help>Enable or disable local on/off control. If enabled, light will only be able to be controlled via Z-Wave.</Help>
		<Item label="Disabled" value="0" />
		<Item label="Enabled" value="1" />
	</Value>
</CommandClass>
```

Zooz 스위치의 경우 다음과 같이 `zwcfg`파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 업데이트(또는 추가)해야합니다.
```xml
<CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="0">
	<Instance index="1" />
	<Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="2" />
	<Value type="int" genre="user" instance="1" index="1" label="Bottom Button Scene" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="3" />
	<Value type="int" genre="user" instance="1" index="2" label="Top Button Scene" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="3" />
</CommandClass>
```

홈어시스턴트 설정의 Z-Wave 네트워크 관리 섹션으로 이동하여 방금 업데이트된 노드를 선택하고 씬(scene) 지원 설정 매개 변수를 활성화하십시오.

이것이 완료되면 다음과 같은 `zwave.scene_activated` 이벤트가 나타납니다 :

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Single tap off|1|7680
Single tap on|2|7680
Double tap off|1|7860
Double tap on|2|7860
Triple tap off|1|7920
Triple tap on|2|7920
4x tap off|1|7980
4x tap on|2|7980
5x tap off|1|8040
5x tap on|2|8040

### HomeSeer Switches

특히 HomeSeer 장치의 경우 다음과 같이 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 업데이트해야합니다.

```xml
<CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="0">
  <Instance index="1" />
  <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false"   verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="2" />
  <Value type="int" genre="user" instance="1" index="1" label="Top Button Scene" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
  <Value type="int" genre="user" instance="1" index="2" label="Bottom Button Scene" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
</CommandClass>
```

아래는 HomeSeer 장치의 액션/씬 표입니다 (다른 유사한 장치에 대한 참조).

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Single tap on|1|0
Single tap off|2|0
Double tap on|1|3
Double tap off|2|3
Triple tap on|1|4
Triple tap off|2|4
Tap and hold on|1|2
Tap and hold off|2|2

일부 설치에는 다음 세부 정보가 표시됩니다. : 

**Top button ID: 1, Bottom ID: 2**

**Action**|**scene\_data**
:-----:|:-----:
Single Press|7800
Hold Button|7740
2x Tap|7860
3x Tap|7920
4x Tap|7980
5x Tap|8040


### Fibaro Button FGPB-101-6 v3.2

<!-- from https://hastebin.com/esodiweduq.cs -->

Button의 경우 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 다음과 같이 업데이트해야합니다. : 

```xml
      <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="0">
        <Instance index="1" />
          <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
          <Value type="int" genre="system" instance="1" index="1" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="3" />
      </CommandClass>
```

아래는 버튼의 액션/씬 표입니다(다른 유사한 장치에 대한 참조).

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Single tap on|1|0
Double tap on|1|3
Triple tap on|1|4

길게 누르면 버튼이 깨어납니다.

### Fibaro Keyfob FGKF-601


Fibaro Keyfob의 경우 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 다음과 같이 업데이트해야합니다.

```xml
      <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="6">
	<Instance index="1" />
	<Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="6" />
	<Value type="int" genre="user" instance="1" index="1" label="Square" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	<Value type="int" genre="user" instance="1" index="2" label="Circle" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	<Value type="int" genre="user" instance="1" index="3" label="X" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	<Value type="int" genre="user" instance="1" index="4" label="Triangle" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	<Value type="int" genre="user" instance="1" index="5" label="Minus" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	<Value type="int" genre="user" instance="1" index="6" label="Plus" units="" read_only="false" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
</CommandClass>
```

아래는 Keyfob의 액션/씬 표입니다 (다른 유사한 장치에 대한 참조).

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Button one (Square) single tap|1|7680
Button one (Square) hold|1|7800
Button one (Square) release|1|7740
Button two (Circle) single tap|2|7680
Button two (Circle) hold|2|7800
Button two (Circle) release|2|7740
Button three (X) single tap|3|7680
Button three (X) hold|3|7800
Button three (X) release|3|7740
Button four (Triangle) single tap|4|7680
Button four (Triangle) hold|4|7800
Button four (Triangle) release|4|7740
Button five (Triangle) single tap|5|7680
Button five (Triangle) hold|5|7800
Button five (Triangle) release|5|7740
Button six (Triangle) single tap|6|7680
Button six (Triangle) hold|6|7800
Button six (Triangle) release|6|7740

서클과 플러스를 동시에 눌러 기기를 깨웁니다.

### Aeotec NanoMote Quad

<!-- from https://products.z-wavealliance.org/products/2817 -->

z-wave 네트워크에 NanoMote를 추가한 후에는 아래 xml 데이터로 zwcfg_\*.xml 파일을 업데이트해야합니다. 홈어시스턴트를 중지하고 zwcfg_\*.xml 파일(config 폴더에 있음)을 여십시오. NanoMote 장치 섹션을 찾은 다음 id="91"로 해당하는 `CommandClass` 섹션을 찾으십시오. 전체 CommandClass 섹션을 아래 xml 데이터로 바꾸십시오. 파일을 저장하고 Home Assistant를 다시 시작하십시오.

```xml
    <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="0">
        <Instance index="1" />
        <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        <Value type="int" genre="system" instance="1" index="1" label="Button One" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        <Value type="int" genre="system" instance="1" index="2" label="Button Two" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        <Value type="int" genre="system" instance="1" index="3" label="Button Three" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        <Value type="int" genre="system" instance="1" index="4" label="Button Four" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
    </CommandClass>
```

아래는 NanoMote Quad의 액션/씬 표입니다.

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Button one single tap|1|7680
Button one hold|1|7800
Button one release|1|7740
Button two single tap|2|7680
Button two hold|2|7800
Button two release|2|7740
Button three single tap|3|7680
Button three hold|3|7800
Button three release|3|7740
Button four single tap|4|7680
Button four hold|4|7800
Button four release|4|7740

Event 예시 :

```yaml
    "event_type": "zwave.scene_activated",
    "data": {
        "entity_id": "zwave.nanomote",
        "scene_id": 2,
        "scene_data": 7680
    }
```

### Aeotec Wallmote

<!-- from https://hastebin.com/esodiweduq.cs -->

Aeotec Wallmote의 경우 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 다음과 같이 업데이트해야합니다.

```xml
      <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="5" innif="true" scenecount="0">
        <Instance index="1" />
          <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
          <Value type="int" genre="system" instance="1" index="1" label="Button One" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
          <Value type="int" genre="system" instance="1" index="2" label="Button Two" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
          <Value type="int" genre="system" instance="1" index="3" label="Button Three" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
          <Value type="int" genre="system" instance="1" index="4" label="Button Four" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
          <Value type="int" genre="system" instance="1" index="5" label="Other" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      </CommandClass>
```

다음은 Wallmote의 액션/씬 표입니다 (다른 유사한 장치에 대한 참조).

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Button one single tap|1|0
Button one hold|1|2
Button one release|1|1
Button two single tap|2|0
Button two hold|2|2
Button two release|2|1
Button three single tap|3|0
Button three hold|3|2
Button three release|3|1
Button four single tap|4|0
Button four hold|4|2
Button four release|4|1

### WallC-S Switch

Aeotec Wallmote와 동일한 설정을 사용하십시오.

### HANK One-key Scene Controller HKZN-SCN01/HKZW-SCN01

HANK One-key Scene Controller의 경우 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 다음과 같이 업데이트해야합니다.

```xml
      <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="1" innif="true" scenecount="0">
        <Instance index="1" />
        <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        <Value type="int" genre="system" instance="1" index="1" label="Button One" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      </CommandClass>
```

아래는 버튼의 액션/씬 표입니다 (다른 유사한 장치에 대한 참조).

**Action**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:
Button single tap|1|0
Button hold|1|2
Button release|1|1

### HANK Four-key Scene Controller HKZN-SCN04

HANK 4 키 씬 컨트롤러의 경우 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 다음과 같이 업데이트해야합니다.

```xml
      <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="5" innif="true" scenecount="0">
        <Instance index="1" />
        <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        <Value type="int" genre="system" instance="1" index="1" label="Button One" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        <Value type="int" genre="system" instance="1" index="2" label="Button Two" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="1" />
        <Value type="int" genre="system" instance="1" index="3" label="Button Three" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="1" />
        <Value type="int" genre="system" instance="1" index="4" label="Button Four" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="1" />
        <Value type="int" genre="system" instance="1" index="5" label="Other" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      </CommandClass>
```

아래는 버튼과 관련 픽토그램(Pictogram)의 액션/씬 표입니다.

**Action**|**Pictogram**|**scene\_id**|**scene\_data**
:-----:|:-----:|:-----:|:-----:
Button one tap|Moon and Star|1|0
Button one hold|Moon and Star|1|2
Button one release|Moon and Star|1|1
Button two tap|People|2|0
Button two hold|People|2|2
Button two release|People|2|1
Button three tap|Circle|3|0
Button three hold|Circle|3|2
Button three release|Circle|3|1
Button four tap|Circle with Line|4|0
Button four hold|Circle with Line|4|2
Button four release|Circle with Line|4|1

### Remotec ZRC-90 Scene Master

ZRC-90 Scene Master가 Home Assistant에서 작동하게 하려면 먼저 `zwcfg` 파일에 서`COMMAND_CLASS_CENTRAL_SCENE`을 편집해야합니다.

1. 홈어시스턴트의 Z-Wave 제어판으로 이동하여 ZRC-90이 할당된 노드 번호를 기록하십시오.
2. 홈어시스턴트 *Stop*.
3. 만일을 대비하여 `zwfcg` 파일을 백업하십시오.
4. `zwcfg` 파일에서 첫 번째 단계에서 적어둔 번호에 해당하는 `Node id`를 찾으십시오.
5. 식별한 `Node id`에서`<CommandClass id="91"`와 `</CommandClass>`사이의 모든 항목을 강조 표시하고 다음을 붙여넣습니다. : 

    ```xml
    <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="5" innif="true" scenecount="0">
      <Instance index="1" />
      <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      <Value type="int" genre="system" instance="1" index="1" label="Scene 1" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="3" />
      <Value type="int" genre="system" instance="1" index="2" label="Scene 2" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      <Value type="int" genre="system" instance="1" index="3" label="Scene 3" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      <Value type="int" genre="system" instance="1" index="4" label="Scene 4" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="1" />
      <Value type="int" genre="system" instance="1" index="5" label="Scene 5" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      <Value type="int" genre="system" instance="1" index="6" label="Scene 6" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      <Value type="int" genre="system" instance="1" index="7" label="Scene 7" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      <Value type="int" genre="system" instance="1" index="8" label="Scene 8" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
      <Value type="int" genre="system" instance="1" index="9" label="Other" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
    </CommandClass>
    ```

6. `zwcfg` 파일의 변경 사항을 저장하고 Home Assistant 백업을 시작하십시오.

버튼을 누르면 다음과 같이 `zwave.scene_activated`가 트리거됩니다.

- `node_id`: the node of your Scene Master (useful if you have more than one)
- `scene_id`: the number button you press (1-8)
- `scene_data`: the type of press registered (see below)

Scene Master에는 4 개의 액션을 보낼 수있는 8 개의 버튼이 있습니다.
액션 유형은 `scene_data` 매개 변수에 반영됩니다. : 

**Action**|**scene\_data**
:-----:|:-----:
Single press | 0
Long press (2s) | 1
Release from hold | 2
Double-press | 3

노드 7로 지정된 Scene Master의 자동화에서 이것이 어떻게 작동하는지 봅시다. : 

```yaml
- id: '1234567890'
  alias: Double-press Button 2 to toggle all lights
  trigger:
  - platform: event
    event_type: zwave.scene_activated
    event_data:
      node_id: 7
      scene_id: 2
      scene_data: 3  
  condition: []
  action:
  - data:
    service: light.toggle
      entity_id: group.all_lights
```

### RFWDC Cooper 5-button Scene Control Keypad

RFWDC Cooper 5 버튼 씬 제어 키패드의 경우 `zwcfg` 파일의 각 노드에 대해 `COMMAND_CLASS_CENTRAL_SCENE`을 다음과 같이 업데이트해야합니다.

```xml
<CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="5" innif="true" scenecount="0">
  <Instance index="1" />
  <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
  <Value type="int" genre="system" instance="1" index="1" label="Button One" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
  <Value type="int" genre="system" instance="1" index="2" label="Button Two" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
  <Value type="int" genre="system" instance="1" index="3" label="Button Three" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
  <Value type="int" genre="system" instance="1" index="4" label="Button Four" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
  <Value type="int" genre="system" instance="1" index="5" label="Button Five" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
</CommandClass>
```

아래는 버튼의 액션/씬의 표입니다.

**Action**|**scene\_id**
:-----:|:-----:
Button one tap|1
Button two tap|2
Button three tap|3
Button four tap|4
Button five tap|5

버튼이 꺼지면 컨트롤러는 일반 `node_event`에서 `basic_set`을 보내고 어떤 버튼을 눌렀는지 지정하지 않습니다. 버튼의 상태는 `indicator` 값으로 인코딩되므로 각 버튼의 상태를 확인하려면 indicator 값을 새로 고쳐야합니다. indicator 값을 설정하여 각 버튼의 LED를 제어할 수도 있습니다. 응답성을 위해서는 스위치 상태가 아닌 `zwave.scene_activated` 이벤트로 자동화를 트리거해야합니다.

씬 컨트롤러에 필요한 설정 예는 다음과 같습니다.

{% raw %}
```yaml
automation:
  - alias: Sync the indicator value on button events
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          entity_id: zwave.scene_contrl
      - platform: event
        event_type: zwave.node_event
        event_data:
          entity_id: zwave.scene_contrl
    action:
      - service: zwave.refresh_node_value
        data_template: 
          node_id: 3
          value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
switch:
  - platform: template
    switches:
      button_1_led:
        value_template: "{{ states('sensor.scene_contrl_indicator')|int|bitwise_and(1) > 0 }}"
        turn_on:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int + 1 }}"
        turn_off:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int - 1 }}"
      button_2_led:
        value_template: "{{ states('sensor.scene_contrl_indicator')|int|bitwise_and(2) > 0 }}"
        turn_on:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int + 2 }}"
        turn_off:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int - 2 }}"
      button_3_led:
        value_template: "{{ states('sensor.scene_contrl_indicator')|int|bitwise_and(4) > 0 }}"
        turn_on:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int + 4 }}"
        turn_off:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int - 4 }}"
      button_4_led:
        value_template: "{{ states('sensor.scene_contrl_indicator')|int|bitwise_and(8) > 0 }}"
        turn_on:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states(scene_contrl_indicator)|int + 8 }}"
        turn_off:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int - 8 }}"
      button_5_led:
        value_template: "{{ states('sensor.scene_contrl_indicator')|int|bitwise_and(16) > 0 }}"
        turn_on:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int + 16 }}"
        turn_off:
          service: zwave.set_node_value
          data_template:
            node_id: 3
            value_id: "{{ state_attr('sensor.scene_contrl_indicator','value_id') }}"
            value: "{{ states('sensor.scene_contrl_indicator')|int - 16 }}"
```

### HeatIt/ThermoFloor Z-Push Button 2/8 Wall Switch

Z-Push Button 2 또는 Z-Push Button 8을 Home Assistant에서 작동시키려면 먼저 `zwcfg` 파일에서 `COMMAND_CLASS_CENTRAL_SCENE`을 편집해야합니다.

1. 홈어시스턴트의 Z-Wave 제어판으로 이동하여 벽 스위치에 할당된 노드 번호를 기록하십시오.
2. 홈어시스턴트 *Stop*.
3. 만일을 대비하여 `zwfcg` 파일을 백업하십시오.
4. `zwcfg` 파일에서 첫 번째 단계에서 적어둔 번호에 해당하는 `Node id`를 찾으십시오.
5. 식별한 `Node id`에서 `<CommandClass id="91"`와 `</CommandClass>` 사이의 모든 항목을 강조 표시하고 다음을 붙여 넣습니다. :
    - 5.1 For the Z-Push Button 2:

    ```xml
        <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="0">				<Instance index="1" />
	    <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="1" label="Button 1" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="2" label="Button 2" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        </CommandClass>
    ```

    - 5.2 For the Z-Push Button 8:

    ```xml
        <CommandClass id="91" name="COMMAND_CLASS_CENTRAL_SCENE" version="1" request_flags="4" innif="true" scenecount="0">				<Instance index="1" />
	    <Value type="int" genre="system" instance="1" index="0" label="Scene Count" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="1" label="Button 1" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="2" label="Button 2" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="3" label="Button 3" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="4" label="Button 4" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="5" label="Button 5" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="6" label="Button 6" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="7" label="Button 7" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
	    <Value type="int" genre="user" instance="1" index="8" label="Button 8" units="" read_only="true" write_only="false" verify_changes="false" poll_intensity="0" min="-2147483648" max="2147483647" value="0" />
        </CommandClass>
    ```

6. `zwcfg` 파일의 변경 사항을 저장하고 Home Assistant 백업을 시작하십시오.

버튼을 누르면 다음과 같이 `zwave.scene_activated`가 트리거됩니다.

- `scene_id`: 왼쪽 위(1)에서 오른쪽 아래(8)까지 누르는 버튼의 수

{% endraw %}
