---
title: 아마존 웹 서비스 (AWS)
description: Instructions on how to integrate Amazon Web Services with Home Assistant.
logo: aws.png
ha_category:
  - Notifications
ha_release: '0.91'
ha_codeowners:
  - '@awarecan'
  - '@robbiet480'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/C_JTPwKuLX0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`aws` 통합구성요소는 [Amazon Web Services](https://aws.amazon.com/)와 상호 작용할 수 있는 단일 장소를 제공합니다. 현재 [AWS SQS](https://aws.amazon.com/sqs/), [AWS SNS](https://aws.amazon.com/sns/)로 메시지를 보낼 수 있는 알림 플랫폼을 제공합니다. 또는 [AWS Lambda](https://aws.amazon.com/lambda/) 함수를 호출하십시오.

## 셋업

Amazon Web Services를 사용하려면 AWS 계정이 있어야합니다. 12 개월의 프리 티어 혜택으로 [여기](https://aws.amazon.com/free/)서 만드십시오. 첫 12 개월 동안에도 프리 티어에서 제공되는 것보다 더 많은 리소스를 사용하면 요금이 청구될 수 있습니다.

`aws` 컴포넌트에서 사용되는 `lambda`, `sns` 및 `sqs` 서비스는 모두 12 개월이 지난 후에도 모든 사용자에게 **Always Free** 등급을 제공합니다. 홈오토메이션의 일반적인 사용은 프리 티어 한도에 도달하지 않을 가능성이 높습니다. [Lambda 요금](https://aws.amazon.com/lambda/pricing/), [SNS 요금](https://aws.amazon.com/sns/pricing/) 및 [SQS 요금][SQS Pricing](https://aws.amazon.com/sqs/pricing/)에서 자세한 내용은 확인하십시오. 

`aws` 통합구성요소는 [botocore](https://botocore.amazonaws.com/v1/documentation/api/latest/index.html)를 사용하여 Amazon Web Services와 통신하며 [AWS Command Client Interface](https://aws.amazon.com/cli/) 도구에서도 사용됩니다. 따라서 `aws`는 `awscli` 도구와 동일한 credential 및 profiles을 공유합니다. 액세스 키를 얻는 방법과 로컬에서 액세스 키를 관리하는 방법은 [Configuring the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)을 참조하십시오.  

## 설정

설치에서 `aws` 통합구성요소와 `notify` 플랫폼을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
aws:
  credentials:
    - name: My AWS Account
      aws_access_key_id: AWS_ID
      aws_secret_access_key: AWS_SECRET
  notify:
    # use the first credential defined in aws integration by default
    - service: lambda
      region_name: us-east-1
```

### 설정과 자격 증명(credentials)

{% configuration %}
name:
  description: Give your AWS credential a name, so that you can refer it in other AWS platforms.
  required: true
  type: string
aws_access_key_id:
  description: Your AWS Access Key ID. If provided, you must also provide an `aws_secret_access_key` and must **not** provide a `profile_name`. Required if `aws_secret_access_key` is provided.
  required: false
  type: string
aws_secret_access_key:
  description: Your AWS Secret Access Key. If provided, you must also provide an `aws_access_key_id` and must **not** provide a `profile_name`. Required if `aws_access_key_id` is provided.
  required: false
  type: string
profile_name:
  description: A credentials profile name.
  required: false
  type: string
validate:
  description: Whether validate credential before use. Validate credential needs `IAM.GetUser` permission.
  required: false
  default: true
  type: boolean
{% endconfiguration %}

### notify 설정

{% configuration %}
service:
  description: Amazon Web Services will be used for notification. You can choose from `lambda`, `sns`, or `sqs`.
  required: true
  type: string
region_name:
  description: The region identifier to connect to, for example, `us-east-1`.
  required: true
  type: string
credential_name:
  description: A reference to an `aws` credential. Notify platform will use the `default profile` defined in `~/.aws` if none of `credential_name`, `aws_access_key_id`, or `profile_name` was given.
  required: false
  type: string
aws_access_key_id:
  description: Your AWS Access Key ID. If provided, you must also provide an `aws_secret_access_key`.
  required: false
  type: string
aws_secret_access_key:
  description: Your AWS Secret Access Key. If provided, you must also provide an `aws_access_key_id`. Required if aws_access_key_id is provided.
  required: false
  type: string
profile_name:
  description: A credentials profile name.
  required: false
  type: string
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
context:
  description: An optional dictionary you can provide to pass custom context through to the notification handler.
  required: false
  type: string
{% endconfiguration %}

## Lambda Notify 사용법

AWS Lambda는 알림 플랫폼이므로 `notify` 서비스 [as described here](/integrations/notify/)를 호출하여 제어할 수 있습니다. 알림(notification) 페이로드에 지정된 모든 대상에 대해 Lambda를 호출합니다. 대상은 함수 이름, 전체 ARN ([Amazon Resource Name](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)) 또는 일부분의 ARN으로 형식을 지정할 수 있습니다. 자세한 내용은 [botocore docs](https://botocore.amazonaws.com/v1/documentation/api/latest/reference/services/lambda.html#Lambda.Client.invoke)를 참조하십시오.

Lambda 이벤트 페이로드에는 서비스 호출 페이로드에 전달된 모든 것이 포함됩니다. 다음은 Lambda로 전송 될 페이로드의 예입니다.

```json
{
  "title": "Test message!",
  "target": "arn:aws:lambda:us-east-1:123456789012:function:ProcessKinesisRecords",
  "data": {
    "test": "okay"
  },
  "message": "Hello world!"
}
```

컨텍스트는 다음과 같습니다.

```json
{
  "custom": {
    "two": "three",
    "test": "one"
  }
}
```

## SNS Notify 사용법

AWS SNS는 알림 플랫폼이므로 `notify` 서비스[as described here](/integrations/notify/)를 호출하여 제어 할 수 있습니다. 알림 페이로드에 지정된 모든 대상에 메시지를 게시합니다. 대상은 SNS topic 또는 endpoint ARN([Amazon Resource Name](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html))이어야합니다. 자세한 내용은 [botocore docs](https://botocore.amazonaws.com/v1/documentation/api/latest/reference/services/sns.html#SNS.Client.publish)를 참조하십시오.

존재하는 경우 SNS 주제(Subject)가 제목(title)으로 설정됩니다. 메시지를 제외한 페이로드의 모든 속성은 문자열화된 메시지 속성으로 전송됩니다.

### SNS within AWS 셋업하기

- AWS 콘솔에 로그인하고 "Security and Identity"에서 "Identity & Access Management"를 선택하십시오.
- 왼쪽에서 "Users"를 선택한 다음 "Create New Users"를 클릭하십시오. 여기에 이름을 입력 한 다음 "Create"를 클릭하십시오.
- credentials를 다운로드하거나 화살표를 클릭하여 한 번 표시할 수 있습니다.

<div class='note warning'>
다운로드하지 않으면 파일을 잃어 버리고 새 사용자를 다시 만들어야합니다.
</div>

- 파일에 표시된 두 개의 키를 복사/붙여 넣기하십시오. 
- 화면 왼쪽에서 "Users"로 돌아가서 방금 만든 사용자를 선택하십시오. "Permissions" 탭에서 "Attach Policy" 아이콘을 클릭하십시오. "SNS"를 검색하고 "AmazonSNSFUullAccess" 정책을 첨부하십시오.
- AWS 콘솔로 돌아가서 "SNS"를 찾아 해당 서비스를 클릭해야합니다. 모바일 서비스 그룹에 속합니다.
- 왼쪽에서 "Topics"를 선택한 다음 "Create new topic"를 선택하십시오.
- Topic 이름과 Display 이름을 선택하십시오.
- 이제 방금 만든 Topic 옆의 확인란을 선택하고 작업에서 "Subscribe to topic"을 선택하십시오.
- 팝업 상자에서 Protocol = SMS를 선택하고 SMS로 보내려는 "Endpoint" 옆에있는 전화번호를 입력하십시오. 이제 "Create"를 클릭하십시오.
- 추가 번호를 반복하십시오.
- "Users" 섹션으로 돌아 가면 "arn:"으로 시작하고 이전에 선택한 Topic 이름으로 끝나는 긴 영숫자 줄이 표시됩니다. 이것이 홈어시스턴트의 "대상(target)"입니다.

## SQS Notify 사용법

AWS SQS는 알림 플랫폼이므로 `notify` 서비스를 호출하여 제어 할 수 있습니다 [as described here](/integrations/notify/). 알림 페이로드에 지정된 모든 대상에 대한 메시지를 큐에 게시합니다. 대상은 SQS topic URL이어야합니다. 자세한 내용은 [SQS docs](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ImportantIdentifiers.html),  [bototcore docs](https://botocore.amazonaws.com/v1/documentation/api/latest/reference/services/sqs.html#SQS.Client.send_message)를 참조하십시오.

SQS 이벤트 페이로드에는 서비스 호출 페이로드에 전달된 모든 것이 포함됩니다. SQS 페이로드는 문자열화 된 JSON으로 게시됩니다. 메시지를 제외한 페이로드의 모든 속성도 문자열화 된 메시지 속성으로 전송됩니다. 다음은 SQS 대기열에 게시될 메시지 예입니다.

```json
{
  "title": "Test message!",
  "target": "https://sqs.us-east-1.amazonaws.com/123456789012/queue2%22",
  "data": {
    "test": "okay"
  },
  "message": "Hello world!"
}
```
