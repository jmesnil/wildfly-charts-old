# wildfly-charts
Helm Charts for WildFly


helm install my-app wildfly \
    --set wildfly.version=22.0 \
    --set source.uri=https://github.com/wildfly/quickstart.git \
    --set source.ref=22.0.0.Final \
    --set source.contextDir=microprofile-config \
    --set galleon.layers="jaxrs-server\,microprofile-platform"