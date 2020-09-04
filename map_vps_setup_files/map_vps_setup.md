# MAP VPS Setup

Authors: @neptuneresearch @serhack

## Usage
See ```/map_vps_setup_files``` for configuration files.  
  
See ```/map_vps_setup_scripts``` for bash scripts for each section.  
The first script ```0_map_vps_setup.sh``` will set all of the scripts as executable and proceed to run them all, pausing for user keypress after each section completes.


# OS Setup

## Software Update
Run the following command to update the OS packages.

    sudo apt-get update && sudo apt-get upgrade -y 

This may cause the ```grub``` installer to appear. If it does:

1. Optional: Review differences
2. Accept differences
3. Choose the device the OS is installed on, default is ```/dev/sda```
4. Choose not to install ```grub```


## Unattended-upgrades

This may already be installed.  
See [Automatic Updates](https://wiki.debian.org/UnattendedUpgrades) for more information.

    sudo apt install unattended-upgrades


## UFW Firewall
1. Install.

    ```sudo apt-get install ufw```

2. Configure by running each of the following rule commands.

| Rule Command | Purpose |
| - | - |
| ```sudo ufw default allow outgoing``` | Allow all outgoing traffic |
| ```sudo ufw default deny incoming``` | Deny all incoming traffic by default |
| ```sudo ufw allow from any to any port 4422 proto tcp``` | Allow incoming traffic to ```TCP port 4422``` for ```sshd``` |
| ```sudo ufw allow from any to any port 18080 proto tcp``` | Allow incoming traffic to ```TCP port 18080``` for ```monerod``` |

3. Enable the firewall and its logging.

    ```sudo ufw enable```  
    ```sudo ufw logging on```

## UTC Time Zone
All MAP nodes must be in the **UTC time zone** in order to standardize the timestamps in the archive output.

1. Run the timezone configuration tool.  

    ```sudo dpkg-reconfigure tzdata```
    
2. Enter the following configuration.

| Setting | Value |
| - | - |
| Geographic area | None of the above |
| Time zone | UTC |

3. Result example:

    ```Current default time zone: 'Etc/UTC'```  
    ```Local time is now:      Sun Oct  7 00:13:21 UTC 2018.```  
    ```Universal Time is now:  Sun Oct  7 00:13:21 UTC 2018.```  


## Hostname MAP-CITY-X
Set the hostname to ```MAP-CITY-X```, where ```CITY``` is the city where the server is physically located, and ```X``` is the index of the server in that city starting at 0. Example: ```MAP-TOKYO-0```

    sudo echo "MAP-CITY-0" > /etc/hostname
    sudo hostname -F /etc/hostname


## Hosts File Self Entry
If the server has a domain name, add a self entry for the server to the file ```/etc/hosts```.

Add line to end:

    0.0.0.0 server.org hostname

where:

| Key | Value |
| - | - |
| 0.0.0.0 | Public IP for server |
| server.org | Domain name for server |
| hostname | Hostname for server (```MAP-CITY-X```, same as in ```/etc/hostname```) |


## Message of the Day
Set the Message of the Day on the server with the following command.

    sudo echo "Welcome to $HOSTNAME part of the MAP (Monero Archival Project). Project coordinator : IsthmusCrypto. Infra Coordinator : SerHack. Any issues should be reported to the Project Coordinator" > /etc/motd



## MAP User Account
1. Create the user account ```map```.

    ```sudo adduser map```

2. Add ```map``` to ```sudo``` group so it can ```sudo```.

    ```sudo usermod -aG sudo map```

3. Create ```sshusers``` group (used by ```sshd_config AllowGroups```).

    ```sudo groupadd sshusers```

4. Add ```map``` to ```sshusers``` group.

    ```sudo adduser map sshusers```


## sshd Configuration

Recommend to first backup original configuration file ```/etc/ssh/sshd_config``` for future reference.

### Quick Configuration
1. Install the file ```map_vps_setup_files/sshd_config``` as ```/etc/ssh/sshd_config```.

2. Skip to step 4 of the Full Configuration.

### Full Configuration
Configure sshd via its configuration file ```/etc/ssh/sshd_config``` as follows.

#### 1. Add Custom Settings
Add the following settings.

| Setting | Description |
| - | - |
| ```Port 4422``` | Use nonstandard port so that naive attempts to connect on the default port are rejected quicker |
| ```AddressFamily inet``` | Use ipv4 only |
| ```PermitRootLogin no``` | No ```root``` account login over ssh |
| ```LoginGraceTime 60``` | Login attempts timeout after 60 seconds |
| ```MaxAuthTries 8``` | Login attempts limit to 8 |
| ```PubkeyAuthentication yes``` | Enable login via public key authentication |
| ```AuthorizedKeysFile .ssh/authorized_keys``` | File which stores authorized public keys (*NOTE: this is one line, the Markdown may have wrapped it to 2 lines*) |
| ```PasswordAuthentication no``` | Disable login via password |
| ```Protocol 2``` | Disable SSH protocol V1 |
| ```AllowGroups sshusers``` | Only allow login from users of group ```sshusers``` |

#### 2. Check Default Settings
The following default settings can remain.

| Default Setting |
| - |
| ```ChallengeResponseAuthentication no``` |
| ```UsePAM yes``` |
| ```X11Forwarding yes``` |
| ```PrintMotd no``` |
| ```AcceptEnv LANG LC_*``` |
| ```Subsystem sftp /usr/lib/openssh/sftp-server``` |

#### 3. Disable All Other Settings
All other settings in the file that do not appear in the table below should be disabled by commenting the line with ```#``` at the beginning, ex: ```#AddressFamily any```

#### 4. Add Authorized Keys
1. Create the folder ```/home/map/.ssh``` and ```chmod 700 /home/map/.ssh```.

2. Install the file ```/map_vps_setup_files/authorized_keys``` as ```/home/map/.ssh/authorized_keys``` and ```chmod 600 /home/map/.ssh/authorized_keys```.

3. Add other public SSH keys as desired.

4. Set owner on ```/home/map/.ssh``` and its contents: ```sudo chown -R map:map /home/map/.ssh```

#### 5. Apply Configuration
After configuring, restart ssh.

    sudo systemctl restart ssh

#### 6. Troubleshooting
If ssh fails to restart because of bad configuration, you can find the invalid configuration line(s) in the syslog at ```/var/log/syslog```.

#### 7. Expected ssh Responses
With the above configuration:

| ssh login command | ssh response |
| - | - |
| ```ssh map@map-city-0``` | ```Connection refused``` |
| ```ssh map@map-city-0 -p 4422 -i ~/.ssh/map``` (and client DOES NOT have key in ```authorized_keys```) | ```Permission denied (publickey)``` |
| ```ssh map@map-city-0 -p 4422 -i ~/.ssh/map``` (and client DOES have key in ```authorized_keys``` ) | Login is successful |

# monerod-archive Setup

## Filesystem Directories
```monerod-archive``` requires the following directories.

| Directory | Purpose |
| - | - |
| ```/usr/bin/monero``` | Application |
| ```/var/lib/monero``` | Data (aka ```.bitmonero```) |
| ```/var/log/monero``` | Logs |
| ```/opt/monerodarchive``` | monerod-archive output |

All directories should have permissions ```755``` and owner ```map:map```.

For each directory, replace the directory name into the following commmands:

```
# Create directory
sudo mkdir /usr/bin/monero
# Set owner to map user, map group
sudo chown map:map /usr/bin/monero
# Set directory permissions
sudo chown 755 /usr/bin/monero
```

## Download monerod-archive

```
cd /usr/bin/monero
wget https://github.com/neptuneresearch/monerod-archive/releases/download/0.08/monerod-archive-v8-linux-amd64.tar.gz
tar -vxf ./monerod-archive-v8-linux-amd64.tar.gz
```

## monerod-archive Configuration File
1. Install the file ```/map_vps_setup_files/monerod-archive.conf``` as ```/etc/monerod-archive.conf```.

2. Set owner and permissions as follows.

```sudo chown map:map /etc/monerod-archive.conf```  
```sudo chmod 644 /etc/monerod-archive.conf```  

## monerod-archive Systemd Service

1. Install the file ```/map_vps_setup_files/monerod-archive.service``` as ```/etc/systemd/system/monerod-archive.service```.

2. Reload systemd service files: ```sudo systemctl daemon-reload```

3. Enable monerod-archive service at startup: ```sudo systemctl enable monerod-archive```

4. Start monerod-archive service now: ```sudo systemctl start monerod-archive```

5. Check status of monerod-archive service: ```sudo systemctl status monerod-archive```


# monerod-archive Logrotate Setup
Install the file ```/map_vps_setup_files/monerod-archive.logrotate.conf``` as ```/etc/logrotate.d/monerod-archive```.


# collectd Setup

## Install collectd

    apt−get install collectd collectd-utils

## Quick Configuration
Install the file ```map_vps_setup_files/collectd.conf``` as ```/etc/collectd/collectd.conf```.

## Full Configuration
1. Edit the file ```/etc/collectd/collectd.conf``` and enable the plugin "Network". The other plugins (cpu, df etc..) have been already enabled . [A list of plugins that can be set up.](https://collectd.org/wiki/index.php/Table_of_Plugins)

    TODO: add lists of plugins enabled.

2. Add the following block in Plugin configuration section

```
<Plugin processes>
	CollectFileDescriptor true
	CollectContextSwitch true
	Process "monerod-archive-v7"
</Plugin>

<Plugin ping>
    Host "$GRAFANAHOST"
    Interval 1.0
    Timeout 0.9
    TTL 255
    MaxMissed -1
</Plugin>

<Plugin network>
	Server "$GRAFANAHOST" "$GRAFANAPORT"
</Plugin>
```

Replace ```$GRAFANAHOST, $GRAFANAPORT``` with ip address and port where Grafana and InfluxDB are installed.

3. Go to Grafana dashboard. Select the appropriate hostname and then it will show you the new data! 
(It may take some minutes to fetch data).
