---
title: 깃랩(Gitlab-CI)
description: How to integrate GitLab-CI Job status within Home Assistant.
logo: gitlab.png
ha_category:
  - Sensor
ha_release: 0.8
ha_iot_class: Cloud Polling
---

`gitlab_ci` 센서 플랫폼은 CI/CD Pipeline 작업에 의해 보고된 결과를 [GitLab](https://gitlab.com/)에 연동합니다.

## 셋업

GitLab 리포지토리 ID가 필요합니다. GitLab 리포지토리의 **Details** 페이지에서 프로젝트 이름 바로 아래에는 **Project ID:**가 있습니다.

또는 `GitLab_Username/GitLab_RepositoryName`을 사용할 수 있습니다 (예: `MyCoolUsername/MyCoolRepository`).

최소한 API 권한 범위를 가진 GitLab 토큰이 필요합니다. 이 토큰은 GitLab 사용자 설정의 [GitLab Personal Access Tokens](https://gitlab.com/profile/personal_access_tokens)페이지에서 만들 수 있습니다.

## 설정

이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: gitlab_ci
    gitlab_id: YOUR_GITLAB_ID
    token: YOUR_GITLAB_TOKEN
```

{% configuration %}
gitlab_id:
  description: The GitLab repository identifier.
  required: true
  type: string
token:
  description: The GitLab API token.
  required: true
  type: string
name:
  description: Sensor name as it appears in Home Assistant.
  required: false
  type: string
  default: GitLab CI Status
url:
  description: The GitLab repository URL. Used for self-hosted repositories.
  required: false
  type: string
  default: https://gitlab.com
{% endconfiguration %}
