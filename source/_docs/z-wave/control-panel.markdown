---
title: "Z-Wave 제어판"
description: "How to use the Z-Wave control panel."
redirect_from: /getting-started/z-wave-panel/
---

<div class='note'>

  If you don't see the **Configuration** menu on the menubar, where you'll find the Z-Wave menu, [see here](/integrations/config/).
  메뉴바에 **설정** 메뉴가 표시되지 않으면 Z-Wave 메뉴를 찾을 수 있습니다 ([여기 참조](/integrations/config/)).

</div>

Renaming Z-Wave entities is now done using the same [customization options](/docs/configuration/customizing-devices/) as for any other entity.
Z-Wave 엔티티의 이름 바꾸기는 이제 다른 엔티티와 동일한 [사용자 정의 옵션](/docs/configuration/customizing-devices/)을 사용하여 수행됩니다.

## Z-Wave 네트워크 관리

Here is where you [include and exclude](/docs/z-wave/adding/) Z-Wave devices from your network.
네트워크에서 Z-Wave 장치를 [포함하기와 제외하기](/docs/z-wave/adding/)위한 곳입니다.

* **Add Node** 컨트롤러를 포함 모드로 전환하여 장치를 Z-Wave 네트워크에 포함(추가)할 수 있습니다
* **Add Node Secure** 컨트롤러를 보안 포함 모드로 전환합니다 ([보안 키](/docs/z-wave/adding#sdding-security-devices)를 생성해야합니다)
* **Remove Node** 컨트롤러를 제외 모드로 전환하므로 장치를 제외(제거)할 수 있습니다. 다른 네트워크에 추가된 비보안 장치를 제외할 수 있습니다.
* **Cancel Command** 위의 중 하나를 취소

* **Heal Network** 컨트롤러가 Z-Wave 네트워크를 "heal"하도록 지시합니다. 기본적으로 노드에게 컨트롤러에게 모든 인접 항목을 알려주도록하여 컨트롤러가 최적의 라우팅을 재계산할 수 있도록합니다.
* **Start Network** Z-Wave 네트워크를 시작합니다.
* **Stop Network** Z-Wave 네트워크를 중지합니다.
* **Soft Reset** tells the controller to do a "soft reset." This is not supposed to lose any data, but different controllers can behave differently to a "soft reset" command, and may cause the Z-Wave network to hang. "soft reset"을 컨트롤러에 지시합니다. 데이터가 손실되지는 않지만 다른 컨트롤러는 "soft reset" 명령과 다르게 동작할 수 있으며 Z-Wave 네트워크가 중단될 수 있습니다.
* **Test Network** 컨트롤러가 no-op 명령을 각 노드에 보내고 응답 시간을 측정하도록 지시합니다. 이론적으로 이는 "사망한 것으로 추정된" 노드를 다시 가져올 수도 있습니다.
* **Save Config** 네트워크의 현재 캐시를 zwcfg_[home_id].xml에 저장합니다.

## Z-Wave 노드 관리

* **Refresh Node** refreshes the information on the node and its entities. If used on a battery powered device, the device will first need to wake for this to work. 노드와 해당 엔티티에 대한 정보를 새로 고칩니다. 배터리 구동 장치에서 사용하는 경우 장치가 작동하려면 먼저 깨워 야합니다.
* **Remove Failed Node** will remove a failed node from the network. The node needs to be on the controller's Failed Node List (marked as `is_failed: true`), otherwise this command will fail. You can trick OpenZWave into thinking the node is failed by selecting the `zwave` entity in the *States* menu, under *Developer tools*, and changing `"is_failed": false,` to `"is_failed": true,` then selecting *Set State*. 
* **Replace Failed Node** will replace a failed device with another. If the node is not in the controller's Failed Node List, or the node responds, this command will fail.
* **Print Node** prints all state of Z-Wave node to the console log

* **Heal Node** starts healing of the node.(Update neighbor list and update return routes)

* **Test Node** sends no_op test messages to the node. This could in theory bring back a dead node.

* **Node Information** this will display the Z-Wave entity card with information about the node:

*  **averageRequestRTT** The average Round Trip Time (RTT) of requests sent to the node, in milliseconds. A value of 250, for example, is a quarter of a second.
*  **averageResponseRTT** The average Round Trip Time of responses to requests
*  **battery_level** *Battery powered devices only* - the battery level, which may be rounded to the nearest 10
*  **capabilities** A comma separated list of the capabilities of the device
*  **friendly_name** The name you specified to be displayed
*  **is_awake** Whether the device is awake or not
*  **is_failed** Whether the device has been marked as failed. The controller won't try to contact failed devices.
*  **is_info_received** True once the controller has received the node information from the node.
*  **is_ready** When you start the network (or Home Assistant) it will take a short while before all devices are ready, this shows which aren't yet ready.
*  **is_zwave_plus** True for any Z-Wave Plus devices (note that controllers always report *false*, regardless of whether they are Plus devices or not)
*  **lastRequestRTT** The Round Trip Time of the last request
*  **lastResponseRTT** The Round Trip Time of the response to the last request
*  **manufacturer_name** The name of the manufacturer, as supplied by OpenZWave
*  **max_baud_rate** The maximum bandwidth the device supports, most modern devices will support 40,000 or higher
*  **node_id** The unique node ID of this node
*  **node_name** The base name of this node, this is used to build the entity ID of all entities of this node
*  **product_name** The product name of the device, as supplied by OpenZWave
*  **query_stage** The query stage for this device (see [here](/docs/z-wave/query-stage/) for details)
*  **receivedCnt** The number of messages received from the device
*  **receivedDups** The number of duplicate messages received from the device
*  **receivedTS** The date and time the last message was received from the devices
*  **receivedUnsolicited** How many unsolicited messages were received
*  **retries** How many retries have been made to send messages to this node
*  **sentCnt** How many messages have been sent to the node
*  **sentFailed** How many messages that were sent weren't acknowledged
*  **sentTS** The date and time the last message was sent to the node
*  **wake_up_interval** *Battery powered devices only* - the wakeup interval of the device, in seconds

<div class='note'>
Battery powered devices need to be awake before you can use the Z-Wave control panel to update their settings. How to wake your device is device specific, and some devices will stay awake for only a couple of seconds. Please refer to the manual of your device for more details.
</div>

#### Entities of this node

This is a dropdown where you can select all the entities of this node. Once selected you can then use:

* **Refresh Entity** to refresh just that entity's values
* **Entity Information** to display the attributes of that entity (e.g., its friendly name, the ID of the node, etc)

Here you can mark a device as requiring polling so the controller is aware of changes because the device doesn't send updates itself. Do see the information on [polling here](/docs/z-wave/devices/#polling), since excessive polling can break your Z-Wave network.

The **Polling intensity** says how many poll intervals this device is polled on. For example, if you set 2 then it's polled on every second interval.

You can also exclude a Z-Wave devices from Home Assistant. You can do that if you have a device that you need to have on the Z-Wave network, but you don't want it to appear in Home Assistant, or if you've got a device that's failed and you're unable to exclude it.

### Node Values

Contains a list of available values of the selected node, and it's instances.

### Node group associations

Where the device supports the *Association* command class, this will allow you to associate the device with another. OpenZWave will automatically associate the device with the controller, to provide instant updates when the device doesn't support the *Hail* command class.

You can use this to enable one device to directly control another. This is primarily useful for remote controls that operate lights or switches, or where you want to have multiple devices operate as one.

There may be multiple groups, that are used for different purposes. The manual of your device will explain what each group is for.

#### Broadcast group

Some Z-Wave devices may associate themselves with the broadcast node (node 255). You'll be able to tell if this has happened if opening a door (or triggering a motion sensor) causes lights to come on, and closing the door (or the motion sensor going clear) causes lights to run off. You can get rid of this by selecting any target node. If the group has node 255 in it, a *Remove broadcast* button will appear. You can also use the `zwave.change_association` service:

```json
{"association": "remove", "node_id": 3, "group": 1, "target_node_id": 255}
```

That would remove the broadcast group from association group 1 of the device with node_id 3.

### Node config options

You can set the *wakeup* interval (in seconds) of the device, this is shown for all devices that can be battery powered, even if they are currently mains powered. The wakeup interval only applies when those devices are battery powered.

<div class='note'>
The wakeup interval has no impact on the device's ability to report sensor changes. This is purely for how often the Z-Wave chip will check in with the controller. That activity consumes a lot of battery power compared to reporting sensor changes and if you reduce it you'll be reducing the battery life of your device.
</div>

Underneath that you can select any supported configuration parameter to see the current setting. You can then change this and select **Set Config Parameter** to updated it. Battery powered devices will be updated the next time they wake.

### Node protection

If your node has the protection commandclass, you can change the protection level of the node.
Check your device manual on how to use this setting, as it is different between manufacturers.
Set the new selection by pressing the **Set Protection** button.

## Node user codes

If your node has user codes, you can set and delete them. The format is raw hex ASCII code. Below the input you will see your actual code. For normal nodes this is as follows:
```yaml
\x30 = 0
\x31 = 1
\x32 = 2
\x33 = 3
\x34 = 4
\x35 = 5
\x36 = 6
\x37 = 7
\x38 = 8
\x39 = 9
```
Some non compliant device like tag readers, have implemented to use raw hex code.
Please refer to a hex ASCII table to set your code. Example: http://www.asciitable.com/

Here is a small Python program than will take numbers on the command line and print the correct sequence for compliant devices:

```python
#! /usr/bin/python3
import sys

translations = {}

for x in range(0, 10):
    translations["%s" % x] = "\\x3%s" % x

for c in sys.argv[1]:
    print(translations[c], end="")
```

## OZW Log

If you want to only retrieve some lines at the end of the log, you can specify that with the selection field. Max is the last 1000 lines and minimum is 0 which equals the whole log. If this is not specified, you will retrieve the whole log.
Select **Load** to open a new window with the static log.
Select **Tail** to open a new window with a tailing log with the last specified lines of the log. This is a self updating window.
