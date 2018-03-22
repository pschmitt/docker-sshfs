# sshfs for CoreOS Container Linux

## Usage

The following command will mount `root@10.0.0.10:/data` to `$PWD/mnt`:

```bash
docker run -it --rm \
    --cap-add SYS_ADMIN \
    --device /dev/fuse \
    --name sshfs \
    -e UID=1000 \
    -e GID=100 \
    -v $PWD/mnt:/mount:shared \
    -v ~/.ssh/id_ed25519:/config/id_ed25519:ro \
    pschmitt/sshfs \
    root@10.0.0.10:/data
```

## Using a jump server

Check out the following `docker-compose.yaml` that mounts 10.127.0.11's `/data` to `$PWD/mnt`, via `home.example.com`.

```yaml
version: '3'

services:
  jump-server:
    image: pschmitt/ssh
    container_name: jump-server
    # restart: unless-stopped
    volumes:
      - ./config:/config/.ssh:ro
    command:
      -o UserKnownHostsFile=/dev/null
      -o StrictHostKeyChecking=no
      -o ExitOnForwardFailure=yes
      -TN -L "*:22222:10.127.0.11:22"
      root@home.example.com

  sshfs:
    image: pschmitt/sshfs
    depends_on:
      - jump-server
    # restart: unless-stopped
    cap_add:
      - SYS_ADMIN
    devices:
      - /dev/fuse:/dev/fuse
    environment:
      - PORT=22222
      - UID=500
      - GID=1000
    volumes:
      - ./config/id_ed25519:/config/id_ed25519:ro
      - ./mnt:/mount:shared
    command: pschmitt@jump-server:/data
```


## Authentification

### Password auth (discouraged)

Set the remote's password via the `SSHPASS` env var.

### RSA keys

Use the `IDENTITY_FILE` env variable to set the name of the key. It defaults to
`/config/id_ed25519`. For an RSA key it should be `/config/id_rsa`.


## Options

### Different port

You can use a alternate port by setting the `PORT` env var.

### Compression

TODO: Not implemented yet.
