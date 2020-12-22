# Learning Tanka

### Overview
This is a tutorial to learn Tanka. It follows the official Tanka [tutorial](https://tanka.dev/)

### Getting Started
Please set up the following dependencies:

* Git clone this repo (run subsequent commands from within repo)

```
git clone git@github.com:Adam262/learn-tanka.git learn-tanka && cd $_

```

* Install [Homebrew package manager](https://docs.brew.sh/Installation)

* Run `brew bundle`. This will install dependencies such as [ASDF](https://github.com/asdf-vm/asdf) and [Docker Desktop for Mac](https://hub.docker.com/editions/community/docker-ce-desktop-mac/) if needed

* Install ASDF plugins and packages needed for this app
```
asdf plugin add tanka
asdf plugin add kubectl

asdf install
``` 

### Commands

```
# V1 - Build from legacy yaml

kubectl apply -f legacy-yaml/prom.yaml legacy-yaml/grafana.yaml
kubectl port-forward deployments/grafana 8080:3000

## Check it worked. Now go to http://localhost:8080 in your browser and login using admin:admin. 
## Navigate to Configuration > Data Sources > Add data source, choose Prometheus as type and enter URL http://prometheus:9090. 
## Hit Save & Test which should yield a big green bar telling you everything is good.

kubectl delete -f legacy-yaml/prom.yaml -f legacy-yaml/grafana.yaml

```
