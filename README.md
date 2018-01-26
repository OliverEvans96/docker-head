# Intent
Create a docker container that you can ssh into over port 10385 that can control the host docker daemon.

I'm going to use this to control ResinOS via SSH on a Raspberry Pi

Based on:
- [Docker install instructions for ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
- [Dockerize an SSH service](https://docs.docker.com/engine/examples/running_ssh_service/)

# Instructions

- Generate root password for image by running `./setpasswd.sh` and entering a password.
- Build the image with `docker-compose build`
- Run with `docker-compose up -d` (`-d` for daemon - otherwise, terminal will be blocked until container is stopped)
- Connect with `ssh root@localhost -p 10385`. Enter the root password you set previously.

# Misc.

### Change port
To change the SSH port, modify the ports line in `docker-compose.yaml`.
For example, to use port 12345, you would use:
```
ports:
    - "12345:22"
```

### Change Password
To change the password without rebuilding the entire image:
- Rerun `./setpasswd.sh`
- Uncomment or recomment the `RUN true` line in `docker-compose.yaml`
- Then do `docker-compose build` and only the last few commands will be rerun.
