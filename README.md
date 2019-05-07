## Install minikube :

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube

sudo ln -s minikube /usr/local/bin/minikube
```

## How to minikube :

`https://kubernetes.io/docs/setup/minikube/`

## Install kubectl : 

```
sudo apt install kubectl
```

## How to switch between work environment :

`https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl`


## Install docker :

```
sudo apt install docker.io
```


## How to use docker :

`https://www.howtoforge.com/tutorial/how-to-create-docker-images-with-dockerfile/`

`https://cloud.google.com/container-registry/docs/pushing-and-pulling`

`https://stackoverflow.com/questions/41509439/whats-the-difference-between-clusterip-nodeport-and-loadbalancer-service-types`

`https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/`

## Rolling update with new images:

`https://kubernetes.io/docs/concepts/workloads/controllers/deployment/`


## Simple python webserver:

`https://www.afternerd.com/blog/python-http-server/`


## Make kubectl able pull/use image from google private registry:

`https://container-solutions.com/using-google-container-registry-with-kubernetes/`

`https://ryaneschinger.com/blog/using-google-container-registry-gcr-with-minikube/`

```
kubectl create secret docker-registry gzero-access-token --docker-server=asia.gcr.io \
--docker-username=oauth2accesstoken --docker-password="$(gcloud auth print-access-token)" --docker-email=me@gandi.id

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gzero-access-token"}]}'
```


## Kubernetes clusters:

`https://cloud.google.com/kubernetes-engine/docs/quickstart`

`https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters`

`https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/`

`https://medium.com/platformer-blog/enable-rolling-updates-in-kubernetes-with-zero-downtime-31d7ec388c81`

`https://cloud.google.com/kubernetes-engine/docs/how-to/container-native-load-balancing`

`https://cloud.google.com/kubernetes-engine/docs/tutorials/http-balancer`

`https://kubernetes.io/docs/concepts/services-networking/ingress/`

`https://pracucci.com/graceful-shutdown-of-kubernetes-pods.html`

`https://kubernetes.io/docs/concepts/configuration/secret/`


```
gcloud container clusters create g-zero-gcp \
    --zone asia-southeast1 \
    --enable-master-authorized-networks \
    --enable-ip-alias \
    --network g-zero \
    --subnetwork zero-gke \
    --cluster-secondary-range-name zero-gke-0 \
    --services-secondary-range-name zero-gke-1 \
    --enable-private-nodes \
    --master-ipv4-cidr 172.20.0.0/28 \
    --no-enable-basic-auth \
    --tags=g-zero-gke \
    --preemptible \
    --max-nodes 1 \
    --num-nodes 1 \
    --machine-type f1-micro
```

## To enable RBAC adding this when creating cluster

```
--no-enable-legacy-authorization
```


```
gcloud container clusters update g-zero-gcp \
    --region asia-southeast1 \
    --enable-master-authorized-networks \
    --master-authorized-networks 139.195.9.100/32
```

## RBAC

`https://kubernetes.io/docs/reference/access-authn-authz/rbac/`

```
Set your account as admin cluster
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user me@gandi.id
```

Playing without context but have cluster information in kubeconfig
```
Get token access fro your account
TOKEN=`gcloud auth print-access-token`

kubectl --cluster xxxx --token $TOKEN --namespace yyyy  get pods

```

Just checking access
```
kubectl auth can-i get pods
```

## Nginx Ingress

```
http://rahmonov.me/posts/nginx-ingress-controller/
https://akomljen.com/kubernetes-nginx-ingress-controller/
https://hackernoon.com/setting-up-nginx-ingress-on-kubernetes-2b733d8d2f45
https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nginx-ingress-with-cert-manager-on-digitalocean-kubernetes
https://docs.giantswarm.io/guides/advanced-ingress-configuration/
https://kubernetes.github.io/ingress-nginx/examples/rewrite/

PS: Mark Statham example seems follow from digitalocean link
https://gitlab.cloud.bukalapak.io/mstatham/example-cluster-setup
```

## How to rollback

```
https://romain.dorgueil.net/blog/en/tips/2016/08/27/rollout-rollback-kubernetes-deployment.html
```



## Additional Note

```
https://www.chrismoos.com/2016/09/28/zero-downtime-deployments-kubernetes/
```
