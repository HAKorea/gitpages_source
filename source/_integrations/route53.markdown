---
title: 아마존 AWS Route53
description: Automatically update your AWS Route53 DNS records.
logo: route53.png
ha_category:
  - Network
ha_release: 0.81
---

`route53` 통합구성요소로 AWS Route53 DNS 레코드를 최신 상태로 유지할 수 있습니다.

연동은 1 시간마다 실행되지만 서비스들 중에서 `route53.update_records` 서비스를 사용하여 수동으로 시작할 수도 있습니다.

이 플랫폼은 [ipify.org](https://www.ipify.org/)의 API를 사용하여 공개 IP 주소를 설정합니다.

## 셋업

이 기능이 작동하려면 적절한 IAM 정책 및 API 키를 사용하여 AWS 계정을 설정해야합니다.

이 프로세스에 익숙하면 다음 섹션을 건너 뛰고 설정 섹션으로 직접 이동할 수 있습니다.

AWS 측에서는 다음을 수행해야합니다.

1. Create a suitable zone for a domain that you own and manage in Route53, the domain `home.yourdomain.com` is used as an example.

2. Once created, write down the Hosted Zone ID value for the domain. This is needed for the plugin and IAM configuration.

3. Create an IAM Policy that provides update and query access to this domain explicitly and has no other permissions to the AWS account.

Here is an IAM Policy sample, don't forget to update your Zone ID on the Resource line.
다음은 IAM 정책 샘플입니다. 리소스(Resource) 라인에서 영역(Zone) ID를 업데이트하는 것을 잊지 마십시오.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "route53:GetHostedZone",
                "route53:ChangeResourceRecordSets",
                "route53:ListResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/YOURZONEIDGOESHERE"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "route53:TestDNSAnswer",
            "Resource": "*"
        }
    ]
}
```

4. Once this has been done, create a new user called `homeassistant` and add the IAM policy to the user, allowing it to manage this DNS resource.

5. Under the security credentials tab for the `homeassistant` user, create a set of access keys for placement in the integration definition YAML.

## 설정

설치에서 본 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
route53:
  aws_access_key_id: ABC123
  aws_secret_access_key: DEF456
  zone: ZONEID678
  domain: yourdomain.com
  records:
    - vpn
    - hassio
    - home
```

{% configuration route53 %}
aws_access_key_id:
  description: The AWS access key ID for the account that has IAM access to the domain.
  required: true
  type: string
aws_secret_access_key:
  description: The AWS secret access key for the account that has IAM access to the domain.
  required: true
  type: string
zone:
  description: The AWS zone ID for the domain in Route53.
  required: true
  type: string
domain:
  description: The domain name for the domain in Route53.
  required: true
  type: string
records:
  description: A list of records you want to update.
  required: true
  type: list
ttl:
  description: The TTL value for the DNS records.
  required: false
  type: integer
  default: 300
{% endconfiguration %}

## 서비스

### `route53.update_records` 서비스

이 서비스를 사용하여 DNS 레코드 업데이트를 수동으로 트리거하십시오.