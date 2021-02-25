{{/*
Expand the name of the chart.
*/}}
{{- define "wildfly-common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "wildfly-common.fullName" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
wildfly-common.appImage is the name of the application image that is built/deployed
*/}}
{{- define "wildfly-common.appImage" -}}
{{ default (include "wildfly-common.appName" .) .Values.image.name }}
{{- end -}}

{{/*
wildfly-common.appImageStreamTag is image stream of of the application image that is built/deployed
*/}}
{{- define "wildfly-common.appImageStreamTag" -}}
{{ include "wildfly-common.appImage" . }}:{{ .Values.image.tag}}
{{- end -}}

{{/*
wildfly.appBuilderImage corresponds to the imagestram for the application Builder image
*/}}
{{- define "wildfly-common.appBuilderImage" -}}
{{ include "wildfly-common.appImage" . }}-build-artifacts
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wildfly-common.appName" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wildfly-common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wildfly-common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
