#!/bin/bash

systemctl stop postfix.service
systemctl disable postfix.service

systemctl restart firewalld

\cp -R /root/.oci /home/opc/.oci

\cp /root/.ssh/oci_rsa.pem /home/opc/.ssh/

chown -R opc:opc /home/opc/.oci

chown opc:opc /home/opc/.ssh/oci_rsa.pem

sed -i "s|/root|/home/opc|" /home/opc/.oci/config