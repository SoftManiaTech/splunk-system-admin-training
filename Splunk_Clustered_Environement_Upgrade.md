
# Splunk Upgrade Steps for Clustered environment

## Step-1 - Health Check for IDX Cluster:

### Run below commands in Cluster Manager

```bash
cd /opt/splunk/bin
./splunk show cluster-status --verbose
```

### Check if all the below parameters are "YES"

```bash

 Pre-flight check successful .................. YES
 ├────── Replication factor met ............... YES
 ├────── Search factor met .................... YES
 ├────── All data is searchable ............... YES
 ├────── All peers are up ..................... YES
 ├────── CM version is compatible ............. YES
 ├────── No fixup tasks in progress ........... YES
 └────── Splunk version peer count { 7.1.0: 3 }

 Indexing Ready YES

```

## Step-2 - Stop Cluster Manager Node:

### Stop Splunk 

```bash
cd /opt/splunk/bin
./splunk stop
```

### Start the upgrade of Cluster Manager

```bash
sudo chown -R splunk:splunk /opt/splunk
cd /home/splunk
sudo -u splunk -H sh -c 'wget -O splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.0.4.1/linux/splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz"'
sudo -u splunk -H sh -c 'tar -xvf splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz -C /opt/'
cd /opt/splunk/bin
sudo -u splunk -H sh -c './splunk start --accept-license --answer-yes --no-prompt'
sudo chown -R splunk:splunk /opt/splunk
```

## Step-3 - Health check for SH Cluster:

### Run below command in any of the Search head to check the health of the SH cluster

```bash
cd /opt/splunk/bin
./splunk show shcluster-status --verbose
```

### Check if below parameters are correct --- conditon mentioned like --> <<<< this prop should be 0 >>>> 

### Here is an example of the output from the command:

```bash
 Captain:
 		decommission_search_jobs_wait_secs : 180
 		               dynamic_captain : 0
 		               elected_captain : Tue Mar  6 23:35:52 2018
 		                            id : FEC6F789-8C30-4174-BF28-674CE4E4FAE2
 		              initialized_flag : 1
 		                         label : sh1
 		 max_failures_to_keep_majority : 1
 		                      mgmt_uri : https://sroback180306192122accme_sh3_1:8089
 		         min_peers_joined_flag : 1
 		               rolling_restart : restart
 		          rolling_restart_flag : 0 <<<< this prop should be 0 >>>>
 		          rolling_upgrade_flag : 0 <<<< this prop should be 0 >>>>
 		            service_ready_flag : 1 <<<< this prop should be 1 >>>>
 		                stable_captain : 1 <<<< this prop should be 1 >>>>

  Cluster Master(s):
 	https://sroback180306192122accme_master1_1:8089		splunk_version: 7.1.0

  Members:
 	sh2
 		                         label : sh2
 		         last_conf_replication : Wed Mar  7 05:30:09 2018
 		              manual_detention : off   <<<< this prop should be off >>>>
 		                      mgmt_uri : https://sroback180306192122accme_sh2_1:8089
 		                mgmt_uri_alias : https://10.0.181.4:8089
 		              out_of_sync_node : 0
 		             preferred_captain : 1
 		              restart_required : 0
 		                splunk_version : 7.1.0
 		                        status : Up    <<<< this prop should be up >>>>
 	sh1
 		                         label : sh1
 		         last_conf_replication : Wed Mar  7 05:30:09 2018
 		              manual_detention : off   <<<< this prop should be up >>>>
 		                      mgmt_uri : https://sroback180306192122accme_sh1_1:8089
 		                mgmt_uri_alias : https://10.0.181.2:8089
 		              out_of_sync_node : 0
 		             preferred_captain : 1
 		              restart_required : 0
 		                splunk_version : 7.1.0
 		                        status : Up

```

## Step-4 - Initialize rolling upgrade of Seach Head Members:

### To initialize the rolling upgrade, run the following CLI command on any cluster member:

```bash
cd /opt/splunk/bin
./splunk upgrade-init shcluster-members
```

## Step-5 - Put a member into manual detention mode:

### Select a search head cluster member other than the captain and put that member into manual detention mode:
#### in our case it's SH-2

```bash
cd /opt/splunk/bin
./splunk edit shcluster-config -manual_detention on
```

## Step-6 - Confirm the member is ready for upgrade:

### Run the following command to confirm that all searches are complete:

```bash
./splunk list shcluster-member-info | grep "active"
```

### The following output indicates that all historical and real-time searches are complete:

 ```bash
 active_historical_search_count:0
 active_realtime_search_count:0
```

## Step-7 - Start the Upgrade of Seach Head-2

```bash
cd /opt/splunk/bin
./splunk stop
sudo chown -R splunk:splunk /opt/splunk
cd /home/splunk
sudo -u splunk -H sh -c 'wget -O splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.0.4.1/linux/splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz"'
sudo -u splunk -H sh -c 'tar -xvf splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz -C /opt/'
cd /opt/splunk/bin
sudo -u splunk -H sh -c './splunk start --accept-license --answer-yes --no-prompt'
sudo chown -R splunk:splunk /opt/splunk
```

## Step-8 - Bring the member back online:

### Turn off manual detention mode:

```bash
cd /opt/splunk/bin/
./splunk edit shcluster-config -manual_detention off
```


## Step-9 - Check cluster health status:

### After you bring the member back online, check that the cluster is in a healthy state.

### Run the following command on the cluster member:

```bash
cd /opt/splunk/bin/
./splunk show shcluster-status --verbose
```

### Check if below parameters are correct --- conditon mentioned like --> <<<< this prop should be 0 >>>> 
```bash
 -----> Note: Check if SH-2 has the new version (say 9.0.4.1) <--------
```

#### Here is an example of the output from the command:

```bash
 Captain:
 		decommission_search_jobs_wait_secs : 180
 		               dynamic_captain : 0
 		               elected_captain : Tue Mar  6 23:35:52 2018
 		                            id : FEC6F789-8C30-4174-BF28-674CE4E4FAE2
 		              initialized_flag : 1
 		                         label : sh1
 		 max_failures_to_keep_majority : 1
 		                      mgmt_uri : https://sroback180306192122accme_sh3_1:8089
 		         min_peers_joined_flag : 1
 		               rolling_restart : restart
 		          rolling_restart_flag : 0 <<<< this prop should be 0 >>>>
 		          rolling_upgrade_flag : 0 <<<< this prop should be 0 >>>>
 		            service_ready_flag : 1 <<<< this prop should be 1 >>>>
 		                stable_captain : 1 <<<< this prop should be 1 >>>>
  Cluster Master(s):
 	https://sroback180306192122accme_master1_1:8089		splunk_version: 7.1.0

  Members:
 	sh2
 		                         label : sh2
 		         last_conf_replication : Wed Mar  7 05:30:09 2018
 		              manual_detention : off   <<<< this prop should be off >>>>
 		                      mgmt_uri : https://sroback180306192122accme_sh2_1:8089
 		                mgmt_uri_alias : https://10.0.181.4:8089
 		              out_of_sync_node : 0
 		             preferred_captain : 1
 		              restart_required : 0
 		                splunk_version : 9.0.0 <<<< this prop should be newer version >>>>
 		                        status : Up    <<<< this prop should be up >>>>
 	sh1
 		                         label : sh1
 		         last_conf_replication : Wed Mar  7 05:30:09 2018
 		              manual_detention : off   <<<< this prop should be up >>>>
 		                      mgmt_uri : https://sroback180306192122accme_sh1_1:8089
 		                mgmt_uri_alias : https://10.0.181.2:8089
 		              out_of_sync_node : 0
 		             preferred_captain : 1
 		              restart_required : 0
 		                splunk_version : 7.1.0
 		                        status : Up
```

## Step-10: Upgrade the SH-1 (Static Captain) member:

### Repeat the steps from Step-5 to Step-9 in SH-1 node

## Step-11 - Start the Upgrade of Deployer (MC):

```bash
cd /opt/splunk/bin
./splunk stop
sudo chown -R splunk:splunk /opt/splunk
cd /home/splunk
sudo -u splunk -H sh -c 'wget -O splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.0.4.1/linux/splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz"'
sudo -u splunk -H sh -c 'tar -xvf splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz -C /opt/'
cd /opt/splunk/bin
sudo -u splunk -H sh -c './splunk start --accept-license --answer-yes --no-prompt'
sudo chown -R splunk:splunk /opt/splunk
```

## Step-11 - Finalize the rolling upgrade:

### Run the following CLI command on any search head cluster member.

```bash
cd /opt/splunk/bin
./splunk upgrade-finalize shcluster-members
```

#### at this point, the Search head cluster has been upgraded to newer version ####


## Step-12 - Initialize rolling upgrade

### Run the following CLI command on the manager node:

```bash
cd /opt/splunk/bin
./splunk upgrade-init cluster-peers 
```

# For Indexer-1

## Step-13 - Take the peer offline

### Run the following CLI command on the peer node:

```bash
cd /opt/splunk/bin/
./splunk offline 
```

## Step-14 - Start the Upgrade of Peer node:

```bash
cd /opt/splunk/bin
./splunk stop
sudo chown -R splunk:splunk /opt/splunk
cd /home/splunk
sudo -u splunk -H sh -c 'wget -O splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.0.4.1/linux/splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz"'
sudo -u splunk -H sh -c 'tar -xvf splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz -C /opt/'
cd /opt/splunk/bin
sudo -u splunk -H sh -c './splunk start --accept-license --answer-yes --no-prompt'
sudo chown -R splunk:splunk /opt/splunk
```

## Step-15 Validate the version of the peer:

### Run below command in Cluster Master & check the peer version:

```bash
cd /opt/splunk/bin
./splunk show cluster-status --verbose
```

#### Example of the output of above command: (Check the version of the peer, it should refelct the latest version)

```bash
 Pre-flight check successful .................. YES
  ├────── Replication factor met ............... YES
  ├────── Search factor met .................... YES
  ├────── All data is searchable ............... YES
  ├────── All peers are up ..................... YES
  ├────── CM version is compatible ............. YES
  ├────── No fixup tasks in progress ........... YES
  └────── Splunk version peer count { 7.1.0: 3 }

  Indexing Ready YES

  idx1 	 0026D1C6-4DDB-429E-8EC6-772C5B4F1DB5	 default
 	 Searchable YES
 	 Status  Up
 	 Bucket Count=14
 	 Splunk Version=9.0.0 <<<<<<<< this prop should be latest version >>>>>>>

  idx3 	 31E6BE71-20E1-4F1C-8693-BEF482375A3F	 default
 	 Searchable YES
 	 Status  Up
 	 Bucket Count=14
 	 Splunk Version=7.1.0

  idx2 	 81E52D67-6AC6-4C5B-A528-4CD5FEF08009	 default
 	 Searchable YES
 	 Status  Up
 	 Bucket Count=14
 	 Splunk Version=7.1.0
```

# For Indexer-2

### Repeat the steps from Step-13 to Step-15

# For Indexer-3

### Repeat the steps from Step-13 to Step-15

## Step-16 - Finalize rolling upgrade

### Run the following CLI command on the manager node:

```bash
cd /opt/splunk/bin/
./splunk upgrade-finalize cluster-peers
```

#### at this point, Cluster Master, Search Head CLuster, Deployer, All the Indexers are upgraded to the latest version 

## Step-17 - Upgrade the forwarders

Note: To upgrade the Universal forwarder (Linux) use below Splunkbase App:

[Upgrade Linux Splunk Universal Forwarder - (Manual / Automate)](https://splunkbase.splunk.com/app/5200/)

Note: To upgrade the Heavy Forwarder (Linux) use below Splunkbase App:

[Upgrade Linux Splunk Heavy Forwarder - (Manual / Automate)](https://splunkbase.splunk.com/app/5201/)

#### at this point, Cluster Master, Search Head CLuster, Deployer, All the Indexers, Forwarders are upgraded to the latest version #####


# After all the above steps... go to monitoring console to check all the health check items, overview, warnings if any....


## Happy Splunking..!!
