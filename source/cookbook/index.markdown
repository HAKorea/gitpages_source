---
title: "쿡북 (홈어시스턴트 설정따라하기)"
description: "Community maintained list of different ways to use Home Assistant."
sidebar: false
regenerate: true
hide_github_edit: true
---

다음은 홈어시스턴트 설정의 예시들입니다. 대부분의 예시들은 [automation] 자동화 기능을 사용하여 [automation related][sec-automation]과 [organization]의 통합구성요소를 응용하여 설정한 것들입니다. 

[`python_script:` examples](/integrations/python_script/)를 예시를 살펴보기 위해선  [Scripts section](https://community.home-assistant.io/c/projects/scripts) 포럼을 방문해주세요.

[automation]: /getting-started/automation/
[sec-automation]: /integrations/#automation
[organization]: /integrations/#organization

새로운 설정(recipes)은 [home-assistant.io repository](https://github.com/home-assistant/home-assistant.io/tree/current/source/_cookbook)에 추가될 수 있습니다.

<div class='note'>

최신 유행하는 설정을 찾기 위한 최적의 방법은 `home-assistant-config` topic으로 [GitHub search](https://github.com/search?q=topic%3Ahome-assistant-config&type=Repositories)에서 검색하는 것입니다. 

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
