#!/bin/bash

name=$1
os_type=$2
num_cpus=$3
ram=$4
vram=$5
vdisk=$6
sata_name=$7
ide_controller=$8

# Create VM
VBoxManage createvm --name "$name" --ostype "$os_type" --register

# Set CPUs, RAM, and VRAM
VBoxManage modifyvm "$name" --cpus "$num_cpus" --memory "$ram" --vram "$vram"

# Set virtual disk
vdisk_file="/home/jose/Challenge-1/$name.vdi"
VBoxManage createhd --filename "$vdisk_file" --size "$vdisk" --variant Standard

# Set SATA
VBoxManage storagectl "$name" --name "$sata_name" --add sata --bootable on

# Attach Virtual Disk to SATA
VBoxManage storageattach "$name" --storagectl "$sata_name" \
    --port 0 --device 0 --type hdd --medium "$vdisk_file"

# Set IDE controller
VBoxManage storagectl "$name" --name "$ide_controller" --add ide

# Show VM
VBoxManage showvminfo "$name"

