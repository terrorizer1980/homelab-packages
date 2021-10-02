{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "chartmuseum.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expands image name.
*/}}
{{- define "chartmuseum.image" -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag -}}
{{- printf "%s:%s" .Values.image.repository $tag -}}
{{- end -}}

{{/*
The standart k8s probe used for redinessProbe and livenessProbe
chartmuseum.probe is http get request
*/}}
{{- define "chartmuseum.probe" -}}
httpGet:
  path: /
  port: {{ .Values.service.internalPort }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "chartmuseum.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
labels.standard prints the standard Helm labels.
The standard labels are frequently used in metadata.
*/}}
{{- define "chartmuseum.labels.standard" -}}
app: {{ template "chartmuseum.name" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
chart: {{ template "chartmuseum.chartref" . }}
{{- end -}}

{{/*
chartref prints a chart name and version.
It does minimal escaping for use in Kubernetes labels.
*/}}
{{- define "chartmuseum.chartref" -}}
  {{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end -}}

{{/*
Templates in chartmuseum.utils namespace are help functions.
*/}}

{{/*
chartmuseum.utils.tls functions makes host-tls from host name
usage: {{ "www.example.com" | chartmuseum.utils.tls }}
output: www-example-com-tls
*/}}
{{- define "chartmuseum.utils.tls" -}}
{{- $host := index . | replace "." "-" -}}
{{- printf "%s-tls" $host -}}
{{- end -}}
