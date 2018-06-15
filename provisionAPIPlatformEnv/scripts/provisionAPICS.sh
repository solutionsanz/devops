#######################################################################
# Provision APICS and DBCS via PSM CLI commands
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

if [ "$#" -ne 5 ]; then

    echo "**************************************** Error: "
    echo " Illegal number of parameters."
    echo " Usage: [apicsPassword DBAPassword WLPassword prefix idDomainName]"
    echo "****************************************"
    exit 1
    
fi

apicsPassword=$1
DBAPassword=$2
WLPassword=$3
app=$4
idDomainName=$5

#######################################################################
#################### Setting up PSM DBCS target environment variables
# Creating a custom copy from template:
cp templates/psm_APICS_Dev_DBCS_Template.json templates/temp_psm_APICS_Dev_DBCS.json
# Setting Public Key in PSM JSON file:
sed -i "s/@PUBLIC_KEY_GOES_HERE@/${publicKey}/g" templates/temp_psm_APICS_Dev_DBCS.json
# Setting APICS Password in PSM JSON file:
sed -i "s/@APICS_PASSWORD_GOES_HERE@/${apicsPassword}/g" templates/temp_psm_APICS_Dev_DBCS.json
# Setting DBA Password in PSM JSON file:
sed -i "s/@DBA_PASSWORD_GOES_HERE@/${DBAPassword}/g" templates/temp_psm_APICS_Dev_DBCS.json
# Setting Environment App Name:
sed -i "s/@APP_NAME_GOES_HERE@/${app}/g" templates/temp_psm_APICS_Dev_DBCS.json
# Setting Identity Domain Name to setup Storage API Path:
sed -i "s/@ID_DOMAIN_NAME_GOES_HERE@/${idDomainName}/g" templates/temp_psm_APICS_Dev_DBCS.json


#######################################################################
#################### Setting up PSM APICS target environment variables
# Creating a custom copy from template:
cp templates/psm_APICS_Dev_Template.json templates/temp_psm_APICS_Dev.json
# Setting Public Key in PSM JSON file:
sed -i "s/@PUBLIC_KEY_GOES_HERE@/${publicKey}/g" templates/temp_psm_APICS_Dev.json
# Setting APICS Password in PSM JSON file:
sed -i "s/@APICS_PASSWORD_GOES_HERE@/${apicsPassword}/g" templates/temp_psm_APICS_Dev.json
# Setting DBA Password in PSM JSON file:
sed -i "s/@DBA_PASSWORD_GOES_HERE@/${DBAPassword}/g" templates/temp_psm_APICS_Dev.json
# Setting Weblogic Admin Password in PSM JSON file:
sed -i "s/@WL_PASSWORD_GOES_HERE@/${WLPassword}/g" templates/temp_psm_APICS_Dev.json
# Setting Environment App Name:
sed -i "s/@APP_NAME_GOES_HERE@/${app}/g" templates/temp_psm_APICS_Dev.json
# Setting Identity Domain Name to setup Storage API Path:
sed -i "s/@ID_DOMAIN_NAME_GOES_HERE@/${idDomainName}/g" templates/temp_psm_APICS_Dev.json

#######################################################################
#################### Calling PSM to provision DBCS and APICS

psm dbcs create-service -c templates/temp_psm_APICS_Dev_DBCS.json > templates/temp_${app}_psm_dbcs.out
dbcsJobId="NA"
dbcsJobId=`cat templates/temp_${app}_psm_dbcs.out | awk -F: '{print $2}' | awk '{$1=$1;print}'`

# Get DBCS Job Id:
echo "*** DBCS JobID is [${dbcsJobId}]"

# Wait for DBCS to be fully provisioned:
code="INIT"
wait=5m

until [ "${code}" = "SUCCEED" ]; 
do

    echo "*** Evaluating DBCS completion for Job ID [${dbcsJobId}]..."

    psm dbcs operation-status -j $dbcsJobId > temp_dbcs_${dbcsJobId}_status.out
    status=`grep "status" temp_dbcs_${dbcsJobId}_status.out`
    code=`echo $status | sed "s/\"//g" | sed "s/,//g" | awk -F: '{print $2}'`

    echo "*** Current Status code for DBCS provisioning is [${code}]"


    if [ "$code" != "SUCCEED" ]; then

        # Waiting for another round
        echo "*** DBCS still in progress... Waiting for ${wait}"
        sleep $wait
    else
        break
    fi
done

echo "****************************************"
echo " DBCS Provisioned, continue with APICS"
echo "****************************************"

psm APICS create-service -c templates/temp_psm_APICS_Dev.json

echo "**************************\
 You can review the APICS Provisioning status with: psm [PAAS] operation-status -j [JOB_ID]"
echo "**************************"



# Removing all temp files:
#rm templates/temp*
