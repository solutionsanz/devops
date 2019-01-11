
pathConnectors="connectors"

######## Note: Using ; in sed expression instead of the most common / due to the substitution will 
######## contain URLs, so lots of / will be used...

#	Connector: Sales Cloud:

cp ${pathConnectors}/${ICS_CONNECTOR_SC_CONFIG_NAME} ${pathConnectors}/temp_${ICS_CONNECTOR_SC_CONFIG_NAME}
sed -i "s;@ICS_SC_CONNECTOR_NAME@;${ICS_SC_CONNECTOR_NAME};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SC_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SC_URI@;${ICS_CONNECTOR_SC_URI};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SC_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SC_OSC_SERVICE_CATALOG_WSDL_URL@;${ICS_CONNECTOR_SC_OSC_SERVICE_CATALOG_WSDL_URL};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SC_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SC_OSC_EVENTS_CATALOG_WSDL_URL@;${ICS_CONNECTOR_SC_OSC_EVENTS_CATALOG_WSDL_URL};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SC_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SC_USERNAME@;${ICS_CONNECTOR_SC_USERNAME};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SC_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SC_PASSWORD@;${ICS_CONNECTOR_SC_PASSWORD};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SC_CONFIG_NAME}

#	Connector: SalesForce:

cp ${pathConnectors}/${ICS_CONNECTOR_SF_CONFIG_NAME} ${pathConnectors}/temp_${ICS_CONNECTOR_SF_CONFIG_NAME}
sed -i "s;@ICS_SF_CONNECTOR_NAME@;${ICS_SF_CONNECTOR_NAME};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SF_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SF_URI@;${ICS_CONNECTOR_SF_URI};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SF_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SF_USERNAME@;${ICS_CONNECTOR_SF_USERNAME};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SF_CONFIG_NAME}
sed -i "s;@ICS_CONNECTOR_SF_PASSWORD@;${ICS_CONNECTOR_SF_PASSWORD};g" ${pathConnectors}/temp_${ICS_CONNECTOR_SF_CONFIG_NAME}


#	Connector: REST Anki-MedRec:

cp ${pathConnectors}/${ICS_REST_ANKIMEDREC_CONFIG_NAME} ${pathConnectors}/temp_${ICS_REST_ANKIMEDREC_CONFIG_NAME}
sed -i "s;@ICS_REST_ANKIMEDREC_CONNECTOR_NAME@;${ICS_REST_ANKIMEDREC_CONNECTOR_NAME};g" ${pathConnectors}/temp_${ICS_REST_ANKIMEDREC_CONFIG_NAME}
sed -i "s;@ICS_REST_ANKIMEDREC_URI@;${ICS_REST_ANKIMEDREC_URI};g" ${pathConnectors}/temp_${ICS_REST_ANKIMEDREC_CONFIG_NAME}
sed -i "s;@ICS_REST_ANKIMEDREC_CONNECTION_URL@;${ICS_REST_ANKIMEDREC_CONNECTION_URL};g" ${pathConnectors}/temp_${ICS_REST_ANKIMEDREC_CONFIG_NAME}

#	Connector: REST APIs4Notifications:

cp ${pathConnectors}/${ICS_REST_APIs4Notifications_CONFIG_NAME} ${pathConnectors}/temp_${ICS_REST_APIs4Notifications_CONFIG_NAME}
sed -i "s;@ICS_REST_APIs4Notifications_CONNECTOR_NAME@;${ICS_REST_APIs4Notifications_CONNECTOR_NAME};g" ${pathConnectors}/temp_${ICS_REST_APIs4Notifications_CONFIG_NAME}
sed -i "s;@ICS_REST_APIs4Notifications_URI@;${ICS_REST_APIs4Notifications_URI};g" ${pathConnectors}/temp_${ICS_REST_APIs4Notifications_CONFIG_NAME}
sed -i "s;@ICS_REST_APIs4Notifications_CONNECTION_URL@;${ICS_REST_APIs4Notifications_CONNECTION_URL};g" ${pathConnectors}/temp_${ICS_REST_APIs4Notifications_CONFIG_NAME}