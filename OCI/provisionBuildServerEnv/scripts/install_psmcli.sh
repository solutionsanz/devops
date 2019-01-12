sudo apt-get update
echo "*********************** Setting up Environment for PSM - CLI"
echo "****************** Installed Python version"
python3 -V
echo "****************** Installing Python Pip"
sudo apt-get install python3-pip -y
echo "****************** Downloading PSM CLI"
# This script is expected to receive the following variables in this specif order: ociUser, ociPasswd, idDomain.
user=$1
passwd=$2
idDomain=$3
sudo curl -X GET -u $user:$passwd -H X-ID-TENANT-NAME:$idDomain https://psm.us.oraclecloud.com/paas/core/api/v1.1/cli/$idDomain/client -o psmcli.zip
sudo -H pip3 install -U psmcli.zip

