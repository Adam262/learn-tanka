(import "prom-grafana/prom-grafana.libsonnet") +
{
  prom_grafana+: {
    prometheus+: {
      deployment+: {
        metadata+: {
          labels+: {
            // patch a label
            foo: "bar"
          }
        }
      }
    }
  }
}
