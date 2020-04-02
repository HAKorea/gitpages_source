---
title: "Sonos로 script를 사용하여 text-to-speech로 말하게하기"
description: "Sonos say script to use text-to-speech with Sonos"
ha_category: Automation Examples
---

#### Sonos로 script를 사용하여 text-to-speech 실행

이 스크립트를 사용하면 Sonos에서 [TTS](/integrations/#text-to-speech) 를 사용할 수 있습니다 .

```yaml
script:
  sonos_say:
    alias: "Sonos TTS script"
    sequence:
     - service: sonos.snapshot
       data_template:
         entity_id: {% raw %}"{{ sonos_entity }}"{% endraw %}
     - service: sonos.unjoin
       data_template:
         entity_id: {% raw %}"{{ sonos_entity }}"{% endraw %}
     - service: media_player.volume_set
       data_template:
         entity_id: {% raw %}"{{ sonos_entity }}"{% endraw %}
         volume_level: {% raw %}"{{ volume }}"{% endraw %}
     - service: tts.voicerss_say
       data_template:
         entity_id: {% raw %}"{{ sonos_entity }}"{% endraw %}
         message: {% raw %}"{{ message }}"{% endraw %}
     - delay: {% raw %}"{{ delay }}"{% endraw %}
     - service: sonos.restore
       data_template:
         entity_id: {% raw %}"{{ sonos_entity }}"{% endraw %}
```

이제 다음과 같이 호출이 가능합니다. :
```yaml
automation:
  - alias: 'test'
    trigger:
      - platform: state
        entity_id: input_boolean.mytest
    action:
      - service: script.sonos_say
        data:
          sonos_entity: media_player.office
          volume: 0.5
          message: 'Your husband coming home!'
          delay: '00:00:05'
```
이 예제는 `voicerss` TTS (text-to-speech) 플랫폼을 사용합니다. 사용할 수 있는 많은 플랫폼이 있습니다. Home Assistant와 함께 기본적으로 설치되는 것은 Google TTS입니다. `configuration.yaml` 파일에 다음과 같이 나타냅니다 .

```yaml
tts:
  - platform: google_translate
```

이 TTS 엔진을 사용하려면 제공된 예제에서 라인을 다음과 같이 변경하십시오. :
```txt
- service: tts.google_translate_say
```
