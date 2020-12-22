// .libsonnet is the extension for Jsonnet libraries.
// Use it to dinstinguish helper code from actual configuration.
{
  k:: {
    deployment: {
      new(name, containers): {
        apiVersion: "apps/v1",
        kind: "Deployment",
        metadata: {
          name: name,
        },
        spec: {
          selector: { matchLabels: {
            name: name,
          }},
          template: {
            metadata: { labels: {
              name: name,
            }},
            spec: { containers: containers }
          }
        }
      }
    },
    service: {
      new(name, ports): {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          labels: {
            name: name,
          },
          name: name,
        },
        spec: {
          ports: ports,
          selector: {
            name: name,
          },
          type: 'NodePort',
        },
      },
    }
  }
}
