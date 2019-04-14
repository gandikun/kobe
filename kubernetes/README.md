## Create Cluster:

Assume Network already setup, we never cleanup it later
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
--preemptible --max-nodes 1 \
--num-nodes 1 \
--machine-type n1-standard-2 \
--no-enable-legacy-authorization \
--project g-zero
```


## Update whitelisted allowed IP for master GKE cluster

```
gcloud container clusters update g-zero-gcp --region asia-southeast1 --enable-master-authorized-networks --project g-zero --master-authorized-networks $(curl -s ifconfig.co)/32
```

## Get GKE cLuster credentials

```
gcloud container clusters get-credentials  g-zero-gcp --region asia-southeast1 --project g-zero
```

## Give admin cluster role permission

```
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user me@gandi.id
```

## Create CLoud NAT for ethernet

```
gcloud compute routers create g-zero-nat --network g-zero --region asia-southeast1 --project g-zero
gcloud compute routers nats create g-zero-nat-config --router g-zero-nat --router-region asia-southeast1 --nat-all-subnet-ip-ranges --auto-allocate-nat-external-ips --project g-zero
```

## Simple example with NEG HTTP Load balancer

```
kubectl apply -f zero-namespace.yaml
kubectl apply -f zero-secret.yaml
kubectl apply -f zero-deployment.yaml
kubectl apply -f zero-backend.yaml
kubectl apply -f zero-service-ingress.yaml
kubectl apply -f zero-ingress.yaml
```

## Simple RBAC example

```
kubectl apply -f zero-rbac-role-pods-write.yaml
kubectl apply -f zero-rbac-role-admin.yaml
kubectl apply -f zero-access.yaml
```

## Nginx Ingress example

App(s)
```
kubectl apply -f zero-namespace.yaml
kubectl apply -f zero-secret.yaml
kubectl apply -f zero-deployment.yaml
kubectl apply -f zero-service-app.yaml
kubectl apply -f zero-ingress-appnginx.yaml
```

Nginx Ingress
```
kubectl apply -f zero-namespace-nginx.yaml
kubectl apply -f zero-configmaps-nginx.yaml
kubectl apply -f zero-rbac-nginx.yaml
kubectl apply -f zero-deployment-nginx.yaml
kubectl apply -f zero-service-nginx.yaml
```


## Cleaning up

Hard way :
```
gcloud -q container clusters delete g-zero-gcp --region asia-southeast1 --project g-zero
```

If CLoud Nat created
```
gcloud -q compute routers nats delete g-zero-nat-config --router g-zero-nat --region asia-southeast1 --project g-zero
gcloud -q compute routers delete g-zero-nat --region asia-southeast1 --project g-zero
```


