---
title: "Z-Wave Query Stage"
description: "What are the Query Stages."
---

Z-Wave 메시가 처음 시작되면 컨트롤러는 메시의 모든 장치에 대해 다음 단계를 모두 수행합니다. 이것은 느린 프로세스이며 완료하려면 장치가 깨어있어야합니다. 주전원 장치나 USB 전원 장치는 항상 깨어 있지만 배터리 전원 장치는 대부분의 시간을 잠들게합니다. 이로 인해 시작 후 배터리 구동 장치가 `Initializing (CacheLoad)`에서 시간을 소비할 것으로 예상할 수 있습니다. - 장치에 따라 시간이 다릅니다.

`Initializing`로 표시되어있는 동안 장치는 계속 정상적으로 작동합니다.

| Stage                  | Description                                                        |
|------------------------|--------------------------------------------------------------------|
| None                   | Query process hasn't started for this node                         |
| ProtocolInfo           | Retrieve protocol information                                      |
| Probe                  | Ping device to see if alive                                        |
| WakeUp                 | Start wake up process if a sleeping node                           |
| ManufacturerSpecific1  | Retrieve manufacturer name and product ids if ProtocolInfo lets us |
| NodeInfo               | Retrieve info about supported, controlled command classes          |
| NodePlusInfo           | Retrieve Z-Wave+ info and update device classes                    |
| SecurityReport         | Retrieve a list of Command Classes that require Security           |
| ManufacturerSpecific2  | Retrieve manufacturer name and product ids                         |
| Versions               | Retrieve version information                                       |
| Instances              | Retrieve information about multiple command class instances        |
| Static                 | Retrieve static information (doesn't change)                       |
| CacheLoad              | Ping a device upon restarting with cached config for the device    |
| Associations           | Retrieve information about associations                            |
| Neighbors              | Retrieve node neighbor list                                        |
| Session                | Retrieve session information (changes infrequently)                |
| Dynamic                | Retrieve dynamic information (changes frequently)                  |
| Configuration          | Retrieve configurable parameter information (only done on request) |
| Complete               | Query process is completed for this node                           |
