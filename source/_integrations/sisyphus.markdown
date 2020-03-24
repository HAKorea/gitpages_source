---
title: 샌드아트테이블(Sisyphus)
description: Instructions on how to integrate your Sisyphus Kinetic Art Table within Home Assistant.
logo: sisyphus.png
ha_category:
  - Hub
  - Light
  - Media Player
ha_release: 0.75
ha_iot_class: Local Push
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/2rxHZwpxCk0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

홈어시스턴트를 위한 [Sisyphus](https://sisyphus-industries.com/) 연동으로 Sisyphus Kinetic Art Table을 관찰하고 제어할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. : 

- **Light** - 테이블을 잠자거나 깨우거나 테이블 조명의 밝기를 조정하는 데 사용할 수 있습니다.
- **Media Player** - 테이블을 잠자기/깨우기, 재생/일시 정지, 트랙 간 이동 또는 셔플 켜기/끄기를 전환하는데 사용할 수 있습니다. "볼륨" 컨트롤은 테이블의 속도를 조정합니다.

Sisyphus 통합구성요소가 설정된 경우 라이트 및 미디어 플레이어가 각 Sisyphus 테이블에 자동으로 추가됩니다.

이 구성 요소를 구성하는 두 가지 방법이 있습니다. 테이블을 자동으로 검색하려면 `configuration.yaml`에 다음을 추가하십시오.

```yaml
# This will auto-detect all Sisyphus tables on your local network.
sisyphus:
```

자동 감지는 약간 느릴 수 있으므로 테이블에 고정 IP 주소 또는 호스트 이름이 있으면 `configuration.yaml`에 테이블 목록을 추가 할 수 있습니다. 예를 들어 :

```yaml
# This will skip auto-detection and add only the listed tables
sisyphus:
  - name: 'TABLE_NAME'
    host: 'TABLE_IP_OR_HOSTNAME'
  - name: 'ANOTHER_TABLE_NAME'
    host: 'ANOTHER_TABLE_IP_OR_HOSTNAME'
```

{% configuration %}
name:
  description: The name by which the table should appear in Home Assistant
  required: true
  type: string
host:
  description: The hostname or IP address of the table
  required: true
  type: string
{% endconfiguration %}
