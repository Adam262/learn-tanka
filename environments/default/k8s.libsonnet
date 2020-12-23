/* 
  .libsonnet is the extension for Jsonnet libraries.
  Use it to dinstinguish helper code from actual configuration.
*/

local deployment_spec(name, containers) = 
  {
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

// +: syntax will merge old `spec` with patch updated keys only
local deployment_spec_patch(patch) = {
  spec+: patch
};

local service_spec(name, ports) = {
  spec: {
    ports: ports,
    selector: {
      name: name,
    },
  },
};

local service_spec_patch(patch) = {
  spec+: patch
};

{
  k8s:: {
    deployment: {
      new(name, containers, patch={}): {
        apiVersion: "apps/v1",
        kind: "Deployment",
        metadata: {
          name: name,
        }
      } +
      deployment_spec(name, containers) +
      deployment_spec_patch(patch),
    },
    service: {
      new(name, ports, patch={ type: 'ClusterIP' }): {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          labels: {
            name: name,
          },
          name: name,
        },
      } +
      service_spec(name, ports) +
      service_spec_patch(patch)
    }
  }
}
