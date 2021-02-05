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

{{- define "wildfly.appBuilderImage" -}}
{{- include "wildfly.appName" . }}-build-artifacts
{{- end }}


{{- define "wildfly.builderImage" -}}
{{- include "wildfly.appName" . }}-builder
{{- end }}

{{- define "wildfly.runtimeImage" -}}
{{- include "wildfly.appName" . }}-runtime
{{- end }}

{{- define "wildfly.version" -}}
{{- default .Chart.AppVersion .Values.wildfly.version }}
{{- end }}

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
