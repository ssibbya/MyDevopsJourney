# Git & GitHub: A Beginner-Friendly Guide (DevOps Journey)

Welcome to my DevOps learning journey! This guide covers everything you need to get started with **Git** and **GitHub**, essential tools for version control and collaboration in modern software development.

Whether you're new or brushing up your skills, this detailed walkthrough will help you understand Git concepts, commands, workflows, and real-world applications.

---

## 📌 What is Version Control?

Version control is a system that records changes to a file or set of files over time. It allows you to revert to specific versions, collaborate with others, and maintain a history of your codebase.

### 🔄 Benefits:
- **History Tracking:** View changes over time
- **Collaboration:** Work with multiple people without overwriting each other
- **Recovery:** Restore previous versions in case of mistakes
- **Experimentation:** Test new features without affecting the main project

---

## ⚖️ Centralized vs Distributed Version Control

| Type           | Description                                                   | Examples   |
|----------------|---------------------------------------------------------------|------------|
| Centralized    | Single central server. All changes are tracked there.         | SVN, CVS   |
| Distributed    | Every developer has a local copy of the entire repo.          | Git        |

### 💡 Why Git?
- Works offline
- Faster operations
- More secure
- No single point of failure

---

## 🧪 Git vs GitHub

| Feature      | Git                              | GitHub (or GitLab, Bitbucket)       |
|--------------|----------------------------------|-------------------------------------|
| Type         | Version control system (local)   | Cloud-based Git repository hosting  |
| Role         | Tracks changes                   | Enables collaboration               |
| Use Case     | Local tracking                   | Remote collaboration, CI/CD         |

---

## 🔧 Installing Git

### 🐧 On Ubuntu:
```bash
sudo apt update
sudo apt install git
```

### 💻 On Windows/Mac:
Download and install from [https://git-scm.com/](https://git-scm.com/)

---

## 📁 Basic Git Setup

### Configure Git:
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### Initialize a Repository:
```bash
git init
```
Creates a `.git` folder to start version control in local.

---

## 🧠 Essential Git Commands

| Command                          | Description                                   |
|----------------------------------|-----------------------------------------------|
| `git status`                     | Show current repo status                      |
| `git add <file>`                | Stages a particular change for commit                     |
| `git add .`                     | Stage all changes                            |
| `git commit -m "message"`       | Commit staged changes                        |
| `git log`                        | View commit history                          |
| `git diff`                       | View unstaged changes                        |
| `git reset --hard <commit>`     | Revert to a specific commit (destructive)    |
| `git checkout <branch|commit>`  | Switch to another branch or commit           |
| `git branch`                    | List branches                                |
| `git branch <name>`            | Create a new branch                          |
| `git merge <branch>`           | Merge another branch into current            |

---

## 🌱 Git Branching Strategy

| Branch Type     | Purpose                                          |
|------------------|--------------------------------------------------|
| `main/master`     | Production-ready code                           |
| `feature/*`       | Development of new features                     |
| `release/*`       | Prepares code for production                    |
| `hotfix/*`        | Emergency bug fixes directly on production      |

---

## 🔐 Git Hooks (Advanced)

Git hooks allow scripts to run automatically at key points like before committing. Useful for enforcing standards or preventing sensitive data leaks.

Examples:
- Pre-commit lint checks
- Prevent committing passwords or keys

---

## 🛠️ Git Stash

Temporarily save changes without committing:
```bash
git stash
```
To retrieve:
```bash
git stash apply
```

---

## 🍒 Merge vs Rebase vs Cherry-pick

| Command                     | Purpose                                               |
|----------------------------|-------------------------------------------------------|
| `git merge <branch>`       | Merge a branch, preserving commit history            |
| `git rebase <branch>`      | Reapply commits on top of another base (linear history) |
| `git cherry-pick <commit>` | Apply a specific commit from another branch          |

---

## 🌍 GitHub: Remote Repositories

### Set Remote Repo:
```bash
git remote add origin https://github.com/username/repo.git
```

### Clone a Repo:
```bash
git clone <repo-url>
```

### Push & Pull:
```bash
git push origin main
# or
git pull origin main
```

---

## 🅾️ Fork vs Clone

| Action    | Fork                                    | Clone                                  |
|-----------|-----------------------------------------|----------------------------------------|
| Where     | GitHub                                  | Local machine                          |
| Purpose   | Copy repo under your GitHub account     | Download repo locally                  |
| Use Case  | Contribute without affecting original   | Work on the project locally            |

### Typical Workflow:
1. Fork a repo from GitHub
2. Clone it to your machine
3. Make changes, push to your fork
4. Create a Pull Request to contribute upstream

---

## 🔁 Git Workflow Summary

```bash
git status
git add .
git commit -m "meaningful message"
git push
```

---

## 🧼 Clean-Up

To delete a Git-tracked project:
```bash
rm -rf <repository-name>
```

---

Happy coding and collaborating! 🚀
