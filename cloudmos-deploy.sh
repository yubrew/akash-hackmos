---
version: "2.0"

services:
  app:
    image: ubuntu:22.04
    env:
      - 'SSH_PUBKEY=ssh-rsa AAAABxxxxx some@email.com'
    command:
      - "sh"
      - "-c"
    args:
      - 'apt-get update;
      apt-get install -y --no-install-recommends -- ssh speedtest-cli netcat-openbsd curl wget ca-certificates jq less iproute2 iputils-ping vim bind9-dnsutils nginx build-essential;
      apt --no-install-recommends -y install curl
      
      mkdir -p -m0755 /run/sshd;
      mkdir -m700 ~/.ssh;
      echo "$SSH_PUBKEY" | tee ~/.ssh/authorized_keys;
      chmod 0600 ~/.ssh/authorized_keys;
      ls -lad ~ ~/.ssh ~/.ssh/authorized_keys;
      md5sum ~/.ssh/authorized_keys;
      exec /usr/sbin/sshd -D'
    expose:
      - port: 80
        as: 80
        to:
          - global: true
      - port: 22
        as: 22
        to:
          - global: true
      - port: 4000
        as: 4000
        to:
          - global: true
      - port: 4001
        as: 4001
        to:
          - global: true
      - port: 4002
        as: 4002
        to:
          - global: true
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 4
        memory:
          size: 16Gi
        storage:
          size: 150Gi
        gpu:
          units: 1
          attributes:
            vendor:
              nvidia:
                - model: a100
  placement:
    akash:
      attributes:
        host: akash
      pricing:
        app:
          denom: uakt
          amount: 1000000

deployment:
  app:
    akash:
      profile: app 
      count: 1