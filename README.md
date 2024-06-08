# Security Incident Detection and Response with Splunk

## Intention

Set up a containerized environment that can be used for practicing offensive security techniques and gain experience with log monitoring configuration and log analysis.

<details>
    <summary>Containers</summary>

  Damn Vulnerable Web App

  Ngrok
  
  Splunk
  
</details>

## Roadmap

Part 1:

- [ ] Test the creation and configuration of a Splunk Docker container without using a `compose.yml` file.
- [ ] Test the Splunk's dashboard

- [ ] Test the creation of DVWA using Docker without a `compose.yml` file.
- [ ] Find where DVWA stores access logs
- [ ] Find where DVWA stores database logs

Part 2:

- [ ] Create a compose file
    - [x] Use an Ngrok container to push DVWA to the internet
    - [ ] Splunk to practice log analysis and event monitoring
    - [x] DVWA to hone offensive security techniques

Part 3:

- [ ] Compose the virtual pentesting environment
- [ ] Login to Splunk and create a 'Monitor' for DVWA's logs
