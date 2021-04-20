{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ch-appliance.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ch-appliance.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ch-appliance.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "cloudhedge.services.url" -}}
{{- printf "http://%s-%s" .Release.Name .tempsvc | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "imagePullSecret" }}
{{- if .Values.global.image.ecrtoken }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" (.Values.global.image.registry | default "registry.connect.redhat.com/cloudhedge") .Values.global.image.ecrtoken | b64enc }}
{{- else }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" (.Values.global.image.registry | default "registry.connect.redhat.com/cloudhedge") (printf "%s:%s" .Values.global.image.username .Values.global.image.password | b64enc) | b64enc }}
{{- end}}
{{- end }}

{{- define "findContainerPort" -}}
{{- $containerPort :=  8080 -}}
{{- if eq .component "webapp" -}}
{{- $containerPort =  8080 -}}
{{- else if eq .component "logging-agent" -}}
{{- $containerPort =  8888 -}}
{{- else if eq .component "logging-service" -}}
{{- $containerPort =  4015 -}}
{{- else if eq .component "auth-gateway-service" -}}
{{- $containerPort =  3000 -}}
{{- else if eq .component "core-engine" -}}
{{- $containerPort =  3001 -}}
{{- else if eq .component "cloud-infra-service" -}}
{{- $containerPort =  3002 -}}
{{- else if eq .component "infra-usage-analysis-engine" -}}
{{- $containerPort =  3003 -}}
{{- else if eq .component "repository-service" -}}
{{- $containerPort =  3004 -}}
{{- else if eq .component "notification-service" -}}
{{- $containerPort =  3005 -}}
{{- else if eq .component "vault-service" -}}
{{- $containerPort =  3006 -}}
{{- else if eq .component "activity-service" -}}
{{- $containerPort =  3007 -}}
{{- else if eq .component "k8s-helm-service" -}}
{{- $containerPort =  4008 -}}
{{- else if eq .component "discover-service-aix" -}}
{{- $containerPort =  5006 -}}
{{- else if eq .component "discover-service-linux" -}}
{{- $containerPort =  5001 -}}
{{- else if eq .component "discover-service-windows" -}}
{{- $containerPort =  5005 -}}
{{- else if eq .component "distribute-service" -}}
{{- $containerPort =  5002 -}}
{{- else if eq .component "openshift-service" -}}
{{- $containerPort =  3008 -}}
{{- else if eq .component "report-service" -}}
{{- $containerPort =  3009 -}}
{{- else if eq .component "ci-service" -}}
{{- $containerPort =  6001 -}}
{{- else if eq .component "cloud-lease-service" -}}
{{- $containerPort =  3010 -}}
{{- else if eq .component "analytics-service" -}}
{{- $containerPort =  7001 -}}
{{- else if eq .component "gc-k8s-service" -}}
{{- $containerPort =  4003 -}}
{{- else if eq .component "aws-k8s-service" -}}
{{- $containerPort =  4002 -}}
{{- else if eq .component "transform-service-linux" -}}
{{- $containerPort =  5003 -}}
{{- else if eq .component "transform-service-windows" -}}
{{- $containerPort =  5004 -}}
{{- end -}}
{{- printf "%d" $containerPort }}
{{- end -}}