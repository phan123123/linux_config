#!/usr/bin/env bash

#install python
sudo apt-get install python \
python3 \
python3-pip

#install pwntools
pip3 install pwntools

#install ROPgadget
pip3 install capstone
git clone https://github.com/JonathanSalwan/ROPgadget ~
sudo python3 ~/ROPgadget/setup.py install

#install checksec
sudo apt-get install checksec -y

#install QEMU:
sudo apt-get install qemu qemu-block-extra qemu-kvm qemu-slof qemu-system \
  qemu-system-arm qemu-system-common qemu-system-mips qemu-system-misc \
  qemu-system-ppc qemu-system-s390x qemu-system-sparc qemu-system-x86 \
  qemu-user qemu-user-binfmt qemu-utils -y

