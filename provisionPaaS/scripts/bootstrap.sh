#######################################################################
# Deploy OIC Integrations via OIC APIs v2.
# This version created by Carlos Rodriguez Iturria (https://www.linkedin.com/in/citurria/)
#######################################################################
#################### Reading and validating passed parameters:


if [ "$#" -ne 0 ]; then

    echo "**************************************** Error: "
    echo " Illegal number of parameters."
    echo " Usage: ./deployItegrations.sh"
    echo "****************************************"
    exit 1
    
fi


#######################################################################
#################### Gathering all Integration projects to be deployed:

for dir in integrations/*/
do
    #dir=${dir%*/}
    echo "Dir found is: ${dir}"
done