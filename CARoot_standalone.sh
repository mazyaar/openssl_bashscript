#!/bin/bash

read -p "Enter your CANAME: "$'\n'  CANAME

echo "optional, create a directory"

mkdir $CANAME
cd $CANAME

echo "generate aes encrypted private key"

openssl genrsa -aes256 -out $CANAME.key 4096

echo "create certificate, 3650 days = 10 years"

openssl req -x509 -new -nodes -key $CANAME.key -sha256 -days 3650 -out $CANAME.crt -subj /CN=$MYCERT/C=US/ST=California/L=LA/O=IT.co

sudo chmod -R 600 $CANAME.crt

echo "Copy your CA to dir /usr/local/share/ca-certificates/"
sudo cp $CANAME.crt /usr/local/share/ca-certificates/$CANAME.crt

echo "Update the CA store: sudo update-ca-certificates"
sudo update-ca-certificates
