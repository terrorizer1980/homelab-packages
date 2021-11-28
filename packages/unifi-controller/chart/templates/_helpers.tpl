{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "unifi-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Expands image name.
*/}}
{{- define "unifi-controller.image" -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag -}}
{{- printf "%s:%s" .Values.image.repository $tag -}}
{{- end -}}

{{/*
The standart k8s probe used for redinessProbe and livenessProbe
unifi-controller.probe is http get request
*/}}
{{- define "unifi-controller.probe" -}}
tcpSocket:
  port: 8080
initialDelaySeconds: 120
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "unifi-controller.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
labels.standard prints the standard Helm labels.
The standard labels are frequently used in metadata.
*/}}
{{- define "unifi-controller.labels.standard" -}}
app: {{ template "unifi-controller.name" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
chart: {{ template "unifi-controller.chartref" . }}
{{- end -}}

{{/*
chartref prints a chart name and version.
It does minimal escaping for use in Kubernetes labels.
*/}}
{{- define "unifi-controller.chartref" -}}
  {{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end -}}

{{/*
Templates in unifi-controller.utils namespace are help functions.
*/}}

{{/*
unifi-controller.utils.tls functions makes host-tls from host name
usage: {{ "www.example.com" | unifi-controller.utils.tls }}
output: www-example-com-tls
*/}}
{{- define "unifi-controller.utils.tls" -}}
{{- $host := index . | replace "." "-" -}}
{{- printf "%s-tls" $host -}}
{{- end -}}
