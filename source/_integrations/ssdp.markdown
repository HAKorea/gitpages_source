---
title: 간단한 서비스 검색 프로토콜 (SSDP)
description: Discover integrations on the network using the SSDP protocol.
ha_category:
  - Network
ha_release: 0.94
logo: home-assistant.png
---

`ssdp` "Simple Service Discovery Protocol" 통합구성요소는 네트워크에서 지원되는 장치 및 서비스를 검색합니다. 감지된 통합구성요소는 설정 패널의 통합구성요소 페이지에서 감지된 섹션에 표시됩니다.

통합구성요소는 manifest.json에 [SSSP 섹션](https://developers.home-assistant.io/docs/en/next/creating_integration_manifest.html#ssdp)을 추가하여 허락하게 추가(opt-in)할 수 있습니다.

## 설정

이 통합구성요소는 설정에서 [`default_config:`](https://www.home-assistant.io/integrations/default_config/) 행을 비활성화하거나 제거하지 않은 한 기본적으로 활성화되어 있습니다. 이 경우 다음 예는 이 통합구성요소를 수동으로 활성화하는 방법을 보여줍니다.

```yaml
# Example configuration.yaml entry
ssdp:
```

## 감지된 통합구성요소

다음 통합은 SSDP 통합에 의해 자동으로 감지됩니다.

 - [deCONZ](../deconz/)
 - [Huawei LTE](../huawei_lte/)
 - [Philips Hue](../hue/)
