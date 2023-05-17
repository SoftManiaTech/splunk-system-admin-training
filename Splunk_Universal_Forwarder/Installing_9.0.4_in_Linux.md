## Step-1 : Become root user
Login as "root" user using below command
```bash
sudo su 
```
## Step-2 : Create new user (splunk), directories & permissions

Create user & group

```bash
useradd splunk
groupadd splunk
```
Create directory
```bash
mkdir /opt/splunkforwarder
```

Change the ownership of the created directory to the new user **"splunk"** (hereafter will be called as splunk user)

```bash
chown -R splunk:splunk /opt/splunkforwarder/
```


Verify the ownership of the directory
```bash
ll /opt/splunkforwarder
```

Install **"wget"**
```bash
yum install wget
```

## Step-3 : Splunk Enterprise Installation

Switch to splunk user 
```bash
sudo su - splunk
```

Navigate to splunk user home directory
```bash
cd /home/splunk
```

Download Splunk Universal Forwarder (Based on the version you want, you can get this command from [https://www.splunk.com/en_us/download/splunk-enterprise/thank-you-enterprise.html](https://www.splunk.com/en_us/download/universal-forwarder/thank-you-universalforwarder.html))
```bash
wget -O splunkforwarder-9.0.4-de405f4a7979-Linux-x86_64.tgz "https://download.splunk.com/products/universalforwarder/releases/9.0.4/linux/splunkforwarder-9.0.4-de405f4a7979-Linux-x86_64.tgz"
```

Extract the tar package
```bash
tar -xvf splunkforwarder-9.0.4-de405f4a7979-Linux-x86_64.tgz -C /opt/
```

Navigate to Splunk bin directory
```bash
cd /opt/splunkforwarder/bin
```

Start the Splunk with accepting license & setting the default username (admin) passing the passowrd (Pa55word)
```bash
./splunk start --accept-license --no-prompt --answer-yes --seed-passwd Pa55word
```

**Note:** In above step installer will ask you to create username and password, please keep these credentials safe (These are the admin credentials which you will use to Manage Splunk)

At this point, universal Forwarder is installed in your linux server

## Step-4: Configure Splunk to run at boot time

Exit from splunk user & sign in as **root** user
``` bash
exit
sudo su 
```

Enable boot start
``` bash
/opt/splunkforwarder/bin/splunk enable boot-start -user splunk
```

That's it... you have successfully installed Splunk on Linux..!!

Happy Splunking..!!



Team - SplunkMania
