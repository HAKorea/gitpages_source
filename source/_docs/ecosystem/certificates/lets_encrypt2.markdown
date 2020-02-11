---
title: "Let's Encrypt를 이용한 TLS/SSL 원격 접속 - 기초 지식"
description: "Let's Encrypt에서 발급한 SSL 인증서로 원격으로 안전하게 연결하는 법"
---

<div class='note'>

Hass.io를 사용하고 있다면 이 가이드 대신 [DuckDNS add-on](/addons/duckdns/)를 따르시길 바랍니다.


</div>

### 0 - IP 주소, 포트 번호 및 포트포워딩에 대한 기본적인 수준의 이해

An IP address is a bit like a phone number. When you access your Home Assistant instance you type something similar to 192.168.0.200:8123 in to your address bar of your browser. The bit before the colon is the IP address (in this case 192.168.0.200) and the bit after is the port number (in this case 8123).  When you SSH in to the device running Home Assistant you will use the same IP address, and you will use port 22. You may not be aware that you are using port 22, but if you are using Putty look in the box next to where you type the IP address, you will see that it has already selected port 22 for you.

So, if an IP address is like a phone number, a port number is like an extension number. An analogy would be if you phone your local doctors on 192-1680-200 and the receptionist answers, you ask to speak to Dr. Smith and she will put you through to extension 8123, which is the phone Dr. Smith is sitting at. The doctors surgery is the device your Home Assistant is running on, Dr. Smith is your Home Assistant. Thusly, your Home Assistant instance is 'waiting for your call' on port 8123, at the device IP 192.168.0.200 .

Now, to speak to the outside world your connection goes through a router. Your router will have two IP addresses. One is the internal network number, most likely 192.168.0.1 in my example, and an external IP address that incoming traffic is sent to.  In the example of calling the doctors, the external IP is your telephone number's area code.

So, when we want to connect to our Home Assistant instance from outside our network we will need to call the correct extension number, at the correct phone number, in the correct area code.

We will be looking for a system to run like this (in this example I will pretend our external IP is 203.0.113.12):

```text
Outside world -> 203.0.113.12:8123 -> your router -> 192.168.0.200:8123
```
Sounds simple?  It really is except for two small, but easy to overcome, complications:

 * IP addresses are often dynamically allocated, so they can change.
 * Because of the way the internet works you cannot chain IP addresses together to get from where you are, to where you want to go.

To get around the issue of changing IP addresses we must remember that there are two IP addresses affected.  Your external one (which we will 'call' to get on to your network from the internet) and your internal one (192.168.0.200 in the example I am currently using).

So, we can use a static IP to ensure that whenever our device running Home Assistant connects to our router it always uses the same address.  This way our internal IP never changes.  This is covered in step 1 below.

We then have no control over our external IP, as our Service Provider will give us a new one at random intervals. To fix this we will use a service called DuckDNS which will give us a name for our connection (something like examplehome.duckdns.org) and behind the scenes will continue to update your external IP. So no matter how many times the IP address changes, typing examplehome.duckdns.org in to our browser will convert to the correct, up-to-date, IP address.  This is covered in step 3 below.

To get around the issue of not being able to chain the IP addresses together (I can't say I want to call 203.0.113.12 and be put through to 192.168.0.200, and then be put through to extension 8123) we use port forwarding. Port forwarding is the process of telling your router which device to allow the outside connection to speak to.  In the doctors surgery example, port forwarding is the receptionist. This takes a call from outside, and forwards it to the correct extension number inside.  It is important to note that port forwarding can forward an incoming request for one port to a different port on your internal network if you so choose, and we will be doing this later on. The end result being that when we have our TLS/SSL certificate our incoming call will by default be requesting port 443 (because that is the default HTTPS port, like the default SSH port is 22), our port forwarding rule can forward this to our HA instance on port 8123 (or we can specify the port number in the URL). When this guide is completed we will run something like this:

```text
Outside world -> https://examplehome.duckdns.org -> 203.0.113.12:443 -> your router -> 192.168.0.200:8123
```
So, let's make it happen...

### 1 - 장치가 고정 IP 주소를 가지도록 설정

Whenever a device is connected to a network it has an IP address. This IP address is often dynamically assigned to the device on connection. This means there are occasions where the IP address you use to access Home Assistant, or SSH in to the device running Home Assistant, may change. Setting a static IP address means that the device will always be on the same address.

SSH in to your system running Home Assistant and login.

Type the following command to list your network interfaces:

```bash
ifconfig
```

You will receive an output similar to the image below:

<p class='img'>
  <img src='/images/screenshots/ip-set.jpg' />
  Screenshot
</p>

Make a note of the interface name and the IP address you are currently on. In the picture it is the wireless connection that is highlighted, but with your setup it may be the wired one (eth0 or similar), make sure you get the correct information.

Then type the following command to open the text file that controls your network connection:

```bash
sudo nano /etc/dhcpcd.conf
```

At the bottom of the file add the following lines:

```text
interface wlan0 <----- or the interface you just wrote down.

static ip_address=192.168.0.200/24  <---- the IP address you just wrote down with a '/24' at the end
static routers=192.168.0.1      <---- Your router's IP address
static domain_name_servers=192.168.0.1 <---- Your router's IP address
```

It is important to note that the first three bytes of your static IP address and your router's IP address should be the same, e.g.:

```text
Router: 192.168.0.1

Yes
HA IP: 192.168.0.200

No
HA IP: 192.175.96.200
```

Press Ctrl + x to close the editor, pressing Y to save the changes when prompted.

Reboot your device running HA:

```bash
sudo reboot
```

When it comes back up check that you can SSH in to it again on the IP address you wrote down.

Make sure Home Assistant is running and access it via the local network by typing the IP address and port number in to the browser:

```text
http://192.168.0.200:8123.
```

All working?  Hooray!  You now have a static IP. This will now always be your internal IP address for your Home Assistant device. This will be known as YOUR-HA-IP for the rest of this guide.

### 2 - (TLS/SSL 없이)포트포워딩, 그리고 테스트 연결

Log in to your router's configuration pages and find the port forwarding options. This bit is hard to write a guide for because each router has a different way of presenting these options. Searching google for "port forwarding" and the name of your router may help. When you find it you will likely have options similar to:

Service name - Port Range -  Local IP -  Local Port - Protocol

You may also have other options (like 'source IP'), these can usually be left blank or in their default state.

Set the port forwarding to:

```text
Service name - ha_test
Port Range - 8123
Local IP - YOUR-HA-IP
Local Port - 8123
Protocol - Both
```

Then save the change. On my router you have to fill these values in, then press an 'add' button to add the new rule to the list, then save the changes. All routers have a different interface, but you must ensure that these rules are saved at this point.  If you are unsure, you can reboot the router and log back in, if the rule is present it was saved, if not, it wasn't!

Once you have saved this rule, go to your browser, and go to:

```text
https://whatismyipaddress.com/
```

This will tell you your current external IP address

Type the external IP address in to the URL bar with http:// in front and :8123 after like so (203.0.113.12 is my example!):

```text
http://203.0.113.12:8123
```

Can you see your Home Assistant instance? If not, your router may not support 'loopback' - try the next step anyway and if that works, and this one still doesn't, just remember that you cannot use loopback, so will have to use internal addresses when you're on your home network. More on this later on if it's relevant to you.

Just to verify this isn't some kind of witchcraft that is actually using your internal network, pick up your phone, disconnect it from your WiFi so that you are on your mobile data and not connected to the home network, put the same URL in the browser on your phone.

Can you see it now, from a device that is definitely not connected to your local network? Excellent! You now have a remotely accessible Home Assistant instance.

But what if your external IP changes?  Plus, remembering all those numbers is pretty hard, isn't it?  Read on to get yourself set up with a word-based URL at DuckDNS that will track any changes to your IP address so you don't have to stress anymore.

### [다음 과정: DuckDNS와 Let's Encrypt &raquo;](/docs/ecosystem/certificates/lets_encrypt/)
