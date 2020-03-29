---
title: "보안"
description: "Instructions on how to secure your Home Assistant installation."
redirect_from: /getting-started/securing/
---

Home Assistant의 주요 장점 중 하나는 클라우드 서비스에 의존하지 않는다는 것입니다. 로컬 네트워크에서만 홈어시스턴트를 사용하더라도 인스턴스를 보호하기위한 조치를 취해야합니다.

## 점검표

다음은 홈어시스턴트 시스템을 보호하기 위해 *반드시 수행* 해야할 작업에 대한 요약입니다. :

- [secrets](/docs/configuration/secrets/)를 설정하십시오. (백업을 필수.)
- 시스템을 정기적으로 최신 상태로 유지하십시오

## 원격 접속

안전한 원격 액세스를 원할 경우 가장 쉬운 방법은 [Home Assistant cloud](/cloud/)를 사용하는 것입니다. 다른 옵션은 [TLS/SSL](/docs/ecosystem/certificates/lets_encrypt/)을 사용하는 [VPN](https://pivpn.dev/), [Tor](/docs/ecosystem/tor/) 혹은 [SSH tunnel](/blog/2017/11/02/secure-shell-tunnel/)를 사용하여 인터넷에 인스턴스를 노출시키는 방법이 있습니다.  

### 수동 설치를 위한 추가 기능

위의 내용뿐만 아니라 보안을 개선하기 위해 다음 사항을 고려하는 것이 좋습니다.:

- sshd 설정(보통 `/etc/ssh/sshd_config`)에서 SSH 세트를 사용하여 비밀번호를 사용하는 대신에 SSH 인증 key들을 사용하는 방법입니다. SSH 서비스로 원격 접속을 활성화하는 경우 특히 중요합니다.
- 보안 모범 사례 지침에 따라 호스트를 보호하십시오, 사례:
  * [Securing Debian Manual](https://www.debian.org/doc/manuals/securing-debian-howto/index.en.html) (라즈비안도 똑같이 적용 가능)
  * [Red Hat Enterprise Linux 7 Security Guide](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/pdf/Security_Guide/Red_Hat_Enterprise_Linux-7-Security_Guide-en-US.pdf), [CIS Red Hat Enterprise Linux 7 Benchmark](https://benchmarks.cisecurity.org/tools2/linux/CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.0.0.pdf)
