# cblmarinerdemo-cross-build
Using qemu emulation to build cblmarinerdemo

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
root@<container-id>:/# cd /tmp
root@<container-id>:/tmp# bash configure_buildenv.sh
```
