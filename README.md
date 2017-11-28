# KollaBrigade

KollaBrigade is a [Brigade](https://github.com/Azure/brigade)Project that builds 
[Kolla](https://github.com/openstack/kolla) OpenStack containers. 

## Prerequisites

1. Have a running [Kubernetes](https://kubernetes.io/docs/setup/) environment
2. Setup [Helm](https://github.com/kubernetes/helm)

## Install

### Set up Brigade

Follow the [quick-start guide](https://github.com/Azure/brigade#quickstart):

Install Brigade into your Kubernetes cluster is to install it using Helm.

```bash
$ helm repo add brigade https://azure.github.io/brigade
$ helm install -n brigade brigade/brigade
```

To manually run Brigade Projects the **brig** binary is required. Follow the
[Developers Guide](https://github.com/Azure/brigade/blob/master/docs/topics/developers.md)
to build the binary. Assuming Brigade is cloned and prerequisites met, simply run:
```bash
$ make brig
```
Test **brig** with `brig version`

### Install KollaBrigade

Clone KollaBrigade and change directory
```bash
$ git clone https://github.com/lukepatrick/KollaBrigade
$ cd KollaBrigade

```
Helm install KollaBrigade
> note the name and namespace can be customized
```bash
$ helm install --name kollabrigade brigade/brigade-project -f kollabrigade.yaml
```

## Usage

* Customize OpenStack Project, tags, registry, etc..
* Set up triggers
* Manually run
```
```

## Dockerfile

Build
```bash
docker build -t quay.io/charter-os/kolla-brigade:0.1.0 .
```
Push
```bash
docker push quay.io/charter-os/kolla-brigade:0.1.0
```

## Contribute

PRs accepted.

## License

MIT