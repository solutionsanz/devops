#######################################################################
# Decommission OIC and DBCS via PSM CLI commands
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
#######################################################################
#################### Reading and validating passed parameters:

if [ ! -f ssh/publicKey.pub ]; then
    echo "**************************************** Error: "
    echo " Public Key under PROJECT_HOME/ssh/publicKey.pub does not exist,"
    echo " please create this file with your public key to be used during provisioning..."
    echo "****************************************"
    exit 1
else
    # Altering current Public Key by escaping each / with \/ for passing parsing purposes:
    cp ssh/publicKey.pub ssh/temp_publicKey.pub
    sed -i "s/\//\\\\\//g" ssh/temp_publicKey.pub
    publicKey=`cat ssh/temp_publicKey.pub`
    rm ssh/temp*
fi

if [ "$#" -ne 3 ]; then

    echo "**************************************** Error: "
    echo " Illegal number of parameters."
    echo " Usage: [oicPassword DBAPassword WLPassword]"
    echo "****************************************"
    exit 1
    
fi

oicPassword=$1
DBAPassword=$2
WLPassword=$3

exit 0

#######################################################################
#################### Setting up PSM DBCS target environment variables
# Creating a custom copy from template:
cp templates/psm_IntegrationCloud_Dev_DBCS_Template.json templates/temp_psm_IntegrationCloud_Dev_DBCS.json
# Setting Public Key in PSM JSON file:
sed -i "s/@PUBLIC_KEY_GOES_HERE@/${publicKey}/g" templates/temp_psm_IntegrationCloud_Dev_DBCS.json
# Setting OIC Password in PSM JSON file:
sed -i "s/@OIC_PASSWORD_GOES_HERE@/${oicPassword}/g" templates/temp_psm_IntegrationCloud_Dev_DBCS.json
# Setting DBA Password in PSM JSON file:
sed -i "s/@DBA_PASSWORD_GOES_HERE@/${DBAPassword}/g" templates/temp_psm_IntegrationCloud_Dev_DBCS.json
#######################################################################
#################### Setting up PSM OIC target environment variables
# Creating a custom copy from template:
cp templates/psm_IntegrationCloud_Dev_Template.json templates/temp_psm_IntegrationCloud_Dev.json
# Setting Public Key in PSM JSON file:
sed -i "s/@PUBLIC_KEY_GOES_HERE@/${publicKey}/g" templates/temp_psm_IntegrationCloud_Dev.json
# Setting OIC Password in PSM JSON file:
sed -i "s/@OIC_PASSWORD_GOES_HERE@/${oicPassword}/g" templates/temp_psm_IntegrationCloud_Dev.json
# Setting DBA Password in PSM JSON file:
sed -i "s/@DBA_PASSWORD_GOES_HERE@/${DBAPassword}/g" templates/temp_psm_IntegrationCloud_Dev.json
# Setting Weblogic Admin Password in PSM JSON file:
sed -i "s/@WL_PASSWORD_GOES_HERE@/${WLPassword}/g" templates/temp_psm_IntegrationCloud_Dev.json

#######################################################################
#################### Calling PSM to provision DBCS and OIC

#psm dbcs create-service -c templates/temp_psm_IntegrationCloud_Dev_DBCS.json

psm InterationCloud create-service -c templates/temp_psm_IntegrationCloud_Dev.json

# Removing all temp files:
rm templates/temp*
