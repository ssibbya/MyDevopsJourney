# 🐳 Understanding Containers in Docker

---

## 📦 What is a Container?

A **container** is a standard unit of software that packages code and all its dependencies so the application runs quickly and reliably across different computing environments.

- A **Docker container image** is:
  - Lightweight
  - Standalone
  - Executable
  - Contains everything needed to run an application (code, runtime, libraries, system tools, system settings).

> 🧠 **Simplified Definition:**  
> A container bundles together:
> - The Application
> - Application libraries
> - Minimum system dependencies

---

## 🆚 Containers vs Virtual Machines

Both **containers** and **virtual machines (VMs)** isolate applications and their dependencies, but they have important differences:

| Aspect | Containers | Virtual Machines |
|:------:|:----------:|:----------------:|
| Resource Utilization | Share the host OS kernel, lightweight and faster | Full OS and hypervisor, heavy and resource-intensive |
| Portability | Highly portable across systems with compatible OS | Less portable, needs compatible hypervisor |
| Security | Share kernel, less isolated than VMs | Stronger isolation with separate OS |
| Management | Easier and faster to manage | More complex to manage |

---

## ⚡ Why are Containers Lightweight?

Containers are lightweight because:
- They **share the host operating system's kernel**.
- They **don't need a full OS** inside them.
- Docker containers **only include what is absolutely necessary** to run the application.

> 🧠 **Fun Fact:**  
> - Official **Ubuntu base container image** size: ~22 MB  
> - Official **Ubuntu VM image** size: ~2.3 GB  
> Containers can be **~100 times smaller** than VMs!

---

## 🗂️ What's Inside a Container?

### Files and Folders in Container Base Images
- `/bin`: Basic binary executables (e.g., `ls`, `cp`, `ps`)
- `/sbin`: System binaries (e.g., `init`, `shutdown`)
- `/etc`: Configuration files
- `/lib`: Libraries needed by binaries
- `/usr`: User utilities and applications
- `/var`: Variable data (logs, spool, temp files)
- `/root`: Home directory for the root user

---

### Files and Folders Accessed from Host OS

Containers also rely on some host OS components:

| Component | Purpose |
|:---------|:--------|
| Host File System | Access via bind mounts to read/write files |
| Networking Stack | Provides network connectivity |
| System Calls | Host kernel processes system calls for CPU, memory, and I/O |
| Namespaces | Isolate file system, PID, and network for containers |
| Control Groups (cgroups) | Control and limit resource usage (CPU, memory, I/O) |

---

## 🛡️ Important Note

While containers **share** resources with the host OS, they are still **isolated**.  
Changes made inside a container:
- **Do not affect** the host system.
- **Do not affect** other containers.

---

## 🧹 Summary

| Point | Explanation |
|:-----|:------------|
| Containers | Bundle applications and dependencies, lightweight |
| VMs | Emulate full operating systems, heavy |
| Size Difference | Containers (~MBs) vs VMs (~GBs) |
| Host Dependency | Containers use host's kernel, VMs use separate OS |

> 📚 **Final Thought:**  
> Containers are lightweight because they **reuse the host OS kernel** and **strip away unnecessary components**, making them minimal, fast, and portable compared to traditional VMs.

---

# 🐳 Docker

---

## 📦 What is Docker?

- **Docker** is a **containerization platform** that makes it easy to build, run, and share containerized applications.
- Using Docker, you can:
  - Build **container images** from a Dockerfile.
  - Run these images to create **containers**.
  - Push container images to **registries** like DockerHub, Quay.io, etc.

> 🧠 **In simple terms:**  
> - **Containerization** is the technology.  
> - **Docker** is the tool that implements it.

---

## 🏛️ Docker Architecture

- **Docker Daemon (`dockerd`)**:  
  The brain of Docker! It listens to Docker API requests and manages Docker objects like images, containers, networks, and volumes.  
  > If the daemon stops, Docker becomes **brain-dead** (sarcasm intended 😄).

- **Docker Client (`docker`)**:  
  CLI tool that sends commands to the daemon (dockerd) via Docker API.

- **Docker Registries**:  
  Storage for Docker images (e.g., **Docker Hub**). Images can be pulled or pushed here.

- **Docker Objects**:  
  - **Images**: Read-only templates
  - **Containers**: Running instances of images
  - **Networks**: Communication layer
  - **Volumes**: Persistent storage

---

## 🔄 Docker Lifecycle

You can understand Docker’s lifecycle using just **three main actions**:

| Action            | Command Example |
|-------------------|------------------|
| Build an Image     | `docker build -t my-image .` |
| Run a Container    | `docker run -d --name my-container my-image` |
| Push an Image      | `docker push my-username/my-image` |

---

## 🧠 Important Docker Terminology

### Docker Daemon (`dockerd`)
- Listens for API requests.
- Manages all Docker objects (containers, images, volumes, etc.).
- Can communicate with other daemons to manage services across hosts.

### Docker Client (`docker`)
- Interface to interact with Docker.
- Sends commands to the Docker daemon.
- Supports communicating with multiple daemons.

### Docker Desktop
- An easy-to-install application for **Mac, Windows, and Linux**.
- Includes:
  - Docker daemon
  - Docker CLI
  - Docker Compose
  - Kubernetes
  - Credential Helper
  - Docker Content Trust

### Docker Registries
- Storage locations for Docker images.
- Examples:
  - **Public Registry**: Docker Hub
  - **Private Registries**: Self-hosted registries or third-party services.
- Commands:
  - `docker pull`: Download an image.
  - `docker push`: Upload an image.

---

## 🏗️ Docker Core Objects

### Dockerfile
- A text file containing instructions to build a Docker image.
- Each line represents a **layer** in the image.

### Images
- Read-only templates used to create containers.
- Often based on a parent image (e.g., Ubuntu, Alpine).
- Customizations include:
  - Installing software
  - Setting environment variables
  - Adding application code

> 🔥 **Efficiency Tip**:  
> When you rebuild an image, **only changed layers are rebuilt**, making Docker builds **fast** and **efficient** compared to traditional VMs.

---

## 🚀 Summary

| Concept        | Description |
|----------------|-------------|
| Containerization | The technology of packaging apps into containers |
| Docker          | Tool that implements containerization |
| Dockerfile      | Blueprint to build images |
| Image           | Blueprint for a container |
| Container       | Running instance of an image |
| Daemon          | Brain of Docker |
| Client          | Interface to interact with Docker |
| Registry        | Storage for Docker images |

---

## 🧹 Final Notes

- Containers are lightweight and portable.
- Docker is **fast** because of image layer caching.
- Docker revolutionized how applications are developed, shipped, and deployed.

---
# 🐳 Docker: Bind Mounts & Volumes

---

## ❗ Problems Without Persistent Storage

- If a container goes down, **logs and stored data are lost**.
- If a backend app stores user files but crashes, users lose access.
- If a **cron job creates files** on the host OS, containers cannot access them unless data is shared.

---

## ✅ Solutions

### 🔗 Bind Mounts
Bind a file or folder **from your host machine into a container**.

```bash
docker run -v /host/path:/container/path my-container
```

Useful for:
- Sharing host files in real-time
- Local development

---

### 🗃️ Docker Volumes
A **Docker-managed persistent storage** method that survives container shutdown or deletion.

- Managed by Docker
- Stored under `/var/lib/docker/volumes/` (not user-visible)
- Can be backed up, shared, or stored in external systems
- Ideal for **databases, logs, and app data**

---

## 🛠️ Key Docker Volume Commands

### Create a volume:
```bash
docker volume create ssibbya
```

### Inspect a volume:
```bash
docker volume inspect ssibbya
```

### Remove a volume:
```bash
docker volume rm ssibbya
```

❗ If volume is still **in use**, you'll get:
```bash
Error response from daemon: remove ssibbya: volume is in use - [...]
```

---

## 🚀 Run Containers with Volume Attached

### Example 1: Basic volume mount
```bash
docker run -d --mount source=ssibbya,target=/app nginx:latest
```

### Example 2: With full mount syntax
```bash
docker run -d --mount type=volume,source=ssibbya,target=/app/data volumedemo
```

### Inspect the container to see mounted volume:
```bash
docker inspect volumedemo
```

---

## 🔄 Explanation of Flags

| Flag        | Description                              |
|-------------|------------------------------------------|
| `-d`        | Run container in **detached mode**       |
| `--mount`   | Mounts a volume or bind mount into the container |
| `target=`   | Path **inside** the container            |
| `source=`   | Volume name or host path (for bind mount) |
| `type=`     | Can be `volume` or `bind`                |

---

## 🧼 Final Notes

- Use **volumes** for persistent data across container restarts
- Use **bind mounts** for local development and real-time file sharing
- Clean up unused volumes with:
  ```bash
  docker volume prune
  ```
---

# 🐳 Docker Networking: Bridge, Host, and Custom Networks

---

## ❗ Why Networking Matters in Docker

- **Default networking in Docker** is via a **bridge network**.
- Containers **cannot communicate** with the outside world without a bridge.
- Docker provides a **virtual Ethernet bridge** called `docker0` that connects containers to the host and to each other.

---

## 🌉 1. Bridge Networking (Default)

When you run a container, Docker attaches it to the default bridge network.

### Step 1: Run a container (default bridge network)
```bash
docker run -d --name container1 nginx:latest
```

### Step 2: Login into the container
```bash
docker exec -it container1 /bin/bash
```

### Step 3: Install `ping` utility
```bash
apt-get update && apt-get install -y iputils-ping
ping -V //To check the version
```

Now you can use `ping` from inside the container to communicate with external resources or other containers on the bridge.

---

## ⚠️ Problems with Default Bridge Networking

- Containers on the same bridge share the virtual interface (`veth0`).
- If attackers gain access to a container, they might sniff sensitive information across containers.
- Default bridge networks and host networks share the same CIDR IP range, making isolation difficult.

---

## ✅ 2. Custom Bridge Network (Better Isolation)

Docker allows creating **custom bridge networks** for secure communication between containers.

### Step 1: Create a custom bridge network
```bash
docker network create secure-network
```

### Step 2: Run a container on the custom network
```bash
docker run -d --name container1 --network=secure-network nginx:latest
```

- Containers attached to `secure-network` are isolated from the default bridge network.
- You can ping containers within the custom network but they are isolated from others.

---

## 🖥️ 3. Host Networking (No Isolation)

In host networking, the container shares the host’s network stack.

### Example: Run a container using host network
```bash
docker run -d --name democontainer --network=host nginx:latest
```

- No IP assignment from Docker; the container uses the host’s IP directly.
- Useful for performance but **NOT secure**.

---

## 🌐 4. Overlay Networking (Short Overview)

- **Overlay networks** connect containers across **multiple Docker hosts**.
- Common in **Docker Swarm** and **Kubernetes** clusters.
- Provides secure, scalable networking for large apps.

---

## 🔄 Quick Overview: Network Types

| Network Type      | Description                                               |
|-------------------|-----------------------------------------------------------|
| `bridge` (default) | Containers get private IPs and connect through `docker0`. |
| `custom bridge`    | Isolated container networks with user-defined settings.   |
| `host`             | Containers share the host’s network stack.                |
| `overlay`          | Containers on different hosts can communicate securely.  |

---

## 🛠️ Summary of Useful Commands

| Action                              | Command Example |
|-------------------------------------|-----------------|
| Run container (default bridge)      | `docker run -d --name container1 nginx:latest` |
| Enter container                     | `docker exec -it container1 /bin/bash` |
| Install ping utility                | `apt-get update && apt-get install -y iputils-ping` |
| Create custom bridge network        | `docker network create secure-network` |
| Run container on custom network     | `docker run -d --name container1 --network=secure-network nginx:latest` |
| Run container with host network     | `docker run -d --name demo --network=host nginx:latest` |

---

## 🧼 Final Notes

- Use **default bridge** for simple setups.
- Use **custom bridge** for secure, isolated container communication.
- Use **host networking** for maximum performance (but with caution).
- Use **overlay networks** for distributed multi-host Docker applications.

---
