(import "prom-grafana/prom-grafana.libsonnet") +
{
  // again, we only want to patch, not replace, thus +::
  _images+:: {
    // we update this one entirely, so we can replace this one (:)
    // use specific image versions in prod over latest
    prom_grafana: {
      prometheus: "prom/prometheus:v2.14",
      grafana: "grafana/grafana:6.5.2"
    }
  }
}
