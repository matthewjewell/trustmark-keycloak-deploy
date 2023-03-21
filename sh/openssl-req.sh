#!/bin/bash

set +o posix

openssl req \
  -x509 \
  -nodes \
  -newkey rsa:4096 \
  -keyout docker/keycloak-httpd/usr/local/apache2/conf/keycloak-httpd.key.pem \
  -out docker/keycloak-httpd/usr/local/apache2/conf/keycloak-httpd.crt.pem \
  -days 365 \
  -subj "/CN=keycloak-httpd" \
  -extensions SAN \
  -config <(cat sh/openssl-req.cnf <(printf "[SAN]\nsubjectAltName='DNS:keycloak-httpd, DNS:host.docker.internal'"))

openssl req \
  -x509 \
  -nodes \
  -newkey rsa:4096 \
  -keyout docker/keycloak-keycloak/etc/x509/https/keycloak-keycloak.key.pem \
  -out docker/keycloak-keycloak/etc/x509/https/keycloak-keycloak.crt.pem \
  -days 365 \
  -subj "/CN=keycloak-keycloak" \
  -extensions SAN \
  -config <(cat sh/openssl-req.cnf <(printf "[SAN]\nsubjectAltName='DNS:keycloak-keycloak, DNS:host.docker.internal'"))

rm docker/keycloak-grails/grails-app/conf/keycloak-grails-truststore.jks

keytool -import \
    -trustcacerts \
    -keystore userinfo/keycloak-truststore.jks \
    -alias keycloak-keycloak \
    -file docker/keycloak-keycloak/etc/x509/https/keycloak-keycloak.crt.pem

keytool -import \
    -trustcacerts \
    -keystore userinfo/keycloak-truststore.jks \
    -alias keycloak-httpd \
    -file docker/keycloak-httpd/usr/local/apache2/conf/keycloak-httpd.crt.pem
