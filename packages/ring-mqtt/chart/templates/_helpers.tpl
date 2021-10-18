{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "ring-mqtt.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expands image name.
*/}}
{{- define "ring-mqtt.image" -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag -}}
{{- printf "%s:%s" .Values.image.repository $tag -}}
{{- end -}}

{{/*
The standart k8s probe used for redinessProbe and livenessProbe
ring-mqtt.probe is http get request
*/}}
{{- define "ring-mqtt.probe" -}}
httpGet:
  path: /
  port: {{ .Values.service.internalPort }}
  initialDelay: 5
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "ring-mqtt.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
labels.standard prints the standard Helm labels.
The standard labels are frequently used in metadata.
*/}}
{{- define "ring-mqtt.labels.standard" -}}
app: {{ template "ring-mqtt.name" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
chart: {{ template "ring-mqtt.chartref" . }}
{{- end -}}

{{/*
chartref prints a chart name and version.
It does minimal escaping for use in Kubernetes labels.
*/}}
{{- define "ring-mqtt.chartref" -}}
  {{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end -}}

{{/*
Templates in ring-mqtt.utils namespace are help functions.
*/}}

{{/*
ring-mqtt.utils.tls functions makes host-tls from host name
usage: {{ "www.example.com" | ring-mqtt.utils.tls }}
output: www-example-com-tls
*/}}
{{- define "ring-mqtt.utils.tls" -}}
{{- $host := index . | replace "." "-" -}}
{{- printf "%s-tls" $host -}}
{{- end -}}
