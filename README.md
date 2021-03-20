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


## Port Pool Concept
- https://github.com/aoirint/SSHPortForwardingProxyClient

This repository can be used as a port proxy (or a port pool).

- `server.example`: 1 computer in a NAT network
- `proxy.example`: 1 computer with a global IP address (like VPS, EC2)
- `client.example`: 1 computer in some network

Here, you want to connect to `server.example:22` from `client.example`.
However, `server.example` is in a NAT network and cannot open any port with a global IP.

First, connect `server.example` to `proxy.example` via SSH with a remote port forwarding which transfers `proxy.example:32122` to `server.example:22`.

Next, connect `client.example` to `proxy.example` via SSH with a local port forwarding which transfers `client.example:32122` to `proxy.example:32122`.

Then, `ssh client.example -p 32122` is now what you want.

In `server.example`, use [SSHPortForwardingProxyClient](https://github.com/aoirint/SSHPortForwardingProxyClient) which keeps a connection to `proxy.example`.

In `proxy.example`, use [SSHPortForwardingProxy](https://github.com/aoirint/SSHPortForwardingProxy) (this repository) which serves a forwarded port from `server.example`.

In `client.example`, use your `ssh` command like below.

```
# Connect to proxy
ssh proxy.example -N -L "127.0.0.1:32122:127.0.0.1:32122"

# In another terminal (keeping the proxy connection),
# Connect to `server.example:22`
ssh localhost -p 32122
```
