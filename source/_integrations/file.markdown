---
title: 파일
description: Instructions on how to integrate sensors which read from files into Home Assistant.
logo: file.png
ha_category:
  - Utility
  - Notifications
  - Sensor
ha_release: pre 0.7
ha_iot_class: Local Polling
ha_codeowners:
  - '@fabaff'
---

현재 홈 어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Notifications](#notifications)
- [Sensor](#sensor)

## 알림 (Notifications)

`file` 플랫폼을 사용하면 Home Assistant의 알림을 파일로 저장할 수 있습니다.

파일 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: file
    filename: FILENAME
```

{% configuration %}
name:
  description: 선택적 매개 변수 `name`을 설정하면 여러 알리미를 만들 수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME`에 바인딩합니다.
  required: false
  default: notify
  type: string
filename:
  description: 사용할 파일 이름입니다. 파일이 존재하지 않으면 파일이 생성되어 [configuration](/docs/configuration/) 폴더에 저장됩니다
  required: true
  type: string
timestamp:
  description: "`timestamp`를 `true`로 설정하면 모든 항목에 타임 스탬프가 추가됩니다."
  required: false
  default: false
  type: boolean
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.

## 센서 (Sensor)

`file` 센서 플랫폼은 일반 텍스트 파일에서 항목을 읽고 찾은 값을 보여줍니다. 파일의 마지막 줄만 사용됩니다. 이것은 명령행에서 `$ tail -n 1 sensor.txt`와 유사합니다. 파일 경로는 [whitelist_external_dirs](/docs/configuration/basic/)에 추가되어야합니다.

`file` 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: file
    file_path: /home/user/.homeassistant/sensor-data.txt
```

{% configuration %}
file_path:
  description: 센서 데이터를 저장하는 파일의 경로.
  required: true
  type: string
name:
  description: 프론트 엔드에서 사용할 센서의 이름.
  required: false
  default: file name
  type: string
unit_of_measurement:
  description: 센서의 측정 단위를 정의. (있는 경우).
  required: false
  type: string
value_template:
  description: 페이로드에서 값을 추출하기 위해 [template](/docs/configuration/templating/#processing-incoming-data)을 정의합니다.
  required: false
  type: template
{% endconfiguration %}

### 사례

이 섹션에는 이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

#### JSON 항목들 (Entries as JSON)

로그 파일에 아래와 같이 JSON 형식의 여러 값이 포함되어 있다고 가정합니다.

```text
[...]
{"temperature": 21, "humidity": 39}
{"temperature": 22, "humidity": 36}
```

온도를 추출하려면 `configuration.yaml` 파일에 다음 항목이 필요합니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: file
    name: Temperature
    file_path: /home/user/.homeassistant/sensor.json
    value_template: {% raw %}'{{ value_json.temperature }}'{% endraw %}
    unit_of_measurement: '°C'
```
