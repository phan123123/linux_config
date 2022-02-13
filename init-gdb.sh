#!/usr/bin/env bash

echo "[+] Checking for required dependencies..."
if command -v git >/dev/null 2>&1 ; then
    echo "[-] Git found!"
else
    echo "[-] Git not found! Aborting..."
    echo "[-] Please install git and try again."
fi

if [ -f ~/.gdbinit ] || [ -h ~/.gdbinit ]; then
    echo "[+] backing up gdbinit file"
    cp ~/.gdbinit ~/.gdbinit.back_up
fi

# download peda and decide whether to overwrite if exists
if [ -d ~/peda ] || [ -h ~/.peda ]; then
    echo "[-] PEDA found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_peda

    if [ $skip_peda = 'n' ]; then
        rm -rf ~/peda
        git clone https://github.com/longld/peda.git ~/peda
    else
        echo "PEDA skipped"
    fi
else
    echo "[+] Downloading PEDA..."
    git clone https://github.com/longld/peda.git ~/peda
fi


# download pwndbg
if [ -d ~/pwndbg ] || [ -h ~/.pwndbg ]; then
    echo "[-] Pwndbg found"
    read -p "skip download to continue? (enter 'y' or 'n') " skip_pwndbg

    if [ $skip_pwndbg = 'n' ]; then
        rm -rf ~/pwndbg
        git clone https://github.com/pwndbg/pwndbg.git ~/pwndbg

        cd ~/pwndbg
        ./setup.sh
    else
        echo "Pwndbg skipped"
    fi
else
    echo "[+] Downloading Pwndbg..."
    git clone https://github.com/pwndbg/pwndbg.git ~/pwndbg

    cd ~/pwndbg
    ./setup.sh
fi


# download gef
echo "[+] Downloading GEF..."
git clone https://github.com/hugsy/gef.git ~/gef


echo "[+] Setting .gdbinit..."
sudo echo 'define init-peda
source ~/peda/peda.py
end
document init-peda
Initializes the PEDA (Python Exploit Development Assistant for GDB) framework
end

define init-pwndbg
source ~/pwndbg/gdbinit.py
end
document init-pwndbg
Initializes PwnDBG
end

define init-gef
source ~/gef/gef.py
end
document init-gef
Initializes GEF (GDB Enhanced Features)
end' 1>~/.gdbinit

echo '#!/bin/sh
exec gdb -q -ex init-gef "$@"' 1>gdb-gef

echo '#!/bin/sh
exec gdb -q -ex init-peda "$@"' 1>gdb-peda

echo '#!/bin/sh
exec gdb -q -ex init-pwndbg "$@"' 1>gdb-pwndbg
echo "[+] Setting permissions..."
chmod +x gdb-*
echo "[-] Permission denied"
sudo cp gdb-* /usr/bin/
sudo rm gdb-*
echo "[+] Done"

echo "Install extend for GEF"
git clone https://github.com/hugsy/gef-extras ~/gef-extras
gdb-gef -ex "gef config gef.extra_plugins_dir ~/gef-extras/scripts" -ex "gef config pcustom.struct_path ~/gef-extras/structs" -ex "gef config syscall-args.path ~/gef-extras/syscall-tables" -ex "gef config context.libc_args True" -ex "gef config context.libc_args_path ~/gef-extras/glibc-function-args" -ex "gef save" -ex "q"

# install engines
pip3 install keystone-engine
pip3 install ropper
