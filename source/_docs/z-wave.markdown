---
title: "Z-Wave"
description: "Using Z-Wave with Home Assistant."
redirect_from: /getting-started/z-wave/
---

Home Assistant의 [Z-Wave](https://www.z-wave.com/) 통합구성요소로 연결된 Z-Wave 장치를 관찰하고 제어할 수 있습니다. Z-Wave를 지원하려면 [지원되는 Z-Wave USB 스틱 또는 모듈](/docs/z-wave/controllers/)을 호스트에 연결해야합니다.

현재 climate, covers, lights, locks, sensors, switches, thermostats이 지원됩니다. 이 플랫폼을 설정한 후 모두 자동으로 선택됩니다.

Z-Wave 설정을 하기 전에 잠시 시간을 내서 [이 기사](https://drzwave.blog/2017/01/20/seven-habits-of-highly-effective-z-wave-networks-for-consumers/)를 읽고 Z-Wave 네트워크의 가장 일반적인 주의사항을 이해하십시오.

## Z-Wave란 ? 

Z-Wave는 홈자동화를 위해 설계된 무선 통신 프로토콜입니다. 서로 직접적인 범위 내에 있지 않은 장치가 다른 노드를 통해 간접적으로 통신할 수 있도록 저전력, 저대역폭 메시 네트워크를 사용합니다. 영구적으로 전원이 공급되는(배터리로 작동하지 않는) 모든 장치는 메쉬를 만드는 데 도움이 됩니다. 전원이 공급된 장치가 충분하지 않거나 잘못 배치하면 메쉬를 신뢰할 수 없게됩니다. 메시를 [그래프](https://community.home-assistant.io/t/z-wave-graph-without-the-python/64275)로 그려서 [상태를 볼 수 있습니다](https://community.home-assistant.io/t/graph-your-z-wave-mesh-python-auto-update/40549).

단일 Z-Wave 네트워크에는 232 개의 장치로 제한됩니다. 더 많은 장치가 필요한 경우 자체 Z-Wave 네트워크를 사용하여 두 번째 Home Assistant 시스템을 설정하고 [MQTT Eventstream](/integrations/mqtt_eventstream/) 또는 [MQTT Statestream](/integrations/mqtt_statestream) 통합구성요소에 연결할 수 있습니다.

Z-Wave 표준은 Z-Wave Plus로 개선되었으며 Z-Wave plus 장치만 사용하면 모든 해당 개선점을 얻을 수 있습니다.

## Z-Wave를 사용하려면 무엇이 필요합니까?

Z-Wave, Z-Wave [콘트롤러](/docs/z-wave/controllers/)와 하나 이상의 [장치](/docs/z-wave/devices/)를 사용해야하는 두 가지 기본 사항이 있습니다. 

### 지역(국가)별 차이

Z-Wave 장치에는 12 개의 서로 다른 지역이 있으며 이 지역은 장치가 사용하는 주파수와 관련이 있습니다. 지역간에 겹치는 부분이 있지만 해당 지역의 장치를 구입해야합니다. Wikipedia에는 ​​[사용된 주파수](https://en.wikipedia.org/wiki/Z-Wave#Radio_frequencies) 목록이 있습니다.

## 시작하기

이제 [콘트롤러](/docs/z-wave/controllers/)를 연결하고 Z-Wave 통합구성요소를 [설정](/docs/z-wave/installation)한 다음 [제어판](/docs/z-wave/control-panel)을 사용하여 [일부 장치 추가](/docs/z-wave/adding)가 필요합니다. 장치와 [엔티티 이름](/docs/z-wave/entities) 지정 방법에 대해 [설명](/docs/z-wave/devices/)합니다.

[사용 가능한 서비스](/docs/z-wave/services/)와 [이벤트](/docs/z-wave/events/), 배터리 구동 장치의 [쿼리 단계](/docs/z-wave/query-stage) 그리고 [특정 장치](/docs/z-wave/device-specific/) 설정에 대한 자세한 정보를 얻을 수 있습니다.

## 즉각적인 상태 업데이트

스위치를 토글하거나 조명을 로컬로 제어할 때 홈어시스턴트에 반영되는데 시간이 걸릴 수 있습니다. Lutron은 장치가 컨트롤러에 무언가 로컬에서 발생한 것을 알리는 전통적인 방법인 *Hail* 명령 클래스를 사용하여 상태 업데이트에 대한 특허를 보유하고 있기 때문입니다. *Association* 명령 클래스 혹은 *Central Scene* 명령 클래스를 통해 동일한 결과를 얻을 수 있습니다. (하지만 OpenZWave에서는 *Central Scene*이 [완전히 지원되지 않습니다.](https://github.com/OpenZWave/open-zwave/pull/1125))

제품에 대한 [Z-Wave 제품 데이터베이스](https://products.z-wavealliance.org/)를 검색하고 **Controlled** 명령 클래스(**Supported** 명령 클래스가 아님)에 있는 제품 중 하나를 나열하면 장치에 변화가 발생할 때 상태 변경을 보고할 수 있습니다. 이 부분이 동작하지 않더라도, 기다리면 업데이트가 결국 발생하거나 [enable polling](/docs/z-wave/control-panel/#entities-of-this-node)을 주의해서 수행합니다.