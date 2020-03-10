## Building your own junos router with cRPD and linuxkit

https://www.juniper.net/documentation/en_US/crpd/topics/task/multi-task/crr-linux-server-install.html

## What is cRPD?

https://www.youtube.com/watch?v=VYyLYr0rNg0

## What is Linuxkit?

## Why combine them?

cRPD is the best parts of Junos (RPD, MGD) disaggregated and packaged in a lightweight docker container. However it needs an OS.

Linuxkit allows us to build a linux distribution that includes EXACTLY what we need, and no more. It's a match made in heaven.

## cRPD Steps

Need to follow the instructions online to download the image and run docker import or whatever. Make sure
the version in the Dockerfile matches what you downloaded.

root@crpd01:/# sudo  mv /etc/ssh/ssh_config /etc/ssh/sshd_config
root@crpd01:/# service ssh restart
/etc/ssh/sshd_config: line 20: Bad configuration option: Host
/etc/ssh/sshd_config: line 51: Bad configuration option: SendEnv
/etc/ssh/sshd_config: line 52: Bad configuration option: HashKnownHosts

We incorporated all the fixes into a dockerfile, so run this:

```
docker build -t crpd-fixes .
```

Our linuxkit build will reference this image.

## LinuxKit Steps

### Build the tool

https://github.com/linuxkit/linuxkit#build-the-linuxkit-tool

You need Go installed since there are no precompiled binaries for the project

```
go get -u github.com/linuxkit/linuxkit/src/cmd/linuxkit
```

### Package to a hypervisor?

https://github.com/linuxkit/linuxkit/blob/master/docs/platform-qemu.md

qemu-kvm

sudo usermod -a -G kvm mierdin
newgrp mierdin


None of the above worked, so I had to run as sudo:

```
(move binary from GOPATH into /usr/bin or something)
sudo linuxkit build -format=qcow2-bios crpd.yml 
```


```
random_mac () {
    hexchars="0123456789abcdef"
    end=$( for i in {1..6} ; do echo -n ${hexchars:$(( $RANDOM % 16 )):1} ; done | sed -e 's/\(..\)/:\1/g' )

    # QEMU OUI space - important to use this
    echo 52:54:00$end
}


```



ctr -n services.linuxkit c  list



# Firecracker Ignite

I looked at this but it seems to be fairly opinionated about how it runs things. It's simpler than linuxkit, but it seems
that I don't have the ability to export a VM image that I can then run myself in a traditional hypervisor.

This tight coupling doesn't really give me what I want today. YMMV.
