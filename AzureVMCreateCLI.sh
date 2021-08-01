#!/bin/sh
#
# Simple script to generate VM on Azure.
# This script expects two input, number of VMs and Azure Resource Group Name.
#

# Number of VMs to be created
vmCount=$1

# Azure Resourse Group Name
resourceGroupName=$2


# The wait time in seconds between spinning up instance
waitTime=5

# Capture the VMs creation information to a file
outputFile1=`pwd`/AzureVMs-$vmCount-Vms-`date +%F-$$`.txt
outputFile2=`pwd`/AzureVMs-$vmCount-Vms-Names-`date +%F-$$`.txt

# Azure CLI parameters setting to match each specific setup
vmNamePrefix1="TyWestUScpuA1-VM-"
vmNamePrefix2="TyEastUS-VM-"
vmNamePrefix3="TyCentraluse-VM-"
vmNamePrefix4="TyWestEuro-VM-"

imageName="UbuntuLTS"
#vmSize="Standard_B1s"
vmSize="Standard_A1_v2"
Username="qa-admin"
Password="Aristo12345!"

vnetname1="qawestus"
vnetname2="qaeastus"
vnetname3="qacentralus"
vnetname4="qawesteuro"

RG1="qawestus"
RG2="qaeastus"
RG3="qacentralus"
RG4="qawesteuro"

storageType="Standard_LRS"

# Start here
#
# Create Azure VMs

count=1
#date >> $outputFile
#printf "Number of the request VMs ==> $vmCount\n" >> $outputFile


while [ $count -le $vmCount ]
do
    echo "Create Azure VM $count/$vmCount for $RG1 Resource Group. VM Name: $vmNamePrefix1$imageName-$count"
    az vm create -g $RG1 -n $vmNamePrefix1-$count --image $imageName --no-wait --size $vmSize --admin-username $Username --admin-password $Password --location "West US" --vnet-name $vnetname1 --subnet default  >> $outputFile1
    printf "vmName ==> $vmNamePrefix1-$count\n" >> $outputFile2
    count=$(($count + 1))
    sleep $waitTime
    echo "----- sleep for $waitTime second -----"
done
#date >> $outputFile

