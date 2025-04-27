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

🧪 Try setting up a custom bridge yourself and ping between containers for practice!
