# [CloudHedge](https://cloudhedge.io) Appliance helm chart

[CloudHedge](https://cloudhedge.io) is a automation tool that enable enterprise and ISVs to containerize their workloads on any flavour of [kubernetes](http://kubernetes.io/). In addition, to speed up and automate the containerization of Windows, Linux, and AIX based workloads within weeks.

Using AI, [CloudHedge](https://cloudhedge.io) can analyze your existing applications, and automatically recommend and transform monolith applications to cloud-native.

[CloudHedge](https://cloudhedge.io) not only support Lift-Shift model but it can also Re-Factor and containerize automatically !

[CloudHedge](https://cloudhedge.io) runs as a SAAS. It can also be deployed in your environment as a CloudHedge Enterprise. Additional documentation for the product can be found [here](https://app.cloudhedge.io/api/ch-user-guide/).

This helm chart is hosted and managed by [CloudHedge Engineers](mailto:engg@cloudhedge.io)

For any query or help reach out to us @ [hello@cloudhedge.io](mailto:hello@cloudhedge.io)

## Introduction

`CloudHedge` charts for Helm are carefully engineered, maintained and are the quickest and easiest way to deploy `CloudHedge Enterprise` on a any flavour  of Kubernetes cluster that are ready to handle production workloads.

This chart sets up a `CloudHedge Enterprise` on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
- The mongoDB is setup as per the [instructions](https://app.cloudhedge.io/api/ch-user-guide/#installation/installation-instructions/install-configure-mongodb/)
- The NFS is setup and enabled as per the [instructions](https://app.cloudhedge.io/api/ch-user-guide/#installation/installation-instructions/Helm-Openshift/enable-nfs/) (optional step)
- The various settings are updated in [values.yaml](./values.yaml) as described bellow.
- Kubernetes 1.12+
- Helm 3.1.0

## Parameters

The following tables lists the configurable parameters of the `CloudHedge Enterprise` chart and their default values per section/component:

### Global parameters

| Parameter                 | Description                                     | Default                                                 |
|---------------------------|-------------------------------------------------|---------------------------------------------------------|
| `global.image.registry`   | Global Container image registry                    | `registry.connect.redhat.com/cloudhedge`                                                   |
| `global.image.tag` | Global Container image tag | `ch-rel-1.3.3`  |
| `global.image.imagePullSecrets` | Global Container registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |
| `global.image.username` & `global.image.password` | All `CloudHedge` component images are available in private repository. One can give username and password of the registry to pull the images. This helm chart creates a docker secret for you.  | `nil`  |
| `global.secrets` | `CloudHedge Enterprise` requires some secret data to be passed. One can pass these values directly or create a secret and pass its name. | `{}` (does not add image pull secrets to deployed pods) |
| `global.secrets.DB_USER` | MongoDB Username | `nil` |
| `global.secrets.DB_PASSWORD` | MongoDB Password | `nil` |
| `global.secrets.DB_PROTO` | MongoDB Protocol | `nil` |
| `global.secrets.DB_URL_WITH_PORT` | MongoDB URL with port number. This URL should be reachable from all `Cloudhedge Enterprise` Pods | `nil` |
| `global.secrets.DB_NAME` | MongoDB Database name | `nil` |
| `global.secrets.JWT_SECRET` | JWT secret value, give a random string. this string is used to encrypt JWT token | `random value`  |
| `global.secrets.ENCRYPT_SECRET` | random string. this sting is used to encrypt sensitive data in DB | `random value` |


## Common parameters

| Parameter            | Description                                                          | Default                        |
|----------------------|----------------------------------------------------------------------|--------------------------------|
| `nameOverride`       | String to partially override                                         |                                |
| `fullnameOverride`   | String to fully override                                             |                                |
| `elkHost`       | `Cloudhedge Enterprise` can push the logs to elk. Give full qualified and reachable elk URL | `""`  |



## Cloudhedge components parameters

`CloudHedge Enterprise` has 25 components. one can over-ride bellow params for individual component (_replace component-name with actual component name_)

| Parameter                   | Description                                                                               | Default                        |
|-----------------------------|-------------------------------------------------------------------------------------------|--------------------------------|
| `component-name.container.ports`              | port information of the component. This is array of the objects which contains keys: `containerPort:` port number of the container, `name:` name of the port object, `targetPort:` target port number                                                  | `[]`                            |
| `component-name.livenessProbe`              | this object holds liveness probe settings. This should be valid liveness probe settings | <code>json: {"initialDelaySeconds": 10, "httpGet": {"path": "/", "port": "<container port>", "scheme": "HTTP" }}</code>                      |
| `component-name.readinessProbe`              | this object holds readiness probe settings. This should be valid readiness probe settings  | <code>json: {"readinessProbe": {"initialDelaySeconds": 10, "httpGet": {"path":"/", "port": 8443, "scheme": "HTTPS" }}}</code> |
| `component-name.image.repository`         | image repository to be used | `component-name` |
| `component-name.image.tag`     | tag to be used | `""` if not given it uses global.tag |
| `component-name.envRefs`   | Extra env variable need to inject in components pod | `nil`, it should be array ob objects with name and value as a key |
| `component-name.service.type`    | how to expose a service for this component valid values are `clusterIP`, `NodePort`, `LoadBalancer` |   `clusterIP` |
| `component-name.service.sessionAffinity` | Affinity for component | `ClientIP` |

---

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install my-release \
  --set imagePullPolicy=Always \
    .
```

The above command sets the `imagePullPolicy` to `Always`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install my-release -f values.yaml .
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Getting support

`Cloudhedge Enterprise` chart is actively managed by `CloudHedge Enggineers`. If you encounter any issues, reach out to us at [hello@cloudhedge.io](mailto:hello@cloudhedge.io). 
