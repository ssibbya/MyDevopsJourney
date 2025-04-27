# 🐳 Docker: Bind Mounts & Volumes

This guide explains how Docker handles persistent data using **Bind Mounts** and **Volumes**, with real-world examples and commands.

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

🧪 Test it yourself and track logs or data between container restarts using volumes!
---

# 🐳 Docker Networking Basics

This guide explains how Docker networking works, why the default is a bridge network, and how to create more secure custom networks.

---

## 🌉 1. Default: Bridge Networking

- By default, Docker uses **bridge networking**.
- Why is it called a "bridge"?
  - It connects (bridges) containers to the host network using a virtual Ethernet interface called **`docker0`**.
  - Without `docker0`, containers cannot talk to the host.

---

## 🌐 2. Host Networking

- In **host networking**, the container shares the **host's `eth0` interface** directly.
- This removes network isolation between the container and the host.

### Pros:
- Low network latency (no bridge overhead)
- Useful when the container must behave like a native host process

### Cons:
- Security risks (no network isolation)
- Containers use the same IP range (CIDR) as the host
- Hackers could exploit `veth0` to access sensitive information if not properly isolated

---

## 🛡️ 3. Custom Bridge Networks

- If containers need **complete isolation** while maintaining communication, **custom bridge networks** solve the problem.
- Docker allows you to create **custom bridge networks** to avoid security issues.

---

## 🛠️ Example Commands

### 1. Create a container with default bridge network:
```bash
docker run -d --name login nginx:latest
```

### 2. Login into the container and install `ping`:
```bash
docker exec -it login /bin/bash
apt-get update && apt-get install -y iputils-ping
```

### 3. Create a secure custom bridge network:
```bash
docker network create secure-network
```

### 4. Run a container in the custom network:
```bash
docker run -d --name finance --network=secure-network nginx:latest
```
- `finance` container is now isolated within `secure-network`.

### 5. Run a container using host network:
```bash
docker run -d --name demo --network=host nginx:latest
```
- `demo` container shares the host's network namespace.

---

## ☁️ 4. Overlay Networking (Coming Soon)

- Overlay networks are used for communication **across multiple Docker hosts** (different machines).
- Commonly used with **Docker Swarm** or **Kubernetes**.

---

## 📑 Summary

| Network Type | Description | Use Case |
|--------------|-------------|----------|
| Bridge       | Default network using `docker0` | General container communication |
| Host         | Shares host's network directly | Low latency, but lower security |
| Custom Bridge| User-defined bridge network | Better isolation + communication |
| Overlay      | Spans across multiple hosts | Clustering, orchestration |

---

🚀 Experiment with bridge, host, and custom networks to better understand how containers communicate!

