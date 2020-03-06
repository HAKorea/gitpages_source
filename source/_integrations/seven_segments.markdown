---
title: 디지털디스플레이 OCR(7 Segments OCR)
description: Instructions on how to use OCR for seven segments displays into Home Assistant.
logo: home-assistant.png
ha_category:
  - Image Processing
ha_release: 0.45
og_image: /images/screenshots/ssocr.png
ha_iot_class: Local Polling
---

`seven_segments` 이미지 처리 플랫폼을 사용하면 Home Assistant를 통해 실제 7 개의 세그먼트 디스플레이를 읽을 수 있습니다. [`ssocr`](https://www.unix-ag.uni-kl.de/~auerswal/ssocr/)은 [camera](/integrations/camera/)에 의해 관찰되는 디스플레이에 표시된 값을 추출하는데 사용됩니다. 

<div class='note'>

[Hass.io](/hassio/)를 사용하는 경우 모든 요구 사항이 이미 충족되었으므로 설정으로 이동하십시오.

</div>

시스템에서 `ssocr`을 사용할 수 있어야합니다. 아래 설치 지침을 확인하십시오.

```bash
sudo dnf -y install imlib2-devel # Fedora
sudo apt install libimlib2-dev # Ubuntu
brew install imlib2 # macOS
git clone https://github.com/auerswal/ssocr.git
cd ssocr
make
sudo make PREFIX=/usr install # On most systems
make deb # (Optional) This allows you to make a deb so that you apt is aware of ssocr
```

설치시 7 세그먼트 디스플레이의 OCR을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: seven_segments
    source:
      - entity_id: camera.seven_segments
```

{% configuration %}
ssocr_bin:
  description: The command line tool `ssocr`. Set it if you use a different name for the executable.
  required: false
  default: ssocr
  type: string
x_position:
  description: X coordinate of the upper left corner of the area to crop.
  required: false
  default: 0
  type: integer
y_position:
  description: Y coordinate of the upper left corner of the area to crop.
  required: false
  default: 0
  type: integer
height:
  description: Height of the area to crop.
  required: false
  default: 0
  type: integer
width:
  description: Width of the area to crop.
  required: false
  default: 0
  type: integer
rotate:
  description: Rotation of the image.
  required: false
  default: 0
  type: integer
threshold:
  description: Threshold for the difference between the digits and the background.
  required: false
  default: 0
  type: integer
digits:
  description: Number of digits in the display.
  required: false
  default: -1
  type: integer
extra_arguments:
  description: Other arguments to use. Like `-D`, `dilation`, `erosion`, `greyscale`, `make_mono`, etc.
  required: false
  type: string
source:
  description: List of image sources.
  required: true
  type: list
  keys:
    entity_id:
      description: A camera entity id to get picture from.
      required: true
      type: string
    name:
      description: This parameter allows you to override the name of your `image_processing` entity.
      required: false
      type: string
{% endconfiguration %}

### 셋업 프로세스

필요한 파라미터를 결정하는 첫 번째 시도는 `ssocr`을 직접 사용하는 것입니다. 결과를 얻으려면 몇 번의 반복이 필요할 수 있습니다.

```bash
$ ssocr -D erosion crop 390 250 490 280 -t 20 -d 4 seven-seg.png
```

This would lead to the following entry for the `configuration.yaml` file:

```yaml
camera:
  - platform: local_file
    file_path: /home/homeassistant/.homeassistant/seven-seg.png
    name: seven_segments
image_processing:
  - platform: seven_segments
    x_position: 390
    y_position: 250
    height: 280
    width: 490
    threshold: 20
    digits: 4
    source:
      - entity_id: camera.seven_segments
```

<p class='img'>
  <img src='{{site_root}}/images/screenshots/ssocr.png' />
</p>

[template sensor](/integrations/template)의 도움으로 값을 badge로 표시 할 수 있습니다.

{% raw %}

```yaml
sensor:
  - platform: template
    sensors:
      power_meter:
        value_template: '{{ states('image_processing.sevensegment_ocr_seven_segments') }}'
        friendly_name: 'Ampere'
        unit_of_measurement: 'A'
```

{% endraw %}
