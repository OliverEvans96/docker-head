Create a docker container that you can ssh into over port 10385 that can control the host docker daemon.

I'm going to use this to control ResinOS via SSH on a Raspberry Pi

Based on:
- [Docker install instructions for ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
- [Dockerize an SSH service](https://docs.docker.com/engine/examples/running_ssh_service/)

Just run `docker-compose up -d`

Then ssh to container via `ssh root@localhost -p 10385` using the password `screencast`. Obviously, this can be configured.
