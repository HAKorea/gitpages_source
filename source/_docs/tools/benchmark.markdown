---
title: "벤치마크"
description: "홈 어시스턴트 벤치마킹을 수행하는 스크립트"
---

홈 어시스턴트의 성능을 측정하기 위해, 컨트롤+C를 눌러 취소할 때까지 벤치마크 스크립트를 실행합니다.

백만 건의 이벤트가 발생되고, 처리됩니다.

```bash
$ hass --script benchmark async_million_events
```

