#set -x

#######################################################################
# Auto deploy OIC Integrations into new target environment.
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
#######################################################################

if [ ! -f integration.properties ]; then
    echo "**************************************** Error: "
    echo " integration.properties file does not exist,"
    echo " please create this file with your Integration properties and try again."
    echo " A sample file was provided for illustratino purposes."
    echo "****************************************"
    exit 1
fi

# 1. We are going to set our environmental properties, by sourcing the integration.properties file that you wish to use.

source ./integration.properties

# 2. Build and Configure the IAR integration archive.

# Keeping the original IAR in GIT repo/artifactory, until we find value on expanding it.
#jar cvf ${ICS_INTEGRATION_IAR_FILENAME} icspackage

# Setup Connectors with environment variables
./setupConnectors.sh

# 3. Import the ICS Integration archive (IAR)
pathIntegration="integration"

###########################
# If upserting, first we need to delete the integration and connectors first, but it is dangerous, do it only if you know what you're doing:

# Deleting integration:
#curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Accept: application/json" -X DELETE ${ICS_INTEGRATION_DELETE_IMPORT_URI} -v

# Deleting each of the associated connectors:
#curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Accept: application/json" -X DELETE ${ICS_SC_CONNECTOR_DELETE} -v
#curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Accept: application/json" -X DELETE ${ICS_SF_CONNECTOR_DELETE} -v
#curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Accept: application/json" -X DELETE ${ICS_REST_ANKIMEDREC_CONNECTOR_DELETE} -v
#curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Accept: application/json" -X DELETE ${ICS_REST_APIs4Notifications_CONNECTOR_DELETE} -v
############################

curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Accept: application/json" -X POST -F "file=@${pathIntegration}/${ICS_INTEGRATION_IAR_FILENAME};type=multipart/form-data" ${ICS_INTEGRATION_POST_IMPORT_URI} -v


# Sleep 5 seconds to give time to complete before configuring the adapters.
sleep 5

# 4. Configure and activate my ICS Connectors:

# 	4.1 Sales Cloud Connector
pathConnectors="connectors"

# Configure Sales Cloud Connector:
curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Content-Type:application/json" -X POST -d @${pathConnectors}/${ICS_CONNECTOR_SC_CONFIG_NAME} ${ICS_CONNECTOR_SC_URI} -v

# Sleep 5 seconds to give time to complete before configuring the next adapter.
sleep 5

#	4.2 Salesforce Connector

# Configure Salesforce Connector:
curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Content-Type:application/json" -X POST -d @${pathConnectors}/${ICS_CONNECTOR_SF_CONFIG_NAME} ${ICS_CONNECTOR_SF_URI} -v


#	4.3 Anki-MedRec Connector

# Configure Anki-MedRec Connector:
curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Content-Type:application/json" -X POST -d @${pathConnectors}/${ICS_REST_ANKIMEDREC_CONFIG_NAME} ${ICS_REST_ANKIMEDREC_URI} -v


#	4.4 APIs4Notifications Connector

# Configure APIs4Notifications Connector:
curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Content-Type:application/json" -X POST -d @${pathConnectors}/${ICS_REST_APIs4Notifications_CONFIG_NAME} ${ICS_REST_APIs4Notifications_URI} -v


# Sleep 5 seconds to give time to complete before Activating the ICS Integration.
sleep 5

# 5. Activate the Integration

curl -u "${ICS_USERNAME}:${ICS_PASSWD}" -H "Accept: application/json" -X POST ${ICS_INTEGRATION_POST_ACTIVATE_URI} -v



