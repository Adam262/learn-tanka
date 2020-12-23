/*
  Jsonnet is lazy-evaluated.
  That is, the imported files are first "copied" into main.jsonnet (the root object) and then converted to JSON.
*/

(import "github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet") +

{
  // Extract only needed parts of ksonnet-util
  local deploy = $.apps.v1.deployment,
  local container = $.core.v1.container,
  local port = $.core.v1.containerPort,
  local service = $.core.v1.service,

  _config:: { // :: is a private key that will appear in compiled json
    grafana: {
      port: 3000,
      name: "grafana",
    },
    prometheus: {
      port: 9090,
      name: "prometheus"
    }
  },

  // Prometheus
  prometheus: {
    deployment: deploy.new(
      name = $._config.prometheus.name,
      replicas = 1,
      containers = [
        container.new(
          name = $._config.prometheus.name,
          image = 'prom/%s' % $._config.prometheus.name
        )
        + container.withPorts([
            port.new(
              'api',
              $._config.prometheus.port
            )
          ])
      ]
    ),

    service: $.util.serviceFor(self.deployment)
  },

  // Grafana
  grafana: {
    deployment: deploy.new(
      name = $._config.grafana.name,
      replicas = 1,
      containers = [
        container.new(
          name = $._config.grafana.name,
          image = '%s/%s' % [$._config.grafana.name, $._config.grafana.name],
        )
        + container.withPorts([
            port.new(
              'ui',
              $._config.grafana.port
            )
          ])
      ]
    ),

    service:
      $.util.serviceFor(self.deployment)
      + service.mixin.spec.withType("NodePort"),
  },

  // Namespace
  namespace: {
    apiVersion: 'v1',
    kind: 'Namespace',
    metadata: {
      name: "cool-namespace"
    }
  }
}
