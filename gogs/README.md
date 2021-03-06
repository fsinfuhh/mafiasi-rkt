% Gogs - Go Git Service

UID: 2001

Ports:
- web: 3005
- ssh: 3006

Mountpoints:
- config
- storage
- log


# Initial steps:
```sh
mkdir -p /opt/config/gogs /var/log/gogs /srv/gogs
cp $CONFIG_DIR/app.ini /opt/config/gogs/app.ini
vim !$ # Set options -- there will be a setup page on first run, too.
chown 2001:nogroup /opt/config/gogs /opt/config/gogs/app.ini /var/log/gogs /srv/gogs
```

The LDAP settings can be configured via the Web interface.

# How to run:

## Option 1: SSH-Port will be forwarded to the ssh daemon of the container (3006).
```sh
rkt run --port=web:3005 --port=ssh:3006 --volume storage,kind=host,source=/srv/gogs --volume config,kind=host,source=/opt/config/gogs --volume log,kind=host,source=/var/log/gogs --debug --interactive --dns=134.100.9.61 rkt.mafiasi.de/gogs
```

## Option 2: The host runs a sshd that will accept ssh connections and forwards the data transparently to the ssh daemon of the container (22):

Additional setup:
```sh
# Set DISABLE_SSH = true in config file
adduser --home $GOGS_STORAGE/gituser --shell $GOGS_STORAGE/gogs-shell --uid 2001 gogs
su -c "ssh-keygen -t ed25519;" gogs
cp gogs-shell $GOGS_STORAGE/gogs-shell
```

Run:
```sh
rkt run --port=web:3005 --volume storage,kind=host,source=/srv/gogs --volume config,kind=host,source=/opt/config/gogs --volume log,kind=host,source=/var/log/gogs --debug --interactive --dns=134.100.9.61 rkt.mafiasi.de/gogs
```


# Trivia:
Can be run with rkt.mafiasi.de/redis.
