// This code works even though grafana.jsonnet + prom.jsonnet refers to the root object $ from outside its scope.
// This is bc Jsonnet is lazy-evaluated
// That is, grafana.jsonnet + prom.jsonnet are first "copied" into main.jsonnet (the root object) and then evaluated.
// So this code consists of all three objects joined to one big object, which is then converted to JSON.
(import "grafana.jsonnet") +
(import "prom.jsonnet") +
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

  // Namespace
  namespace: {
    apiVersion: 'v1',
    kind: 'Namespace',
    metadata: {
      name: "cool-namespace"
    }
  }
}
