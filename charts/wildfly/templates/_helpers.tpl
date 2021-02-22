{{/*
Expand the name of the chart.
*/}}
{{- define "wildfly.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "wildfly.fullName" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
wildfly.appImage is the name of the application image that is built/deployed
*/}}
{{- define "wildfly.appImage" -}}
{{ default (include "wildfly.appName" .) .Values.image.name }}
{{- end -}}

{{/*
wildfly.appImageStreamTag is image stream of of the application image that is built/deployed
*/}}
{{- define "wildfly.appImageStreamTag" -}}
{{ include "wildfly.appImage" . }}:{{ .Values.image.tag}}
{{- end -}}

{{/*
wildfly.appBuilderImage corresponds to the imagestram for the application Builder image
*/}}
{{- define "wildfly.appBuilderImage" -}}
{{ include "wildfly.appImage" . }}-build-artifacts
{{- end }}

{{/*
wildfly.builderImage corresponds to the name of the WildFly Builder Image
*/}}
{{- define "wildfly.builderImage" -}}
{{ .Values.build.s2i.builderImage }}:{{ include "wildfly.version" . }}
{{- end }}

{{/*
wildfly.runtimeImage corresponds to the name of the WildFly Runtime Image
*/}}
{{- define "wildfly.runtimeImage" -}}
{{ .Values.build.s2i.runtimeImage }}:{{ include "wildfly.version" . }}
{{- end }}

{{/*
If wildfly.version is not defined, use by defaul the Chart's appVersion
*/}}
{{- define "wildfly.version" -}}
{{- default .Chart.AppVersion .Values.build.s2i.version -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wildfly.appName" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "wildfly.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wildfly.labels" -}}
helm.sh/chart: {{ include "wildfly.chart" . }}
{{ include "wildfly.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wildfly.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wildfly.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
