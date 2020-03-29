---
title: "패키지"
description: "Describes all there is to know about configuration packages in Home Assistant."
redirect_from: /topics/packages/
---

홈어시스턴트의 패키지는 서로 다른 구성요소의 설정을 하나로 묶을 수 있는 방법을 제공합니다. [장치 추가](/docs/configuration/devices/) 페이지에서 두 가지 설정 스타일 (플랫폼 항목을 함께 또는 개별적으로 지정)에 대해 이미 배웠습니다. 이 두 설정 방법 모두 `configuration.yaml` 파일에서 연동 키를 작성해야 합니다. 패키지를 사용하면 [설정 나누기](/docs/configuration/splitting_configuration)에 도입된 `!include` 지시문을 사용하여 다른 구성요소(component) 혹은 다른 설정 부분을 포함시킬 수 있습니다.  

패키지는 설정의 core `homeassistant/packages` 아래에서 설정되며 패키지 이름 형식(공백 없음, 모두 소문자)과 패키지 설정이 포함된 사전(dictionary)을 따릅니다. 예를 들어, `pack_1` 패키지는 다음과 같이 생성됩니다 :


```yaml
homeassistant:
  ...
  packages: 
    pack_1:
      ...package configuration here...
```

패키지 설정은 다음과 같습니다: `switch`, `light`, `automation`, `groups`, 혹은 하드웨어 플랫폼을 포함한 대부분의 다른 홈어시스턴트 구성요소.

`!include`를 사용하여 inline 또는 별도의 YAML 파일로 지정할 수 있습니다.

inline의 예시 `configuration.yaml` :

```yaml
homeassistant:
  ...
  packages: 
    pack_1:
      switch:
        - platform: rest
          ...
      light:
        - platform: rpi
          ...
```

Include의 예시 `configuration.yaml` :

```yaml
homeassistant:
  ...
  packages: 
    pack_1: !include my_package.yaml
```

`my_package.yaml` "top-level" 설정이 포함되어 있습니다. :

```yaml
switch:
  - platform: rest
    ...
light:
  - platform: rpi
    ...
```

병합될 패키지에 대한 몇가지 규칙이 있습니다. :

1. 플랫폼 기반 통합구성요소는 (`light`, `switch`, 등)으로 병할될 수 있습니다.
2. entity_id(`{key: config}`)를 나타내는 키에 의해 식별되는 entity가 있는 구성요소(component)는 패키지와 기본설정 파일간에 고유한 '키'가 있어야합니다. 

    예를들어 메인 설정에 다음이 있는 경우. 패키지에서 `input_boolean`로 “my_input”을 다시 재사용할 수 없습니다 :
    
    ```yaml
    input_boolean:
      my_input:
    ```
3. 플랫폼이 아닌 통합구성요소 [2]이거나 entity ID 키가 [3]인 사전(dictionary)은 목록에 대한 키를 제외한 키가 한 번만 정의된 경우에만 병합할  수 있습니다. 

<div class='note tip'>
패키지 내부의 구성 요소(component)는 설정 스타일 1을 사용하여 플랫폼 항목만 지정할 수 있으며 모든 플랫폼은 통합 구성요소 이름으로 그룹화됩니다.
</div>

### 패키지 폴더 만들기

패키지를 구성하는 한 가지 방법은 홈어시스턴트 설정 디렉토리에 “packages” 라는 폴더를 만드는 것입니다. packages 디렉토리에서 YAML 파일에 원하는 수의 패키지를 저장할 수 있습니다. 이 항목은 `configuration.yaml` 에서 모든 패키지를 로드합니다. 

```yaml
homeassistant:
  packages: !include_dir_named packages
```

이는 splitting the configuration을 사용하며 파일 이름을 나타내는 키가 있는 디렉토리의 모든 파일을 포함합니다.
[splitting the configuration](/docs/configuration/splitting_configuration/)에 관한 문서를 보면, `!include_dir_named`과 다른 명령문들을 포함한 많은 정보들에 관해 도움이 될 것입니다. 
이 방법의 장점은 시스템을 여러 파일이 아닌 하나의 파일로 통합하는데 필요한 모든 설정을 가져오는 것입니다.

### 패키지를 사용한 entity 사용자 정의

패키지 내에서 [customize entities](/docs/configuration/customizing-devices/)를 쓸 수 있습니다. 다음과 같이 사용자 정의 항목을 작성하십시오. : 

```yaml
homeassistant:
  customize:
```
