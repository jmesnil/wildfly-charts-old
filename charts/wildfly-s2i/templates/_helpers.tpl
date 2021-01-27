{{/*
Expand the name of the chart.
*/}}
{{- define "wildfly-s2i.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "wildfly-s2i.appBuilderImage" -}}
{{- include "wildfly-s2i.appname" . }}-build-artifacts
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wildfly-s2i.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "wildfly-s2i.builderImage" -}}
{{- include "wildfly-s2i.fullname" . }}-builder
{{- end }}

{{- define "wildfly-s2i.runtimeImage" -}}
{{- include "wildfly-s2i.fullname" . }}-runtime
{{- end }}

{{- define "wildfly-s2i.version" -}}
{{- default .Chart.AppVersion .Values.wildfly.version }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wildfly-s2i.appname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "wildfly-s2i.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wildfly-s2i.labels" -}}
helm.sh/chart: {{ include "wildfly-s2i.chart" . }}
{{ include "wildfly-s2i.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wildfly-s2i.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wildfly-s2i.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
