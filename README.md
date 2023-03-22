Trustmark Deployer for Keycloak
==================
This project is for deploying keycloak configured for use with the Trustmark tools.  The deployer also includes a simple userinfo tool for use validating users have correct permissions for the trustmark tools.


Configure Keycloak
==================

You will need to edit the docker-compose.yml file and specify the FQDN for your server for these two fields:

```           
            "--hostname-url=https://host.docker.internal/auth/",
            "--hostname-admin-url=https://host.docker.internal/auth/",
```

As configured in this deployer, Keycloak will start up with a Trustmark Realm with a simple visual theme.  To customize the look and feel of SSO to the tools, you can modify the files in the deployer here:

```
          docker/keycloak-keycloak/opt/keycloak/themes/tf/
```

Run the docker container as follows:

```
shell$ docker compose up -d --build 
```

If you have setup Keycloak to be proxied you would want to proxy the sub-path `/auth`.   Feel free to contact help@trustmarkinitiative.org for help setting up the proxying configuration for Keycloak.  You may also use a dockerized instance of httpd for proxying, sample configuration for such a deploy are available in the ```docker/keycloak-httpd``` directory.

Open `https://host.docker.internal/auth/`. You may log in with username `administrator` and the password specified in the docker-compose.yml file:

```
       KEYCLOAK_ADMIN_PASSWORD: "value-here"
```

Users cannot be saved within realm exports, so to login to the trustmark tools, you will need to create users in the `trustmark` realm, or it is recommended to configure keycloak for SSO from your enterprise.  See the [TBD] to do that. 

Users must be assigned roles or be placed into groups that have roles pre-assigned to be able to use the tools.  See [TBD2] on how to assign users roles and groups.

The "Super Admin" group will make the user an admin in all tools.  This is useful for initial deploys, but if you intend for a variety of people to use the tools, you will need to assign individual roles for them.

In addition to configuring users within the Keycloak `trustmark` realm, you will need to configure client for all trustmark tools using Keycloak for sign-on.  All 2.0 version Trustmark Tools depend on Keycloak for login.  Typically configuring each client can be as easy as setting the redirect-uri for the tool within keycloak, as it assumes each tool will use a simple client id for each tool.

Testing
====

The included userinfo tool is useful for testing and validating your Keycloak configuration, as it functions similarly to all the trustmark tools.


