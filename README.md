# SSH Port Forwarding Proxy

## SECURITY NOTICE
**DO NOT PUBLISH THE BUILT DOCKER IMAGE.**

**YOU MUST BUILD THIS IMAGE BY YOURSELF.**


## Image Build
```shell
docker-compose build --force-rm --no-cache
```

`--force-rm` prevents the intermediate images being cached and reused.

`--no-cache` prevents reusing cached images.


## Practice Usage
1. Decide the username to login. (example: `myuser`)
2. Add your public key to `/authorized_keys/myuser`.
3. Execute `docker-compose up -d`.
4. Execute `ssh -N myuser@localhost -p 12322 -i YOUR_PRIVATE_KEY`.
5. Execute `docker-compose down` to close the ssh server.


## Real Usage
1. Decide the username to login. (example: `myuser`)
2. Add your public key to `/authorized_keys/myuser`.
3. Copy `docker-compose.override.yml.template` to `docker-compose.override.yml` and change the configuration.
4. Execute `docker-compose up -d`.
5. Execute `ssh -N myuser@YOUR_HOSTNAME -p YOUR_PORT -i YOUR_PRIVATE_KEY`.
6. Execute `docker-compose down` to close the ssh server.

Though you can place multiple users in `/authorized_keys` like `/authorized_keys/userA` and `/authorized_keys/userB`,
there may be security issues (example: all users share the network ports).
