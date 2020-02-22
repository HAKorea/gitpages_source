---
title: "Lovelace 작동 방식"
description: "Explains how Lovelace works under the hood."
---

기존 사용자 인터페이스는 상태 머신에만 의존했습니다. 이는 상태 머신이 이제 디바이스 상태의 소스 일뿐만 아니라 사용자 인터페이스 설정 소스라는 의미에서 문제가 있어왔습니다. Lovelace와는 완전히 다른 접근법을 취하고 있습니다. 모든 사용자 인터페이스 구성은 사용자가 제어하는 ​​별도의 파일에 있습니다. 

<p class='img'>
<img
  src='/images/lovelace/lovelace-ui-comparison.png'
  alt='Diagram showing how states no longer contain UI configuration.'>
기존 구성과 새로운 구성의 시각적 비교
</p>

<!-- source: https://docs.google.com/drawings/d/1O1o7-wRlnsU1lLgfdtn3s46P5StJjSL5to5RU9SV8zs/edit?usp=sharing -->
