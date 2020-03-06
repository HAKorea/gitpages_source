---
title: 홈브루잉(Plaato Airlock)
description: Instructions on how to integrate Plaato Airlock sensors within Home Assistant.
logo: plaato.png
ha_release: 0.95
ha_category:
  - Sensor
ha_iot_class: Cloud Push
ha_config_flow: true
ha_codeowners:
  - '@JohNan'
---

이 통합은 [Plaato Airlock](https://www.plaato.io/)과의 연동을 설정합니다 . Plaato Airlock은 발효 과정에 대한 독특한 통찰력을 원하는 맥주 양조업자를위한 도구입니다. 이 연동으로 Home Assistant에서 모든 발효 데이터를 사용할 수 있습니다!

## 설정

Plaato Airlock을 설정하려면 Home Assistant 프론트 엔드의 통합구성요소 패널을 통해 이를 설정해야합니다.

이렇게하면 "Webhook"탭의 PLAATO 모바일 앱 설정에 사용할 웹 후크 URL이 제공됩니다. 자세한 내용은 [here](https://plaato.io/apps/help-center#!hc-general)를 참조하십시오 .

이 센서 플랫폼은 Plaato가 제작하지 않았습니다. Plaato는 공식적이지 않고 개발되지 않았으며 지원하지 않습니다.
