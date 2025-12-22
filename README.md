# NixOS v.VM

[nix.dev](https://nix.dev/)  
[NixOS](https://nixos.org/manual/nixos/stable/)  
[Appendix A. Configuration Options](https://nixos.org/manual/nixos/stable/options)

## Installazione

`sudo su`

### Partitioning
```console
lsblk # Per controllare i dischi
parted /dev/sdX -- mklabel gpt
parted /dev/sdX -- mkpart root ext4 512MB -4GB
parted /dev/sdX -- mkpart swap linux-swap -4GB 100%
parted /dev/sdX -- mkpart ESP fat32 1MB 512MB
parted /dev/sdX -- set 3 esp on
```
### Formatting
```console
mkfs.ext4 -L nixos /dev/sdX1
mkswap -L swap /dev/sdX2
mkfs.fat -F 32 -n boot /dev/sdX3
```
### Installing
```console
mount /dev/disk/by-label/nixos /mnt
# (for UEFI)
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```
### Config
```console
nixos-generate-config --root /mnt # Crea la base
cd /mnt/etc/nixos
git clone https://github.com/giacomofm/nixos-vm-dev.git
```

Edita: `configuration.nix` (add negli import: `./nixos-vm-dev/os.nix`)

`nixos-install`

Password per l'utente:  
`nixos-enter --root /mnt -c 'passwd giacomo'`

`reboot`

## Upgrading

[Upgrading NixOS](https://nixos.org/manual/nixos/stable/#sec-upgrading)

```console
sudo nixos-rebuild switch --upgrade
```

## Cleaning

`nixos-rebuild list-generations`  
`sudo nix-collect-garbage -d`

## Git Utils

```console
cd /etc/nixos/nixos-vm-dev
git add . && git commit -m "[ma message]" && git push
```
