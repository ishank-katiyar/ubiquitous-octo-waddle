# sync timedate

timedatectl set-ntp true

# check timedate
timedatectl status


# DISK PARTITION STARTED
# check disk

fdisk -l

# start

fdisk "yourdisk without quotes" # example fdisk /dev/sda

m # help
g # gpt partition
n # add partition
# efi partition
1
enter
+550M

# swap partition
n
2
enter
+2G # choose wisely (for main machine use atlest as RAM | minimun 20% of RAM)

# main partition
n
3
enter
enter

# change partition type
t

# of efi file system
1
1 #efi file system

# of swap partition
t
2
19 # linux swap

# exit partition and exit fdisk
w 



# make file system

#efi partition
mkfs.fat -F32 /dev/sda1

# swap partition
mkswap /dev/sda2
swapon /dev/sda2

# main partition
mkfs.ext4 /dev/sda3



# mount main partition
mount /dev/sda3 /mnt



# install base system for arch
pacstrap /mnt base linux linux-firmware # about 400mb download, watch anime


# create fstab file
genfstab -U /mnt >> /mnt/etc/fstab


# chroot into main machine
arch-chroot /mnt # Hurray!!


# sync time
ln -sf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime


# sync hardware clock
hwclock --systohc

# install neovim 
pacman -S neovim

# edit /etc/locale.gen
nvim /etc/locale.gen # uncomment 'en_US.UTF-8 UTF-8'
locale-gen # takes 2s


# set hostname
nvim /etc/hostname # write ishank

nvim /etc/hosts # paste next 3 lines
127.0.0.1	localhost
::1		localhost
127.0.1.1	myhostname.localdomain	myhostname

# set password for root
passwd

#add user
useradd -m ishank

# add password for user ishank
passwd ishank

# add groups
usermod -aG wheel,audio,video,optical,storage ishank

#install sudo
pacman -S sudo

EDITOR=nvim visudo #Uncomment line %wheel ALL=(ALL) ALL


#install grub
pacman -S grub

#install some more packages
pacman -S efibootmgr dosfstools os-prober mtools

#something like mounting
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI #efi partition

# actually installing grub
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg


#install networkmanager git
pacman -S networkmanager git

systemctl enable NetworkManager

exit

umount -l /mnt

# install some more packages
sudo pacman -S xf86-video-fbdev xorg xorg-xinit feg alacritty firefox picom base-devel

# install AUR
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd

# install window manager
sudo pacman -S xmonad xmonad-contrib

# copy file
cp /etc/X11/xinit/xinitrc /home/ishank/.xinitrc
nvim .xinitrc # comment last 4 lines and write exec xmonad

sudo reboot # login and run command startx


# remember to edit xmonad.hs

first install nvidia from https://howto.lintel.in/install-nvidia-arch-linux/
use xrandr to make screen resolution 1920x1080
https://askubuntu.com/questions/918707/cant-change-desktop-resolution-size-1920x1080-not-found-in-available-modes
