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

## Database Params
| Parameter                 | Description | Default | Required |
|---------------------------|---------------------------|---------------------------|---------------------------|
| `db.dbUser` | MongoDB Username | `nil` | Yes |
| `db.dbPassword` | MongoDB Password | `nil` | Yes | 
| `db.dbUrl` | MongoDB URL with port number. This URL should be reachable from all `Cloudhedge Enterprise` Pods | `nil` | Yes |
| `db.dbName` | MongoDB Database name | `nil` | Yes |
| `db.dbProto` | MongoDB Protocol | `mongodb` |  NO |

### Global parameters

| Parameter | Description | Default | Required |
|---------------------------|---------------------------|---------------------------|---------------------------|
| `global.image.registry`   | Global Container image registry | `registry.connect.redhat.com/cloudhedge`       |  No |
| `global.image.tag` | Global Container image tag | `ch-rel-1.3.3`  |  No |
| `global.image.imagePullSecrets` | Global Container registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |  No |
| `global.image.username` | All `CloudHedge` component images are available in private repository. One can give username and password of the registry to pull the images. This helm chart creates a docker secret for you. Set value = docker registry username | `nil`  |  No |
| `global.image.password` | All `CloudHedge` component images are available in private repository. One can give username and password of the registry to pull the images. This helm chart creates a docker secret for you. Set value = docker registry password | `nil`  |  No |
| `global.webappExposeType` | How to expose the webapp? Possible values are: LoadBalancer, ClusterIP and NodePort  | `LoadBalancer` |  No |
| `global.webappProtocol` | How Webapp is exposed | `HTTP` |  No |
| `global.jwtSecret` | JWT secret value, give a random string. this string is used to encrypt JWT token | `theJWTSuperSecretValue`  |  No |
| `global.encryptSecret` | random string. this sting is used to encrypt sensitive data in DB | `theEncryptSuperSecretValue` |  No |
| `global.commonLabels` | Labels need to attach with every deployed object | `{}` |  No |
| `global.commonAnnotations` | Annotations need to attach with every deployed object | `{}` |  No |

## Common parameters

| Parameter | Description | Default | Required |
|---------------------------|---------------------------|---------------------------|---------------------------|
| `nameOverride`       | String to partially override | `""` | No |
| `fullnameOverride`   | String to fully override | `""` | No |
| `elkHost`       | `Cloudhedge Enterprise` can push the logs to elk. Give full qualified and reachable elk URL | `""`  | No |
| `appHost`       | exposed URL of the webapp. This URL should be reachable from discover box and build box | `""`  | No |

---

# Install helm chart 
## Adding the Helm Repository
This step is required if you’re installing the chart via the helm repository.
```
helm repo add cloudhedge https://cloudhedge.github.io/ch-appliance-helm3-chart/
helm update 
```
Verify that helm repository gets added by running the command.

```
helm repo list 
```

List all available version of CloudHedge helm charts by running a command,
```
helm search repo cloudhedge
```
This command output should show all available versions of CloudHedge helm charts 

## Setup CloudHedge Appliance 

### Passing params via command line. 

Specify parameter using the `--set key=value,key=value` argument to `helm install` command For example,

```bash
$ helm install ch-appliance \
  --set db.dbUser=<placeholder> \
  --set db.dbPassword=<placeholder> \
  --set db.dbUrl=<placeholder> \
  --set db.dbName=<placeholder> \
  --set db.dbProto=<placeholder> \
  --set global.image.username=<placeholder> \
  --set global.image.password=<placeholder> \
  --set global.webappProtocol=HTTPS \
  cloudhedge/ch-appliance-helmchart

```
Make sure to use correct db credentials by replacing `<placeholder>` with correct values

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install ch-appliance -f values.yaml cloudhedge/ch-appliance-helmchart
```

You can use the default [values.yaml](./values.yaml). The file has enough pointers for each possible parameter. Update this file and run mansioned commnad 

## Getting support

`CloudHedge Enterprise` chart is actively managed by `CloudHedge Enggineers`. If you encounter any issues, reach out to us at [hello@cloudhedge.io](mailto:hello@cloudhedge.io). 
