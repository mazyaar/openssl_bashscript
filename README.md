# openssl_bashscript
Make CA root server and Certificate for web Server with openssl Script.

OpenSSL is a free, open-source library that you can use for digital certificates. One of the things you can do is build your own CA (Certificate Authority).

A CA is an entity that signs digital certificates. An example of a well-known CA is Verisign. Many websites on the Internet use certificates for their HTTPS connections that were signed by Verisign.

Besides websites and HTTPS, there are some other applications/services that can use digital certificates. For example:

VPNs: instead of using a pre-shared key you can use digital certificates for authentication.
Wireless: WPA 2 enterprise uses digital certificates for client authentication and/or server authentication using PEAP or EAP-TLS.
Instead of paying companies like Verisign for all your digital certificates. It can be useful to build your own CA for some of your applications. In this lesson, you will learn how to create your own CA.

Step1: Make Root CA

Step2: Make Certificate

Step3: Verification

Requirment:
  OS: Ubuntu/Debian
  Ram: 2GB Minimum
  H.D.D: 20GB Minimum
  Server: not dependet
  
  Use Script:
  
  ~ chmod +x CA_full.sh
  ~ ./CA_full.sh
  
 Enter your CANAME
 ENter your Web Server Name
 
 Atlast add Certificates on your devices. 
