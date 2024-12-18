#!/bin/bash

echo "Criando as imagens .........."

docker build -t danielmoreiradeveloper/projeto-k8s-pipeline-deploy-app:1.0 app/.
docker build -t danielmoreiradeveloper/projeto-k8s-pipeline-deploy-database:1.0 mysql/.

echo "Realizando push das imagens .........."

docker push danielmoreiradeveloper/projeto-k8s-pipeline-deploy-app:1.0
docker push danielmoreiradeveloper/projeto-k8s-pipeline-deploy-database:1.0

echo "Criando serviços no cluster Kubernetes"

kubectl apply -f ./services.yml

echo "Criando LoadBalancers no cluster Kubernetes"

kubectl apply -f ./loadbalancer.yml

echo "Criando persistentVolume no cluster Kubernetes"
kubectl apply -f ./persistentvolume.yml

echo "Criando os deployments"

kubectl apply -f ./app-deployment.yml
kubectl apply -f ./mysql-deployment.yml