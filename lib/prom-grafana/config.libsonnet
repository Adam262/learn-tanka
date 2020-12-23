{
  // +:: is important (we don't want to override the
  // _config object, just add to it)
  _config+:: {
    // define a namespace for this library
    prom_grafana: {
      grafana: {
        port: 3000,
        name: "grafana",
      },
      prometheus: {
        port: 9090,
        name: "prometheus"
      }
    }
  },

  // again, make sure to use +::
  _images+:: {
    prom_grafana: {
      grafana: "%s/%s" % [$._config.prom_grafana.grafana.name, $._config.prom_grafana.grafana.name],
      prometheus: "prom/%s" % $._config.prom_grafana.prometheus.name,
    }
  }
}
