# ☸️ Kubernetes - A Container Orchestration Platform

## 📖 Table of Contents
- [What is Kubernetes](#what-is-kubernetes)
- [Why Kubernetes](#why-kubernetes)
- [Docker vs Kubernetes Architecture](#docker-vs-kubernetes-architecture)
- [Kubernetes Architecture](#kubernetes-architecture)
- [Core Concepts](#core-concepts-in-kubernetes)
- [Kubernetes Pod](#what-is-a-pod)
- [Cluster Types](#kubernetes-cluster-types)
- [Deployments & Scaling](#kubernetes-deployment)
- [Kubernetes Services](#kubernetes-services-svc)

---

## What is Kubernetes

**Kubernetes** is an open-source container orchestration platform designed to automate the deployment, scaling, and management of containerized applications.

Containers are **ephemeral** by nature — they can be short-lived and prone to failures. Kubernetes solves critical real-world production issues such as:

---

## Why Kubernetes

| Problem | Docker Limitation | Kubernetes Solution |
|--------|--------------------|---------------------|
| 1. **Resource Conflicts on a Single Host** | Containers share host resources, and excessive usage can crash others. | Kubernetes distributes containers across multiple nodes to balance resources. |
| 2. **No Auto-Healing** | If a container is accidentally stopped or crashes, Docker doesn’t restart it. | Kubernetes monitors and automatically restarts failed containers. |
| 3. **Lack of Auto-Scaling or Load Balancing** | Docker doesn’t natively support scaling or traffic routing. | Kubernetes supports auto-scaling and built-in load balancing across pods. |
| 4. **Enterprise-Level Support** | Docker doesn’t provide enterprise-grade networking, firewalling, or storage. | Kubernetes provides APIs, RBAC, service discovery, storage integration, and more. |

---

Absolutely — here's the **updated and accurate comparison** including the **deprecation of `dockershim`**, with correct terminology and architecture for both Docker and Kubernetes. You can directly include this in your `README.md`.

---

## Docker vs Kubernetes Architecture

### 🚢 Docker Architecture (Single Host)

Docker is used to **build, ship, and run containers**. Its core building block is the **container**, and to run containers, it requires a **container runtime**.

- In earlier versions, Docker used a component called `dockershim` to interface with Kubernetes. However, **`dockershim` has been deprecated and removed**. Kubernetes now interacts directly with runtimes like **`containerd`** or **CRI-O**, which follow the [Container Runtime Interface (CRI)].
- Docker manages containers using the **Docker Engine**, which includes:
  - Docker Daemon: Runs in the background and manages containers.
  - Docker CLI: Command-line interface to interact with the daemon.
  - Docker Image: A snapshot of your application with all dependencies.
- Containers run on a **single machine**, and resources are shared among them.

**Limitation Example**:
Imagine you’re running a Node.js backend and a React frontend on Docker:
- If the Node container uses too much CPU, the React container might crash.
- There's no auto-restart or load balancing.
- It's limited to one host — no clustering or multi-node deployment.

---

## Kubernetes Architecture

Kubernetes architecture is based on a **master-worker** (control plane-data plane) model.

![Diagram-55](https://github.com/user-attachments/assets/8a8a4d71-b168-4ff3-bd62-1d84f57d6333)

### 🧠 Control Plane (Master)

Responsible for **cluster-wide decisions** like scheduling, scaling, and health monitoring.

| Component | Role |
|----------|------|
| **API Server** | Central control component. Receives all requests and communicates with other components. |
| **Scheduler** | Decides **which node** runs a pod based on resource availability. |
| **Controller Manager** | Handles replication, node health, and scaling. Manages **ReplicaSets**, **Deployments**, etc. |
| **etcd** | A distributed key-value store that holds cluster state and configuration. |
| **Cloud Controller Manager (CCM)** | Integrates Kubernetes with cloud providers (e.g., AWS, GCP). Manages load balancers, storage, etc. |

### 🔧 Data Plane (Worker Nodes)

Worker nodes are where containers actually run. Each node has:

| Component | Role |
|----------|------|
| **kubelet** | Responsible for pod creation and communication with the control plane. |
| **kube-proxy** | Handles networking, service discovery, and **load balancing** inside the cluster. |
| **Container Runtime** | Software to run containers (e.g., containerd, CRI-O). Required for pod execution. |

---

## 📦 Why is Control Plane Needed?

Even though pods and containers run on **worker nodes**, Kubernetes needs a **centralized intelligence system** to:

- Decide **where** to place a pod (Node 1 or Node 2)
- Ensure **auto-scaling** and **self-healing**
- Interface with cloud resources (via CCM)
- Maintain **high availability** and consistency across the cluster

---

## Core Concepts in Kubernetes

| Concept | Description |
|--------|-------------|
| **Pods** | Smallest deployable unit, can contain one or more containers |
| **ReplicaSet** | Ensures the desired number of pods are always running |
| **Deployment** | Declarative update of ReplicaSets and pods |
| **Services** | Abstraction to expose a set of pods as a network service |
| **Namespaces** | Virtual clusters within a physical cluster for isolation |

---

## Summary

Kubernetes is the **go-to platform** for running containerized applications in production. It addresses all the limitations of Docker by providing:

- Clustering
- Load balancing
- Auto-scaling
- Auto-healing
- Enterprise-grade networking
- Cloud integration

For modern DevOps and cloud-native environments, Kubernetes is a must-know tool.

---

## What is a Pod?
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

## Hands-On Workflow 

Sample pod.yaml: https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/pods/simple-pod.yaml

### 1. Start Minikube Cluster
```bash
minikube start
```
- Starts your local Kubernetes cluster using Minikube.

### 2. Create a Pod (For Learning Only)
```bash
kubectl apply -f simple-pod.yaml
```
- Deploys a basic pod defined in YAML.

### 3. Check Pod Status
```bash
kubectl get pods
kubectl get pods -o wide
```

### 4. View Detailed Pod Info
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
#### Avoid Creating Pods Directly
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
Sample deployment.yaml: https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/controllers/nginx-deployment.yaml
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
# Kubernetes Services and Scaling - README

## Estimating Number of Pods

The ideal number of pods depends on the expected load and the capacity of each pod. You can estimate the number of pods needed with a simple formula:

```
Required Pods = Total Expected Load / Load Handled Per Pod
```

**Example:**
- 1 pod can handle 10 requests per second.
- If you expect 100 requests per second:

```
Required Pods = 100 / 10 = 10 Pods
```

---

## Kubernetes Services (svc)

When a Deployment creates Pods, each pod is assigned a new IP address. This becomes a problem if clients try to access the application using those IPs because they change when pods are recreated.

### Why Use Services?
- Provide a stable network identity and IP for accessing the pods.
- Help in load balancing between pods.
- Enable service discovery using labels and selectors.
- Allow external access to the application when required.

### Types of Kubernetes Services

1. **ClusterIP (Default)**
   - Accessible **only within** the Kubernetes cluster.
   - Supports load balancing and service discovery.
   - Good for internal microservice communication.

2. **NodePort**
    
* **NodePort** is a type of Kubernetes **Service** that exposes your application running inside the cluster **on a port of each worker node**.
* This makes the app accessible from **outside the cluster**, as long as you know the IP address of **any** worker node and the **NodePort**.

---

### 🧠 How It Works Behind the Scenes

1. **Port Range**

   * NodePort uses ports from the reserved range: **`30000–32767`** (default).
   * When you create a service of type `NodePort`, Kubernetes assigns a port from this range — or you can specify one manually.

2. **kube-proxy and iptables**

   * `kube-proxy` runs on each worker node and is responsible for networking rules.
   * It **updates the iptables** rules to route external traffic coming to `<NodeIP>:<NodePort>` to the correct Kubernetes Service, and from there to the backend Pods.

3. **Pre-routing Rule (iptables)**

   * A rule is added in the **PREROUTING** chain.
   * It tells the system: "If a request comes to `<NodeIP>:<NodePort>`, forward it to the internal ClusterIP Service."

4. **Service to Pod**

   * The Service uses **label selectors** to find the matching Pods.
   * It then **load balances** traffic across the healthy Pods behind it.

---

### 🔁 Flow of a Request in NodePort

```
User → http://<NodeIP>:<NodePort> 
     → kube-proxy intercepts the request
     → iptables forwards it to the ClusterIP of the Service
     → Service load balances to one of the backend Pods
     → Pod sends response back
```

---

### ✅ Use Case

* **Best for development** or **internal testing**.
* Not suitable for production-level public exposure (use **LoadBalancer** or **Ingress** instead).

---

### 📌 Example

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
spec:
  type: NodePort
  selector:
    app: my-app
  ports:
    - port: 80          # ClusterIP port
      targetPort: 8080  # Pod port
      nodePort: 30080   # Node port (within 30000–32767)
```

* If your node has IP `192.158.1.100`, you can access your app at:

  ```
  http://192.158.1.100:30080
  ```

3. **LoadBalancer**
   - Exposes the service to the **external world** using a cloud provider's load balancer (e.g., AWS ELB).
   - Automatically assigns a public IP.
   - Requires a cloud controller manager (CCM) in cloud environments like EKS.

![1_tnK94zrEwyNe1hL-PhJXOA](https://github.com/user-attachments/assets/82900451-4e00-4169-852b-d5f69f25f6e6)

### External Access Example
- In **Minikube**, you can’t access your app from outside using the pod IP directly.
- Use services to route traffic appropriately.

---

Great! Here's the **updated hands-on Kubernetes Services guide** including **Kubeshark** to inspect real-time network traffic. This version is clean, professional, and beginner-friendly.

---

# 🧪 Kubernetes Services – Hands-On Guide with Kubeshark

This guide covers how to expose services using **NodePort** and **LoadBalancer**, and how to monitor traffic using **Kubeshark**.

---

## ✅ Prerequisites

- Kubernetes cluster running via **Minikube**
- `kubectl` configured
- A sample deployment and service YAML (`deployment.yaml` and `services.yaml`)
- **Kubeshark** installed (`brew install kubeshark/tap/kubeshark` or [docs](https://kubeshark.co/docs/install/))

---

## 🔧 Step 1: Deploy the Application

Apply your deployment and service configuration:

```bash
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml
```

Check resources:

```bash
kubectl get pods
kubectl get svc
```

---

## 🌐 Step 2: Access the Service (NodePort)

No need to SSH into the node. Use Minikube IP.

### 1. Get Minikube IP
```bash
minikube ip
```

### 2. Access the service:
```bash
curl -L http://<minikube-ip>:<nodePort>/demo
```

---

## 🔄 Step 3: Change to LoadBalancer

Edit the service:

```bash
kubectl edit svc demo-service
```

Change type from NodePort to LoadBalancer:
```yaml
type: LoadBalancer
```

---

## 🌍 Step 5: Access via LoadBalancer

Check for external IP:

```bash
curl -L http://<minikubeIP>:8000/demo
```

---

## 🧪 Step 6: Inspect Traffic Using Kubeshark

Kubeshark (formerly Mizu) is a network traffic analyzer for Kubernetes. It lets you see live, in-cluster traffic at the HTTP/gRPC level, without changing your apps.

### 1. Start Kubeshark
```bash
kubeshark tap
```

This launches a web UI and starts capturing traffic.

> You’ll be prompted to open `http://localhost:8899` in your browser.

### 2. Trigger a request:
```bash
curl -L http://<external-ip>:8000/demo
```

### 3. View traffic in real time in the Kubeshark UI:
- Inspect HTTP requests/responses
```bash
http://<externalIP>:8899/?q=http and request.path == "/demo"
```
- Check source/destination pods
- Debug headers, status codes, etc.
<img width="1716" alt="Screenshot 2025-05-03 at 1 12 06 PM" src="https://github.com/user-attachments/assets/dbf02e22-2975-40d7-9196-f670386df824" />

### 4. Stop Kubeshark
Press `Ctrl+C` in the terminal to stop tapping.

---
