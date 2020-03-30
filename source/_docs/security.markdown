---
title: "홈어시스턴트의 보안"
description: "홈어시스턴트의 보안성."
---

홈어시스턴트는 네트워크 연결을 통한 접근을 허용하는 다른 서비스 또는 데몬과 마찬가지이기 때문에, 전체적인 보안을 강화하면서도 운영 상태를 유지하기 위한 특정 조치를 취했습니다.

사용 사례에 관계없이 설치 과정을 마치면 [당신의 설치를 보호하십시오.](/docs/configuration/securing/).

홈어시스턴트는 당신의 라우터나 방화벽의 설정을 변경할 수 **없습니다.** 이는 당신이 [포트포워딩](/docs/configuration/remote/)을 설정해야 한다는 것이고, 외부에서 접속할 경우 방화벽 룰을 조절해야 한다는 것을 의미합니다. 기본적으로 당신의 프론트엔드와 홈어시스턴트 애드온(Mosquitto, SSH, Samba 등)은 내부 네트워크에서만 접속할 수 있습니다.

## 서버 배너

홈어시스턴트의 [지문/서버 배너에 대한 자세한 내용](/docs/security/webserver/)을 확인할 수 있습니다. 

## Porosity

홈 어시스턴트의 기본 포트는 8123입니다. 이 포트로 [`프론트엔드`](/integrations/frontend/)와 [`API`](/integrations/api/)가 제공됩니다. 둘다 `server_host` 또는 `server_port`와 같은 설정을 조정하는 기능이 포함된 [`http`](/integrations/http/)통합을 따릅니다.

다양한 애드온이 있는 Hass.io 인스턴스의 [포트 열기](/docs/security/porosity/)를 참고하십시오. 

## HTTP SSL/TLS

홈 어시스턴트는 서버 사이드 SSL/TLS 설정에 [Mozilla's Operations Security team recommendations](https://wiki.mozilla.org/Security/Server_Side_TLS)를 따릅니다. 홈 어시스턴트는 기본적으로 **Modern compatibility**를 사용합니다. **Intermediate compatibility**를 사용하기 원한다면, [`http` 통합](/integrations/http/)에서 설정할 수 있습니다.

## SSH

The SSH connection for [디버깅](https://developers.home-assistant.io/docs/en/hassio_debugging.html) on port 22222 is not enabled by default and can only be used with keys. 
[디버깅](https://developers.home-assistant.io/docs/en/hassio_debugging.html)을 위한 SSH 연결(포트 22222)은 기본적으로 비활성화되어 있습니다. 그리고 키 인증으로만 쓸 수 있습니다.

[SSH server add-on](/addons/ssh/)으로 SSH를 사용할 경우 설정과 보안에 대한 책임은 사용자에게 있습니다.

## 소스 코드

자원의 부족으로 인해 우리는 모든 의존성을 검토하고 악의적인 행동, 정보의 유출 또는 GDPR 준수 여부를 검사할 수 없습니다. 그러나 우리는 의존성의 발전에 깊은 관심을 가지고 있으며 업스트림 개발자와 긴밀히 협력하려고 노력합니다.

