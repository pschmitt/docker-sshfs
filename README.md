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
