---
title: 글로벌 LoRAWAN(The Things Network)
description: Instructions for how to integrate The Things Network within Home Assistant.
logo: thethingsnetwork.png
ha_category:
  - Hub
  - Sensor
ha_release: 0.55
ha_iot_class: Configurable
ha_codeowners:
  - '@fabaff'
---

`thethingsnetwork` 통합구성요소를 통해 [The Things Network](https://www.thethingsnetwork.org)와 상호 작용할 수 있습니다. 이 커뮤니티 중심의 개방형 네트워크는 [LoRaWAN](https://www.lora-alliance.org/)을 지원하여 저대역폭 (51 바이트/메시지)으로 장거리 ( ~ 5 ~ 15km) 통신을 지원합니다. [Gateways](https://www.thethingsnetwork.org/docs/gateways/)는 센서에서 수신된 데이터를 Things 네트워크로 전송합니다.

Things 네트워크는 데이터를 사용할 수 있도록 다양한 연동을 지원합니다.

| The Things Network Integration | Home Assistant platform |
|---|---|
| [MQTT](https://www.thethingsnetwork.org/docs/applications/mqtt/) | |
| [Storage](https://www.thethingsnetwork.org/docs/applications/storage/) | [`thethingsnetwork`](#sensor) |
| [HTTP](https://www.thethingsnetwork.org/docs/applications/http/) | |

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Sensor](#sensor)

## 셋업

[The Things Network Console](https://console.thethingsnetwork.org/) 웹 사이트를 방문하여 Things  네트워크 자격 증명(credentials)으로 로그인한 다음 **Applications**에서 Applications을 선택하십시오.

**Application ID**는 데이터 범위(scope)를 식별하는데 사용됩니다.

<p class='img'>
<img src='/images/integrations/thethingsnetwork/applications.png' />
Application 개요
</p>

Application에서 데이터를 읽으려면 액세스키가 필요합니다.

<p class='img'>
<img src='/images/integrations/thethingsnetwork/access_key.png' />
Access keys
</p>

## 설정

이 컴포넌트를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
thethingsnetwork:
  app_id: sensor-123
  access_key: ttn-account-v2.xxxxxxxxxxx_yyyyyyyyyyy
```

{% configuration %}
app_id:
  description: The Application ID.
  required: true
  type: string
access_key:
  description: The access key.
  required: true
  type: string
{% endconfiguration %}

## Sensor

`thethingsnetwork` 센서 플랫폼을 사용하면 [The Things Network Storage Integration](https://www.thethingsnetwork.org/docs/applications/storage/)에서 데이터를 얻을 수 있습니다.

이 플랫폼에서는 [The Things Network component](#configuration) 및 [The Things Network Storage Integration](https://www.thethingsnetwork.org/docs/applications/storage/)도 설정해야합니다.

### 전제 조건

[The Things Network Console](https://console.thethingsnetwork.org/) 웹 사이트를 방문하여 The Things Network 자격 증명으로 로그인한 다음 **Applications**에서 Applications을 선택하고 **Integrations**으로 이동하십시오.

Add a new integration.

<p class='img'>
<img src='/images/integrations/thethingsnetwork/add_integration.png' />
Add a The Things Network integration
</p>

Select **Data Storage**.

<p class='img'>
<img src='/images/integrations/thethingsnetwork/choose_integration.png' />
Choose a The Things Network integration
</p>

Click **Add integration** to finish the process.

<p class='img'>
<img src='/images/integrations/thethingsnetwork/confirm_integration.png' />
Add a The Things Network Data Storage integration
</p>

When done, the status of the integration should be **Running**. You could check the output after clicking on **go to platform** in an interactive web interface.

<p class='img'>
<img src='/images/integrations/thethingsnetwork/storage_integration.png' />
Add a The Things Network integration
</p>

Select **Devices** to get the ID of your device that you want to use.

<p class='img'>
<img src='/images/integrations/thethingsnetwork/devices.png' />
Devices overview
</p>

### 설정

이 플랫폼을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: thethingsnetwork
    device_id: ha-demo
    values:
      sensor_value: unit of measurement
      voltage: V
```

{% configuration %}
  device_id:
    description: The ID of the device.
    required: true
    type: string
  values:
    description: The sensor values with their unit of measurement
    required: true
    type: list
{% endconfiguration %}
