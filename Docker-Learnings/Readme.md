```markdown
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
```
