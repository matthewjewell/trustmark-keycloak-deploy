FROM amazoncorretto:latest

EXPOSE 8080

#RUN yum install -y wget

WORKDIR /work
ADD https://trustmarkinitiative.org/software/userinfo-1.0.war   userinfo.war
COPY keycloak-truststore.jks keycloak-truststore.jks

CMD [ \
    "java", \
    "-Djavax.net.debug=all", \
    "-Djavax.net.ssl.trustStore=/work/keycloak-truststore.jks", \
    "-Djavax.net.ssl.trustStorePassword=password", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-jar", \
    "/work/userinfo.war" \
    ]

