# olm-paas-deploy

Deploying [opr-paas](https://github.com/belastingdienst/opr-paas) via Operator Lifecycle Manager (OLM) on [Red Hat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift) or [OKD](https://okd.io).

# Installation

To start installation of the operator, apply the resources from the `installation` folder on your cluster. We're creating a new namespace `paas-system` and we're installing the operator in that namespace. You can let ArgoCD manage the installation by using the accompanying application:

```
oc apply -f argocd/app_opr-paas-installation.yaml
```

The installation will start shortly after you've applied the resources the cluster.

You can monitor installation by watching the objects in the namespace:

```bash
watch oc get subscriptions,clusterserviceversions,installplans -n paas-system
```

# Configuration

## Create a secret keypair

* Download the latest release of [opr-paas-crypttool](https://github.com/belastingdienst/opr-paas-crypttool).
* Generate a public key and a private key to be used by the operator:

```bash
./crypttool generate --privateKeyFile opr-paas.key --publicKeyFile opr-paas.pub
Private key written to opr-paas.key
Public key written to opr-paas.pub
```

Create a Secret with the private key:

```bash
oc create secret generic paas-private-keys --from-file=privateKey0=./opr-paas.key -n paas-system
```

Create a ConfigMap with the public key:

```bash
oc create configmap paas-public-key --from-file=opr-paas.pub=./opr-paas.pub -n paas-system
```
