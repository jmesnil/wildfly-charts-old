# Helm Chart for WildFly

A Helm chart for building and deploying a [Wildly](https://www.wildfly.org) application on OpenShift.

The build and deploy steps are configured in separate `build` and `deploy` values.

The input of the `build` step is a Git repository that contains the application code and the output is an `ImageStreamTag` resource that contains the built application image.

The input of the `deploy` step is an `ImageStreamTag` resource that contains the built application image and the output is a `DeploymentConfig` and related resources to access the application from inside and outside OpenShift.

## Application Image

The configuration for the image that is built and deployed is configured in a `image` section.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `image.name` | Name of the image you want to build/deploy | Defaults to the Helm release name. | The chart will create/reference an [ImageStream](https://docs.openshift.com/container-platform/4.6/openshift_images/image-streams-manage.html) based on this value. |
| `image.tag` | Tag that you want to build/deploy | `latest` | The chart will create/reference an [ImageStreamTag](https://docs.openshift.com/container-platform/4.6/openshift_images/image-streams-manage.html#images-using-imagestream-tags_image-streams-managing) based on the name provided |

## Building the Application

The configuration to build the application image is configured in a `build` section.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `build.enabled` | Determines if build-related resources should be created. | `true` | Set this to `false` if you want to deploy a previously built image. Leave this set to `true` if you want to build and deploy a new image. |
| `build.uri` | Git URI that references your git repo | &lt;required&gt; | Be sure to specify this to build the application. |
| `build.ref` | Git ref containing the application you want to build | `main` | - |
| `build.contextDir` | The sub-directory where the application source code exists | - | - |
| `build.mode` | Determines whether the application will be built using WildFly S2I images or Bootable Jar | `s2i` | Allowed values: `s2i` or `bootable-jar` |
| `build.env` | Freeform `env` field | - | [Kubernetes documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) |
| `build.envFrom` | Freeform `envFrom` field | - | [Kubernetes documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) |
| `build.resources` | Freeform `resources` field | - | [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| `build.images`| Freeform images injected in the source during build | - | [OpenShift documentation](https://docs.openshift.com/container-platform/4.6/builds/creating-build-inputs.html#builds-define-build-inputs_creating-build-inputs) |
| `build.s2i` | Configuration specific to building with WildFly S2I images | - | - |
| `build.s2i.version` | Version of the WildFly S2I images. | Defaults to this chart `AppVersion` | - |
| `build.s2i.builderImage` | WildFly S2I Builder image | quay.io/wildfly/wildfly-centos7 | [WildFly S2I documentation](https://github.com/wildfly/wildfly-s2i)  |
| `build.s2i.runtimeImage` | WildFly S2I Runtime image | quay.io/wildfly/wildfly-runtime-centos7 | [WildFly S2I documentation](https://github.com/wildfly/wildfly-s2i) |
| `build.s2i.galleonLayers` | A comma separated list of layer names to compose a WildFly server | - |  [WildFly S2I documentation](https://github.com/wildfly/wildfly-s2i) |

## Deploying the Application

The configuration to build the application image is configured in a `deploy` section.

| Value | Description | Default | Additional Information |
| ----- | ----------- | ------- | ---------------------- |
| `deploy.enabled` | Determines if deployment-related resources should be created. | `true` | Set this to `false` if you do not want to deploy an application image built by this chart. |
| `deploy.replicas` | Number of pod replicas to deploy. | `1` | [OpenShift Documentation](https://docs.openshift.com/container-platform/4.6/applications/deployments/what-deployments-are.html) | 
| `deploy.route.enabled` | Determines if a `Route` should be created | `true` | Allows clients outside of OpenShift to access your application |
| `deploy.env` | Freeform `env` field | - | [Kubernetes documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) |
| `deploy.envFrom` | Freeform `envFrom` field | - | [Kubernetes documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/) |
| `deploy.resources` | Freeform `resources` field | - | [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) |
| `deploy.livenessProbe` | Freeform `livenessProbe` field. | HTTP Get on `<ip>:admin/health/live` | [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| `deploy.readinessProbe` | Freeform `readinessProbe` field. | HTTP Get on `<ip>:admin/health/ready` | [Kubernetes documentation](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
