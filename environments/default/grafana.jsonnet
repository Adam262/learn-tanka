{
  // Grafana
  grafana: {
    deployment: $.k8s.deployment.new($._config.grafana.name, [{
      image: '%s/%s' % [$._config.grafana.name, $._config.grafana.name],
      name: $._config.grafana.name,
      ports: [{
        containerPort: $._config.grafana.port,
        name: 'ui',
      }]
    }]),

    service: $.k8s.service.new($._config.grafana.name, [{
      name: '%s-ui' % $._config.grafana.name, // printf-style formatting
      port: $._config.grafana.port,
      targetPort: $._config.grafana.port,
    }])
  }
}
