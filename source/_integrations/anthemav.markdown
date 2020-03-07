---
title: Anthem A/V 리시버
description: Instructions on how to integrate Anthem A/V Receivers into Home Assistant.
logo: anthemav.png
ha_category:
  - Media Player
ha_iot_class: Local Push
ha_release: 0.37
---

[Anthem]의 현재 및 최신 A/V 수신기 및 프로세서는 모두 IP 기반 네트워크 제어를 지원합니다. 이 홈 어시스턴트 플랫폼은 네트워크에서 이러한 수신기에 대한 적절한 "로컬 푸시"지원을 추가합니다.

## 지원 모델

* [MRX 520](https://www.anthemav.com/products-current/series=mrx-series-gen3/model=mrx-520/page=overview), [MRX 720](https://www.anthemav.com/products-current/collection=performance/model=mrx-720/page=overview), [MRX 1120](https://www.anthemav.com/products-current/collection=performance/model=mrx-1120/page=overview), and [AVM 60](https://www.anthemav.com/products-current/model=avm-60/page=overview)
* [MRX 310](https://www.anthemav.com/products-archived/type=av-receiver/model=mrx-310/page=overview), [MRX 510](https://www.anthemav.com/products-archived/series=mrx-series/model=mrx-510/page=overview), [MRX 710](https://www.anthemav.com/products-archived/type=av-receiver/model=mrx-710/page=overview)

Support is provided through the Python [anthemav] module. Older, RS-232 serial-based units like the [D2v](https://www.anthemav.com/products-current/type=av-processor/model=d2v-3d/page=overview) use a different protocol entirely and are not currently supported.

[Anthem]:	https://www.anthemav.com/
[anthemav]: https://github.com/nugget/python-anthemav


Anthem A / V 수신기를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
media_player:
  - platform: anthemav
    host: IP_ADDRESS
```

{% configuration %}
host:
  description: The host name or the IP address of the device.
  required: true
  type: string
port:
  description: The port number of the device.
  required: false
  default: 14999
  type: integer
name:
  description: The name of the device used in the frontend.
  required: false
  type: string
{% endconfiguration %}

## 참고 및 제한사항

- 튜너는 현재 `media_player` 재생, 일시 중지, 이전 및 다음 컨트롤과 같은 기능이 지원되지 않습니다.
- 이 플랫폼을 활성화하면 Anthem 장치에서 "Standby IP Control On"을 설정하고 시행합니다. 당신은 딱 이 기능을 원합니다. 기기에서 사용 중지하면 Home Assistant에서 다시 사용하도록 설정됩니다.
- 현재 영역(zone) 1 만 지원됩니다.

<div class='note warning'>

이 플랫폼은 네트워크 제어 포트에 대한 지속적인 연결을 유지하여 다른 응용 프로그램이 수신기와 통신하지 못하게합니다. 여기에는 Anthem iOS 및 Android 원격 제어 앱과 ARC-2 Anthem Room Calibration 소프트웨어가 포함됩니다. 네트워크 제어 포트를 사용하는 다른 응용 프로그램을 사용하려면 이 플랫폼을 비활성화하고 Home Assistant를 다시 시작해야합니다.
<br /><br />
*기본 Python 모듈에는 네트워크 연결을 중지하고 다시 시작하기 위한 후크가 있지만 해당 기능은 현재 Home Assistant 플랫폼에서 지원되지 않습니다.*

</div>
