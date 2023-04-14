{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "paradisApp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Helm labels
*/}}
{{- define "paradisApp.helmLabels" -}}
helm.sh/chart: {{ include "paradisApp.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "paradisApp.labels" -}}
{{- if .Values.commit -}}
version: "{{ .Values.version }}-{{ .Values.commit }}"
{{- else -}}
version: "{{ .Values.version }}"
{{- end }}
{{ include "paradisApp.selectorLabels" . }}
{{- end }}

{{/*
Define App Label Selector
*/}}
{{- define "paradisApp.appLabel" -}}
{{- default .Release.Name .Values.appLabelOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "paradisApp.selectorLabels" -}}
app: {{ include "paradisApp.appLabel" . }}
{{- end }}