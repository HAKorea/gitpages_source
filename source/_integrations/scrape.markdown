---
title: 스크랩(scrape)
description: Instructions on how to integrate Web scrape sensors into Home Assistant.
logo: home-assistant.png
ha_category:
  - Sensor
ha_release: 0.31
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@fabaff'
---

`scrape` 센서 플랫폼은 웹사이트에서 정보를 스크랩합니다. 센서는 HTML 페이지를 로드하고 값을 검색하고 분리 할 수 있는 옵션을 제공합니다. 이는 [scrapy](https://scrapy.org/)와 같은 본격적인 웹 스크레이퍼가 아니기 때문에 간단한 웹 페이지에서만 작동하며 올바른 섹션을 얻는데 시간이 오래 걸릴 수 있습니다.


### 한국형 스크랩 사례

HA 네이버카페의 검은별31님이 제작하신 [우리나라 날씨의 세차센서 이용법](https://cafe.naver.com/koreassistant/809) 을 참조하십시오. 



---------------------------------------------------------------------------------------------------------

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :


```yaml
# Example configuration.yaml entry
sensor:
  - platform: scrape
    resource: https://www.home-assistant.io
    select: ".current-version h1"
```

{% configuration %}
resource:
  description: 값이 포함 된 웹 사이트의 URL
  required: true
  type: string
select:
  description: "검색할 HTML 태그를 정의. Beautifulsoup의 [CSS selectors](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#css-selectors)를 상세하게 체크하십시오."
  required: true
  type: string
attribute:
  description: 선택한 태그에서 속성값을 가져옵니다..
  required: false
  type: string
index:
  description: CSS selector에서 반환한 elements 중 사용할 element를 정의
  required: false
  default: 0
  type: integer
name:
  description: 센서 이름.
  required: false
  default: Web scrape
  type: string
value_template:
  description: 센서 상태를 얻기 위한 템플릿을 정의.
  required: false
  type: template
unit_of_measurement:
  description: "센서의 측정 단위를 정의 (있는 경우)."
  required: false
  type: string
authentication:
  description: HTTP 인증의 유형. `basic` 혹은 `digest` 중의 하나 
  required: false
  type: string
verify_ssl:
  description: "예를 들어 자체 서명된 경우 SSL 인증서의 검증을 활성화/비활성화 함."
  required: false
  type: boolean
  default: true
username:
  description: 웹 사이트에 액세스하기위한 사용자 이름.
  required: false
  type: string
password:
  description: 웹 사이트에 액세스하기위한 비밀번호.
  required: false
  type: string
headers:
  description: 웹 요청에 사용할 헤더.
  required: false
  type: string
{% endconfiguration %}

## 사례

이 섹션에는이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다. 이 예에서는 [Jupyter notebook](https://nbviewer.jupyter.org/github/home-assistant/home-assistant-notebooks/blob/master/other/web-scraping.ipynb)을 사용하여 좀 더 통찰력을 얻을 수 있습니다.

### Home Assistant

현재 릴리스 Home Assistant는 [https://www.home-assistant.io/](/)에 게시되어 있습니다.

{% raw %}
```yaml
sensor:
# Example configuration.yaml entry
  - platform: scrape
    resource: https://www.home-assistant.io
    name: Release
    select: ".current-version h1"
    value_template: '{{ value.split(":")[1] }}'
```
{% endraw %}

### 사용가능한 구현들

[Component overview](/integrations/) 페이지 에서 모든 구현(implementations)에 대한 카운터를 얻으십시오.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: scrape
    resource: https://www.home-assistant.io/integrations/
    name: Home Assistant impl.
    select: 'a[href="#all"]'
    value_template: '{{ value.split("(")[1].split(")")[0] }}'
```
{% endraw %}

### 태그에서 값을 얻으십시오

독일의 [Federal Office for Radiation protection (방사선관련 국가기관)](http://www.bfs.de/)에서는 UV지수를 포함하여 광학 방사선에 대한 다양한 세부 사항을 발표하고 있습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: scrape
    resource: http://www.bfs.de/DE/themen/opt/uv/uv-index/prognose/prognose_node.html
    name: Coast Ostsee
    select: 'p'
    index: 19
    unit_of_measurement: 'UV Index'
```

### IFTTT 상태

자동화를 위해 [IFTTT](/integrations/ifttt/) 웹서비스를 많이 사용하고 [IFTTT 상태](https://status.ifttt.com/) 에 대해 궁금한 경우 프론트 엔드에서 IFTTT 현재 상태를 표시 할 수 있습니다. 

```yaml
# Example configuration.yaml entry
sensor:
  - platform: scrape
    resource: https://status.ifttt.com/
    name: IFTTT status
    select: '.component-status'
```

### 최신 팟캐스트 에피소드 파일 URL 가져오기

[favorite podcast](https://hasspodcast.io/)의 최신 에피소드에 대한 파일 URL을 얻으려면 호환되는 미디어 플레이어로 전달할 수 있습니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: scrape
    resource: https://hasspodcast.io/feed/podcast
    name: Home Assistant Podcast
    select: 'enclosure'
    index: 1
    attribute: url
```

### 에너지 가격

이 예는 전기 가격을 검색하려고합니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: scrape
    resource: https://elen.nu/timpriser-pa-el-for-elomrade-se3-stockholm/
    name: Electricity price
    select: ".elspot-content"
    value_template: '{{ ((value.split(" ")[0]) | replace (",", ".")) }}'
    unit_of_measurement: "öre/kWh"
```
{% endraw %}

### BOM 날씨

사용자 에이전트 헤더(User Agent header)가 전송되지 않은 경우 호주 기상청 웹 사이트에서 오류를 반환합니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: scrape
    resource: http://www.bom.gov.au/vic/forecasts/melbourne.shtml
    name: Melbourne Forecast Summary
    select: ".main .forecast p"
    value_template: '{{ value | truncate(255) }}'
    # Request every hour
    scan_interval: 3600
    headers:
      User-Agent: Mozilla/5.0
```
{% endraw %}
