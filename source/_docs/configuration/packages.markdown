---
title: "패키지"
description: "Describes all there is to know about configuration packages in Home Assistant."
redirect_from: /topics/packages/
---

홈어시스턴트의 패키지는 서로 다른 구성 요소의 설정을 하나로 묶을 수있는 방법을 제공합니다. [장치 추가](/docs/configuration/devices/) 페이지에서 두 가지 설정 스타일 (플랫폼 항목을 함께 또는 개별적으로 지정)에 대해 이미 배웠습니다. 이 두 구성 방법 모두 `configuration.yaml` 파일에서 연동 키를 작성해야 합니다. 패키지를 사용하면 [설정 나누기](/docs/configuration/splitting_configuration)에 도입 된 `! include` 지시문을 사용하여 다른 구성 요소(component) 또는 다른 설정 부분을 포함시킬 수 있습니다.  

Packages are configured under the core `homeassistant/packages` in the configuration and take the format of a package name (no spaces, all lower case) followed by a dictionary with the package config. For example, package `pack_1` would be created as:
패키지 설정의 주요부분은 `homeassistant/packages` 아래 설정되고, 패키지 설정 따른 (공백없음, 소문자)의 패키지 이름의 형식을 취합니다. 예를 들어 패키지 `pack_1` 이라고 만들 수 있습니다. : 

```yaml
homeassistant:
  ...
  packages: 
    pack_1:
      ...package configuration here...
```

패키지 설정은 다음과 같습니다: `switch`, `light`, `automation`, `groups`, 혹은 하드웨어 플랫폼을 포함한 대부분의 다른 홈어시스턴트 구성요소.

`!include` 를 사용하여 inline 또는 별도의 YAML 파일로 지정할 수 있습니다.

inline의 예 `configuration.yaml`:

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

Include의 예 `configuration.yaml`:

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

병합 될 패키지에 대한 몇 가지 규칙이 있습니다. :

1. 플랫폼 기반 통합구성요소는 (`light`, `switch`, etc) 로 병할 될 수 있습니다.
2. entity_id (`{key: config}`)를 나타내는 키에 의해 식별되는 entity가 있는 구성 요소(component)는 패키지와 기본 구성 파일간에 고유한 '키'가 있어야합니다. 

    예를 들어 메인 구성에 다음이 있는 경우. 패키지에서 `input_boolean` 로 “my_input”을 다시 재사용 할 수 없습니다 :
    
    ```yaml
    input_boolean:
      my_input:
    ```
3. Any integration that is not a platform [2], or dictionaries with Entity ID keys [3] can only be merged if its keys, except those for lists, are solely defined once.
3. 플랫폼이 아닌 통합구성요소 [2] 또는 entity ID 키가 [3] 인 사전은 목록에 대한 키를 제외한 키가 한 번만 정의 된 경우에만 병합 할 수 있습니다. 

<div class='note tip'>
Components inside packages can only specify platform entries using configuration style 1, where all the platforms are grouped under the integration name.
패키지 내부의 구성 요소(component)는 설정 스타일 1을 사용하여 플랫폼 항목만 지정할 수 있으며 모든 플랫폼은 통합 구성요소 이름으로 그룹화됩니다.
</div>

### 패키지 폴더 만들기

One way to organize packages is to create a folder named "packages" in your Home Assistant configuration directory. In the packages directory you can store any number of packages in a YAML file. This entry in your `configuration.yaml` will load all packages:
패키지를 구성하는 한 가지 방법은 홈어시스턴트 구성 디렉토리에 “packages” 라는 폴더를 만드는 것입니다. packages 디렉토리에서 YAML 파일에 원하는 수의 패키지를 저장할 수 있습니다. 이 항목은 `configuration.yaml` 에서 모든 패키지를 로드합니다. 

```yaml
homeassistant:
  packages: !include_dir_named packages
```

This uses the concept splitting the configuration and will include all files in a directory with the keys representing the filenames.
이것은 설정 분할 개념을 사용하며 파일 이름을 나타내는 키가 있는 디렉토리의 모든 파일을 포함합니다.
See the documentation about [splitting the configuration](/docs/configuration/splitting_configuration/) for more information about `!include_dir_named` and other include statements that might be helpful. 
[splitting the configuration](/docs/configuration/splitting_configuration/)에 관한 문서를 보면, `!include_dir_named` 과 다른 명령문들을 포함한 많은 정보들에 관해 도움이 될 것입니다. 
The benefit of this approach is to pull all configurations required to integrate a system, into one file, rather than across several.
이 방법의 시스템을 하나의 파일이 아닌 여러 파일로 분산 통합하는 장점이 있습니다.

### 패키지를 사용한 entity 사용자 정의

패키지 내에서 [customize entities](/docs/configuration/customizing-devices/) 를 쓸 수 있습니다. 다음과 같이 사용자 정의 항목을 작성하십시오. : 

```yaml
homeassistant:
  customize:
```
