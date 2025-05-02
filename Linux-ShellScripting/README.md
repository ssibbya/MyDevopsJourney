# Understanding Linux & Shell Scripting

Now let's jump into one of the most essential building blocks in DevOps – **Linux**!

---

## Why is Linux preferred in production over Windows or other OS?
- ✅ Free & Open-source
- ✅ Secure and fast
- ✅ Lightweight and highly customizable
- ✅ Wide adoption in cloud environments
- ✅ Popular distributions: Ubuntu, Red Hat, CentOS, Debian

### The Kernel – Heart of the OS
The **Kernel** is the core part of Linux. It bridges software and hardware communication. Think of it like the engine of the OS.

**Key Responsibilities:**
- Device Management
- Memory Management
- Process Management
- System Call Handling

---

## OS Architecture Diagram

```plaintext
+-------------------+--------------------+---------------+
|  System Software  |   User Processes   |   Compilers   |
+--------------------------------------------------------+
|                      System Libraries                  |
+--------------------------------------------------------+
|                           Kernel                       |
+--------------------------------------------------------+
|                          Hardware                      |
```

---

## Shell Scripting Essentials
Shell scripting allows automation and interaction with Linux systems efficiently.

### Commonly Used Commands
| Command  | Description                             |
|----------|-----------------------------------------|
| `mkdir`  | Create a new directory                  |
| `ls`     | List directory contents                 |
| `cd`     | Change directory                        |
| `touch`  | Create a new file                       |
| `cat`    | View file contents                      |
| `pwd`    | Show current directory path             |
| `cp`     | Copy files or directories               |
| `mv`     | Move or rename files/directories        |
| `rm`     | Remove files                            |
| `rmdir`  | Remove empty directories                |
| `man`    | Display manual/help for a command       |
| `sudo`   | Execute command as a superuser          |
| `nproc`  | Show number of CPU cores                |
| `free`   | Display memory usage                    |
| `df`     | Disk space usage                        |
| `top`    | Live system resource usage              |
| `grep`   | Search within files                     |
| `awk`    | Text processing                         |
| `curl`   | Transfer data from or to a server       |
| `wget`   | Download files from the web             |
| `find`   | Search for files and directories        |

---

## File Permissions & `chmod`
Linux file permissions control access to files/folders.
- **User (Owner)**, **Group**, and **Others (Everyone)**

| Value | Permission |
|-------|------------|
| 4     | Read       |
| 2     | Write      |
| 1     | Execute    |
| 7     | Full (4+2+1)

**Example:**
```bash
chmod 755 myfile.sh
```
Means: Owner can read/write/execute, others can read/execute.

---

## 🔁 Control Flow in Shell

### ➰ Loops:
```bash
for i in {1..5}; do
  echo "Loop #$i"
  if [ $i -eq 3 ]; then
    continue  # Skip loop when i = 3
  fi
  echo "Still in loop"
done
```

### Difference Between `break` and `continue`
- `break` exits the loop entirely.
- `continue` skips the current iteration and continues with the next.

---

## `crontab` – Schedule Tasks
`crontab` syntax has 5 fields:
```plaintext
* * * * * command-to-execute
| | | | |
| | | | +----- Day of the Week (0 - 6)
| | | +------- Month (1 - 12)
| | +--------- Day of the Month (1 - 31)
| +----------- Hour (0 - 23)
+------------- Minute (0 - 59)
```

---

## Softlink vs Hardlink
- **Softlink (Symbolic Link):** A pointer to the original file. If original file is deleted, the link breaks.
- **Hardlink:** A direct copy of the file. It remains even if the original is deleted.

| Feature          | Softlink         | Hardlink         |
|------------------|------------------|------------------|
| File reference   | Pointer          | Clone            |
| Breaks on delete | Yes              | No               |
| Can span devices | Yes              | No               |

**Example:**
```bash
ln -s original.txt softlink.txt
ln original.txt hardlink.txt
```

---

## Network Troubleshooting Tools

### `traceroute`
Shows the path packets take to reach a destination.
```bash
traceroute google.com
```
It helps in diagnosing network latency and route hops.

### `tracepath`
Similar to `traceroute` but doesn't require root privileges.
```bash
tracepath google.com
```

---

## Log Management with `logrotate`
System logs can grow huge over time. `logrotate` helps manage and rotate them automatically.

- Rotates logs weekly/daily
- Compresses old logs
- Deletes very old logs

**Simple Config Example:**
```bash
/var/log/syslog {
    weekly
    rotate 4
    compress
    missingok
    notifempty
}
```
This keeps 4 weekly rotated logs of `syslog`, compresses them, and skips if empty.

---

Want more Linux tips or automation use cases? Let me know! 💡

