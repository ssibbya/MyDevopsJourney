# Kubernetes Learning - README

## Kubernetes Basics

### What is a Pod?
- In Kubernetes, the **Pod** is the smallest and most basic deployable unit.
- A Pod defines how to run one or more containers that share storage/network.
- In Docker, you'd use a command like:
  ```bash
  docker run -d --name demo -p 8080:8080 --network=mern -it demo-frontend
  ```
  This includes all run-time details via command line.
- In Kubernetes, this info is defined in a YAML manifest file (e.g., `pod.yaml`), making configuration declarative and reusable.

### kubectl
- `kubectl` is the command line interface to interact with Kubernetes clusters.

## Why Use YAML?
- Kubernetes uses YAML files for declarative configuration — meaning you describe the desired state, and Kubernetes maintains it.

## Kubernetes Cluster Types
- **Minikube**: CLI tool to create a local Kubernetes cluster.
- **K3s**, **kind**: Lightweight Kubernetes clusters for testing/dev environments.
- **KOPS**: Used to create production-grade Kubernetes clusters on cloud platforms like AWS.

## Setup Steps

### 1. Install Tools
- Install `kubectl` CLI.
- Install `minikube`.
- Install virtualization driver (e.g., `hyperkit`).

---

## 🛠️ Hands-On Workflow 

### Start Minikube Cluster
```bash
minikube start
```
- Starts your local Kubernetes cluster using Minikube.

### Create a Pod (For Learning Only)
```bash
kubectl apply -f simple-pod.yaml
```
- Deploys a basic pod defined in YAML.

### Check Pod Status
```bash
kubectl get pods
kubectl get pods -o wide
```

### View Detailed Pod Info
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Delete a Pod
```bash
kubectl delete pod <pod-name>
```

---

## Kubernetes Deployment

### Difference: Container vs Pod vs Deployment

- **Container**: Built using a Dockerfile and run via CLI (e.g., `docker run ...`).
- **Pod**:
  - Uses Docker image.
  - Specifications are provided in a `.yaml` manifest.
  - Can include multiple containers that share the same network and storage volumes.
- **Deployment**:
  - Provides auto-healing, scaling, and rollout capabilities.
  - A `deployment.yaml` file is recommended over a plain `pod.yaml`.
  - Structure:
    ```
    Deployment
        └── ReplicaSet
              └── Pod(s)
    ```
#### ⚠️ Avoid Creating Pods Directly
- While it is useful for basic learning, creating pods directly with a `pod.yaml` is not recommended for production or scalable applications.
- Pods created manually are not automatically restarted or replaced if they fail.
- To benefit from features like:
  - Auto-restart (self-healing)
  - Scaling
  - Rolling updates and rollbacks
  - Consistent state management

  You should use a **Deployment**, defined in a `deployment.yaml` file. 

### ReplicaSet vs Deployment
- **ReplicaSet** ensures a specified number of Pods are running (auto-healing).
- **Deployment** manages ReplicaSets and provides updates, rollbacks, etc.

## Notes
- Kubernetes automatically assigns sequential IP addresses to new pods.
- ❗ Avoid manually creating pods; use `deployment.yaml` for resilience, scaling, and best practices.

#### Apply Deployment
```bash
kubectl apply -f deployment.yaml
```
- Creates a Deployment that manages ReplicaSets and Pods.

#### View Resources
```bash
kubectl get deployments
kubectl get replicasets
kubectl get pods
```

#### Test Auto-Healing
```bash
kubectl delete pod <pod-name>
```
- Kubernetes will recreate the pod automatically.

---

### 🔍 Other Useful Commands

- List all resources:
  ```bash
  kubectl get all
  kubectl get all -A
  ```
- Check cluster nodes:
  ```bash
  kubectl get nodes
  ```
- SSH into Minikube node:
  ```bash
  minikube ssh
  ```

Reference for `kubectl`: [https://kubernetes.io/docs/reference/kubectl/quick-reference/](https://kubernetes.io/docs/reference/kubectl/quick-reference/)

---
