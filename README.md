# wildfly-charts
Helm Charts for WildFly


helm install --dry-run --debug wildfly --generate-name \
    --set source.uri=https://github.com/wildfly/quickstart.git \
    --set source.ref=22.0.Final \
    --set source.contextDir=microprofile-config \
    --set galleon.layers="jaxrs-server\,microprofile-platform"