---
title: 블루투스 LE Tracker
description: Instructions for integrating bluetooth low-energy tracking within Home Assistant.
logo: bluetooth.png
ha_category:
  - Presence Detection
ha_iot_class: Local Polling
ha_release: 0.27
---

이 추적기는 부팅시 및 일정한 간격으로 새 장치를 검색하고 interval_seconds 값을 기준으로 Bluetooth 저에너지 장치를 정기적으로 추적합니다. 장치를 서로 페어링 할 필요는 없습니다.

발견 된 장치는 `known_devices.yaml`에 장치 mac주소의 접두사로 'BLE_'로 저장됩니다.

이 플랫폼에는 pybluez가 설치되어 있어야합니다. 데비안 기반 설치에서는 다음을 실행합니다. 

```bash
sudo apt install bluetooth
```

이 플랫폼을 시작하기 전에 다음 사항에 유의하십시오.

 - 이 플랫폼은 Windows와 호환되지 않습니다
 - 이 플랫폼은 블루투스 스택에 액세스해야합니다. 자세한 내용은 [Rootless Setup section](#rootless-setup)을 참조하십시오.

설치에서 Bluetooth 트래커를 사용하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: bluetooth_le_tracker
```

<iframe width="690" height="437" src="https://www.youtube.com/embed/oBkahrDfUFE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

{% configuration %}
track_new_devices:
  description: 새로 검색된 장치가 기본적으로 추적되는 경우
  required: false
  default: false
  type: boolean
interval_seconds:
  description: 새 장치에 대한 각 검색 사이의 초
  required: false
  default: 12
  type: integer
{% endconfiguration %}

일부 BT LE 장치는 MAC 주소를 정기적으로 변경하므로 새 장치는 5 번 발견 된 경우에만 검색됩니다. 일부 BTLE 장치 (예 : 피트니스 추적기)는 페어링 된 장치에서만 볼 수 있습니다. 이 경우 BTLE 추적기는 이 장치를 볼 수 없습니다.

## Rootless Setup

일반적으로 Bluetooth 스택에 액세스하는 것은 루트용으로 예약되어 있지만 루트로 네트워크로 연결된 프로그램을 실행하는 것은 보안상 좋지 않습니다. 블루투스 스택에 루트가 아닌 액세스를 허용하기 위해 Python 3 및 hcitool에 누락 된 기능을 제공하여 블루투스 스택에 액세스 할 수 있습니다. setuid 비트 설정과 매우 유사합니다. (상세 내용은 [Stack Exchange](https://unix.stackexchange.com/questions/96106/bluetooth-le-scan-as-non-root)) 참조.

```bash
sudo apt-get install libcap2-bin
sudo setcap 'cap_net_raw,cap_net_admin+eip' `readlink -f \`which python3\``
sudo setcap 'cap_net_raw+ep' `readlink -f \`which hcitool\``
```

홈 어시스턴트를 다시 시작해야합니다.

추가 구성 변수에 대해서는 [Device tracker page](/integrations/device_tracker/) 페이지를 확인 하십시오 .