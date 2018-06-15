#######################################################################
# Provision PaaS stack via Cloud Stack templates powered by PSM CLI.
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
#######################################################################
#################### Reading and validating passed parameters:

if [ ! -f ssh/myPublic_sshKey.pub ]; then
    echo "**************************************** Error: "
    echo " Public Key under PROJECT_HOME/ssh/myPublic_sshKey.pub does not exist,"
    echo " please create this file with your public key to be used during provisioning..."
    echo "****************************************"
    exit 1
else
    # Altering current Public Key by escaping each / with \/ for passing parsing purposes:
    cp ssh/myPublic_sshKey.pub ssh/temp_publicKey.pub
    sed -i "s/\//\\\\\//g" ssh/temp_publicKey.pub
    publicKey=`cat ssh/temp_publicKey.pub`
    rm ssh/temp*
fi

if [ "$#" -ne 6 ]; then

    echo "**************************************** Error: "
    echo " Illegal number of parameters."
    echo " Usage: [stackPassword DBAPassword WLPassword idDomainName stackName stackTemplateVersion wc]"
    echo "****************************************"
    exit 1
    
fi

stackPassword=$1
DBAPassword=$2
WLPassword=$3
idDomainName=$4
stackName=$5
stackTemplateVersion=$6
wc=$7

#######################################################################
#######################################################################
#################### Setting up PSM Stack Cloud Stack template:
# Creating a custom copy from template:
cp templates/${stackName}-template.yaml templates/temp_${stackName}-template.yaml
# Setting Public Key in PSM JSON file:
sed -i "s/@PUBLIC_KEY_GOES_HERE@/${publicKey}/g" templates/temp_${stackName}-template.yaml
# Setting Stack Password in PSM JSON file:
sed -i "s/@STACK_PASSWORD_GOES_HERE@/${stackPassword}/g" templates/temp_${stackName}-template.yaml
# Setting DBA Password in PSM JSON file:
sed -i "s/@DBA_PASSWORD_GOES_HERE@/${DBAPassword}/g" templates/temp_${stackName}-template.yaml
# Setting Weblogic Admin Password in PSM JSON file:
sed -i "s/@WL_PASSWORD_GOES_HERE@/${WLPassword}/g" templates/temp_${stackName}-template.yaml
# Setting Environment stackName Name:
sed -i "s/@APP_NAME_GOES_HERE@/${stackName}/g" templates/temp_${stackName}-template.yaml
# Setting Identity Domain Name to setup Storage API Path:
sed -i "s/@ID_DOMAIN_NAME_GOES_HERE@/${idDomainName}/g" templates/temp_${stackName}-template.yaml
# Setting Template Name:
sed -i "s/@TEMPLATE_NAME@/${stackName}-template/g" templates/temp_${stackName}-template.yaml
# Setting Template Version:
sed -i "s/@TEMPLATE_VERSION@/${stackTemplateVersion}/g" templates/temp_${stackName}-template.yaml

#######################################################################
#######################################################################
#################### Calling PSM to provision Stack via Cloud Stack

# Verifying Cloud Stack template
echo "**** Verifying Cloud Stack Template"
stackValidation=`psm stack validate-template -f templates/temp_${stackName}-template.yaml | grep message | awk -F: '{print $2}'`
echo "*** Cloud Stack template verification. Message is [${stackValidation}]"

# Upserting template:
echo "*** Publishing Stack Cloud Template"
psm stack delete-template -n ${stackName}-template -v $templateVersion
psm stack import-template -f templates/temp_${stackName}-template.yaml

#Creating Stack:
echo "*** Creating Cloud Stack"
psm stack create -n "${stackName}" -t ${stackName}-template -d "${stackName}" -f ROLLBACK -wc ${wc}



echo "**************************\
 You can review the Stack Provisioning status with: psm stack operation-status -j [JOB_ID]"
echo "**************************"



# Removing all temp files:
#rm templates/temp*
