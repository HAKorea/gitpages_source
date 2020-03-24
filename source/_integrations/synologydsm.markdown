---
title: 시놀로지 DSM(Synology DSM)
description: Instructions on how to integrate the SynologyDSM sensor within Home Assistant.
logo: synology.png
ha_category:
  - System Monitor
ha_release: 0.32
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/CHrw7l4lJYY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`synologydsm` 센서 플랫폼을 사용하면 [Synology NAS](https://www.synology.com)에서 다양한 통계를 얻을 수 있습니다.

## 설정

`synologydsm` 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: synologydsm
    host: IP_ADDRESS_OF_SYNOLOGY_NAS
    username: YOUR_USERNAME
    password: YOUR_PASSWORD
    monitored_conditions:
      - cpu_total_load
      - memory_real_usage
      - network_up
```

{% configuration %}
name:
  description: Synology 장치의 프런트 엔드에서 사용할 이름.
  required: false
  default: Synology DSM
  type: string
host:
  description: 모니터링 할 Synology NAS의 IP 주소.
  required: true
  type: string
port:
  description: Synology NAS에 연결할 수 있는 포트 번호.
  required: false
  default: 5001
  type: integer
username:
  description: Synology NAS에 연결하는 사용자 (별도의 계정이 권장됩니다. 자세한 내용은 아래의 별도 사용자 구성 섹션을 참조하십시오).
  required: true
  type: string
password:
  description: Synology NAS에 연결하기위한 사용자의 비밀번호.
  required: true
  type: string
ssl:
  description: HTTPS를 사용해야하는지 결정.
  required: false
  default: true
  type: boolean
volumes:
  description: "모니터링할 볼륨의 배열입니다. 모든 볼륨이 기본값입니다. 볼륨 이름의 공백을 밑줄로 바꿉니다 (예: `volume 1`을 `volume_1`로 바꿉니다.)"
  required: false
  type: list
disks:
  description: "모니터링할 디스크 배열. 모든 디스크가 기본값입니다. `sda`,`sdb` 등과 같은 디스크 이름 만 사용하십시오."
  required: false
  type: list
monitored_conditions:
  description: 페이로드에서 값을 추출할 [template](/topics/templating/)을 정의합니다.
  required: true
  type: list
  keys:
    cpu_other_load:
      description: 지정되지 않은 부하를 백분율로 표시.
    cpu_user_load:
      description: 사용자부하를 백분율로 표시.
    cpu_system_load:
      description: 시스템부하를 백분율로 표시.
    cpu_total_load:
      description: 모든 부하를 백분율로 표시.
    cpu_1min_load:
      description: 지난 1 분의 최대로드를 표시.
    cpu_5min_load:
      description: 지난 5 분 동안 최대로드를 표시.
    cpu_15min_load:
      description: 지난 15 분 동안 최대로드를 표시.
    memory_real_usage:
      description: 사용된 메모리의 백분율을 표시.
    memory_size:
      description: 총 메모리 크기 (MB)를 표시.
    memory_cached:
      description: 총 캐시 크기 (MB)를 표시.
    memory_available_swap:
      description: 사용 가능한 스왑의 총 크기를 MB 단위로 표시.
    memory_available_real:
      description: 사용 된 총 메모리 크기 (실제 메모리를 기준으로 함)를 MB 단위로 표시.
    memory_total_swap:
      description: 실제 메모리의 총 크기를 MB 단위로 표시
    memory_total_real:
      description: 실제 메모리의 총 크기 (MB)를 표시.
    network_up:
      description: 네트워크 인터페이스의 전체 속도를 표시 (모든 인터페이스를 결합).
    network_down:
      description: 네트워크 인터페이스의 전체 다운 속도를 표시 (모든 인터페이스를 결합).
    disk_name:
      description: 하드 디스크의 이름을 표시 (각 디스크에 대한 새 항목을 생성).
    disk_device:
      description: 하드 디스크의 경로를 표시 (각 디스크에 대한 새 항목을 생성).
    disk_smart_status:
      description: 하드 디스크의 S.M.A.R.T 상태를 표시 (각 디스크에 대한 새 항목 생성).
    disk_status:
      description: 하드 디스크의 상태를 표시 (각 디스크에 대한 새 항목 생성).
    disk_exceed_bad_sector_thr:
      description: 하드 디스크가 최대 불량 섹터 임계 값을 초과했는지 표시하기 위해 true / false를 표시합니다 (각 디스크에 대한 새 항목 생성).
    disk_below_remain_life_thr:
      description: 하드 디스크가 남은 수명 임계 값 아래로 떨어졌는지 표시하기 위해 true / false를 표시 (각 디스크에 대한 새 항목 생성).
    disk_temp:
      description: 하드 디스크의 온도를 표시합니다. (각 디스크에 대해 새 항목을 작성하고 unit_system을 사용하여 C 또는 F 로 표시).
    volume_status:
      description: 볼륨 상태를 표시 (각 볼륨에 대한 새 항목을 만듭니다).
    volume_device_type:
      description: 볼륨 유형 (RAID 등)을 표시 (각 볼륨에 대한 새 항목을 만듭니다).
    volume_size_total:
      description: 볼륨의 전체 크기를 GB 단위로 표시 (각 볼륨에 대한 새 항목을 만듭니다).
    volume_size_used:
      description: 볼륨의 사용된 공간을 GB 단위로 표시 (각 볼륨에 대한 새 항목을 만듭니다).
    volume_percentage_used:
      description: 볼륨에 사용 된 백분율을 GB 단위로 표시 (각 볼륨에 대한 새 항목을 만듭니다).
    volume_disk_temp_avg:
      description: 볼륨에있는 모든 디스크의 평균 온도를 표시 (각 볼륨에 대한 새 항목을 만듭니다).
    volume_disk_temp_max:
      description: 볼륨에있는 모든 디스크의 최대 온도를 표시 (각 볼륨에 대한 새 항목을 만듭니다).
{% endconfiguration %}

<div class='note'>
Home Assistant를 부팅한 후 센서가 표시되는 데 최대 15 분이 걸릴 수 있습니다. 이는 홈어시스턴트가 완전히 초기화 된 후 센서가 생성되기 때문입니다.
</div>

<div class='note warning'>
이 센서는 최대 절전 모드 인 경우 Synology NAS를 깨웁니다.
</div>

<div class='note warning'>

  `ssl :`를 `False`로 설정하면, *port* 도 명시적으로 **5000**으로 설정해야합니다. 

</div>

## 별도의 사용자 설정

Synology DSM API의 특성상 사용자에게 관리자 권한을 부여해야합니다. 이는 활용 정보가 핵심 모듈에 저장되어 있다는 사실과 관련이 있습니다.

사용자를 만들 때 모든 위치 및 응용 프로그램에 대한 액세스를 거부 할 수 있습니다. 이렇게하면 사용자는 웹 인터페이스에 로그인하거나 Synology NAS의 파일을 볼 수 없습니다. 여전히 API를 사용하여 사용률 및 스토리지 정보를 읽을 수 있습니다.