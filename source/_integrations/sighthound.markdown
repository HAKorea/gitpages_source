---
title: 사이트하운드(Sighthound)
description: Detect people with Sighthound Cloud.
logo: sighthound-logo.png
ha_category:
  - Image Processing
ha_release: 0.105
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@robmarkcole'
---

[Sighthound Cloud](https://www.sighthound.com/products/cloud)를 사용하여 카메라 이미지에서 사람을 감지합니다. Sighthound Developer Tier (비 상업용 무료)를 사용하면 매월 5000 개의 이미지를 처리​​할 수 ​​있습니다. 한 달에 더 많은 처리가 필요한 경우 프로덕션 계정 (기본 또는 Pro 계정)에 가입해야합니다.

이 통합은 엔티티의 상태가 이미지에서 감지된 사람들의 수인 이미지 처리 엔티티를 추가합니다. 감지된 각 사람에 대해 `sighthound.person_detected` 이벤트가 시작됩니다. 이벤트 데이터는 이벤트를 발생시키는 이미지 처리 엔티티의 entity_id 및 검출된 사람 주위의 경계 박스를 포함합니다.

`save_file_folder`가 설정된 경우, 사람을 새로 감지할 때마다 이름이 sighthound_{camera_name}_latest.jpg 인 주석이 달린 이미지가 설정된 폴더에 저장되고 존재하지 않는 경우 덮어 씁니다. 저장된 이미지는 감지 된 사람 주변의 경계 상자를 표시하며 [Local File](/integrations/local_file/) 카메라를 사용하여 홈어시스턴트 프론트 엔드에 표시될 수 있으며 알림에 사용될 수 있습니다.

**Note** 기본적으로 컴포넌트는 이미지를 자동으로 스캔하지 않지만 예를 들면 모션에 의해 트리거되는 자동화를 사용하여 `image_processing.scan` 서비스를 호출해야합니다.


## 설정

설치에서이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
image_processing:
  - platform: sighthound
    api_key: some_key
    save_file_folder: /my_dir/
    source:
      - entity_id: camera.my_cam
```

{% configuration %}
api_key:
  description: Your Sighthound Cloud API key.
  required: true
  type: string
account_type:
  description: If you have a paid account, used `prod`.
  required: false
  type: string
save_file_folder:
  description: The folder to save annotated images to.
  required: false
  type: string
source:
  description: The list of image sources.
  required: true
  type: map
  keys:
    entity_id:
      description: A camera entity id to get a picture from.
      required: true
      type: string
    name:
      description: This parameter allows you to override the name of your `image_processing` entity.
      required: false
      type: string
{% endconfiguration %}
