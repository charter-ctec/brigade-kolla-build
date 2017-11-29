# KollaBrigade

[![Docker Repository on Quay](https://quay.io/repository/charter-os/kolla-brigade/status "Docker Repository on Quay")](https://quay.io/repository/charter-os/kolla-brigade)

KollaBrigade is a [Brigade](https://github.com/Azure/brigade) Project that builds 
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

Manually run the project. The project name is the same as the project value in
the *kollabrigade.yaml*
```bash
$ brig run lukepatrick/KollaBrigade
```

To customize the parameters of the Project, edit *brigade.js*
```javascript
  //set up ENV
  kb_job.env = {
    "KOLLA_BASE": "ubuntu",
    "KOLLA_TYPE": "source",
    "KOLLA_TAG": "3.0.2-kb",
    "KOLLA_PROJECT": "keystone",
    "KOLLA_NAMESPACE": "charter-os",
    "KOLLA_VERSION": "3.0.2",
    "DOCKER_USER": "user",
    "DOCKER_PASS": "pass",
    "DOCKER_REGISTRY": "quay.io",
    "REPO_BASE": "https://github.com/openstack",
    "PROJECT_REFERENCE": "stable/ocata",
    "PROJECT_GIT_COMMIT": "e1a94f39edb6cf777c71c7a511476b1e60436ab9",
    "RELEASE": "stable-ocata"
  }
```
Change **KOLLA_PROJECT** for a different OpenStack Application, 
**PROJECT_REFERENCE** for a different release, or **KOLLA_TAG** 
for the Tag applied to the Images created. 

If *brigade.js* is customized then running the Project will need to have source *brigade.js* overriden

Run with override:
```bash
$ brig run lukepatrick/KollaBrigade -f brigade.js
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