#!/bin/bash

mkdir -p certs

openssl req -x509 -newkey rsa:4096 -days 365 \
 -keyout cert/tls.key \
 -out certs/tls.crt \
 -nodes \
 -subj "/C=ES/ST=Asturias/L=Oviedo/O=CUPS/CN=raspberrypi.local"
