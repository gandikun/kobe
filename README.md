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



## Service Mesh(Istio)

Istio Basic Understanding

- [https://www.infoworld.com/article/3328817/what-is-istio-the-kubernetes-service-mesh-explained.html](https://www.infoworld.com/article/3328817/what-is-istio-the-kubernetes-service-mesh-explained.html)
- [https://glasnostic.com/blog/kubernetes-service-mesh-what-is-istio](https://glasnostic.com/blog/kubernetes-service-mesh-what-is-istio)
- [https://istio.io/docs/concepts/what-is-istio/](https://istio.io/docs/concepts/what-is-istio/)

Istio Multicluster Setup

- [https://istio.io/docs/setup/kubernetes/install/multicluster/vpn/](https://istio.io/docs/setup/kubernetes/install/multicluster/vpn/)
  - [https://istio.io/docs/tasks/multicluster/split-horizon-eds/](https://istio.io/docs/tasks/multicluster/split-horizon-eds/)
- [https://istio.io/docs/setup/kubernetes/install/multicluster/gateways/](https://istio.io/docs/setup/kubernetes/install/multicluster/gateways/)
  - [https://istio.io/docs/tasks/multicluster/gateways/](https://istio.io/docs/tasks/multicluster/gateways/)

Accessing Services Outside Istio Mesh

- [https://istio.io/docs/tasks/traffic-management/egress/egress-control/](https://istio.io/docs/tasks/traffic-management/egress/egress-control/)

Extending your Mesh(make your VMs join your GKE service mesh)

- [https://istio.io/docs/setup/kubernetes/additional-setup/mesh-expansion/](https://istio.io/docs/setup/kubernetes/additional-setup/mesh-expansion/)

Sample Examples

- [https://github.com/GoogleCloudPlatform/istio-samples](https://github.com/GoogleCloudPlatform/istio-samples)



## Scaling In Kubernetes

VPA

- [https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler)

HPA

- [https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
- [https://medium.com/uptime-99/kubernetes-hpa-autoscaling-with-custom-and-external-metrics-da7f41ff7846](https://medium.com/uptime-99/kubernetes-hpa-autoscaling-with-custom-and-external-metrics-da7f41ff7846)

Auto Scaling in Kuberenetes

- [https://medium.com/kubecost/understanding-kubernetes-cluster-autoscaling-675099a1db92](https://medium.com/kubecost/understanding-kubernetes-cluster-autoscaling-675099a1db92)
- [https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-autoscaler](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-autoscaler)



## Canary in Kubernetes

Using Spinnaker:

- [https://cloud.google.com/solutions/automated-canary-analysis-kubernetes-engine-spinnaker](https://cloud.google.com/solutions/automated-canary-analysis-kubernetes-engine-spinnaker)

Using Code Build:

- [https://codelabs.developers.google.com/codelabs/cloud-builder-gke-continuous-deploy/index.html#8](https://codelabs.developers.google.com/codelabs/cloud-builder-gke-continuous-deploy/index.html#8)

Using native kubernetes way:

- [https://medium.com/google-cloud/kubernetes-canary-deployments-for-mere-mortals-13728ce032fe](https://medium.com/google-cloud/kubernetes-canary-deployments-for-mere-mortals-13728ce032fe)
- [https://www.bogotobogo.com/DevOps/Docker/Docker-Rolling-Update-Canary-Blue-Green-Deployments-to-GKE-Kubernetes.php](https://www.bogotobogo.com/DevOps/Docker/Docker-Rolling-Update-Canary-Blue-Green-Deployments-to-GKE-Kubernetes.php)
- [https://medium.com/google-cloud/automated-canary-deployments-with-flagger-and-istio-ac747827f9d1](https://medium.com/google-cloud/automated-canary-deployments-with-flagger-and-istio-ac747827f9d1)

Using Flagger and Istio:

- [https://medium.com/google-cloud/automated-canary-deployments-with-flagger-and-istio-ac747827f9d1](https://medium.com/google-cloud/automated-canary-deployments-with-flagger-and-istio-ac747827f9d1)

Using Istio:

- [https://github.com/GoogleCloudPlatform/istio-samples/tree/master/istio-canary-gke](https://github.com/GoogleCloudPlatform/istio-samples/tree/master/istio-canary-gke)

- [https://istio.io/blog/2017/0.1-canary/](https://istio.io/blog/2017/0.1-canary/)

- [https://istio.io/docs/tasks/traffic-management/traffic-shifting/](https://istio.io/docs/tasks/traffic-management/traffic-shifting/)

- [https://istio.io/docs/concepts/traffic-management/#splitting-traffic-between-versions](https://istio.io/docs/concepts/traffic-management/#splitting-traffic-between-versions)

  ​