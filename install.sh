#!/bin/sh

# Automated script to install my env configs

# Clone dotfiles
if [ $# -gt 0 ]
  then
    SCRIPT_DIR=$1
  else
    SCRIPT_DIR=~/.myenv
fi

#nix-shell -p git --command "git clone https://github.com/volceri/.myenv $SCRIPT_DIR" || exit

# Generate hardware config for new system
echo "Generating hardware config for new system"
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/system/hardware-configuration.nix || exit

# Check if uefi or bios
if [ -d /sys/firmware/efi/efivars ]; then
    echo "Using uefi"
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"uefi\";/" $SCRIPT_DIR/flake.nix || exit
else
    sed -i "0,/bootMode.*=.*\".*\";/s//bootMode = \"bios\";/" $SCRIPT_DIR/flake.nix || exit
    grubDevice=$(findmnt / | awk -F' ' '{ print $2 }' | sed 's/\[.*\]//g' | tail -n 1 | lsblk -no pkname | tail -n 1 ) || exit
    sed -i "0,/grubDevice.*=.*\".*\";/s//grubDevice = \"\/dev\/$grubDevice\";/" $SCRIPT_DIR/flake.nix || exit
fi

# Patch flake.nix with different username/name and remove email by default
# sed -i "0,/volceri/s//$(whoami)/" $SCRIPT_DIR/flake.nix
# sed -i "0,/Volceri\sD\'Avila/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" $SCRIPT_DIR/flake.nix
# sed -i "s/volceri.davila@gmail.com//" $SCRIPT_DIR/flake.nix
# sed -i "s+~/.myenv+$SCRIPT_DIR+g" $SCRIPT_DIR/flake.nix

# Open up editor to manually edit flake.nix before install
if [ -z "$EDITOR" ]; then
    EDITOR=nano;
fi
echo "Using $EDITOR to edit flake.nix"
$EDITOR $SCRIPT_DIR/flake.nix || exit

# Permissions for files that should be owned by root
# sudo $SCRIPT_DIR/harden.sh $SCRIPT_DIR

echo "Adding changes to Git"
git add *

# Rebuild system
echo "Rebuilding the system"
sudo nixos-rebuild switch --flake $SCRIPT_DIR#system  || exit

# Install and build home-manager configuration
nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake $SCRIPT_DIR#user
