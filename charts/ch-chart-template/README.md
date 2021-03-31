# Cloudhedge Helm chart template
This is a template chart for deployment of any app on Kubernetes. This template can create below kubernetes `Kind`s
- `Deployment`: Using images from public or private registery. For private registry imagePullSecrets needs to be managed from parent-chart or adding `Secret` kind yaml with `type: kubernetes.io/dockerconfigjson` and refering value
- `Ingress`
- `Service`

## Usage
This chart can be used to standalone app deployment or micro-service based apps

### Standalone app deployment
For stat standalone just overriding values defined and execute below command
```shell
$ helm install . -n release-name
```

### Micro-service app deployment

#### Create parent Chart
For micro-service based app create and parent helm chart using below command
```shell
$ helm create parent-chart-name
```
then create a requirements.yaml with content similar to below
```yaml
dependencies:
- name: ch-chart-template
  version: 0.1.0
  alias: core-engine #<-- this is micro-service name which will used in parent chart's values.yaml
- name: ch-chart-template
  version: 0.1.0
  alias: vault-service
- name: ch-chart-template #<-- this is micro-service name
  version: 0.1.0
  alias: webapp
  ...
```
#### Override values of child charts
In values.yaml file of parent directory micro-services values needs to be overriden example below
```yaml
webapp:
  nameOverride: webapp
  internalPort: 80 #<-- port being exposed by container
  imagePullSecrets:
    - name: dockersecret #<-- option. required if images are in private repository
  image:
    #registory: xyz.registory.com #<-- registory override if necessary
    repository: webapp #<-- repository name override
    tag: dev-123 #<-- tag override
  ingress:
    enabled: true #<-- if this micro-service requires ingress
  envRefs: #<-- envRefs managed by parent chart or manually which are passed to child chart
    - type: configMapRef #<-- inject configMapRef in containers
      ref: app-service-urls

core-engine:
  nameOverride: core-engine
  internalPort: 3001
  imagePullSecrets:
    - name: dockersecret
  image:
    repository: core-engine
    tag: dev-123 #tag-to-replace
  envRefs:
    - type: secretRef #<-- inject secretRef in containers
      ref: cbdbcreds
    - type: configMapRef
      ref: app-service-urls
```

## Todo
[ ] Additional kinds `Secrets`, `ConfigMap`, `StorageClass`, `PVC`, 