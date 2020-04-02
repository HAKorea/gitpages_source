---
title: "쿡북 (홈어시스턴트 설정따라하기)"
description: "Community maintained list of different ways to use Home Assistant."
sidebar: false
regenerate: true
hide_github_edit: true
---

다음은 홈어시스턴트 설정의 예시들입니다. 대부분의 예시들은 [Automation] 기능을 사용하여 [Automation 관련][sec-automation]과 [organization]의 통합구성요소를 응용하여 설정한 것들입니다. 

[`python_script:` 사례](/integrations/python_script/)의 예시를 살펴보기 위해선 [Scripts 색션](https://community.home-assistant.io/c/projects/scripts) 포럼을 방문해주세요.

[automation]: /getting-started/automation/
[sec-automation]: /integrations/#automation
[organization]: /integrations/#organization

새로운 설정(recipes)은 [home-assistant.io 저장소](https://github.com/home-assistant/home-assistant.io/tree/current/source/_cookbook)에 추가될 수 있습니다.

<div class='note'>

최신 유행하는 설정을 찾기 위한 최적의 방법은 `home-assistant-config` 주제로 [GitHub 검색](https://github.com/search?q=topic%3Ahome-assistant-config&type=Repositories)에서 찾는 것입니다. 

</div>

{% assign cookbook = site.cookbook | sort: 'title' %}
{% assign categories = cookbook | map: 'ha_category' | uniq | sort %}

{% for category in categories %}
### {{ category }}

  {% if category == 'Automation Examples' %}

  {% elsif category == 'Full configuration.yaml examples' %}
Some users keep a public scrubbed copy of their `configuration.yaml` to learn from.
  {% elsif category == '' %}

  {% endif %}

  {% for recipe in cookbook %}
    {% if recipe.ha_category == category %}
      {% if recipe.ha_external_link %}
  * [{{recipe.title}} <i class="icon-external-link"></i>]({{recipe.ha_external_link}})
      {% else %}
  * [{{recipe.title}}]({{recipe.url}})
      {% endif %}
    {% endif %}
  {% endfor %}
{% endfor %}
