#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt instal openssl

read -p "Enter your CANAME: "$'\n'  CANAME
read -p "Enter your MYCERT: "$'\n'  MYCERT

echo "optional, create a directory"

mkdir $CANAME
cd $CANAME
chmod -R 600 $CANAME

echo "generate aes encrypted private key"

openssl genrsa -aes256 -out $CANAME.key 4096

echo "create certificate, 3650 days = 10 years"

openssl req -x509 -new -nodes -key $CANAME.key -sha256 -days 3650 -out $CANAME.crt -subj /CN=$MYCERT/C=US/ST=California/L=LA/O=IT.co

echo "create certificate for service"

openssl req -new -nodes -out $MYCERT.csr -newkey rsa:4096 -keyout $MYCERT.key -subj /CN=$MYCERT/C=US/ST=California/L=LA/O=IT.co

echo "create a v3 ext file for SAN properties"

cat > $MYCERT.v3.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = myserver.local
DNS.2 = myserver1.local
IP.1 = 192.168.1.1
IP.2 = 192.168.2.1
EOF

openssl x509 -req -in $MYCERT.csr -CA $CANAME.crt -CAkey $CANAME.key -CAcreateserial -out $MYCERT.crt -days 1825 -sha256 -extfile $MYCERT.v3.ext

sudo chmod -R 600 $CANAME.crt
sudo chmod -R 600 $MYCERT.crt

echo "Copy your CA to dir /usr/local/share/ca-certificates/"
sudo cp $CANAME.crt /usr/local/share/ca-certificates/$CANAME.crt

echo "Update the CA store: sudo update-ca-certificates"
sudo update-ca-certificates
