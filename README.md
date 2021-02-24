# wildfly-charts - Helm Charts for WildFly

<p align="center">
  <img src="https://helm.sh/img/helm.svg" alt="Helm logo" title="WildFly" height="90"/>
  <img src="./wildfly.svg" alt="WildFly logo" title="WildFly" height="90"/>
</p>

# Install Helm Repository

The `wildfly` Chart can be installed from [https://jmesnil.github.io/wildfly-charts/](https://jmesnil.github.io/wildfly-charts/)

```
$ helm repo add wildfly https://jmesnil.github.io/wildfly-charts/
"wildfly" has been added to your repositories
$ helm search repo wildfly
NAME                    CHART VERSION   APP VERSION     DESCRIPTION
wildfly/wildfly         0.9.7           22.0            A Helm chart to build and deploy WildFly applic...
````

# Install Helm Chart
This will build an application image from a Git repository.

A complete documentation of this Chart is available in [charts/wildfly/](./charts/wildfly).
