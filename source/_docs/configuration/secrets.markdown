---
title: "비밀정보 저장"
description: "Storing secrets outside of your configuration.yaml."
redirect_from: /topics/secrets/
---

`configuration.yaml` 파일은 해당 파일에 액세스 권한을 가진 사람은 누구나 읽을 수 있는, 일반 텍스트 파일입니다. 이 파일에는 설정을 공유하려는 경우 수정해야하는 비밀정보 및 API 토큰이 포함되어 있습니다. `!secret` 를 사용하면 설정 파일에서 개인정보를 제거 할 수 있습니다. 이 분리는 암호와 API 키가 모두 한 곳에 저장되어 `configuration.yaml`을 [설정 나누기](/docs/configuration/splitting_configuration/)를 하면, 더 이상 파일 또는 여러 yaml 파일에 분산되지 않기 때문에 암호와 API 키를 쉽게 추적하는 데 도움이됩니다.


### secrets.yaml 사용

개인정보를 이전하는 워크플로우는 `secrets.yaml`에서 [설정 나누기](/docs/configuration/splitting_configuration/)와 매우 유사합니다. 홈어시스턴트 [설정 디렉토리](/docs/configuration/) 에 `secrets.yaml` 파일을 저장하십시오. 

`configuration.yaml` 파일의 비밀정보 및 API 키 항목은 일반적으로 아래 예와 같습니다.

```yaml
homeassistant:
  auth_providers:
   - type: legacy_api_password
     api_password: YOUR_PASSWORD
```

이러한 항목은 `!secret` 및 식별자로 교체해야합니다.

```yaml
homeassistant:
  auth_providers:
   - type: legacy_api_password
     api_password: !secret http_password
```

`secrets.yaml` 파일은 식별자에 할당 된 해당 암호가 포함되어 있습니다.

```yaml
http_password: YOUR_PASSWORD
```

### 비밀정보 디버깅 (Debugging secrets)

설정을 여러 파일로 분할하기 시작하면 하위 폴더의 구성이 끝날 수 있습니다. 비밀정보는 다음 순서로 해결됩니다. :

- 비밀정보를 참조하는 `secrets.yaml`는 다른 YAML 파일들과 같이 있는 폴더에 위치함. 
- 다음으로 메인 configuration.yaml와 함께 있는 폴더에서 중지된다면, 부모 폴더의 secrets.yaml 에서 비밀정보가 있는 파일을 검색할 것입니다. 
- 마지막으로, `keyring`은 비밀정보를 쿼리합니다 (아래 좀 더 자세한 정보).

비밀정보가 어디에서 로드되는지 확인하려면, `secrets.yaml` 파일에 옵션을 추가 하거나 `check_config` 스크립트를 사용하십시오.

*Option 1*:  `secrets.yaml` 안에 다음을 추가하여 비밀정보가 검색되는 위치를 홈어시스턴트 로그로 확인하십시오  :

```yaml
logger: debug
```
이는 실제 비밀정보 값을 로그에 출력하지 않습니다.

*Option 2*: `secrets.yaml`파일이 사용한 모든 내용에서 비밀정보들이 검색되는 위치를 보기 위해서  명령행에서 [`check_config` script](/docs/tools/check_config/) 스크립트 를 사용할 수 있습니다. :

```bash
$ hass --script check_config --secrets
```
모든 비밀정보들이 출력됩니다. 

## `secrets.yaml`에 대한 대안

- [OS에서 관리하는 keyring을 사용하여 비밀정보 저장](/docs/tools/keyring/)
- [AWS에서 안전하게 비밀정보 저장](/docs/tools/credstash/)

