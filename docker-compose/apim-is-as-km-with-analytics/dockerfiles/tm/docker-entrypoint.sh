#!/bin/bash

echo "Optimizing WSO2 Carbon Server" 
#sh ${WSO2_SERVER_HOME}/bin/profileSetup.sh 
sh ${WSO2_SERVER_HOME}/bin/profileSetup.sh -Dprofile=traffic-manager
sh ${WSO2_SERVER_HOME}/bin/api-manager.sh -Dprofile=traffic-manager "$@"
