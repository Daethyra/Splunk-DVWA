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
- [ ] Understand the fine details of Universal Forwarder
- [ ] Understand the fine details of Heavy Forwarder
- [ ] Able to explain the differences between Universal and Heavy Forwarders

- [x] Test the creation of DVWA using Docker without a `compose.yml` file.
- [x] Find where DVWA stores access logs
- [x] Find where DVWA stores database logs
- [x] Decide whether to use PHPIDS in tandem with Splunk


Part 2:

- [ ] Create a compose file
    - [ ] Splunk Indexer/Receiver to collect and visualize data
    - [ ] Configure DVWA's Splunk Forwarder (Universal/Heavy) to monitor:
        - [x] Authentication Logs: `/var/log/apache2/access.log`
        - [x] Error Logs: `/var/log/apache2/error.log`, `/var/mysql/error.log`
        - [x] Other Files: `/etc/shadow`
        - [x] DVWA Port 80
        - [ ] <s>High concurrent CPU usage</s>
        - [ ] <s>Critical disk capacity</s>
        - [ ] PHPIDS logs
    - [ ] <details><summary>Figure a way to automate the Forwarder's installation and configuration post composition</summary>
      - [ ] Create a script to automate the installation of a Splunk Forwarder
        - [ ] Add command to `compose.yml`: `sh -c "install-splunk-forwarder.sh && echo 'Splunk Forwarder Installed'"`
        - [ ] NOTE: DVWA doesn't have `wget` or `curl`, but has `dpkg`. It may be best to just download the forwarder file onto the host before mounting it directly in `compose.yml` with a volume command like: volumes: `/home/kali/Desktop/splunk_forwarder/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb:/opt/splunkforwarder-9.2.1-78803f08aabb-linux-2.6-amd64.deb`
        - [ ] [Installation Documentation](https://docs.splunk.com/Documentation/Forwarder/9.2.1/Forwarder/Installanixuniversalforwarder#Install_the_universal_forwarder_on_Linux:~:text=the%20CAP_DAC_READ_SEARCH%20capability.-,Install%20on%20Linux,-As%20of%20Splunk)
      - [x] [Simplest implementation](https://splunk.github.io/docker-splunk/EXAMPLES.html#create-standalone-and-universal-forwarder) seems to be adding a Forwarder container in the compose file and configuring it accordingly</details>

Part 3:

- [ ] Compose the virtual pentesting environment
  - [ ] Is everything working properly?
    - [ ] Check Splunk Receiver dashboard for forwarder connections
    - [ ] Login to DVWA, check whether the Database was created
      - [ ] Check Receiver for data regarding `/var/log/apache2/access.log`
- [ ] Create an Alert for `access.log`

- [ ] Follow the Cyber Kill Chain framework
  - [ ] Insert the seven steps below (Recon, Weaponization, Delivery, Exploitation, Installation, C2, Actions on Objectives)
    - [ ] Add specific objectives to complete that are required before moving to the next step