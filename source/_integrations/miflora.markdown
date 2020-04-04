---
title: 샤오미 식물재배(Mi Flora)
description: Instructions on how to integrate MiFlora BLE plant sensor with Home Assistant.
logo: miflora.png
ha_category:
  - Environment
ha_release: 0.29
ha_iot_class: Local Polling
ha_codeowners:
  - '@danielhiversen'
  - '@ChristianKuehnel'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/UE-vcslPnKc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

샤오미 miflora는 본 문서와 같이 홈어시스턴트의 블루투스 장치에 연결하여 사용하지만, 블루투스의 태생적 한계로 인해 5미터 이상 거리가 떨어져 있는 경우 올바른 동작을 하지 않습니다. 이를 해결하기위한 방법은 다음과 같습니다. 

miflora를 실제 사용시 어떤 위치에도 식물재배기를 설치할 수 있도록 [ESPHOME](https://hakorea.github.io/integrations/esphome/)의 [ESP32의 내장된 블루투스를 통해 연결하는 방식](https://esphome.io/components/sensor/xiaomi_hhccjcy01.html)으로 설치하시길 적극적으로 추천 드립니다. 

`miflora` 센서 플랫폼은 식물의 토양과 공기상태를 모니터링할 수 있습니다. [Mi Flora 플랜트 센서](https://gadget-freakz.com/product/xiaomi-mi-flora-plant-sensor/)는 주변의 빛과 온도뿐만 아니라 토양의 수분과 전도도를 모니터링하는 소형 Bluetooth 저에너지 장치입니다. 한 번에 하나의 BLE 장치만 폴링할 수 있으므로 라이브러리는 한 번에 둘 이상의 장치를 폴링하지 않도록 잠금을 구현합니다.

사용 가능한 "중국"과 "인터네셔널" 버전이 있으며 "인터네셔널"만 작동하는 [보고서](https://community.home-assistant.io/t/miflora-showing-data-unknown/19550/8)가 있습니다.

## 블루투스 백엔드 설치

Home Assistant를 설정하기 전에 Bluetooth 백엔드와 센서의 MAC 주소가 필요합니다. 운영 체제에 따라 시스템에 적합한 Bluetooth 백엔드를 설정해야 할 수도 있습니다. : 

- On [Home Assistant](/hassio/installation/): Miflora will work out of the box.
- On a [Home Assistant Core Docker](/docs/installation/docker/): Works out of the box with `--net=host` and properly configured Bluetooth on the host.
- On other Linux systems:
  - Preferred solution: Install the `bluepy` library (via pip). When using a virtual environment, make sure to install the library in the right one.
  - Fallback solution: Install `gatttool` via your package manager. Depending on the distribution, the package name might be: `bluez`, `bluetooth`, `bluez-deprecated`
- On Windows and MacOS there is currently no support for the [miflora library](https://github.com/open-homeautomation/miflora/).

## 장치 스캔하기

Start a scan to determine the MAC addresses of the sensor (you can identify your sensor by looking for `Flower care` or `Flower mate` entries) using this command:

```bash
$ sudo hcitool lescan
LE Scan ...
F8:04:33:AF:AB:A2 [TV] UE48JU6580
C4:D3:8C:12:4C:57 Flower mate
[...]
```

Or, if your distribution is using bluetoothctl use the following commands:

```bash
$ bluetoothctl
[bluetooth]# scan on
[NEW] Controller <your Bluetooth adapter> [default]
[NEW] F8:04:33:AF:AB:A2 [TV] UE48JU6580
[NEW] C4:D3:8C:12:4C:57 Flower mate
```

`hcitool` 또는 `bluetoothctl`을 사용할 수 없지만 Android 전화기에 액세스 할 수 있는 경우 Play Store에서 `BLE 스캐너` 또는 유사한 스캐너 응용 프로그램을 사용해 센서 MAC 주소를 쉽게 찾을 수 있습니다. Windows 10을 사용하는 경우 Windows 스토어에서 `Microsoft Bluetooth LE Explorer`앱을 사용해보십시오.

## 설정

Mi Flora plant 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: miflora
    mac: 'xx:xx:xx:xx:xx:xx'
    monitored_conditions:
      - moisture
```

{% configuration %}
mac:
  description: The MAC address of your sensor.
  required: true
  type: string
monitored_conditions:
  description: The parameters that should be monitored.
  required: false
  default: [moisture, light, temperature, conductivity, battery]
  type: list
  keys:
    moisture:
      description: Moisture in the soil.
    light:
      description: Brightness at the sensor's location.
    temperature:
      description: Temperature at the sensor's location.
    conductivity:
      description: Conductivity in the soil.
    battery:
      description: Battery details. Cached and only updated once a day.
name:
  description: The name displayed in the frontend.
  required: false
  type: string
force_update:
  description: Sends update events even if the value hasn't changed.
  required: false
  type: boolean
  default: false
median:
  description: "Sometimes the sensor measurements show spikes. Using this parameter, the poller will report the median of the last 3 (you can also use larger values) measurements. This filters out single spikes. Median: 5 will also filter double spikes. If you never have problems with spikes, `median: 1` will work fine."
  required: false
  type: integer
adapter:
  description: "Define the Bluetooth adapter to use. Run `hciconfig` to get a list of available adapters."
  required: false
  default: hci0
  type: string
{% endconfiguration %}

<div class='note warning'>

By default the sensor is only polled once every 20 minutes (`scan_interval` is 1200 seconds by default). On a Home Assistant restart sensor will report initial value. If you set `median: 3`, it will take _at least_ 40 minutes before the sensor will report an average value. Keep in mind though that reducing polling intervals will have a negative effect on the battery life.
기본적으로 센서는 20 분마다 한 번만 폴링됩니다 (`scan_interval`은 기본적으로 1200 초입니다). 홈어시스턴트 재시작시, 센서에서 초기값을 보고합니다. `median: 3`을 설정하면 센서가 평균값을 보고하는데 최소 40 분이 걸립니다. 폴링 간격을 줄이면 배터리 수명에 부정적인 영향을 미칩니다.

</div>

## 전체 사례 

전체 설정 예는 다음과 같습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: miflora
    mac: 'xx:xx:xx:xx:xx:xx'
    name: Flower 1
    force_update: true    
    median: 3
    monitored_conditions:
      - moisture
      - light
      - temperature
      - conductivity
      - battery
```
