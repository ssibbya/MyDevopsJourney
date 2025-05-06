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
- [Kubernetes Ingress](#kubernetes-ingress)
- [Kubernetes RBAC](#kubernetes-rbac)
- [Custom Resources](#custom-resources)

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

### 🔁 Flow of a Request in NodePort

```
User → http://<NodeIP>:<NodePort> 
     → kube-proxy intercepts the request
     → iptables forwards it to the ClusterIP of the Service
     → Service load balances to one of the backend Pods
     → Pod sends response back
```

### ✅ Use Case

* **Best for development** or **internal testing**.
* Not suitable for production-level public exposure.

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

* If your node has IP `192.168.1.100`, you can access your app at:

  ```
  http://192.168.1.100:30080
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

## Kubernetes Ingress

### Why Ingress?

**Problem 1:**
When organizations moved from traditional setups (like VMs) to Kubernetes, they noticed Kubernetes **LoadBalancer** service only offers **basic round-robin** traffic routing.
But traditional systems (e.g., AWS ELB, F5, Nginx) supported:

* Sticky sessions
* Weighted routing
* IP allowlisting/denylists
* WAF (Web Application Firewall)
* TLS termination
* Path-based or host-based routing

**Problem 2:**
For every **`LoadBalancer` service**, the **cloud provider charges** for:

* Provisioning a **public IP address**
* Running and maintaining the external load balancer

**Ingress solves both problems** by providing a **smart, cost-effective gateway** for managing external access to your Kubernetes services.

## What Is Ingress?

* **Ingress** is **not a service** itself, but a **set of rules** to control **how external HTTP/HTTPS traffic** reaches your **internal Kubernetes services**.
* It supports:

  * **Path-based routing** (e.g., `/login`, `/products`)
  * **Host-based routing** (e.g., `api.myapp.com`, `dashboard.myapp.com`)
  * **SSL/TLS termination**
  * **Centralized access control**

## How Ingress Works

```
[Client Request]
     ↓
[Ingress Controller] <-- Smart load balancer (Nginx, HAProxy, Traefik, etc.)
     ↓
[Ingress Resource] <-- Rules for routing
     ↓
[Service]
     ↓
[Pods]
```
<img width="692" alt="Screenshot 2025-05-04 at 5 15 52 PM" src="https://github.com/user-attachments/assets/83df4b21-7bbe-4d6c-bf34-584334e98f99" />

## Ingress vs Ingress Controller

| Component              | Description                                                                                                                          |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Ingress**            | YAML configuration that defines routing rules.                                                                                       |
| **Ingress Controller** | A **Pod** that listens to the Ingress resources and configures the load balancer accordingly. Examples: **NGINX, Traefik, HAProxy**. |
| **Note**               | Without an Ingress Controller, Ingress rules are useless.                                                                            |

## How to Enable Ingress in Minikube (Nginx Ingress Controller)

```bash
# Enable ingress in Minikube (automatically installs NGINX controller)
minikube addons enable ingress

# Optional: Check if ingress controller pods are running
kubectl get pods -n ingress-nginx
```

Sample Ingress YAML: https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/service/networking/ingress-wildcard-host.yaml

## Commands to Test

```bash
kubectl apply -f ingress.yaml
kubectl get ingress
kubectl get svc
kubectl get pods -A
kubectl logs <controller-pod-name> -n ingress-nginx
```

> To access the app via custom domain (e.g., `myapp.local`), update your **`/etc/hosts`** file:

```bash
sudo vi /etc/hosts
# Add this line
127.0.0.1   myapp.local
```

## Benefits of Ingress

* Only **one LoadBalancer** for the whole cluster (cost-effective)
* Acts as **API Gateway**
* **TLS termination** support
* Supports advanced rules like:

  * Path and host-based routing
  * Header-based routing (with extensions)
  * Rate limiting and authentication (with plugins)

## Ingress Controller Options

| Controller             | Description                                |
| ---------------------- | ------------------------------------------ |
| **NGINX**              | Most popular, easy to use                  |
| **HAProxy**            | High performance                           |
| **Traefik**            | Supports auto-discovery, dynamic configs   |
| **AWS ALB Controller** | For EKS users needing deep AWS integration |


## 🧭 More Ingress Concepts — Deep Dive

### 🔄 **Host-Based vs Path-Based vs Wildcard Routing**

These are different routing techniques supported by Ingress rules:

#### 🏠 **Host-Based Routing**

* Routes traffic based on domain name (host header).
* Common when hosting **multiple applications** on the same cluster.
* Example:

  * `admin.myapp.com` → Admin Service
  * `user.myapp.com` → User Service

#### 🛣️ **Path-Based Routing**

* Routes traffic based on the request path.
* Useful for **monolithic apps split by endpoints**.
* Example:

  * `/login` → Login Service
  * `/dashboard` → Dashboard Service

#### 🃏 **Wildcard Host Routing**

* Matches multiple subdomains using wildcard (`*`).
* Good for **multi-tenant applications**.
* Example:

  * `*.myapp.com` → Multi-tenant router service
  * `client1.myapp.com`, `client2.myapp.com` → All match

### 🔐 TLS Termination in Ingress

TLS/SSL ensures secure traffic. Ingress handles TLS in 3 different ways:

#### 1. **SSL Offloading**

* TLS is **terminated at the Ingress Controller** (decrypted).
* Traffic from Ingress to backend is plain HTTP.
* Advantage: Backend doesn’t deal with encryption.
* Use Case: When internal traffic is trusted or performance matters.

#### 2. **SSL Passthrough**

* Ingress does **not decrypt** TLS.
* Traffic is forwarded **encrypted** to the backend service.
* The backend pod must handle TLS termination.
* Use Case: When you want end-to-end encryption (zero trust networks).

#### 3. **SSL Bridging**

* TLS is **terminated at Ingress**, inspected, and **re-encrypted** before forwarding to backend.
* Both Ingress and backend use different TLS certificates.
* Use Case: Needed when you want to inspect traffic **and** enforce encryption end-to-end.

### 🛡️ Ingress Advanced Use Cases

* **Rate Limiting** – Block clients that exceed request limits.
* **IP Whitelisting** – Allow only certain IPs to access.
* **Rewrite Paths** – Strip or replace paths before forwarding.
* **Web Application Firewall (WAF)** – Protect against threats like SQL injection.
* **Basic Auth** – Protect endpoints with user/pass.

---

## Kubernetes RBAC

Kubernetes uses RBAC (Role-Based Access Control) to **define who can access what** in your cluster. This is critical for enforcing **least-privileged access**.

---

## 🧠 Key Concepts

### 👤 Users vs 🛠 Service Accounts

| Type             | Description                                      |
|------------------|--------------------------------------------------|
| **User**         | A human (e.g., developer, admin). Not managed by Kubernetes. Use external providers (e.g., AWS IAM, Azure AD). |
| **Service Account** | A Kubernetes-managed identity used by apps running in Pods. |

---

## 📦 RBAC Components

| Component             | Scope       | Purpose                                     |
|------------------------|-------------|---------------------------------------------|
| **Role**               | Namespace   | Defines allowed actions on resources **within a namespace** |
| **ClusterRole**        | Cluster     | Same as Role but applies **across the entire cluster**       |
| **RoleBinding**        | Namespace   | Grants a Role to a User/Group/Service Account in a namespace |
| **ClusterRoleBinding** | Cluster     | Grants a ClusterRole to subjects **cluster-wide**             |

---

## 🧾 YAML Examples with Explanation

### 1️⃣ Role (Namespace Scoped)

This YAML defines a **Role** that allows read-only access to Pods in the `dev` namespace.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: read-pods
  namespace: dev
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]


🔍 **Explanation**:

* `resources`: Targets **pods**
* `verbs`: Allows `get`, `watch`, and `list` (read-only access)
* `apiGroups`: Empty string `""` means the core API group (where Pods belong)

---

### 2️⃣ RoleBinding

This binds the above Role to a specific user named `dev-user` within the same namespace.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: dev
subjects:
- kind: User
  name: dev-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: read-pods
  apiGroup: rbac.authorization.k8s.io
```

🔍 **Explanation**:

* `subjects`: Who gets access (here, a user named `dev-user`)
* `roleRef`: The Role being assigned (`read-pods` in `dev`)

---

### 3️⃣ ClusterRole (Cluster Wide)

Allows read-only access to Nodes across the entire cluster.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: view-nodes
rules:
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list"]
```

---

### 4️⃣ ClusterRoleBinding

Grants the above ClusterRole to a user `ops-user` at the cluster level.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: view-nodes-binding
subjects:
- kind: User
  name: ops-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: view-nodes
  apiGroup: rbac.authorization.k8s.io
```

---

## 🔐 External Authentication (IAM Integration Example)

Kubernetes does **not manage user accounts** directly. Use cloud identity providers:

* **AWS**: IAM user + OIDC provider
* **Azure**: Azure AD
* **Google Cloud**: Google OAuth

✅ Example: Grant AWS IAM user access to EKS using `aws-auth` ConfigMap

```bash
aws eks update-kubeconfig --name my-cluster
```

---

## ✅ Summary

* Use **Roles** and **RoleBindings** for namespace-level control.
* Use **ClusterRoles** and **ClusterRoleBindings** for cluster-wide permissions.
* Bind roles to **users, groups, or service accounts**.
* Kubernetes integrates with external identity systems for user authentication.

RBAC ensures secure and fine-grained access to your Kubernetes cluster. 🔐

---

## 🛠️ Custom Resources

Kubernetes is highly extensible. Instead of only using native features, you can extend its functionality by **creating your own APIs**. This is especially useful for integrating tools like Argo CD, Keycloak, or security policies.

---

### 🚀 Why Use Custom Resources?

* Native Kubernetes objects (like Pods, Services, Deployments) might not cover all use cases.
* You can define your own resource types and automate their behavior.

---

### 📚 Key Components of a Custom Resource Extension

#### 1. **Custom Resource Definition (CRD)**

* A CRD defines a **new API type** for Kubernetes.
* It tells Kubernetes: “Here’s a new kind of object you should understand.”
* Example: `Ingress`, `Certificate`, or a new kind of `App` resource.

#### 2. **Custom Resource (CR)**

* A specific instance of a custom resource type.
* Just like a Pod is an instance of a Deployment, a CR is an instance of a CRD.

#### 3. **Custom Controller**

* The logic that watches for changes in CRs and acts accordingly.
* Written in Go using `client-go` library.
* It listens to API server changes using **informers** and processes events using a **worker queue**.

---

### ⚙️ How It Works — Step-by-Step

```
flowchart
    "Developer" -->
      A1(Create CRD)
      A3(Write Custom Controller)

     "User" -->
      A2(Create CR)

     "Kubernetes" -->
      B1[API Server]
      B2[Validate CR against CRD]
      B3[Store in etcd]

     "Custom Controller" -->
      C1[Watch CR Events]
      C2[Work Queue]
      C3[Business Logic: e.g. Create Resources]

    A1 --> B1
    A2 --> B1
    B1 --> B2 --> B3
    A3 --> C1
    B3 --> C1 --> C2 --> C3
```

---

### 🧱 Analogy with Built-In Resources

| Custom Resource Component | Equivalent Built-In Example     |
| ------------------------- | ------------------------------- |
| CRD                       | Deployment definition           |
| Controller                | Deployment controller (builtin) |
| CR                        | Actual deployment object        |

---

### 📄 YAML Definitions (Simplified)

#### CustomResourceDefinition (CRD) Example

```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: crontabs.stable.example.com
spec:
  group: stable.example.com
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
  scope: Namespaced
  names:
    plural: crontabs
    singular: crontab
    kind: CronTab
    shortNames:
    - ct
```

#### Custom Resource (CR) Example

```yaml
apiVersion: stable.example.com/v1
kind: CronTab
metadata:
  name: my-cron-job
spec:
  schedule: "*/5 * * * *"
  image: my-cron-image
```

---

### ✅ Summary

* CRDs define **what your custom API looks like**.
* CRs are **instances** of those custom APIs, created by developers.
* Controllers **watch** for CRs and **take action** accordingly, written by DevOps engineers.

This approach powers tools like **ArgoCD, Cert-Manager, Prometheus Operator**, and many more.

