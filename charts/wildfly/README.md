# Helm Chart for WildFly

A Helm chart for building and deploying a [Wildly](https://www.wildfly.org) application on OpenShift.

The build and deploy steps are configured in separate `build` and `deploy` values.

The input of the `build` step is a Git repository that contains the application code and the output is an `ImageStreamTag` resource that contains the built application image.

The input of the `deploy` step is an `ImageStreamTag` resource that contains the built application image and the output is a `DeploymentConfig` and related resources to access the application from inside and outside OpenShift.

## Prerequisites
Below are prerequisites that may apply to your use case.

### Pull Secret
You will need to create a pull secret if you need to pull an image from an external registry that requires authentication. Use the following command as a reference to create your pull secret:
```bash
oc create secret docker-registry my-pull-secret --docker-server=$REGISTRY_URL --docker-username=$USERNAME --docker-password=$PASSWORD --docker-email=$EMAIL
```

You can use this secret by passing `--set build.pullSecret=my-pull-secret` to `helm install`, or you can configure this in a values file:
```yaml
build:
  pullSecret: my-pull-secret
```
and apply by passing `-f $VALUES_FILE`.

## Application Image

The configuration for the image that is built and deployed is configured in a `image` section.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `image.name` | Name of the image you want to build/deploy | Defaults to the Helm release name. | The chart will create/reference an [ImageStream](https://docs.openshift.com/container-platform/latest/openshift_images/image-streams-manage.html) based on this value. |
| `image.tag` | Tag that you want to build/deploy | `latest` | The chart will create/reference an [ImageStreamTag](https://docs.openshift.com/container-platform/latest/openshift_images/image-streams-manage.html#images-using-imagestream-tags_image-streams-managing) based on the name provided |

## Building the Application

The configuration to build the application image is configured in a `build` section.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `build.enabled` | Determines if build-related resources should be created. | `true` | Set this to `false` if you want to deploy a previously built image. Leave this set to `true` if you want to build and deploy a new image. |
| `build.uri` | Git URI that references your git repo | &lt;required&gt; | Be sure to specify this to build the application. |
| `build.ref` | Git ref containing the application you want to build | `main` | - |
| `build.contextDir` | The sub-directory where the application source code exists | - | - |
| `build.pullSecret` | Image pull secret | - | The secret must exist in the same namespace or the chart will fail to install - [OpenShift documentation](https://docs.openshift.com/container-platform/latesst/openshift_images/managing_images/using-image-pull-secrets.html) |
| `build.mode` | Determines whether the application will be built using WildFly S2I images or Bootable Jar | `s2i` | Allowed values: `s2i` or `bootable-jar` |
| `build.env` | Freeform `env` items | - | [Kubernetes documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/). These environment variables will be used when the application is _built_. If you need to specify environment variables for the running application, use `deploy.env` instead. |
| `build.resources` | Freeform `resources` items | - | [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| `build.images`| Freeform images injected in the source during build | - | [OpenShift documentation](https://docs.openshift.com/container-platform/latest/builds/creating-build-inputs.html#builds-define-build-inputs_creating-build-inputs) |
| `build.triggers.githubSecret`| Name of the secret containing the WebHookSecretKey for the GitHub Webhook | - | The secret must exist in the same namespace or the chart will fail to install - [OpenShift documentation](https://docs.openshift.com/container-platform/latest/cicd/builds/triggering-builds-build-hooks.html#builds-webhook-triggers_triggering-builds-build-hooks) |
| `build.triggers.genericSecret`| Name of the secret containing the WebHookSecretKey for the Generic Webhook | - | The secret must exist in the same namespace or the chart will fail to install - [OpenShift documentation](https://docs.openshift.com/container-platform/latest/cicd/builds/triggering-builds-build-hooks.html#builds-webhook-triggers_triggering-builds-build-hooks) |
| `build.s2i` | Configuration specific to building with WildFly S2I images | - | - |
| `build.s2i.version` | Version of the WildFly S2I images. | Defaults to this chart `AppVersion` | - |
| `build.s2i.builderImage` | WildFly S2I Builder image | [quay.io/wildfly/wildfly-centos7](https://quay.io/wildfly/wildfly-centos7) | [WildFly S2I documentation](https://github.com/wildfly/wildfly-s2i)  |
| `build.s2i.runtimeImage` | WildFly S2I Runtime image | [quay.io/wildfly/wildfly-runtime-centos7](https://quay.io/wildfly/wildfly-runtime-centos7) | [WildFly S2I documentation](https://github.com/wildfly/wildfly-s2i) |
| `build.s2i.galleonLayers` | A comma separated list of layer names to compose a WildFly server | - |  [WildFly S2I documentation](https://github.com/wildfly/wildfly-s2i) |

## Deploying the Application

The configuration to build the application image is configured in a `deploy` section.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `deploy.enabled` | Determines if deployment-related resources should be created. | `true` | Set this to `false` if you do not want to deploy an application image built by this chart. |
| `deploy.replicas` | Number of pod replicas to deploy. | `1` | [OpenShift Documentation](https://docs.openshift.com/container-platform/latest/applications/deployments/what-deployments-are.html) | 
| `deploy.route.enabled` | Determines if a `Route` should be created | `true` | Allows clients outside of OpenShift to access your application |
| `deploy.route.tls.enabled` | Determines if the `Route` should be TLS-encrypted | `true`| [OpenShift Documentation](https://docs.openshift.com/container-platform/latest/networking/routes/secured-routes.html) |
| `deploy.route.tls.termination` | Determines the type of TLS termination to use | `edge`| Allowed values: `edge, reencrypt, passthrough` |
| `deploy.route.tls.insecureEdgeTerminationPolicy` | Determines if insecure traffic should be redirected | `Redirect` | Allowed values: `Allow, Disable, Redirect` |
| `deploy.env` | Freeform `env` items | - | [Kubernetes documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).  These environment variables will be used when the application is _running_. If you need to specify environment variables when the application is built, use `build.env` instead. |
| `deploy.envFrom` | Freeform `envFrom` items | - | [Kubernetes documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).  These environment variables will be used when the application is _running_. If you need to specify environment variables when the application is built, use `build.envFrom` instead. |
| `deploy.resources` | Freeform `resources` items | - | [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| `deploy.livenessProbe` | Freeform `livenessProbe` field. | HTTP Get on `<ip>:admin/health/live` | [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| `deploy.readinessProbe` | Freeform `readinessProbe` field. | HTTP Get on `<ip>:admin/health/ready` | [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| `deploy.volumeMounts` | Freeform `volumeMounts` items| - | [Kubernetes Documentation](https://kubernetes.io/docs/concepts/storage/volumes/) |
| `deploy.volumes` | Freeform `volumes` items| - | [Kubernetes Documentation](https://kubernetes.io/docs/concepts/storage/volumes/) |
| `deploy.initContainers` | Freeform `initContainers` items | - | [Kubernetes Documentation](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) |
| `deploy.extraContainers` | Freeform extra `containers` items | - | [Kubernetes Documentation](https://kubernetes.io/docs/concepts/workloads/pods/#pod-templates) |