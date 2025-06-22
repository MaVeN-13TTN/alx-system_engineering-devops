# 0x09. Web infrastructure design

This project focuses on designing and understanding web infrastructure components through diagrams and explanations.

## Learning Objectives

- Draw diagrams covering web stack infrastructure
- Explain what each component is doing
- Explain system redundancy
- Understand key acronyms: LAMP, SPOF, QPS

## Tasks

### 0. Simple web stack

Design a one server web infrastructure that hosts a website reachable via www.foobar.com

### Requirements

- 1 server
- 1 web server (Nginx)
- 1 application server
- 1 application files (code base)
- 1 database (MySQL)
- 1 domain name foobar.com configured with www record pointing to server IP 8.8.8.8

### 1. Distributed web infrastructure

Design a three server web infrastructure that hosts www.foobar.com with load balancing and database clustering

### Requirements

- 2 additional servers
- 1 web server (Nginx)
- 1 application server
- 1 load balancer (HAProxy)
- 1 set of application files (code base)
- 1 database (MySQL)

## Files

- `0-simple_web_stack`: Simple web stack infrastructure design
- `1-distributed_web_infrastructure`: Distributed web infrastructure with load balancing
