\#!/bin/bash
# TODO: Validate input and test on each build that it still works (prevents support cases)

CONF_DIR=./config

if [ ! -f "$CONF_DIR/env.yml" ]; then
   read -p "What is your Robokiller Access Key : " robokiller_access_key;
   read -p "What is your NGROK Token (optional): " ngrok_token;
   read -p "What is your LocaltoNet API TOKEN (optional): " localtonet_api_token;
   read -p "What is your LocaltoNet AUTH TOKEN (optional): " localtonet_auth_token;
   read -p "Editor (nano, vim, emacs): " visual;


   if [ ! -d "$CONF_DIR" ]; then
       mkdir $CONF_DIR
   fi
   echo "RK_API_KEY: '$robokiller_access_key'" >> $CONF_DIR/env.yml
   echo "NGROK_TOKEN: '$ngrok_token'" >> $CONF_DIR/env.yml
   echo "VISUAL: '$visual'" >> $CONF_DIR/env.yml
   echo "LOCALTONET_API_TOKEN: '$localtonet_api_token'" >> $CONF_DIR/env.yml
   echo "LOCALTONET_AUTH_TOKEN: '$localtonet_auth_token'" >> $CONF_DIR/env.yml
   echo "setup successful"
else
   echo "Setup $CONF_DIR/env.yml file already exists"
fi

