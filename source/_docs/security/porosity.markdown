---
title: "Home Assistant/Hass.io 보안에 대한 고찰"
description: "Use nmap to scan your Home Assistant instance."
---

많은 사용자가 [Hass.io](/hassio/)를 실행함에 따라 여기에서는 Raspberry Pi 3B 및 Hass.io 0.70.0을 사용하여 Home Assistant가 네트워크 쪽에서 어떻게 보이는지 보여줍니다. 이것은 완전한 조사가 아니라 간단한 개요입니다.

홈어시스턴트 시스템의 IP 주소는 192.168.0.215입니다. 스캔 소스인 시스템은 Fedora 27을 실행하는 시스템이며 Nmap 7.60은 포트 스캔을 수행하는 데 사용됩니다. 두 시스템 모두 동일한 네트워크에 있습니다.

## SSH server Add-on

Hass.io에 안전하게 액세스하기 위해 SSH는 [SSH 서버 애드온](/addons/ssh/)에 의해 제공됩니다.

```bash
$ sudo nmap -A -n --reason -Pn -T5 -p1-65535 192.168.0.215

Starting Nmap 7.60 ( https://nmap.org ) at 2018-05-29 15:08 CEST
Nmap scan report for 192.168.0.215
Host is up, received arp-response (0.00051s latency).
Not shown: 65532 closed ports
Reason: 65532 resets
PORT      STATE SERVICE REASON         VERSION
22/tcp    open  ssh     syn-ack ttl 63 OpenSSH 7.5 (protocol 2.0)
| ssh-hostkey:
|   2048 e3:a2:2d:20:3a:67:68:b9:b1:9e:16:fa:48:80:82:96 (RSA)
|   256 92:f0:f4:be:4f:44:60:0e:c4:92:8a:cb:34:9e:c5:c2 (ECDSA)
|_  256 09:da:a2:14:cd:c4:69:e9:13:e6:70:64:98:d0:55:0c (EdDSA)
8123/tcp  open  http    syn-ack ttl 64 aiohttp 3.1.3 (Python 3.6)
|_http-open-proxy: Proxy might be redirecting requests
| http-robots.txt: 1 disallowed entry
|_/
|_http-server-header: Python/3.6 aiohttp/3.1.3
|_http-title: Home Assistant
22222/tcp open  ssh     syn-ack ttl 64 Dropbear sshd 2016.74 (protocol 2.0)
MAC Address: B8:41:CD:4B:7A:5D (Raspberry Pi Foundation)
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.2 - 4.8
Network Distance: 1 hop
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE
HOP RTT     ADDRESS
1   0.51 ms 192.168.0.215

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 726.23 seconds
```

포트 22와 8123이 열려있을 것으로 예상되었습니다. 포트 22222에는 추가 SSH 서버가 실행 중입니다. 이 포트는 [debugging](https://developers.home-assistant.io/docs/en/hassio_debugging.html)용이며 키를 사용한 로그인만 지원합니다. 즉, Raspberry Pi에서 SD 카드를 제거하고 SSH 공개키가 있는 `authorized_keys`를 만든 다음 SD 카드를 Pi에 다시 넣어 액세스해야합니다.

## Mosquitto MQTT broker Add-on

[Mosquitto MQTT 브로커 애드온](/addons/mosquitto/)을 설정하는 동안 설정이 수정되지 않았으며 애드온이 기본 설정으로 실행되었습니다.

```bash
$ sudo nmap -A -n --reason -Pn -T5 -p1-65535 192.168.0.215

Starting Nmap 7.60 ( https://nmap.org ) at 2018-05-29 15:52 CEST
Nmap scan report for 192.168.0.215
Host is up, received arp-response (0.0011s latency).
Not shown: 65532 closed ports
Reason: 65532 resets
PORT      STATE SERVICE                  REASON         VERSION
1883/tcp  open  mosquitto version 1.4.12 syn-ack ttl 63
| mqtt-subscribe:
|   Topics and their most recent payloads:
|     $SYS/broker/load/connections/5min: 0.39
[...]
|     $SYS/broker/load/connections/15min: 0.13
|_    $SYS/broker/clients/total: 2
8123/tcp  open  http                     syn-ack ttl 64 aiohttp 3.1.3 (Python 3.6)
|_http-open-proxy: Proxy might be redirecting requests
| http-robots.txt: 1 disallowed entry
|_/
|_http-server-header: Python/3.6 aiohttp/3.1.3
|_http-title: Home Assistant
22222/tcp open  ssh                      syn-ack ttl 64 Dropbear sshd 2016.74 (protocol 2.0)
MAC Address: B8:41:CD:4B:7A:5D (Raspberry Pi Foundation)
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.2 - 4.8
Network Distance: 1 hop
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE
HOP RTT     ADDRESS
1   1.13 ms 192.168.0.215

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 223.76 seconds
```

인증서 사용을 고려하여 MQTT를 보호하고 최소한 `logins : ` 아래에 비밀번호를 가진 사용자를 지정합니다. 로컬 네트워크에서만 포트 1883을 사용하십시오.

## Samba Add-on

[Samba 애드온](/addons/samba/)을 사용하면 Windows 시스템을 사용하여 설정 및 다른 공유에 액세스 할 수 있습니다. 기본적으로 사용자 설정은 없습니다. 로컬 보안을 강화하려면 사용자 이름과 비밀번호를 설정하고 guest를 허용하지 않는 것이 좋습니다. 샘플 설정은 다음과 같습니다.

이 부가 기능을 사용하여 Hass.io에 대한 포트 스캔으로 세부 정보를 제공합니다.

```bash
$ sudo nmap -A -n --reason -Pn -T5 -p1-65535 192.168.0.215

Starting Nmap 7.60 ( https://nmap.org ) at 2018-05-29 16:29 CEST
Host is up, received arp-response (0.00045s latency).
Not shown: 65523 closed ports
Reason: 65523 resets
PORT      STATE    SERVICE     REASON         VERSION
139/tcp   open     netbios-ssn syn-ack ttl 64 Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp   open     netbios-ssn syn-ack ttl 64 Samba smbd 4.7.3 (workgroup: WORKGROUP)
8123/tcp  open     http        syn-ack ttl 64 aiohttp 3.1.3 (Python 3.6)
|_http-open-proxy: Proxy might be redirecting requests
| http-robots.txt: 1 disallowed entry
|_/
|_http-server-header: Python/3.6 aiohttp/3.1.3
|_http-title: Home Assistant
22222/tcp open     ssh         syn-ack ttl 64 Dropbear sshd 2016.74 (protocol 2.0)
MAC Address: B8:41:CD:4B:7A:5D (Raspberry Pi Foundation)
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.2 - 4.8
Network Distance: 1 hop
Service Info: Host: HASSIO; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_nbstat: NetBIOS name: HASSIO, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| smb-os-discovery:
|   OS: Windows 6.1 (Samba 4.7.3)
|   Computer name: \x00
|   NetBIOS computer name: HASSIO\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2018-05-29T16:41:05+02:00
| smb-security-mode:
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode:
|   2.02:
|_    Message signing enabled but not required
| smb2-time:
|   date: 2018-05-29 16:41:05
|_  start_date: 1601-01-01 00:53:28

TRACEROUTE
HOP RTT     ADDRESS
1   0.46 ms 192.168.0.215

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 727.43 seconds
```

139와 445는 공개되어 있으며 주식을 열거 할 수 있습니다. 다른 도구를 사용해도 거의 동일한 정보를 얻을 수 있습니다.

```bash
$ smbclient -L //192.168.0.215 -U%

	Sharename       Type      Comment
	---------       ----      -------
	config          Disk      
	addons          Disk      
	share           Disk      
	backup          Disk      
	IPC$            IPC       
IPC Service (Samba Home Assistant config share)
Reconnecting with SMB1 for workgroup listing.

	Server               Comment
	---------            -------

	Workgroup            Master
	---------            -------
	WORKGROUP            HASSIO
```

그러나 사용자 이름과 비밀번호가 없으면 여기에 표시된 세팅으로 설정 파일에 액세스 할 수 없습니다.

```json
[...]
  "guest": false,
  "username": "homeassistant",
  "password": "homeassistant",
  "interface": "eth0"
}
```
