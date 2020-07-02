---
title: Proxmox VE
description: Access your ProxmoxVE instance in Home Assistant.
logo: proxmoxve.png
ha_category:
  - Binary Sensor
ha_release: 0.103
ha_iot_class: Local Polling
ha_codeowners:
  - '@k4ds3'
---

<div class='videoWrapper'>
<iframe width="775" height="436" src="https://www.youtube.com/embed/LlxTPLnM3zw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>

[Proxmox VE](https://www.proxmox.com/en/)는 오픈 소스 서버 가상화 환경입니다. 이 통합구성요소를 통해 인스턴스에서 다양한 데이터를 불러올 수 있습니다.

이 구성 요소를 구성하면 이진 센서가 자동으로 나타납니다.

## 설정

<div class='note'>
하나 이상의 VM 또는 컨테이너 항목이 구성되어 있어야합니다. 그렇지 않으면 이 통합구성요소로 아무 작업도 수행하지 않습니다.
</div>

`proxmoxve` 컴포넌트를 사용하려면 `configuration.yaml` 파일에 다음 설정을 추가하십시오.

```yaml
# Example configuration.yaml entry
proxmoxve:
  - host: IP_ADDRESS
    username: USERNAME
    password: PASSWORD
    nodes:
      - node: NODE_NAME
        vms:
          - VM_ID
        containers:
          - CONTAINER_ID
```

{% configuration %}
host:
  description: IP address of the Proxmox VE instance.
  required: true
  type: string
port:
  description: The port number on which Proxmox VE is running.
  required: false
  default: 8006
  type: integer
verify_ssl:
  description: Whether to do strict validation on SSL certificates. If you use a self signed SSL certificate you need to set this to false.
  required: false
  default: true
  type: boolean
username:
  description: The username used to authenticate.
  required: true
  type: string
password:
  description: The password used to authenticate.
  required: true
  type: string
realm:
  description: The authentication realm of the user.
  required: false
  default: pam
  type: string
nodes:
  description: List of the Proxmox VE nodes to monitor.
  required: true
  type: map
  keys:
    node:
      description: Name of the node
      required: true
      type: string
    vms:
      description: List of the QEMU VMs to monitor.
      required: false
      type: list
    containers:
      description: List of the LXC containers to monitor.
      required: false
      type: list
{% endconfiguration %}

Example with multiple VMs and no containers:

```yaml
proxmoxve:
  - host: IP_ADDRESS
    username: USERNAME
    password: PASSWORD
    nodes:
      - node: NODE_NAME
        vms:
          - VM_ID_1
          - VM_ID_2
```

## Binary Sensor

본 통합구성요소는 추적된 각 가상 머신 또는 컨테이너에 대한 이진 센서가 자동으로 생성됩니다. 이진 센서는 VM의 상태가 실행중인 경우 켜져 있거나 VM의 상태가 다른 경우 꺼져 있습니다.

생성된 센서는 `binary_sensor.NODE_NAME_VMNAME_running`입니다.

## Proxmox Permissions

VM과 컨테이너의 상태를 확인하려면 연결에 사용된 사용자는 최소한 VM.Audit 권한을 가져야합니다. 다음은 최소 필수 권한으로 새 사용자를 구성하는 방법에 대한 안내서입니다.

### Create Home Assistant Role

사용자를 만들기 전에 사용자에 대한 권한 역할을 만들어야합니다.

* Click `Datacenter`
* Open `Permissions` and click `Roles`
* Click the `Create` button above all the existing roles
* name the new role (e.g. "home-assistant")
* Click the arrow next to privileges and select `VM.Audit` in the dropdown
* Click `Create`

### Create Home Assistant User

방금 만든 역할로만 제한된 홈어시스턴트 전용 사용자를 작성하는 것이 가장 안전한 방법입니다. 이 명령어들은 사용자를 위해 `pve` 영역을 사용합니다. 이렇게하면 연결이 가능하지만 사용자는 SSH 연결에 대해 인증되지 않습니다. `pve` 영역을 사용한다면, 설정에 `realm: pve`를 추가하십시오.

* Click `Datacenter`
* Open `Permissions` and click `Users`
* Click `Add`
* Enter a username (e.g. "hass")
* Enter a secure password (it can be complex as you will only need to copy/paste it into your Home Assistant configuration)
* Set the realm to "Proxmox VE authentication server"
* Ensure `Enabled` is checked and `Expire` is set to "never"
* Click `Add`

### Add User Permissions to Assets

방금 생성한 사용자와 역할을 적용하려면 권한을 부여해야합니다.

* Click `Datacenter`
* Click `Permissions`
* Open `Add` and click `User Permission`
* Select "\" for the path
* Select your hass user ("hass")
* Select the Home Assistant role ("home-assistant")
* Make sure `Propigate` is checked
