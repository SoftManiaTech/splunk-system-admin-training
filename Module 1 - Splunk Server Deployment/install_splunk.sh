#!/bin/bash
echo
yum install wget -y
cd /tmp
wget -O splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz "https://download.splunk.com/products/splunk/releases/9.4.0/linux/splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz"
echo
echo "Splunk Downloaded."
echo
tar -xzvf /tmp/splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz -C /opt
rm -f /tmp/splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz
useradd splunk
echo
echo "Splunk installed and splunk linux user created."
echo
chown -R splunk:splunk /opt/splunk
echo
runuser -l splunk -c '/opt/splunk/bin/splunk start --accept-license --no-prompt --answer-yes --seed-passwd Pa55word'
/opt/splunk/bin/splunk enable boot-start -user splunk
runuser -l splunk -c '/opt/splunk/bin/splunk stop'
chown root:splunk /opt/splunk/etc/splunk-launch.conf
chmod 644 /opt/splunk/etc/splunk-launch.conf
echo
echo "Splunk test start and stop complete. Enabled Splunk to start at boot. Also, adjusted splunk-launch.conf to mitigate privilege escalation attack."
echo
runuser -l splunk -c '/opt/splunk/bin/splunk start'
if [[ -f /opt/splunk/bin/splunk ]]
        then
                echo Splunk Enterprise
                cat /opt/splunk/etc/splunk.version | head -1
                echo "has been installed, configured, and started!"
                echo "Visit the Splunk server using https://hostNameORip:8000 as mentioned above."
                echo
                echo
                echo "                        HAPPY SPLUNKING!!!"
                echo
                echo
                echo
        else
                echo Splunk Enterprise has FAILED install!
fi
#End of File
