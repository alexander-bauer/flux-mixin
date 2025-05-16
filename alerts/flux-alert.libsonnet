{
  prometheusAlerts+:: {
    groups+: [
      {
        name: 'flux-alert',
        rules: [
          {
            alert: 'FluxReconcilationFailed',
            expr: |||
              max(gotk_resource_info{ready="False"}) by (namespace, name, customresource_kind) == 1
            |||,
            labels: {
              severity: 'warning',
            },
            annotations: {
              description: '{{ $labels.customresource_kind }} {{ $labels.name }} reconcilation has been failed for more than 10 minutes in {{ $labels.exported_namespace }} namespace',
              runbook_url: '',
              summary: 'Flux {{ $labels.customresource_kind }} {{ $labels.name }} failed',
            },
            'for': '10m',
          },
        ],
      },
    ],
  },
}
