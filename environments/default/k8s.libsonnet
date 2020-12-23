/* 
  .libsonnet is the extension for Jsonnet libraries.
  Use it to dinstinguish helper code from actual configuration.
*/

local deployment_spec(name, containers) = 
  {
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
  };

{
  k:: {
    deployment: {
      new(name, containers): 
        deployment_spec(name, containers)
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
