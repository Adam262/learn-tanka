{
  local patch = {
    spec+: {
      minReadySeconds: 10,
      replicas: 1,
      revisionHistoryLimit: 10
    }
  },

  local deployment = $.k.deployment.new(
      $._config.prometheus.name,
      [{
        image: 'prom/%s' % $._config.prometheus.name,
        imagePullPolicy: 'IfNotPresent',
        name: $._config.prometheus.name,
        ports: [
          {
            containerPort: $._config.prometheus.port,
            name: 'api',
          },
        ],
      }]
    ),

  // Prometheus
  prometheus: {
    deployment: deployment + patch,

    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        labels: {
          name: $._config.prometheus.name,
        },
        name: $._config.prometheus.name,
      },
      spec: {
        ports: [
          {
            name: '%s-api' % $._config.prometheus.name,
            port: $._config.prometheus.port,
            targetPort: $._config.prometheus.port,
          },
        ],
        selector: {
          name: $._config.prometheus.name,
        },
      },
    },
  }
}
