# wildfly-charts
Helm Charts for WildFly

# Install Helm Repository

The WildFly Charts can be installed from [https://jmesnil.github.io/wildfly-charts/](https://jmesnil.github.io/wildfly-charts/)

```
$ helm repo add jmesnil https://jmesnil.github.io/wildfly-charts/
"jmesnil" has been added to your repositories
$ helm search repo wildfly
NAME                    CHART VERSION   APP VERSION     DESCRIPTION
jmesnil/wildfly         0.8.1           22.0            A Helm chart to build and deploy WildFly applic...
````

# Install Helm Chart
This will build an application image from a Git repository.

The only required parameter is `source.uri`.
The version of WildFly image can be set with `wildfly.version`. If unspecifiec, it defaults
to the app version of the Helm Chart.

```
helm install my-wildfly-app jmesnil/wildfly \
    --set build.uri=https://github.com/wildfly/quickstart.git \
    --set build.ref=22.0.0.Final \
    --set build.contextDir=microprofile-config \
    --set build.s2i.galleonLayers="jaxrs-server\,microprofile-platform"
```