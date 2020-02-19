---
title: Python Scripts
description: Instructions on how to setup Python scripts within Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.47
ha_quality_scale: internal
---

This integration allows you to write Python scripts that are exposed as services in Home Assistant. Each Python file created in the `<config>/python_scripts/` folder will be exposed as a service. The content is not cached so you can easily develop: edit file, save changes, call service. The scripts are run in a sandboxed environment. The following variables are available in the sandbox:
이 통합구성요소를 통해 홈어시스턴트에서 서비스로 노출되는 Python 스크립트를 작성할 수 있습니다. `<config>/python_scripts/` 폴더에 생성 된 각 파이썬 파일은 서비스로 노출됩니다. 컨텐츠는 캐시되지 않으므로 쉽게 개발 가능합니다. : 파일을 편집하고 변경 사항을 저장하며 서비스를 호출 할 수 있습니다. 스크립트는 샌드 박스 환경에서 실행됩니다. 샌드 박스에서 다음 변수를 사용할 수 있습니다.

| Name | Description |
| ---- | ----------- |
| `hass` | 홈 어시스턴트 객체. 액세스는 서비스 호출, 상태 설정/제거 및 실행 이벤트만 허용 [API reference][hass-api]
| `data` | 데이터는 Python Script 서비스 호출로 전달.
| `logger` | 로거(logger)는 메시지를 기록 할 수 있도록: `logger.info()`, `logger.warning()`, `logger.error()`. [API reference][logger-api]

[hass-api]: /developers/development_hass_object/
[logger-api]: https://docs.python.org/3.7/library/logging.html#logger-objects

<div class='note'>

It is not possible to use Python imports with this integration. If you want to do more advanced scripts, you can take a look at [AppDaemon](/docs/ecosystem/appdaemon/)
이 통합구성요소로 Python 가져 오기를 사용할 수 없습니다. 고급 스크립트를 원한다면 [AppDaemon](/docs/ecosystem/appdaemon/)을 살펴보십시오.

</div>

## 첫 스크립트 작성 (Writing your first script)

 - Add to `configuration.yaml`: `python_script:`
 - Create folder `<config>/python_scripts`
 - Create a file `hello_world.py` in the folder and give it this content:

```python
name = data.get("name", "world")
logger.info("Hello %s", name)
hass.bus.fire(name, {"wow": "from a Python script!"})
```

 - Start Home Assistant
 - Call service `python_script.hello_world` with parameters

```yaml
name: you
```

## 서비스 호출하기 (Calling Services)

The following example shows how to call a service from `python_script`. This script takes two parameters: `entity_id` (required), `rgb_color` (optional) and calls `light.turn_on` service by setting the brightness value to `255`.
다음 예제는 `python_script` 에서 서비스를 호출하는 방법을 보여줍니다. 이 스크립트는 두가지 매개변수를 취함: 
`entity_id` (필수),`rgb_color` (선택 사항) 및 밝기 값을 '255'로 설정하여 `light.turn_on` 서비스를 호출합니다.

```python
# turn_on_light.py
entity_id = data.get("entity_id")
rgb_color = data.get("rgb_color", [255, 255, 255])
if entity_id is not None:
    service_data = {"entity_id": entity_id, "rgb_color": rgb_color, "brightness": 255}
    hass.services.call("light", "turn_on", service_data, False)
```
The above `python_script` can be called using the following JSON as an input.
위의 `python_script`는 다음 JSON으로 입력 사용하여 호출 할 수 있습니다.

```yaml
entity_id: light.bedroom
rgb_color: [255, 0, 0]
```

## 파이썬 스크립트 문서화 (Documenting your Python scripts)

You can add descriptions for your Python scripts that will be shown in the Call Services tab of the Developer Options page. To do so, simply create a `services.yaml` file in your `<config>/python_scripts` folder. Using the above Python script as an example, the `services.yaml` file would look like:
개발자 옵션 페이지의 호출 서비스 탭에 표시될 Python 스크립트에 대한 설명을 추가 할 수 있습니다. 그렇게하려면 `<config>/python_scripts` 폴더에 `services.yaml` 파일을 만드십시오. 위의 Python 스크립트를 예로 들면 `services.yaml` 파일은 다음과 같습니다. :

```yaml
# services.yaml
turn_on_light:
  description: Turn on a light and set its color. 
  fields:
    entity_id:
      description: The light that will be turned on.
      example: light.bedroom
    rgb_color:
      description: The color to which the light will be set.
      example: [255, 0, 0]
```

더 많은 사례는, [Scripts section](https://community.home-assistant.io/c/projects/scripts) 우리 포럼을 방문하세요.
