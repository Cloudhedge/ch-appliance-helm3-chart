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
| `global.image.username` | All `CloudHedge` component images are available in private repository. One can give username and password of the registry to pull the images. This helm chart creates a docker secret for you. Set value = docker registry username | `nil`  |
| `global.image.password` | All `CloudHedge` component images are available in private repository. One can give username and password of the registry to pull the images. This helm chart creates a docker secret for you. Set value = docker registry password | `nil`  |
| `global.db.dbUser` | MongoDB Username | `nil` |
| `global.db.dbPassword` | MongoDB Password | `nil` |
| `global.db.dbUrl` | MongoDB URL with port number. This URL should be reachable from all `Cloudhedge Enterprise` Pods | `nil` |
| `global.db.dbName` | MongoDB Database name | `nil` |
| `global.jwtSecret` | JWT secret value, give a random string. this string is used to encrypt JWT token | `theJWTSuperSecretValue`  |
| `global.encryptSecret` | random string. this sting is used to encrypt sensitive data in DB | `theEncryptSuperSecretValue` |


## Common parameters

| Parameter            | Description                                                          | Default                        |
|----------------------|----------------------------------------------------------------------|--------------------------------|
| `nameOverride`       | String to partially override                                         |                                |
| `fullnameOverride`   | String to fully override                                             |                                |
| `elkHost`       | `Cloudhedge Enterprise` can push the logs to elk. Give full qualified and reachable elk URL | `""`  |
| `appHost`       | exposed URL of the webapp. This URL should be reachable from discover box and build box | `""`  |

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
