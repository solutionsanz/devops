#######################################################################
# Decommission PaaS stack via Cloud Stack templates powered by PSM CLI.
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
#######################################################################
#################### Reading and validating passed parameters:

if [ "$#" -ne 2 ]; then

    echo "**************************************** Error: "
    echo " Illegal number of parameters."
    echo " Usage: [DBAPassword stackName]"
    echo "****************************************"
    exit 1
    
fi

DBAPassword=$1
stackName=$2

#######################################################################
#######################################################################
#################### Setting up PSM Stack Cloud Stack template:
# Creating a custom copy from template:
cp templates/${stackName}-destroy.json templates/temp_${stackName}-destroy.json
# Setting DBA Password in PSM JSON file:
sed -i "s/@DBA_PASSWORD_GOES_HERE@/${DBAPassword}/g" templates/temp_${stackName}-destroy.json

#######################################################################
#######################################################################
#################### Calling PSM to provision Stack via Cloud Stack

# Deleting Cloud Stack:
echo "*** Deleting Cloud Stack"
psm stack delete -n ${stackName} -c templates/temp_${stackName}-destroy.json

echo "**************************\
 You can review the Stack decommissioning status with: psm stack operation-status -j [JOB_ID]"
echo "**************************"



# Removing all temp files:
#rm templates/temp*
