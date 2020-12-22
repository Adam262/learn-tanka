{
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
  // Grafana
  grafana: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: $._config.grafana.name,
      },
      spec: {
        selector: {
          matchLabels: {
            name: $._config.grafana.name,
          },
        },
        template: {
          metadata: {
            labels: {
              name: $._config.grafana.name,
            },
          },
          spec: {
            containers: [
              {
                image: '%s/%s' % [$._config.grafana.name, $._config.grafana.name],
                name: $._config.grafana.name,
                ports: [{
                    containerPort: $._config.grafana.port,
                    name: 'ui',
                }],
              },
            ],
          },
        },
      },
    },
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
  },

  // Prometheus
  prometheus: {
    deployment: {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: $._config.prometheus.name,
      },
      spec: {
        minReadySeconds: 10,
        replicas: 1,
        revisionHistoryLimit: 10,
        selector: {
          matchLabels: {
            name: $._config.prometheus.name,
          },
        },
        template: {
          metadata: {
            labels: {
              name: $._config.prometheus.name,
            },
          },
          spec: {
            containers: [
              {
                image: 'prom/%s' % $._config.prometheus.name,
                imagePullPolicy: 'IfNotPresent',
                name: $._config.prometheus.name,
                ports: [
                  {
                    containerPort: $._config.prometheus.port,
                    name: 'api',
                  },
                ],
              },
            ],
          },
        },
      },
    },
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
