# cblmarinerdemo-cross-build
Using qemu emulation to build cblmarinerdemo


# Machine prereqs
On your host Linux machine, create/edit /etc/docker/daemon.json and add the following lines

Note: The following change will affect ALL of your current container images. After making this change, you will need to re-download previous container images. Note that we are explicitly setting container image basesize to 50G. The default value for device mapper images is 10GB, which is insufficient to build all of CBL-Mariner 1.0. When changing this value, you will need to remove any previously cached container images. Otherwise they will retain the previous devicemapper base size value.

```
{
        "storage-driver": "devicemapper",
        "storage-opts": [
                "dm.basesize=50G"
        ]
}
```

# Run 
clone repo and from within repo run the following

Setup docker container
```
$ docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```
```
# The following will take several minutes
$ docker build -t cblmarinerdemoaarch64 .
$ docker run -v /dev:/dev --privileged -it cblmarinerdemoaarch64 /bin/bash
```
You now should be in the root of the container
root@<container-id>:/#

Setup build env
``` 
#This will take several minutes
root@<container-id>:/# bash configure_buildenv.sh
```
