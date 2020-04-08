---
title: "Docker에 HA Core 설치하기"
description: "Instructions to install Home Assistant on a Docker."
redirect_from: /getting-started/installation-docker/
---

<div class='note warning'>

아래 지침은 자신이 관리하는 자체 Docker 환경에서 실행되는 Home Assistant Core를 설치하기위한 것입니다.

Home Assistant의 애드온 에코시스템을 포함하여 Home Assistant Supervised를 설치하려면 [일반 Linux 호스트에서 Home Assistant Supervised](/hassio/installation/#alternative-install-home-assistant-supervised-on-a-generic-linux-host/) 설치 지침을 참조하십시오.

</div>

## 플랫폼 설치

Docker를 사용한 설치는 간단합니다. `/PATH_TO_YOUR_CONFIG`가 설정을 저장하고 실행할 폴더를 가리키도록 다음 명령을 조정하십시오. : 

### Linux

```bash
docker run --init -d --name="home-assistant" -e "TZ=America/New_York" -v /PATH_TO_YOUR_CONFIG:/config --net=host homeassistant/home-assistant:stable
```

### Raspberry Pi 3 (Raspbian)

```bash
docker run --init -d --name="home-assistant" -e "TZ=America/New_York" -v /PATH_TO_YOUR_CONFIG:/config --net=host homeassistant/raspberrypi3-homeassistant:stable
```

`/PATH_TO_YOUR_CONFIG`를 설정경로로 바꿔야합니다. 예를 들어 설정경로를 `/home/pi/homeassistant`로 선택한 경우 명령은 다음과 같습니다. : 

```bash
docker run --init -d --name="home-assistant" -e "TZ=America/New_York" -v /home/pi/homeassistant:/config --net=host homeassistant/raspberrypi3-homeassistant:stable
```

### macOS

macOS에서`docker-ce`(또는 `boot2docker`)를 사용하는 경우 로컬 시간대를 Docker 컨테이너에 매핑할 수 없습니다([Docker issue](https://github.com/docker/for-mac/issues/44)). `-v /etc/localtime:/etc/localtime:ro` 대신 컨테이너를 시작할 때 시간대 환경 변수를 전달하십시오 (예: `-e "TZ=America/Los_Angeles"`). "America/Los_Angeles"를 [당신의 시간대](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)로 바꾸십시오. 

macOS 호스트에서 `http://localhost:8123`을 직접 탐색하려면 포트를 컨테이너로 직접 전달해야합니다.`--net=host` 스위치를 `-p 8123:8123`으로 바꾸십시오. 자세한 내용은 [Docker 포럼](https://forums.docker.com/t/should-docker-run-net-host-work/14215/10)에서 확인할 수 있습니다.

```bash
docker run --init -d --name="home-assistant" -e "TZ=America/Los_Angeles" -v /PATH_TO_YOUR_CONFIG:/config -p 8123:8123 homeassistant/home-assistant:stable
```

다른한편 `docker-compose`는 macOS에서 최신 버전의 `docker-ce`에서 작동합니다. 우리는 `docker-compose.yml` 예제(이 페이지 아래)를 제공하지만 위의 `docker run` 예제와는 다릅니다. .yml 지시문을 일치시키려면 _두가지_ 를 변경해야합니다. : 먼저 동등한 `ports:` 지시어를 추가한 다음 `_network_mode: host` 섹션을 _제거_ 하십시오. `Port mapping is incompatible with network_mode: host:` 때문입니다. 자세한 내용은 [Docker 네트워킹 설명서](https://docs.docker.com/network/)를 참조하십시오. Arduino 등의 장치에서 사용하는 `/dev/tty*` 장치 이름은 Linux 예제와 다르므로 `mount:` 작성에 업데이트가 필요할 수 있습니다.

### Windows

Docker 컨테이너는 Windows 호스트 시스템과 완전히 격리되어 있습니다. 따라서 컨테이너를 삭제하면 해당 컨테이너에 대한 모든 변경 사항도 제거됩니다. 설정 파일 또는 기타 자산을 지속적으로 유지하려면 컨테이너에 Windows 폴더를 마운트하십시오.

진행하기 전에 Docker가 마운트할 드라이브를 공유했는지 확인하십시오. 이를 통해 Docker 컨테이너가 아닌 로컬 시스템에 설정 파일을 저장할 수 있습니다 (업그레이드하면 손상될 수 있음).

<https://docs.docker.com/docker-for-windows/#shared-drives>
<https://docs.docker.com/docker-for-windows/troubleshoot/#verify-domain-user-has-permissions-for-shared-drives-volumes>

```powershell
docker run --init -d --name="home-assistant" -e "TZ=America/Los_Angeles" -v /PATH_TO_YOUR_CONFIG:/config --net=host homeassistant/home-assistant:stable
```

실습할 때 트릭을 이해하는 것이 더 쉽습니다. 현재 작업 디렉토리(`C:\Users\<your login name>\homeassistant`와 같은 것이 먼저 존재하는지 확인하십시오)를 컨테이너의 `/config` 위치에 있는 `homeassistant/home-assistant:stable` 이미지에 마운트하고 싶을 경우 다음과 같이 하면됩니다. : 

```powershell
docker run --init -d --name="home-assistant" -e "TZ=America/Los_Angeles" -v //c/Users/<your login name>/homeassistant:/config --net=host homeassistant/home-assistant:stable
```

Windows의 Docker에서 Home Assistant를 실행하면 라우팅을 위해 포트를 매핑하는데 약간의 어려움이 있을 수 있습니다(`--net=host` 스위치는 실제로 하이퍼바이저(hypervisor)의 네트워크 인터페이스에 적용되므로). 이 문제를 해결하려면 포트 프록시 ipv4 규칙을 로컬 Windows 시스템에 추가해야합니다.('192.168.1.10'을 Windows IP가 무엇이든 대체하고 '10.0.50.2'를 Docker 컨테이너의 IP가 무엇이든 대체하십시오) :

```bash
netsh interface portproxy add v4tov4 listenaddress=192.168.1.10 listenport=8123 connectaddress=10.0.50.2 connectport=8123
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=8123 connectaddress=10.0.50.2 connectport=8123
```

이렇게하면 `http://localhost:8123`에서 Home Assistant 포털에 액세스할 수 있으며 라우터의 포트 8123을 컴퓨터 IP로 전달하면 트래픽이 Docker 컨테이너를 통해 전달됩니다.

### Synology NAS

DSM 내의 Synology는 이제 깔끔한 UI로 Docker를 지원하므로 command-line없이 Docker를 사용하여 Home Assistant를 간단히 설치할 수 있습니다. 패키지에 대한 자세한 내용 (NAS가 지원되는 경우 호환성 정보 포함)은 <https://www.synology.com/en-us/dsm/packages/Docker>를 참조하십시오.

단계는 다음과 같습니다. : 

- Install "Docker" package on your Synology NAS
- Launch Docker-app and move to "Registry"-section
- Find "homeassistant/home-assistant" within registry and click on "Download". Choose the "stable" tag.
- Wait for some time until your NAS has pulled the image
- Move to the "Image"-section of the Docker-app
- Click on "Launch"
- Choose a container-name you want (e.g., "homeassistant")
- Click on "Advanced Settings"
- Set "Enable auto-restart" if you like
- Within "Volume" click on "Add Folder" and choose either an existing folder or add a new folder. The "mount path" has to be "/config", so that Home Assistant will use it for the configs and logs. It is therefore recommended that the folder you choose should be named "config" or "homeassistant/config" to avoid confusion when referencing it within service calls.
- Within "Network" select "Use same network as Docker Host"
- To ensure that Home Assistant displays the correct timezone go to the "Environment" tab and click the plus sign then add `variable` = `TZ` & `value` = `Europe/London` choosing [your correct timezone](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
- Confirm the "Advanced Settings"
- Click on "Next" and then "Apply"
- Your Home Assistant within Docker should now run and will serve the web interface from port 8123 on your Docker host (this will be your Synology NAS IP address - for example `http://192.168.1.10:8123`)

내장 방화벽을 사용하는 경우 포트 8123도 허용 목록에 추가해야합니다. "Control Panel -> Security"의 방화벽탭에서 찾을 수 있습니다. 방화벽 프로필 드롭 다운 상자 옆의 "Edit Rules"을 클릭하십시오. 새 규칙을 작성하고 포트에 대해 "Custom"를 선택하고 8123을 추가하십시오. 소스 IP를 원하는 경우 기본 "All"로 유지하십시오. 작업은 "Allow"으로 유지되어야합니다.

Z-Wave 제어를 위해 Z-Wave USB 스틱을 사용하려면 HA Docker 컨테이너에 USB 스틱에 액세스하기위한 추가 설정이 필요합니다. 여러 가지 방법이 있지만 액세스 권한을 부여하는 가장 권한이 적은 방법은 터미널을 통해서만 작성할 수 있습니다. Synology NAS에 터미널 액세스를 설정하려면 이 페이지를 참조하십시오.

<https://www.synology.com/en-global/knowledgebase/DSM/help/DSM/AdminCenter/system_terminal>

SSH를 통해 터미널에 액세스하려면 이 페이지를 참조하십시오. : 

<https://www.synology.com/en-global/knowledgebase/DSM/tutorial/General_Setup/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet>

다음과 같이 터미널 명령을 조정하십시오. : 

- 설정을 저장하려는 폴더를 `/PATH_TO_YOUR_CONFIG`로 가리키게 하십시오
- `/PATH_TO_YOUR_USB_STICK`을 USB스틱의 경로로 바꾸십시오. (예: 대부분의 Synology 사용자의 경우 `/dev/ttyACM0`)
- "Australia/Melbourne"를 [당신의 시간대](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)로 바꿉니다.

터미널에서 실행하십시오.

```bash
sudo docker run --restart always -d --name="homeassistant" -v /PATH_TO_YOUR_CONFIG:/config --device=/PATH_TO_YOUR_USB_STICK -e TZ=Australia/Melbourne --net=host homeassistant/home-assistant:stable
```

[여기의 지침을 따라](/docs/z-wave/installation) 나머지 Z-Wave 설정을 완료하십시오.

참고: Synology NAS 내의 Docker에서 Home Assistant를 업데이트하려면 다음을 수행하면됩니다.

- Go to the Docker-app and move to "Registry"-section
- Find "homeassistant/home-assistant" within registry and click on "Download". Choose the "stable" tag.
- Wait until the system-message/-notification comes up, that the download is finished (there is no progress bar)
- Move to "Container"-section
- Stop your container if it's running
- Right-click on it and select "Action"->"Clear". You won't lose any data, as all files are stored in your configuration-directory
- Start the container again - it will then boot up with the new Home Assistant image

참고: Synology NAS 내에서 홈어시스턴트를 다시시작하려면 다음을 수행하면됩니다.

- Go to the Docker-app and move to "Container"-section
- Right-click on it and select "Action"->"Restart".

<div class='note'>

Synology Docker에서 홈어시스턴트와 함께 USB Bluetooth 어댑터 또는 Z-Wave USB 스틱을 사용하려는 경우, 이 지시 사항은 USB 디바이스에 액세스하도록 컨테이너를 올바르게 설정하지 않습니다. Synology Docker Home Assistant에서 이러한 장치를 설정하려면 제공된 [지침](https://philhawthorne.com/installing-home-assistant-io-on-a-synology-diskstation-nas/)을 따르십시오. 

</div>

### QNAP NAS

QTS 내의 QNAP는 이제 깔끔한 UI로 Docker를 지원하므로 command-line없이 Docker를 사용하여 Home Assistant를 간단히 설치할 수 있습니다. 패키지에 대한 자세한 내용 (NAS가 지원되는 경우 호환성 정보 포함). <https://www.qnap.com/solution/container_station/en/index.php> 를 참조하십시오.  

단계는 다음과 같습니다. : 

- Install "Container Station" package on your Qnap NAS
- Launch Container Station and move to "Create Container"-section
- Search image "homeassistant/home-assistant" with Docker Hub and click on "Install"
  Make attention to CPU architecture of your NAS. For ARM CPU types the correct image is "homeassistant/armhf-homeassistant"
- Choose "stable" version and click next
- Choose a container-name you want (e.g., "homeassistant")
- Click on "Advanced Settings"
- Within "Shared Folders" click on "Volume from host" > "Add" and choose either an existing folder or add a new folder. The "mount point has to be `/config`, so that Home Assistant will use it for the configuration and logs.
- Within "Network" and select Network Mode to "Host"
- To ensure that Home Assistant displays the correct timezone go to the "Environment" tab and click the plus sign then add `variable` = `TZ` & `value` = `Europe/London` choosing [your correct timezone](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
- Click on "Create"
- Wait for some time until your NAS has created the container
- Your Home Assistant within Docker should now run and will serve the web interface from port 8123 on your Docker host (this will be your Qnap NAS IP address - for example `http://192.xxx.xxx.xxx:8123`)

참고: Qnap NAS 내의 Docker에서 Home Assistant를 업데이트하려면 컨테이너와 이미지를 제거하고 다시 단계를 수행하십시오 ("config" 폴더를 제거하지 마십시오).

Qnap Docker의 홈어시스턴트와 함께 USB Bluetooth 어댑터 또는 Z-Wave USB 스틱을 사용하려면 다음 단계를 따르십시오.

#### Z-Wave

- Connect to your NAS over SSH
- Load cdc-acm kernel module(when NAS restart need to run this command)
  `insmod /usr/local/modules/cdc-acm.ko`
- Find USB devices attached. Type command:
  `ls /dev/tty*`
  The above command should show you any USB devices plugged into your NAS. If you have more than one, you may get multiple items returned. Like : `ttyACM0`
  
- Run Docker command:
  `docker run --init --name home-assistant --net=host --privileged -itd -v /share/CACHEDEV1_DATA/Public/homeassistant/config:/config -e variable=TZ -e value=Europe/London --device /dev/ttyACM0 homeassistant/home-assistant:stable`
  
  `-v` is your configuration path
  `-e` is set timezone
  
- Edit `configuration.yaml`

```yaml
zwave:
  usb_path: /dev/ttyACM0
```

홈어시스턴트에게 Z-Wave 라디오를 찾을 위치를 알려줍니다.

#### Bluetooth

- SSH를 통해 NAS에 연결
- Docker 명령 실행:
  `docker run --init --name home-assistant --net=host --privileged -itd -v /share/CACHEDEV1_DATA/Public/homeassistant/config:/config -e variable=TZ -e value=Europe/London -v /dev/bus/usb:/dev/bus/usb -v /var/run/dbus:/var/run/dbus homeassistant/home-assistant:stable`
  
  첫 번째 `-v`는 설정 경로입니다.
  `-e`는 시간대를 설정합니다.
  
- `configuration.yaml` 파일을 편집하십시오

```yaml
device_tracker:
  - platform: bluetooth_tracker
```

## Restart

설정을 변경하면 서버를 다시시작해야합니다. 이를 위해 두 가지 옵션이 있습니다.

 1. <img src='/images/screenshots/developer-tool-services-icon.png' alt='service developer tool icon' class="no-shadow" height="38" /> 서비스 개발자 도구로 이동하여 `homeassistant/restart` 서비스를 선택하고 "서비스 호출"를 클릭하십시오.
 2. 또는 `docker restart home-assistant`를 실행하여 터미널에서 다시 시작할 수 있습니다.

## Docker Compose

Docker 명령이 복잡해짐에 따라 `docker-compose`로 전환하는 것이 바람직할 수 있으며 장애 또는 시스템 재시작시 자동 재시작을 지원합니다. `docker-compose.yml` 파일을 생성하십시오 :

```yaml
  version: '3'
  services:
    homeassistant:
      container_name: home-assistant
      image: homeassistant/home-assistant:stable
      volumes:
        - /PATH_TO_YOUR_CONFIG:/config
      environment:
        - TZ=America/New_York
      restart: always
      network_mode: host
```

그런 다음 컨테이너를 다음과 같이 시작하십시오. : 

```bash
docker-compose up -d
```

설정을 변경할 때 홈어시스턴트를 다시 시작하려면 다음을 수행하십시오. : 

```bash
docker-compose restart
```

## Exposing Devices

장치에 액세스해야하는 Z-Wave, Zigbee 또는 기타 연동을 사용하려면 적절한 장치를 컨테이너에 매핑해야합니다. 컨테이너를 실행하는 사용자에게 `/dev/tty*`파일에 액세스 할 수 있는 올바른 권한이 있는지 확인한 다음 장치 매핑을 Docker 명령에 추가하십시오. : 

```bash
$ docker run --init -d --name="home-assistant" -v /PATH_TO_YOUR_CONFIG:/config \
   -e "TZ=Australia/Melbourne" --device /dev/ttyUSB0:/dev/ttyUSB0 \
   --net=host homeassistant/home-assistant:stable
```

또는 `docker-compose.yml` 파일에서 :

```yaml
  version: '3'
  services:
    homeassistant:
      container_name: home-assistant
      image: homeassistant/home-assistant:stable
      volumes:
        - /PATH_TO_YOUR_CONFIG:/config
      devices:
        - /dev/ttyUSB0:/dev/ttyUSB0
        - /dev/ttyUSB1:/dev/ttyUSB1
        - /dev/ttyACM0:/dev/ttyACM0
      environment:
        - TZ=America/New_York
      restart: always
      network_mode: host
```

<div class='note'>

Mac에서는 기본적으로 USB 장치가 [통과되지 않습](https://github.com/docker/for-mac/issues/900)니다. 장치가 표시되지 않으면 Christopher McClellan의 [Mac용 Docker와 함께 USB사용](https://dev.to/rubberduck/using-usb-with-docker-for-mac-3fdd)의 지침을 따르십시오.

</div>