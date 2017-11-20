![Build Status](https://travis-ci.org/HappyPathway/BootStrap.svg?branch=master)

# BootStrap
![Boot Strap Diagram](assets/bootstrap.png?raw=true "BootStrap")

## Purpose of Project
This project aims to help new projects by pre-configuring a Deployment pipeline that will read config files from specific locations in project repositories. The output of this project will be both an AWS AMI and a Vagrant VM. 

Users of this service will be able to spin up an instance, and after providing a few key configuration details a Docker swarm will be configured, upgraded, and scaled based off of config files in the repo. 
