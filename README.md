# Intent
Create a docker container that you can ssh into over port 10385 that can control the host docker daemon.

I'm going to use this to control ResinOS via SSH on a Raspberry Pi

Based on:
- [Docker install instructions for ubuntu](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
- [Dockerize an SSH service](https://docs.docker.com/engine/examples/running_ssh_service/)

# Instructions

- Generate root password for image by running `./setpasswd.sh` and entering a password.
- Build the image with `docker-compose build`.
- At this point, you can delete `passwd.txt`.
- Run with `docker-compose up -d` (`-d` for daemon - otherwise, terminal will be blocked until container is stopped).
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

### SSH Warning
You may see the following warning upon SSH authentication after a full rebuild.

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:lKn+tsamsBZ5zZrFUk3egIiXLzO2q8dyYw35YfEoGYE.
Please contact your system administrator.
Add correct host key in /home/oliver/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/oliver/.ssh/known_hosts:37
ECDSA host key for [localhost]:10385 has changed and you have requested strict checking.
Host key verification failed.
```

This is just because SSH was used to the previous container, and now you're connecting to
a new container at the same address. To remedy the situation, just remove the `[localhost]:10385` line from `~/.ssh/known_hosts`.

