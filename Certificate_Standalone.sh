#!/bin/bash
read -p "Please Enter CA Path(for example /root/ca/cert): " -r CANAME
read -p "Enter your MYCERT: "$'\n'  MYCERT

echo "optional, create a directory"
mkdir $MYCERT
cd $MYCERT
chmod -R 600 $MYCERT

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

sudo chmod -R 600 $MYCERT.crt
