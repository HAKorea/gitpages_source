---
title: "원격 접속"
description: "Setting up remote access for Home Assistant."
---

<div class='note'>
<a href="https://www.nabucasa.com">Home Assistant Cloud</a> 사용자는 어떤 설정을 하지 않더라도 <a href="https://www.nabucasa.com/config/remote/">Remote UI</a> 를 사용하여 원격 접속을 할 수 있습니다.
</div>

집 밖에서 홈어시스턴트에 로그인하려면, 인스턴스에 원격으로 액세스 할 수 있어야합니다.

<div class='note warning'>

이 작업을 수행하기 전에 [보안 점검 목록](/docs/configuration/securing/)을 따르십시오 .

</div>

<div class='note'>
홈어시스턴트는 더 이상 릴리스 0.77 이후 IP 주소를 통한 원격 액세스를 지원하지 않으므로 도메인 이름을 사용해야합니다.
</div>

가장 일반적인 방법은 공유기에서 홈어시스턴트를 호스팅하는 컴퓨터의 포트 8123으로 포트 전달 (모든 포트에 대해)을 설정하는 것입니다. 이 작업을 수행하는 방법에 대한 일반적인 지침은 `소유한 공유기의 포트포워딩 방법 설명`을 검색하여 찾을 수 있습니다. 공유기의 빈 포트를 사용하여 포트 8123으로 전달할 수 있습니다.

포트에 액세스 할 수있게하는 문제는 일부 인터넷 서비스 제공 업체가 동적 IP 만 제공한다는 것입니다. 이로 인해 외부에서 홈어시스턴트에 액세스하지 못할 수 있습니다. [DuckDNS](https://www.duckdns.org/)와 같은 무료 동적 DNS 서비스를 사용하여이 문제를 해결할 수 있습니다.

원격으로 Home Assistant 설치에 액세스 할 수 없는 경우, ISP가 [CG-NAT](https://en.wikipedia.org/wiki/Carrier-grade_NAT)로 다른 사용자와 공유하는 대신 전용 IP를 제공하는지 확인하십시오. 이것은 IPv4 주소의 부족으로 인해 현재는 상당히 일반화되고 있습니다. 대부분의 ISP가 아닌 경우 일부는 전용 IPv4 주소를 할당하기 위해 추가 비용을 지불하도록 요구합니다.

<div class='note'>

포트를 올리는 것만으로는 안전하지 않습니다. 홈어시스턴트에 원격으로 접속하는 경우 트래픽 암호화를 반드시 고려해야합니다. 자세한 내용은 [set up encryption using Let's Encrypt](/blog/2017/09/27/effortless-encryption-with-lets-encrypt-and-duckdns/) 블로그 내용 혹은 홈어시스턴트에 Let's Encrypt 사용하기 [detailed guide](/docs/ecosystem/certificates/lets_encrypt/)를  확인하십시오.

</div>

클라이언트와 홈어시스턴트 인스턴스 간에 [self-signed certificate](/docs/ecosystem/certificates/tls_self_signed_certificate/)로 집안 정보를 보호하십시오.

홈어시스턴트 프론트 엔드에 액세스하는 다른 방법은,  [the instructions how to use Tor](/docs/ecosystem/tor/) 를 참고하십시오.
