# Security Incident Detection and Response with Splunk

A Docker-based virtual lab for cybersecurity training, focused on configuring a Splunk Indexer and Damn Vulnerable Web App (DVWA) with a Splunk Forwarder. The setup provides an easily redployable environment ideal for aspiring penetration testers and incident responders.

## Intention

Orchestrate a containerized environment that can be used for practicing offensive security techniques and gain experience with log monitoring configuration and log analysis.

<details>
    <summary><u>Containers</u></summary>

  Damn Vulnerable Web App
  
  Splunk
  
</details>

## Objectives

Part 1:

- [x] Test the creation and configuration of a Splunk Docker container without using a `compose.yml` file.
- [x] Test the Splunk's dashboard
- [x] Understand the fine details of Universal Forwarder
- [x] Understand the fine details of Heavy Forwarder
- [x] Able to explain the differences between Universal and Heavy Forwarders

- [x] Test the creation of DVWA using Docker without a `compose.yml` file.
- [x] Find where DVWA stores access logs
- [x] Find where DVWA stores database logs
- [x] Decide whether to use PHPIDS in tandem with Splunk


Part 2:

- [ ] Create a compose file
    - [x] Splunk Indexer/Receiver to collect and visualize data
    - [ ] Configure DVWA's Splunk Forwarder (Universal/Heavy) to monitor:
        - [x] Authentication Logs: `/var/log/apache2/access.log`
        - [x] Error Logs: `/var/log/apache2/error.log`, `/var/mysql/error.log`
        - [x] Other Files: `/etc/shadow`
        - [x] DVWA Port 80
        - [ ] <s>High concurrent CPU usage</s>
        - [ ] <s>Critical disk capacity</s>
        - [ ] PHPIDS logs
    - [x] <details><summary>Figure a way to automate the Forwarder's installation and configuration post composition</summary>
      - [x] Solution 1: Create a script to automate the installation of a Splunk Forwarder
        - [x] Add command to `compose.yml`: `sh -c "install_splunk_forwarder.sh"`
        - [x] NOTE: DVWA doesn't have `wget` or `curl`, but has `dpkg`. It may be best to just download the forwarder file onto the host before mounting it directly in `compose.yml` with a volume command like: volumes: `/home/kali/Desktop/splunk_forwarder/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb:/opt/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb`
          - [`install_splunk_forwarder.sh`](https://docs.splunk.com/Documentation/Forwarder/9.2.1/Forwarder/Installanixuniversalforwarder "Universal Forwarder Installation Documentation: *nix"):
            1. `dpkg -i /tmp/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb`
            2. `echo 'Splunk Forwarder Installed'`
            3. `export SPLUNK_HOME=/opt/splunkforwarder >> ~/.profile` OR [while in a CLI session](https://docs.splunk.com/Documentation/Splunk/9.2.1/Admin/AbouttheCLI#:~:text=To%20set%20the%20%24SPLUNK_HOME%20environment%20variable%20while%20working%20in%20a%20CLI%20session%3A "Documentation"): `source /opt/splunk/bin/setSplunkEnv` & skip step 4
            4. `export PATH=$SPLUNK_HOME/bin:$PATH`
            5. `splunk add forward-server 127.0.0.1:9997` OR navigate to `$SPLUNK_HOME/bin` and use: `./splunk add forward-server 127.0.0.1:9997`
            6. `splunk add monitor /var/log/apache2/access.log`
            7. `splunk add monitor /var/log/apache2/error.log`
            8. `splunk add monitor /var/log/mysql/error.log`
            9. `splunk add monitor /etc/shadow`
            10. `splunk add tcp 80` OR try: `splunk add monitor 80`
      - [ ] <s>Solution 2: requires I create the `inputs.conf` and `outputs.conf` before composition runtime, and that these configuration files are mounted in a safe directory being being copied to `$SPLUNK_HOME/etc/system/local` post installation of the Splunk Forwarder on DVWA.</s>
      - [x] <s>[Solution 3](https://splunk.github.io/docker-splunk/EXAMPLES.html#create-standalone-and-universal-forwarder): Add a Universal Forwarder container in the compose file and configuring it using `SPLUNK_ADD`</s></details>

Part 3:

- [ ] Compose the virtual pentesting environment
- [ ] Check Splunk Receiver dashboard for forwarder connections
- [ ] Create Alerts for all monitored data

- [ ] Follow the Cyber Kill Chain framework
  - [ ] Insert the seven steps below (Recon, Weaponization, Delivery, Exploitation, Installation, C2, Actions on Objectives)
    - [ ] Add specific objectives to complete that are required before moving to the next step