---
title: "Let's Encrypt를 이용한 TLS/SSL 원격 접속"
description: "Let's Encrypt에서 발급한 SSL 인증서로 원격으로 안전하게 연결하는 법"
---

<div class='note'>

Hass.io를 사용하고 있다면 이 가이드 대신 [DuckDNS add-on](/addons/duckdns/)를 따르시길 바랍니다.


</div>

이 가이드는 16/03/2017에 mf_social에 의해 추가되었으며 작성 당시에 유효했습니다. 이 가이드는 다음과 같은 가정하에 있습니다:

 * 내부 네트워크를 통해 홈 어시스턴트 인스턴스에 접속할 수 있다, 또한 내부 네트워크에서 SSH로 접속할 수 있다.
 * 라우터의 내부 IP 주소를 알고 있고, 라우터의 설정 페이지에 접속할 수 있다.
 * You have already secured your Home Assistant instance, following the advice on [this page](/docs/configuration/securing/)
 * (내부 네트워크에 연결되지 않은)집 밖에서 TLS/SSL 인증서로 안전하게 홈 어시스턴트 인스턴스에 접속하고 싶다.
 * 지금까지 사용한 문장에 대해 기본적으로 이해할 수 있다.
 * 네트워크의 80포트에서 아무것도 실행하고 있지 않다. (만약 그랬다면 알고 있을 겁니다).
 * If you are not using Home Assistant on a Debian/Raspian system you will be able to convert any of the terminology I use in to the correct syntax for your system.
 * You understand that this is a 'guide' covering the general application of these things to the general masses and there are things outside of the scope of it, and it does not cover every eventuality (although I have made some notes where people may stumble). Also, I have used some turns of phrase to make it easier to understand for the novice reader which people of advanced knowledge may say is inaccurate.  My goal here is to get you through this guide with a satisfactory outcome and have a decent understanding of what you are doing and why, not to teach you advanced internet communication protocols.
 * Each step presumes you have fully completed the previous step successfully, so if you did an earlier step following a different guide, please ensure that you have not missed anything out that may affect the step you have jumped to, and ensure that you adapt any commands to take in to account different file placements from other guides.

목차:

 - 0 - IP 주소, 포트 번호 및 포트포워딩에 대한 기본적인 수준의 이해
 - 1 - 장치가 고정 IP 주소를 가지도록 설정
 - 2 - (TLS/SSL 없이)포트포워딩, 그리고 테스트 연결
 - 3 - DuckDNS 계정 설정
 - 4 - Let's Encrypt에서 TLS/SSL 인증서 발급
 - 5 - 들어오는 연결 확인
 - 6 - 포트포워딩 정리
 - 7 - 인증서 만료 날짜를 모니터링하도록 센서 설정
 - 8 - TLS/SSL 인증서의 자동 재발급 설정
 - 9 - 문제 발생 시 경고 알림 설정

**0, 1, 2에 대해서는 [이 문서](/docs/ecosystem/certificates/lets_encrypt2/)를 참고하세요**
### 3 - DuckDNS 계정 설정

Open your browser and go to https://duckdns.org.

Sign in and create an account using one of the id validation options in the top right corner.

In the domains section pick a name for your subdomain, this can be anything you like, and click add domain.

The URL you will be using later to access your Home Assistant instance from outside will be the subdomain you picked, followed by duckdns.org . For our example we will say our URL is examplehome.duckdns.org

Set up Home Assistant to keep your DuckDNS URL and external IP address in sync. In your `configuration.yaml` file add the following:

```yaml
duckdns:
  domain: examplehome
  access_token: abcdefgh-1234-abcd-1234-abcdefgh
```

The access token is available on your DuckDNS page. Restart Home Assistant after the change.

What you have now done is set up DuckDNS so that whenever you type examplehome.duckdns.org in to your browser it will convert that to your router's external IP address. Your external IP address will always be up to date because Homeassistant will update DuckDNS every time it changes.

Now type your new URL in to your address bar on your browser with port 8123 on the end:

```text
http://examplehome.duckdns.org:8123
```

What now happens behind the scenes is this:

- DuckDNS receives the request and forwards the request to your router's external IP address (which has been kept up to date by your device running Home Assistant)
- Your router receives the request on port 8123 and checks the port forwarding rules
- It finds the rule you created in step 2 and forwards the request to your HA instance
- Your browser displays your Home Assistant instance frontend.

Did it work? Super!

You now have a remotely accessible Home Assistant instance that has a text-based URL and will not drop out if your service provider changes your IP. But, it is only as secure as the password you set, which can be snooped during your session by a malicious hacker with relative ease. So we need to set up some encryption with TLS/SSL, read on to find out how.

### 4 - Let's Encrypt에서 TLS/SSL 인증서 발급

First we need to set up another port forward like we did in step 2.  Set your new rule to:

```text
Service name - ha_letsencrypt
Port Range - 80
Local IP - YOUR-HA-IP
Local Port - 80
Protocol - Both
```

Remember to save the new rule.

<div class='note'>
In cases where your ISP blocks port 80 you will need to change the port forward options to forward port 443 from outside to port 443 on your Home Assistant device. Please note that this will limit your options for automatically renewing the certificate, but this is a limitation because of your ISP setup and there is not a lot we can do about it!
</div>

Now SSH in to the device your Home Assistant is running on.

<div class='note'>

If you're running the 'standard' setup on a Raspberry Pi the chances are you just logged in as the 'pi' user. If not, you may have logged in as the Home Assistant user. There are commands below that require the Home Assistant user to be on the `sudoers` list. If you are not using the 'standard' Pi setup it is presumed you will know how to get your Home Assistant user on the `sudoers` list before continuing.  If you are running the 'standard' Pi setup, from your 'pi' user issue the following command (where `homeassistant` is the Home Assistant user):

```bash
sudo adduser homeassistant sudo
```

</div>

If you did not already log in as the user that currently runs Home Assistant, change to that user (usually `homeassistant` or `hass` - you may have used a command similar to this in the past):

```bash
sudo -u homeassistant -H -s
```

Make sure you are in the home directory for the Home Assistant user:

```bash
cd
```

We will now make a directory for the certbot software, download it and give it the correct permissions:

```text
mkdir certbot
cd certbot/
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
```

You might need to stop Home Assistant before continuing with the next step. You can do this via the Web-UI or use the following command if you are running on Raspbian:

```text
sudo systemctl stop home-assistant@homeassistant.service
```

You can restart Home Assistant after the next step using the same command and replacing `stop` with `start`.
Now we will run the certbot program to get our SSL certificate. You will need to include your email address and your DuckDNS URL in the appropriate places:

```text
./certbot-auto certonly --standalone --preferred-challenges http-01 --email your@email.address -d examplehome.duckdns.org
```

Once the program has run it will generate a certificate and other files and place them in a folder `/etc/letsencrypt/` .

Confirm this file has been populated:

```bash
ls /etc/letsencrypt/live/
```

This should show a folder named exactly after your DuckDNS URL.

Our Home Assistant user needs access to files within the letsencrypt folder, so issue the following commands to change the permissions.

```bash
sudo chmod 755 /etc/letsencrypt/live/
sudo chmod 755 /etc/letsencrypt/archive/
```

Did all of that go without a hitch? Wahoo! Your Let's Encrypt certificate is now ready to be used with Home Assistant. Move to step 5 to put it all together

### 5 - 들어오는 연결 확인

<div class='note'>

Following on from Step 4 your SSH will still be in the certbot folder. If you edit your configuration files over SSH you will need to change to our `homeassistant` folder:

```bash
cd ~/.homeassistant
```

If you use Samba shares to edit your files you can exit your SSH now.

</div>

If during step 4 you had to use port 443 instead of port 80 to generate your certificate, you should delete that rule now.

Go to your router's configuration pages and set up a new port forwarding rule, thus:

```text
Service name - ha_ssl
Port Range - 443
Local IP - YOUR-HA-IP
Local Port - 8123
Protocol - Both
```

Remember to save the rule changes.

Now edit your configuration.yaml file to reflect the SSL entries and your base URL (changing the `examplehome` subdomain to yours in all three places):

```yaml
http:
  ssl_certificate: /etc/letsencrypt/live/examplehome.duckdns.org/fullchain.pem
  ssl_key: /etc/letsencrypt/live/examplehome.duckdns.org/privkey.pem
  base_url: examplehome.duckdns.org
```

You may wish to set up other options for the [http](/integrations/http/) integration at this point, these extra options are beyond the scope of this guide.

Save the changes to configuration.yaml. Restart Home Assistant.

In step 3 we accessed our Home Assistant from the outside world with our DuckDNS URL and our port number. We are going to use a slightly different URL this time.

```text
https://examplehome.duckdns.org
```

Note the **S** after http, and that no port number is added. This is because https will use port 443 automatically, and we have already set up our port forward to redirect this request to our Home Assistant instance on port 8123.

You should now be able to see your Home Assistant instance via your DuckDNS URL, and importantly note that your browser shows the connection as secure.

You will now NO LONGER be able to access your Home Assistant via your old internal IP address in the way you previously have. Your default way to access your Home Assistant instance, even from inside your house, is to use your DuckDNS URL.

In cases where you need to access via the local network only (which should be few and far between) you can access it with the following URL (note the added **S** after http):

```text
https://YOUR-HA-IP:8123
```

...and accepting the browsers warning that you are connecting to an insecure site. This warning occurs because your certificate expects your incoming connection to come via your DuckDNS URL. It does not mean that your device has suddenly become insecure.

Some cases such as this are where your router does not allow 'loopback' or where there is a problem with incoming connections due to technical failure. In these cases you can still use your internal connection and safely ignore the warnings.

If you were previously using a webapp on your phone/tablet to access your Home Assistant you should delete the old one and create a new one with the new address. The old one will no longer work as it is not keyed to your new, secure URL.  Instructions for creating your new webapp can be found [here](/docs/frontend/mobile/).

All done? Accessing your Home Assistant from across the world with your DuckDNS URL and a lovely secure logo on your browser? Ace! Now let's clean up our port forwards so that we are only exposing the parts of our network that are absolutely necessary to the outside world.

### 6 - 포트포워딩 정리

In step 2 we created a port forwarding rule called `ha_test`. This opens port 8123 to the world, and is no longer necessary.

Go to your router's configuration pages and delete the `ha_test` rule.

You should now have two rules in relation to Home Assistant for your port forwards, named:

`ha_ssl` and `ha_letsencrypt`

If you have any more for Home Assistant you should delete them now. If you only have `ha_ssl` this is probably because during step 4 you had to use port 443 instead of port 80, so we deleted the rule during step 5.

You are now part of one of two groups:

 * If you have BOTH rules you are able to set up auto renewals of your certificates using port 80 and the standard http challenge, as performed above.
 * If you only have one, you are still able to set up auto renewals of your certificates, but will have to specify additional options when renewing that will temporarily stop Home Assistant and use port 8123 for certificate renewal.

Please remember whether you are a ONE-RULE person or a BOTH-RULE person for step 8!

Let's Encrypt certificates only last for 90 days. When they have less than 30 days left they can be renewed. Renewal is a simple process.

Move on to step 7 to see how to monitor your certificates expiry date, and be ready to renew your certificate when the time comes.

### 7 - 인증서 만료 날짜를 모니터링하도록 센서 설정

Setting a sensor to read the number of days left on your TLS/SSL certificate before it expires is not required, but it has the following advantages:

 * You can physically see how long you have left, pleasing your inner control freak
 * You can set automations based on the number of days left
 * You can set alerts to notify you if your certificate has not been renewed and is coming close to expiry.
 * If you cannot set up automatic renewals due to your ISP blocking port 80, you will have timely reminders to complete the process manually.

If you do not wish to set up a sensor you can skip straight to step 8 to learn how to update your certificates.

The sensor will rely on a command line program that needs to be installed on your device running Home Assistant. SSH in to the device and run the following commands:

```bash
sudo apt-get update
sudo apt-get install ssl-cert-check
```

<div class='note'>

In cases where, for whatever reason, apt-get installing is not appropriate for your installation you can fetch the ssl-cert-check script from `http://prefetch.net/code/ssl-cert-check` bearing in mind that you will have to modify the command in the sensor code below to run the script from wherever you put it, modify permission if necessary and so on.

</div>

To set up a senor add the following to your `configuration.yaml` (remembering to correct the URL for your DuckDNS):

```yaml
sensor:
  - platform: command_line
    name: SSL cert expiry
    unit_of_measurement: days
    scan_interval: 10800
    command: "ssl-cert-check -b -c /etc/letsencrypt/live/examplehome.duckdns.org/cert.pem | awk '{ print $NF }'"
```

Save the configuration.yaml. Restart Home Assistant.

On your default_view you should now see a sensor badge containing your number of days until expiry. If you've been following this guide from the start and have not taken any breaks in between, this should be 89 or 90. The sensor will update every 3 hours. You can place this reading on a card using groups, or hide it using customize. These topics are outside of the scope of this guide, but information can be found on their respective integrations pages: [Group](/integrations/group/) and [Customize](/docs/configuration/customizing-devices/)

Got your sensor up and running and where you want it? Top drawer! Nearly there, now move on to the final steps to ensure that you're never without a secure connection in the future.

### 8 - TLS/SSL 인증서의 자동 재발급 설정

The certbot program we downloaded in step 4 contains a script that will renew your certificate. The script will only obtain a new certificate if the current one has less than 30 days left on it, so running the script more often than is actually needed will not cause any harm.

If you are a ONE-RULE person (from step 6), you can automatically renew your certificate with your current port mapping by temporarily stopping Home Assistant and telling certbot to bind port 8123 internally, and using a `tls-sni` challenge so that the Let's Encrypt CA binds port 443 externally. The flags used to specify these additional steps are shown below.

If you are a TWO-RULE person (from step 6), you can automatically renew your certificate using a `http-01` challenge and port 80.

There are a number of options for automating the renewal process:

#### Option 1:
Your certificate can be renewed as a 'cron job' - cron jobs are background tasks run by the computer at specified intervals (and are totally independent of Home Assistant). Defining cron is outside of the scope of this guide but you will have had dealings with `crontab` when setting up DuckDNS in step 3

To set a cron job to run the script at regular intervals:

 * SSH in to your device running Home Assistant.
 * Change to your Home Assistant user (where `homeassistant` is the name of the user):

```bash
sudo -u homeassistant -H -s
```

 * Open the crontab:

```bash
crontab -e
```

 * If you are a TWO-RULE Person: Scroll to the bottom of the file and paste in the following line

```text
30 2 * * 1 ~/certbot/certbot-auto renew --quiet --no-self-upgrade --standalone --preferred-challenges http-01
```

* If you are a ONE-RULE Person: Scroll to the bottom of the file and paste in the following line

```text
30 2 * * 1 ~/certbot/certbot-auto renew --quiet --no-self-upgrade --standalone --preferred-challenges tls-sni-01 --tls-sni-01-port 8123 --pre-hook "sudo systemctl stop home-assistant@homeassistant.service" --post-hook "sudo systemctl start home-assistant@homeassistant.service"
```
* Let's take a moment to look at the differences here:
	1. This method uses a `tls-sni` challenge, so the Let's Encrypt CA will attempt to bind port 443 externally (which you have forwarded)
	2. `--tls-sni-01-port 8123` tells certbot to bind port 8123 internally, which matches with the port forwarding rules that are already in place.
	3. We define pre-hooks and post-hooks that stop our Home Assistant service before certbot runs, freeing port 8123 for certificate renewal, and restart Home Assistant after renewal is complete.

 * Save the file and exit


#### Option 2:
You can set an automation in Home Assistant to run the certbot renewal script.

Add the following sections to your configuration.yaml if you are a TWO-RULE person

```yaml
shell_command:
  renew_ssl: ~/certbot/certbot-auto renew --quiet --no-self-upgrade --standalone --preferred-challenges http-01

automation:
  - alias: 'Auto Renew SSL Cert'
    trigger:
      platform: numeric_state
      entity_id: sensor.ssl_cert_expiry
      below: 29
    action:
      service: shell_command.renew_ssl
```
If you are a ONE-RULE person, replace the `certbot-auto` command above with `~/certbot/certbot-auto renew --quiet --no-self-upgrade --standalone --preferred-challenges tls-sni-01 --tls-sni-01-port 8123 --pre-hook "sudo systemctl stop home-assistant@homeassistant.service" --post-hook "sudo systemctl start home-assistant@homeassistant.service"`

#### Option 3:
You can manually update the certificate when your certificate is less than 30 days to expiry.

To manually update:

 * SSH in to your device running Home Assistant.
 * Change to your Home Assistant user (where `homeassistant` is the name of the user):

```bash
sudo -u homeassistant -H -s
```

 * Change to your certbot folder

```bash
cd ~/certbot/
```

 * Run the renewal command

```bash
./certbot-auto renew --quiet --no-self-upgrade --standalone --preferred-challenges http-01
```

* If you are a ONE-RULE person, replace the `certbot-auto` command above with `~/certbot/certbot-auto renew --quiet --no-self-upgrade --standalone --preferred-challenges tls-sni-01 --tls-sni-01-port 8123 --pre-hook "sudo systemctl stop home-assistant@homeassistant.service" --post-hook "sudo systemctl start home-assistant@homeassistant.service"`

So, now were all set up. We have our secured, remotely accessible Home Assistant instance and we're on track for keeping our certificates up to date. But what if something goes wrong?  What if the automation didn't fire?  What if the cron job forgot to run?  What if the dog ate my homework? Read on to set up an alert so you can be notified in plenty of time if you need to step in and sort out any failures.

### 9 - 문제 발생 시 경고 알림 설정

We set up our automatic renewal of our certificates and whatever method we used the certificate should be renewed on or around 30 days before it expires. But what if a week later it still hasn't been? This alert will go off if the expiry time on the certificate gets down to 21 days. This will give you 3 weeks to fix the problem, get your new certificate installed and get another 90 days of secure Home Assistant connections in play.

In your `configuration.yaml` add the following automation, adding your preferred notification platform where appropriate:

```yaml
automation:
  - alias: 'SSL expiry notification'
    trigger:
      platform: numeric_state
      entity_id: sensor.ssl_cert_expiry
      below: 21
    action:
      service: notify.[your_notification_preference]
      data:
        message: 'Warning - SSL certificate expires in 21 days and has not been automatically renewed'
```

If you receive this warning notification, follow the steps for a manual update from step 8. Any error messages received at that point can be googled and resolved. If the manual update goes without a hitch there may be something wrong with your chosen method for automatic updates, and you can start troubleshooting from there.

So, that's it. We've taken a Home Assistant instance that was only reachable on the local network, made it accessible from the internet, secured it, and set up a system to ensure that it always stays secure. Well done, go and treat yourself to a cookie!
