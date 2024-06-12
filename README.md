# Security Incident Detection and Response with Splunk

## Intention

Orchestrate a containerized environment that can be used for practicing offensive security techniques and gain experience with log monitoring configuration and log analysis.

<details>
    <summary><u>Containers</u></summary>

  Damn Vulnerable Web App
  
  Splunk
  
</details>

## Objectives

Part 1:

- [ ] Can I use BHIS Rita to find patterns in network traffic for this virtual environment?
- [ ] Should I monitor DNS logs?
- [ ] Can I monitor PHPIDS logs?

- [x] Test the creation and configuration of a Splunk Docker container without using a `compose.yml` file.
- [x] Test the Splunk's dashboard
- [ ] Understand the fine details of Universal Forwarder
- [ ] Understand the fine details of Heavy Forwarder
- [ ] Able to explain the differences between Universal and Heavy Forwarders
- [ ] Is it possible to monitor `/var/log/btmp`, `/var/log/faillog`, `/var/log/lastlog`, `/var/log/wtmp` considering they're binaries?

- [x] Test the creation of DVWA using Docker without a `compose.yml` file.
- [x] Find where DVWA stores access logs
- [x] Find where DVWA stores database logs
- [ ] Decide whether to use PHPIDS in tandem with Splunk

- [ ] Create a script to automate the installation of a Splunk Forwarder
- [ ] Mount the script to DVWA and execute it upon finishing startup

Part 2:

- [ ] Create a compose file
    - [ ] Splunk Indexer/Receiver to collect and visualize data
    - [ ] Configure DVWA's Splunk Forwarder (Universal/Heavy) to monitor:
        - [ ] Authentication Logs: `/var/log/apache2/access.log`, `/var/log/btmp`
        - [ ] Error Logs: `/var/log/apache2/error.log`, `/var/mysql/error.log`
        - [ ] Other Files: `/etc/shadow`
        - [ ] DVWA Port traffic:
          - [ ] 22
          - [ ] 80
          - [ ] 445
          - [ ] 3389
        - [ ] High concurrent CPU usage
        - [ ] Critical disk capacity
    - [ ] Figure a way to automate the Forwarder's installation and configuration post composition
      - [ ] [Simplest implementation](https://splunk.github.io/docker-splunk/EXAMPLES.html#create-standalone-and-universal-forwarder) seems to be adding a Forwarder container in the compose file and configuring it accordingly

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