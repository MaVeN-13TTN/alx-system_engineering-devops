# 0x18. Webstack monitoring

## Background Context

"You cannot fix or improve what you cannot measure" is a famous saying in the Tech industry. In the age of the data-ism, monitoring how our Software systems are doing is an important thing. In this project, we will implement one of many tools to measure what is going on our servers.

Web stack monitoring can be broken down into 2 categories:

- **Application monitoring**: getting data about your running software and making sure it is behaving as expected
- **Server monitoring**: getting data about your virtual or physical server and making sure they are not overloaded (could be CPU, memory, disk or network overload)

## Learning Objectives

At the end of this project, you are expected to be able to explain to anyone, without the help of Google:

### General

- Why is monitoring needed
- What are the 2 main area of monitoring
- What are access logs for a web server (such as Nginx)
- What are error logs for a web server (such as Nginx)

## Servers

| Name           | Username | IP             | State   |
| -------------- | -------- | -------------- | ------- |
| 1300052-web-01 | ubuntu   | 18.212.71.220  | running |
| 1300052-web-02 | ubuntu   | 54.165.239.199 | running |
| 1300052-lb-01  | ubuntu   | 44.204.4.83    | running |

## Requirements

### General

- Allowed editors: vi, vim, emacs
- All your files will be interpreted on Ubuntu 16.04 LTS
- All your files should end with a new line
- A README.md file, at the root of the folder of the project, is mandatory
- All your Bash script files must be executable
- Your Bash script must pass Shellcheck (version 0.3.7) without any error
- The first line of all your Bash scripts should be exactly `#!/usr/bin/env bash`
- The second line of all your Bash scripts should be a comment explaining what is the script doing

## Resources

- [What is server monitoring](https://www.sumologic.com/insight/server-monitoring/)
- [What is application monitoring](https://en.wikipedia.org/wiki/Application_performance_management)
- [System monitoring by Google](https://landing.google.com/sre/sre-book/chapters/monitoring-distributed-systems/)
- [Nginx logging and monitoring](https://docs.nginx.com/nginx/admin-guide/monitoring/logging/)

## Tasks

### 0. Sign up for Datadog and install datadog-agent

**mandatory**

For this task head to https://www.datadoghq.com/ and sign up for a free Datadog account. When signing up, you'll have the option of selecting statistics from your current stack that Datadog can monitor for you. Once you have an account set up, follow the instructions given on the website to install the Datadog agent.

#### Requirements:

- Sign up for Datadog - Please make sure you are using the US website of Datadog (https://app.datadoghq.com)
- Use the US1 region
- Install datadog-agent on web-01
- Create an application key
- Copy-paste in your Intranet user profile your DataDog API key and your DataDog application key
- Your server web-01 should be visible in Datadog under the host name XX-web-01
- You can validate it by using this API
- If needed, you will need to update the hostname of your server

**Repo:**

- GitHub repository: alx-system_engineering-devops
- Directory: 0x18-webstack_monitoring
