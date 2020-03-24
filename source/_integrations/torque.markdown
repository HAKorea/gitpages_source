---
title: 자동차 OBD2 연동(Torque)
description: Instructions on how to integrate Torque sensors into Home Assistant.
logo: torque.png
ha_category:
  - Car
ha_release: '0.10'
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/JIa0nsrQXI0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`Torque` 플랫폼을 사용하면 Torque 모바일 애플리케이션을 통해 Bluetooth OBD2 스틱에서 릴레이된 [Torque](https://torque-bhp.com/) 데이터를 모니터링 할 수 있습니다.

## 셋업

설치시 Torque 센서를 사용하려면 Torque 모바일 애플리케이션과 Home Assistant를 모두 설정해야합니다.

### Torque 앱

In **Settings** -> **Data Logging & Upload**:

Under the **Logging Preferences** header:

- Touch **Select what to log**, activate the menu in the upper right, and select **Add PID to log**.
- Select items of interest.

Under the **Realtime Web Upload** header:

- Check **Upload to web-server**.
- Enter `http://HOST:PORT/api/torque?api_password=YOUR_PASSWORD` as the **Web-server URL**, where `HOST` and `PORT` are your externally accessible Home Assistant HTTP host and port and YOUR_PASSWORD is your Home Assistant's [API password](/integrations/http/). It highly recommended that you protect your Home Assistant instance with [SSL/TSL](/docs/ecosystem/certificates/).
- Enter an email address in **User Email Address**.
- Optionally set the **Web Logging Interval**. The 2-second default may quickly fill up the Home Assistant history database.

### 설정

`configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: torque
    email: your_configured@email.com
```

{% configuration %}
name:
  description: Vehicle name (your choice).
  required: false
  default: vehicle
  type: string
email:
  description: Email address configured in Torque application.
  required: true
  type: string
{% endconfiguration %}
