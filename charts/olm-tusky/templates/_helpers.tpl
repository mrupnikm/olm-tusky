{{/*
Create chart name and version as used by the chart label
*/}}
{{- define "tusky-db-backup.fullname" -}}
{{- printf "%s" (include "tusky-db-backup.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name
*/}}
{{- define "tusky-db-backup.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tusky-db-backup.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ include "tusky-db-backup.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
