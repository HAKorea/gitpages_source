---
title: 클라우드플레어(Cloudflare)
description: Automatically update your Cloudflare DNS records.
logo: cloudflare.png
ha_category:
  - Network
ha_release: 0.74
ha_codeowners:
  - '@ludeeus'
---

`cloudflare` 통합구성요소를 사용하면 Cloudflare 레코드를 최신 상태로 유지할 수 있습니다.

연동은 1 시간마다 실행되지만 서비스 아래의 `cloudflare.update_records` 서비스를 사용하여 수동으로 시작할 수도 있습니다.

## 셋업

Cloudflare 계정 설정에서 글로벌 API 키를 찾을 수 있습니다.

## 설정

설치에서 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
cloudflare:
  email: YOUR_EMAIL_ADDRESS
  api_key: YOUR_GLOBAL_API_KEY
  zone: EXAMPLE.COM
  records:
    - ha
    - www
```

{% configuration cloudflare %}
email:
  description: The email address for your Cloudflare account.
  required: true
  type: string
api_key:
  description: The global API key for your Cloudflare account.
  required: true
  type: string
zone:
  description: The DNS zone (domain) you want to update.
  required: true
  type: string
records:
  description: A list of records (subdomains) you want to update.
  required: true
  type: list
{% endconfiguration %}

## 추가 정보

### 외부 서비스 이용법

이 플랫폼은 [ipify.org](https://www.ipify.org/)의 API를 사용하여 public IP 주소를 설정합니다.

### API Key

`api_key`는 Cloudflare의 계정의 [global API key](https://support.cloudflare.com/hc/en-us/articles/200167836-Managing-API-Tokens-and-Keys#12345682)입니다. (API 토큰 아님).

### Home Assistant Companion App

Cloudflare를 통해 [iOS App](https://companion.home-assistant.io/)을 사용하려면 **최소 TLS 버전을 1.2**로 설정하려면 다음을 수행하십시오.
1. Login to your [Cloudflare](https://dash.cloudflare.com/) account.
2. Choose your domain.
3. Click on the `SSL/TLS` icon.
4. Go to tab `Edge Certificates`.
5. Find `Minimum TLS Version` and set it to **1.2**.

다른 세팅들은 문제를 일으키지 않아야 합니다.

### SSH over Cloudflare

SSH 사용([this](https://blog.cloudflare.com/cloudflare-now-supporting-more-ports/) 소스에 따름)의 경우 Cloudflare를 우회하여 서버에 직접 연결해야합니다. 이렇게하려면 프록시 상태가 "DNS only"(오렌지 아이콘을 클릭하면 색상이 회색으로 바뀝니다)인 CNAME DNS 레코드(예: `ssh.example.com`)를 만든 다음 서버 SSH 포트를 사용하여 `ssh.example.com`에 연결하십시오.

### Home Assistant에만 Cloudflare 도메인 사용

기본 도메인만 업데이트하려면 `example.com`과 같이 도메인만 레코드 목록에 배치하십시오. 매시간마다 IP로 `A` DNS 레코드를 업데이트합니다.

```yaml
# Example configuration.yaml entry for one domain
cloudflare:
  email: YOUR_EMAIL_ADDRESS
  api_key: YOUR_GLOBAL_API_KEY
  zone: EXAMPLE.COM
  records:
    - EXAMPLE.COM
```

#### 최소 DNS 레코드 설정은 다음과 같습니다 (https를 이미 설정한 경우) :

도메인에서 Home Assistant 서버의 IP 주소로 리디렉션하려면 다음 DNS 레코드를 설정하십시오.

```text
Type: A
Name: @
IPv4 Address: your.ip.address
```

[this](https://api.ipify.org/) 페이지에서 현재 IP 주소를 찾을 수 있습니다.

`https://www`에서 `https://`로 리디렉션하려면 다음 DNS 레코드를 설정해야합니다.

```text
Type: CNAME
Name: @
Target: example.com (your actual domain)
```

또한 페이지 규칙을 작성하십시오.

```text
If the URL matches: www.example.com*
Then the settings are: Forwarding URL
Status: 302 - Temporary redirect
Destination URL: https://example.com/$1
```
