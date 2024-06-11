# Security Incident Detection and Response with Splunk

## Intention

Orchestrate a containerized environment that can be used for practicing offensive security techniques and gain experience with log monitoring configuration and log analysis.

<details>
    <summary>Containers</summary>

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
- [ ] Decide whether to use PHPIDS in tandem with Splunk

Part 2:

- [ ] Create a compose file
    - [ ] Splunk Indexer/Receiver to collect and visualize data
    - [ ] Configure DVWA's Splunk Forwarder (Universal/Heavy) to monitor:
        - `/var/log/auth.log`, `/var/log/apache2/access.log`, and `/var/log/apache2/error.log`
        - DVWA Port 80 traffic
    - [ ] Figure a way to automate the Forwarder's installation and configuration post composition

Part 3:

- [ ] Compose the virtual pentesting environment
  - [ ] Is everything working properly?
    - [ ] Check Splunk Receiver dashboard for forwarder connections

- [ ] Follow the Cyber Kill Chain framework