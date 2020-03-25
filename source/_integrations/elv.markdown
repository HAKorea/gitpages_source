---
title: 스마트홈플랫폼(ELV PCA)
description: Instructions on how to integrate ELV PCA 301 switches into Home Assistant.
logo: elv.png
ha_category: Switch
ha_iot_class: Local Polling
ha_release: 0.95
ha_codeowners:
  - '@majuss'
---

`pca` 스위치 플랫폼을 사용하면 [ELV PCA 301 smart switch](https://www.elv.de/funkschaltsteckdose-fuer-energiekostenmonitor-pca-301.html)의 상태를 제어 할 수 있습니다. [pca-hex firmware](https://github.com/mhop/fhem-mirror/blob/master/fhem/FHEM/firmware/JeeLink_PCA301.hex)로 플래시 된 [JeeLink]https://www.digitalsmarties.net/products/jeelink)와 같은 868MHz 인터페이스가 필요합니다. 

## 설정

PCA 301 스위치 또는 소켓을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
elv:
  device: SERIAL_PORT
```

이 플랫폼은 범위 내에 있는 모든 PCA 301 스위치를 추가합니다. 총사용 에너지 (KWh)와 현재 전력 (Watt)을 읽을 수 있습니다.

{% configuration %}
device:
  description: "The path to you serial console. Get it via: `ls /dev/tty*`."
  required: true
  type: string
name: 
  description: Default name for the plugs.
  required: false
  type: string
{% endconfiguration %}
