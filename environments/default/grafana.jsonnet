{
  // Grafana
  grafana: {
    deployment: $.k.deployment.new('grafana', [{
      image: '%s/%s' % [$._config.grafana.name, $._config.grafana.name],
      name: $._config.grafana.name,
      ports: [{
        containerPort: $._config.grafana.port,
        name: 'ui',
      }]
    }]),

    service: {
      apiVersion: 'v1',
      kind: 'Service',
      metadata: {
        labels: {
          name: $._config.grafana.name,
        },
        name: $._config.grafana.name,
      },
      spec: {
        ports: [{
            name: '%s-ui' % $._config.grafana.name, // printf-style formatting
            port: $._config.grafana.port,
            targetPort: $._config.grafana.port,
        }],
        selector: {
          name: $._config.grafana.name,
        },
        type: 'NodePort',
      },
    },
  }
}
