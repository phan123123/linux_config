#!/usr/bin/env bash

#install python
sudo apt-get install python \
python3 \
python3-pip

#install pwntools
pip3 install pwntools

#install ROPgadget
pip3 install capstone
git clone https://github.com/JonathanSalwan/ROPgadget ~/ROPgadget
sudo python3 ~/ROPgadget/setup.py install

#install one_gadget
sudo apt install ruby -y
sudo gem install one_gadget

#install main_arena
sudo cp ./scripts/main_arena /usr/bin/main_arena
sudo chmod o+x /usr/bin/main_arena

#install checksec
sudo apt-get install checksec -y

#install QEMU:
sudo apt-get install qemu qemu-block-extra qemu-kvm qemu-slof qemu-system \
  qemu-system-arm qemu-system-common qemu-system-mips qemu-system-misc \
  qemu-system-ppc qemu-system-s390x qemu-system-sparc qemu-system-x86 \
  qemu-user qemu-user-binfmt qemu-utils -y

