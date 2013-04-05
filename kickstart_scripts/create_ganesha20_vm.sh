virt-install \
-n centos-sonas \
-r 2048 \
--vcpus=1 \
--os-variant=rhel6 \
--accelerate \
-v \
-w bridge:virbr0 \
--disk path=/mnt/virtstorage/centos.img,size=8.5 \
-l http://mirror.clarkson.edu/centos/6.4/os/x86_64/ \
--graphics vnc \
-x "ks=https://raw.github.com/bongiojp/hudson_build_scripts/master/kickstart_scripts/ganesha20_ks.cfg NOVERIFYSSL ksdevice=eth0 ip=192.168.122.213 netmask=255.255.255.0 dns=192.168.122.120 gateway=192.168.122.1"


# -nographics \
# http://mirror.clarkson.edu/centos/6.4/isos/x86_64/ \
