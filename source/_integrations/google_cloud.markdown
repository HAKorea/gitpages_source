---
title: 구글 클라우드 플랫폼
description: Google Cloud Platform integration.
logo: google_cloud.png
ha_category: Text-to-speech
ha_release: 0.95
ha_codeowners:
  - '@lufton'
---

`google_cloud` 플랫폼을 사용하면 [구글 클라우드 플랫폼](https://cloud.google.com/) API를 사용하여 홈어시스턴트에 통합 할 수 있습니다.

## 설정 (Configuration)

구글 클라우드 플랫폼을 사용하려면 사용할 [`API 키`] (# acquire-an-api-key) 파일의 `config` 디렉토리 상대 경로를 제공해야합니다. `config` 폴더 아래에 놓고 `configuration.yaml`의 key_file 매개 변수를 설정하십시오

```yaml
# Example configuration.yaml entry
tts:
  - platform: google_cloud
    key_file: googlecloud.json
```

## API 키 발급받기

해당 문서에 설명 된 API 키 발급 프로세스 :

* [Text-to-Speech](https://cloud.google.com/text-to-speech/docs/quickstart-protocol)
* [Speech-to-Text](https://cloud.google.com/speech-to-text/docs/quickstart-protocol)
* [Geocoding](https://developers.google.com/maps/documentation/geocoding/start)

모든 API에 대한 기본 지침 :

1. [Cloud Resource Manager](https://console.cloud.google.com/cloud-resource-manager) 방문.
2. 맨위에 `CREATE PROJECT` 버튼 클릭
3. `Project name`을 만들어서 `Create` 버튼을 클릭하십시오.
4. [Google Cloud Platform 프로젝트에 결제가 사용 설정되어 있는지 확인](https://cloud.google.com/billing/docs/how-to/modify-project).
5. 아래 링크 중 하나 [API 라이브러리](https://console.cloud.google.com/apis/library)를 방문하여 드롭 다운 목록에서 `Project`를 선택하고 `Continue` 버튼을 클릭하여 필요한 Cloud API를 활성화하십시오.

    * [Text-to-Speech](https://console.cloud.google.com/flows/enableapi?apiid=texttospeech.googleapis.com)
    * [Speech-to-Text](https://console.cloud.google.com/flows/enableapi?apiid=speech.googleapis.com)
    * [Geocoding](https://console.cloud.google.com/flows/enableapi?apiid=geocoding-backend.googleapis.com)

6. 인증 설정 :

    1. [this link](https://console.cloud.google.com/apis/credentials/serviceaccountkey)를 방문하십시오.
    2. From the `Service account` list, select `New service account`.
    2. `Service account` 목록에서 `New service account` 을 선택하십시오.
    3. In the `Service account name` field, enter any name.
    3. `Service account name` 필드에 이름을 입력하십시오. 

    텍스트 음성 변환 API 키를 요청하는 경우 :

    4. 역할(Role) 목록에서 값을 선택하지 마십시오. **이 서비스에 액세스하는 데 역할(Role)이 필요하지 않습니다**.
    5. `Create` 를 클릭. 이 서비스 계정에는 역할(Role)이 없다는 경고 메시지가 나타납니다.
    6. `Create without role`을 클릭. `API 키`가 포함 된 JSON 파일이 컴퓨터에 다운로드됩니다..

## 구글 클라우드 Text-to-Speech

[구글 클라우드 Text-to-Speech](https://cloud.google.com/text-to-speech/)는 20 개 이상의 언어 및 변형에서 100 개 이상의 음성으로 텍스트를 사람과 유사한 음성으로 변환합니다. 이 기술은 음성 합성 (WaveNet)과 Google의 강력한 신경망에 대한 혁신적인 연구를 적용하여 고음질 오디오를 제공합니다. 이렇게 사용하기 쉬운 API를 사용하면 고객 서비스, 장치 상호 작용 및 기타 응용 프로그램을 변화시키는 사용자와 활발한 상호 작용을 만들 수 있습니다.

### 가격 (Pricing)

Cloud Text-to-Speech API는 서비스로 전송되는 오디오로 합성 할 문자 수를 기준으로 매월 가격이 책정됩니다.

| Feature                       | Monthly free tier         | Paid usage                        |
|-------------------------------|---------------------------|-----------------------------------|
| Standard (non-WaveNet) voices | 0 to 4 백만글자 | $4.00 USD / 1 백만글자  |
| WaveNet voices                | 0 to 1 백만글자 | $16.00 USD / 1 백만글자 |

### Text-to-Speech 설정

{% configuration %}
key_file:
  description: "Google Cloud Platform과 함께 사용할 [`API 키`](# acquire-an-api-key) 파일입니다. 지정하지 않으면 `os.environ['GOOGLE_APPLICATION_CREDENTIALS']`경로가 사용됩니다"
  required: false
  type: string
language:
  description: "음성의 기본 언어는 `en-US`. 지원되는 언어, 성별 및 음성은 [here](https://cloud.google.com/text-to-speech/docs/voices). 따라서 문서화되지 않았지만 지원되는 언어가 추가로 있습니다. (드롭다운을 [here](https://cloud.google.com/text-to-speech/#streaming_demo_section))."
  required: false
  type: string
  default: en-US
gender:
  description: "음성의 기본 성별은 `male`. 지원되는 언어, 성별 및 음성은 [here](https://cloud.google.com/text-to-speech/docs/voices)."
  required: false
  type: string
  default: neutral
voice:
  description: "기본 목소리는 `en-US-Wavenet-F`. 지원되는 언어, 성별 및 음성은 [here](https://cloud.google.com/text-to-speech/docs/voices). **중요! 이 매개 변수는 설정된 경우 `language` 및 `gender` 매개 변수를 대체합니다.**."
  required: false
  type: string
encoding:
  description: "기본 오디오 인코더. 지원되는 인코딩은 `ogg_opus`, `mp3` 그리고 `linear16`."
  required: false
  type: string
  default: mp3
speed:
  description: "[0.25, 4.0] 범위 내에서 음성의 속도. 1.0은 특정 음성에서 지원되는 기본 고유 속도입니다. 2.0은 두 배 빠르며, 0.5는 반의 속도입니다. unset (0.0) 인 경우 기본적으로 기본 1.0 속도입니다."
  required: false
  type: float
  default: 1.0
pitch:
  description: "[-20.0, 20.0] 범위에서 음색의 기본 피치. 20은 원래 피치에서 20 반음이 증가 함을 의미합니다. -20은 원래 피치에서 20 반음의 감소를 의미합니다."
  required: false
  type: float
  default: 0.0
gain:
  description: "[-96.0, 16.0] 범위에서 음색의 기본 볼륨 게인 (dB)입니다.설정하지 않거나 0.0 (dB) 값으로 설정하면 정상적인 기본 신호 진폭에서 재생됩니다. -6.0 (dB) 값은 일반 기본 신호 진폭의 진폭의 약 절반에서 재생됩니다. +6.0 (dB) 값은 일반 기본 신호 진폭의 진폭의 약 2 배로 재생됩니다. 일반적으로 이보다 큰 값은 효과적으로 음량이 증가하지 않으므로 +10 (dB)을 초과하지 않는 것이 좋습니다."
  required: false
  type: float
  default: 0.0
profiles:
  description: "텍스트에 음성으로 (포스트 합성된) 적용되는 '오디오 효과' 프로파일을 선택하는 식별자입니다. 효과는 주어진 순서대로 서로 그 위에 적용됩니다. 지원되는 프로필 ID는 [here](https://cloud.google.com/text-to-speech/docs/audio-profiles)에 나열되어 있습니다."
  required: false
  type: list
  default: "[]"
{% endconfiguration %}

### 전체 설정의 예 (Full configuration example)

Google 클라우드 텍스트 음성 변환 설정은 다음과 같습니다. :

```yaml
# Example configuration.yaml entry
tts:
  - platform: google_cloud
    key_file: googlecloud.json
    language: en-US
    gender: male
    voice: en-US-Wavenet-F
    encoding: linear16
    speed: 0.9
    pitch: -2.5
    gain: -5.0
    profiles:
      - telephony-class-application
      - wearable-class-device
```
