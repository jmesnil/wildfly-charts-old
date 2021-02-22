# wildfly-charts
Helm Charts for WildFly

# Install Helm Repository

The WildFly Charts can be installed from [https://jmesnil.github.io/wildfly-charts/](https://jmesnil.github.io/wildfly-charts/)

```
$ helm repo add jmesnil https://jmesnil.github.io/wildfly-charts/
"jmesnil" has been added to your repositories
$ helm search repo wildfly
NAME                    CHART VERSION   APP VERSION     DESCRIPTION
jmesnil/wildfly         0.9.7           22.0            A Helm chart to build and deploy WildFly applic...
````

# Install Helm Chart
This will build an application image from a Git repository.

A complete documentation of this Chart is available in [its README](https://github.com/jmesnil/wildfly-charts/blob/main/charts/wildfly/README.md).