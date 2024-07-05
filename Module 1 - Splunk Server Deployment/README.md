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
mkdir /opt/splunk
```

Change the ownership of the created directory to the new user **"splunk"** (hereafter will be called as splunk user)

```bash
chown -R splunk:splunk /opt/splunk/
```


Verify the ownership of the directory
```bash
ll /opt
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

Download Splunk (Based on the version you want, you can get this command from https://www.splunk.com/en_us/download/splunk-enterprise/thank-you-enterprise.html)
```bash
wget -O splunk-9.2.2-d76edf6f0a15-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.2.2/linux/splunk-9.2.2-d76edf6f0a15-Linux-x86_64.tgz"
```

Extract the tar package
```bash
tar -xvf splunk-9.2.2-d76edf6f0a15-Linux-x86_64.tgz -C /opt/
```

Navigate to Splunk bin directory
```bash
cd /opt/splunk/bin
```

Start the Splunk with accepting license
```bash
./splunk start --accept-license
```

**Note:** In above step installer will ask you to create username and password, please keep these credentials safe (These are the admin credentials which you will use to Manage Splunk)

At this point, open your browser and check the link: http://<public_ip_address>:8000

Splunk login screen will popup..

## Step-4: Configure Splunk to run at boot time

Exit from splunk user & sign in as **root** user
``` bash
./splunk stop
exit
```
``` bash
sudo su 
```

Enable boot start
``` bash
/opt/splunk/bin/splunk enable boot-start -user splunk
```

``` bash
sudo su - splunk
/opt/splunk/bin/splunk start
```

That's it... you have successfully installed Splunk on Linux..!!

Happy Splunking..!!



Team - SplunkMania
