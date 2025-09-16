{{/*
Expand the name of the chart.
*/}}
{{- define "plausible-analytics.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "plausible-analytics.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "plausible-analytics.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "plausible-analytics.labels" -}}
helm.sh/chart: {{ include "plausible-analytics.chart" . }}
{{ include "plausible-analytics.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "plausible-analytics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "plausible-analytics.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "plausible-analytics.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "plausible-analytics.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Define the name of the secret to use
*/}}
{{- define "plausible-analytics.secretName" -}}
{{- if .Values.secret.existingSecret -}}
{{- .Values.secret.existingSecret -}}
{{- else -}}
{{- template "plausible-analytics.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Generate the PostgreSQL service name
*/}}
{{- define "plausible-analytics.postgresql.serviceName" -}}
{{- if .Values.postgresql.enabled -}}
{{- printf "%s-postgresql" (include "plausible-analytics.fullname" .) -}}
{{- else -}}
{{- required "A PostgreSQL service name is required when postgresql.enabled is false" .Values.postgresql.externalServiceName -}}
{{- end -}}
{{- end -}}

{{/*
Generate the ClickHouse service name
*/}}
{{- define "plausible-analytics.clickhouse.serviceName" -}}
{{- if .Values.clickhouse.enabled -}}
{{- printf "%s-clickhouse" (include "plausible-analytics.fullname" .) -}}
{{- else -}}
{{- required "A ClickHouse service name is required when clickhouse.enabled is false" .Values.clickhouse.externalServiceName -}}
{{- end -}}
{{- end -}}

{{/*
Generate the default PostgreSQL database URL
*/}}
{{- define "plausible-analytics.postgresql.defaultURL" -}}
{{- $serviceName := include "plausible-analytics.postgresql.serviceName" . -}}
{{- $username := .Values.postgresql.auth.username | default "postgres" -}}
{{- $password := .Values.postgresql.auth.password | default "postgres" -}}
{{- $database := .Values.postgresql.auth.database | default "plausible_db" -}}
{{- $port := .Values.postgresql.port | default 5432 -}}
{{- printf "postgres://%s:%s@%s:%v/%s" $username $password $serviceName $port $database -}}
{{- end -}}

{{/*
Generate the default ClickHouse database URL
*/}}
{{- define "plausible-analytics.clickhouse.defaultURL" -}}
{{- $serviceName := include "plausible-analytics.clickhouse.serviceName" . -}}
{{- $username := .Values.clickhouse.auth.username | default "clickhouse" -}}
{{- $password := .Values.clickhouse.auth.password | default "password" -}}
{{- $database := .Values.clickhouse.auth.database | default "plausible_events_db" -}}
{{- $port := 8123 -}}
{{- printf "http://%s:%s@%s:%v/%s" $username $password $serviceName $port $database -}}
{{- end -}}
