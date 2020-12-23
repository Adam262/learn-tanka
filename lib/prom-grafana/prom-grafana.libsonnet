/*
  Jsonnet is lazy-evaluated.
  That is, the imported files are first "copied" into main.jsonnet (the root object) and then converted to JSON.
*/

(import "github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet") +
(import "./config.libsonnet") +
{
  // Extract only needed parts of ksonnet-util
  local deploy = $.apps.v1.deployment,
  local container = $.core.v1.container,
  local port = $.core.v1.containerPort,
  local service = $.core.v1.service,
  local c = $._config.prom_grafana,
  local i = $._images.prom_grafana,

  prom_grafana: {
    // Prometheus
    prometheus: {
      deployment: deploy.new(
        name = c.prometheus.name,
        replicas = 1,
        containers = [
          container.new(
            c.prometheus.name,
            i.prometheus
          )
          + container.
              withPorts([
                port.new(
                  'api',
                  c.prometheus.port
                )
              ]).
              withImagePullPolicy('IfNotPresent')
        ]
      ).
        withMinReadySeconds(10).
        withReplicas(1).
        withRevisionHistoryLimit(10),

      service: $.util.serviceFor(self.deployment)
    },

    // Grafana
    grafana: {
      deployment: deploy.new(
        name = c.grafana.name,
        replicas = 1,
        containers = [
          container.new(
            c.grafana.name,
            i.grafana,
          )
          + container.
              withPorts([
                port.new(
                  'ui',
                  c.grafana.port
                )
              ]).
              withImagePullPolicy('Always')
        ]
      ),

      service:
        $.util.serviceFor(self.deployment)
        + service.mixin.spec.withType("NodePort"),
    },
  }
}
