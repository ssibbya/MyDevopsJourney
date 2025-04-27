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

# 🐳 Docker Networking: Bridge, Host, and Custom Networks

This guide explains how Docker manages container networking, including **bridge**, **host**, and **custom bridge** networks, with real-world examples and commands.

---

## ❗ Why Networking Matters in Docker

- **Default networking in Docker** is via a **bridge network**.
- Containers **cannot communicate** with the host network directly without the bridge.
- Docker provides a **virtual Ethernet bridge** called `docker0` that connects containers to the host and to each other.

---

## 🌉 1. Bridge Networking (Default)

- Docker creates a default bridge (`docker0`) to manage container communication.
- Containers get a **private IP address** and use `docker0` to connect to the host or other containers.
- Without a bridge, containers would not be able to reach the outside network easily.

---

## 🖥️ 2. Host Networking

- With host networking, Docker **binds the container directly** to the host’s `eth0` interface.
- The container shares the host’s IP address and network stack.
- No bridge (`docker0`) is involved.
- Useful when high network performance or simplicity is needed.

---

## ⚠️ Problem with Bridge and Host Networks

- Containers connected to the default bridge (`docker0`) or using the host network **share** the **veth0** (virtual Ethernet interface).
- **Security Risk:**  
  If containers need **complete isolation**, sharing the same `veth0` can expose sensitive information to attackers.
- **Host network** can't solve this because it shares the **same CIDR IP range** with the host.

---

## ✅ Solution: Custom Bridge Network

- Docker allows the creation of **custom bridge networks** to isolate container communication.
- **Custom networks provide:**  
  - Isolated environments
  - Better security
  - User-defined subnets and IP management

---

## 🛠️ Key Docker Commands

### 1. Run a container using the default bridge network:
```bash
docker run -d --name login nginx:latest
```

### 2. Login to the container:
```bash
docker exec -it login /bin/bash
```

### 3. Install `ping` inside the container:
```bash
apt-get update && apt-get install -y iputils-ping
```

### 4. Create a secure custom bridge network:
```bash
docker network create secure-network
```

### 5. Run a container in the custom bridge network:
```bash
docker run -d --name finance --network=secure-network nginx:latest
```

- (Finance container is attached to the `secure-network`.)

### 6. Run a container with host networking:
```bash
docker run -d --name demo --network=host nginx:latest
```

- (Demo container uses the host's network stack.)

---

## 🔄 Quick Overview: Network Types

| Network Type      | Description                                               |
|-------------------|-----------------------------------------------------------|
| `bridge` (default) | Containers get private IPs and connect through `docker0`. |
| `host`             | Containers share host's network interface (no isolation). |
| `custom bridge`    | Isolated container networks with user-defined settings.   |
| `overlay`          | Allows containers to communicate across multiple hosts.   |

---

## 🌐 3. Overlay Networking (Brief Intro)

- **Overlay networks** connect containers across different Docker hosts.
- Commonly used in **Docker Swarm** or **Kubernetes** for multi-host communication.
- Secure and scalable for large distributed applications.

---

## 🧼 Final Notes

- Use **default bridge** for basic setups.
- Use **custom bridge** for better security and container isolation.
- Use **host network** for performance-critical applications that don't need network isolation.
- Use **overlay network** for multi-host communication.

---

📚 Keep experimenting by creating custom networks, isolating services, and improving container security!
