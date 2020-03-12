---
title: DNS IP
description: Instructions on how to integrate a DNS IP sensor into Home Assistant.
logo: home-assistant.png
ha_category:
  - Network
ha_iot_class: Cloud Polling
ha_release: '0.40'
---

`dnsip` 센서는 DNS 확인을 통해 가져온 IP 주소를 값으로 노출합니다. 두 가지 작동 모드가 있습니다.

1. 최소 설정으로 센서를 활성화하면 호스트 이름이 `myip.opendns.com`인 [OpenDNS](https://www.opendns.com/) 네임 서버를 쿼리하여 external/public IP 주소로 확인합니다. .

2. `hostname`을 지정하면 호스트 이름을 확인하는 IP를 제공하여 정기적인 DNS 조회가 수행됩니다.

`resolver` 매개 변수를 원하는 네임 서버로 설정하여 사용중인 네임 서버를 덮어쓸 수도 있습니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: dnsip
```

{% configuration %}
hostname:
  description: The hostname for which to perform the DNS query.
  required: false
  default: "`myip.opendns.com` (special hostname that resolves to your public IP)"
  type: string
name:
  description: Name of the sensor.
  required: false
  default: "`myip` or hostname without dots if specified"
  type: string
resolver:
  description: The DNS server to target the query at.
  required: false
  default: "`208.67.222.222` (OpenDNS)"
  type: string
ipv6:
  description: Set this to `true` or `false` if IPv6 should be used. When resolving the public IP, this will be the IP of the machine where Home Assistant is running on.
  required: false
  default: false
  type: boolean
resolver_ipv6:
  description: The IPv6 DNS server to target the query at.
  required: false
  default: "`2620:0:ccc::2` (OpenDNS)"
  type: string
scan_interval:
  description: Defines number of seconds for polling interval.
  required: false
  default: "`120`"
  type: integer
{% endconfiguration %}

## 확장 예시

```yaml
# Example configuration.yaml entry
sensor:
  # Own public IPv4 address
  - platform: dnsip
  # Resolve IP address of home-assistant.io via Google DNS
  - platform: dnsip
    hostname: home-assistant.io
    name: hass
    resolver: 8.8.8.8
```
