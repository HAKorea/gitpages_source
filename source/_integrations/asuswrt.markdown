---
title: 아수스커펌라우터(Asuswrt)
description: Instructions on how to integrate Asuswrt into Home Assistant.
logo: asus.png
ha_category:
  - Hub
  - Presence Detection
  - Sensor
ha_release: 0.83
ha_iot_class: Local Polling
ha_codeowners:
  - '@kennedyshead'
---

`asuswrt` 통합구성요소는 [ASUSWRT](https://event.asus.com/2013/nw/ASUSWRT/) 기반 라우터에 연결하기위한 주요 통합입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- **Presence Detection** - asuswrt 플랫폼은 ASUSWRT 기반 라우터에 연결된 장치를 보고 현재 상태를 감지합니다.
- **Sensor** - asuswrt 센서 플랫폼을 사용하면 Home Assistant 내의 ASUSWRT에서 데이터를 업로드하고 다운로드하는 정보를 제어할 수 있습니다.

## 설정

설치시 ASUSWRT 라우터를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
asuswrt:
  host: YOUR_ROUTER_IP
  username: YOUR_ADMIN_USERNAME
```

{% configuration %}
host:
  description: "The IP address of your router, e.g., `192.168.1.1`."
  required: true
  type: string
username:
  description: "The username of a user with administrative privileges, usually `admin`."
  required: true
  type: string
password:
  description: "The password for your given admin account (use this if no SSH key is given)."
  required: false
  type: string
protocol:
  description: "The protocol (`ssh` or `telnet`) to use."
  required: false
  type: string
  default: ssh
port:
  description: SSH port to use.
  required: false
  type: integer
  default: 22
mode:
  description: "The operating mode of the router (`router` or `ap`)."
  required: false
  type: string
  default: router
ssh_key:
  description: The path to your SSH private key file associated with your given admin account (instead of password).
  required: false
  type: string
require_ip:
  description: If the router is in access point mode.
  required: false
  type: boolean
  default: true
sensors:
  description: List of enabled sensors
  required: false
  type: list
  keys:
    "upload":
      description: TX upload sensor
    "download":
      description: RX download sensor
    "download_speed":
      description: download mbit/s sensor
    "upload_speed":
      description: upload mbit/s sensor
{% endconfiguration %}

<div class='note warning'>

`protocol:telnet`을 사용하려면 라우터에서 텔넷을 활성화해야합니다.

</div>

### 센서 설정 사례

설치 과정에서 ASUSWRT 센서를 활성화하려면 다음 설정 예를 참조하십시오.

```yaml
# Example configuration.yaml entry
asuswrt:
  host: YOUR_ROUTER_IP
  username: YOUR_ADMIN_USERNAME
  ssh_key: /config/id_rsa
  sensors:
    - upload
    - download
    - upload_speed
    - download_speed
```

위의 예는 다음 센서를 만듭니다.

- sensor.asuswrt_download (unit_of_measurement: Gigabyte - *Daily accumulation*)
- sensor.asuswrt_download_speed (unit_of_measurement: Mbit/s)
- sensor.asuswrt_upload (unit_of_measurement: Gigabyte - *Daily accumulation*)
- sensor.asuswrt_upload_speed (unit_of_measurement: Mbit/s)


## Padavan 사용자 정의 펌웨어 (RT-N56U 프로젝트)

[rt-n56u 프로젝트](https://bitbucket.org/padavan/rt-n56u)는 `/var/lib/misc/`에서 장치를 `asuswrt`로 추적하는데 사용되는 `dnsmasq.leases`를 저장하지 않습니다. 그러나 라우터의 부팅 과정에서 `dnsmasq.leases`를 연결하여 rt-n56u 프로젝트에 이 연동을 계속 사용할 수 있습니다.

다음 단계에 따라 링크를 설정하십시오.

1. SSH or Telnet into the router. (default ssh admin@my.router)
2. Run the following command to find the file:

```bash
$ find / -name "dnsmasq.leases"
```
3. Copy or remember the full path of, example: `/tmp/dnsmasq.leases`
4. Create the folder if it does not exist:

```bash
$ mkdir -p /var/lib/misc
```
5. Add the linking process to the routers started script (one line):

```bash
$ echo "/bin/ln -s /tmp/dnsmasq.leases /var/lib/misc/dnsmasq.leases" >> /etc/storage/started_script.sh
```

6. Reboot the router or link the file:

```bash
$ /bin/ln -s /tmp/dnsmasq.leases /var/lib/misc/dnsmasq.leases
```

시작된 스크립트는 라우터의 웹인터페이스에서 액세스하고 편집할 수 있습니다. `Advanced Settings -> Customization -> Scripts -> Custom User Script -> Run After Router Started`
