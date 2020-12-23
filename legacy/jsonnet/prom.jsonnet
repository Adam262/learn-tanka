{
  // Prometheus
  prometheus: {
    deployment: $.k8s.deployment.new(
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
      }],
      {
        minReadySeconds: 10,
        replicas: 1,
        revisionHistoryLimit: 10
      }
    ),

    service: $.k8s.service.new(
      $._config.prometheus.name,
      [{
        name: '%s-api' % $._config.prometheus.name, // printf-style formatting
        port: $._config.prometheus.port,
        targetPort: $._config.prometheus.port,
      }]
    )
  },
}
