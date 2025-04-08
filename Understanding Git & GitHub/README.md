# Git & GitHub: A Beginner-Friendly Guide (DevOps Journey)

Welcome! This document is part of my DevOps learning journey where I dive into the world of **version control using Git and GitHub**.  
If you're new or brushing up your Git skills, this guide will help you understand the basics in a practical, conversational way.

---

## 🗂️ Version Control: What and Why?

Imagine you're working on a project and accidentally mess up a file.  
Wouldn't it be great to go back in time and restore it?  
That’s what **version control** is all about!

### 🔄 Key Benefits:
1. **Sharing:** Collaborate with team members on code/projects.
2. **Versioning:** Track every change made, roll back if needed, and maintain history.

---

## ⚖️ Centralized vs. Distributed Version Control

| Type | Description | Examples |
|------|-------------|----------|
| **Centralized** | One central server. Developers check out code, make changes, and commit back to the server. | SVN, CVS |
| **Distributed** | Every developer has a **full copy** of the repository including history. | Git |

💡 **Why Git is better?**  
Even if the central server goes down, you still have a full copy locally. No more single point of failure!

---

## 🧪 Git vs GitHub – What’s the Difference?

- **Git** is an **open-source version control tool**. You install it locally and track code changes.
- **GitHub**, **GitLab**, and **Bitbucket** are **platforms built on top of Git**.  
  They offer collaboration tools like:
  - Code hosting
  - Pull requests
  - Issues
  - Reviews
  - Project boards

---

## 🚀 Getting Started with Git

### 🔧 Install Git:
For Ubuntu:  
```bash
sudo apt-get install git

---

##📁 Initialize a Git Repository:
```bash
git init

This creates a .git folder – the brain of your project’s version control.

##🧠 Core Git Commands You Need to Know

|	 Command 	|	 Purpose	|
|---------------|---------------|
|git status	| Check current state of files|
git add <filename> |	Stage file changes|
git commit -m "message" |	Save changes to version history|
git push |	Send your changes to a remote repository (e.g., GitHub)|
git log	| See commit history|
git diff | 	View line-by-line changes|
git reset --hard <commit-id>	| Roll back to a specific version|
git checkout <commit-id>	| View older commit temporarily|

🛠️ Tip: Every time you update a file, run:

```bash
git add .
git commit -m "meaningful message"

---

##🔐 Git Hooks
Want to stop sensitive data like passwords from getting committed accidentally?
Use Git hooks – custom scripts that run before actions like commits. Super helpful for enforcing rules.

---

##🌱 Git Branching (A Must-Know!)
Branching lets you work on new features without touching the stable main branch.

###🧪 What’s a Branch?
Say you have a calculator app on the main branch.
Now you want to add a scientific mode.
Create a feature branch, test thoroughly, and then merge it back.

###💡 Branching Strategy (Good for Resume & Interviews)

`main` or `master` – Stable production-ready code

`feature/*` – New features in progress

`release/*` – Preparing for deployment (so `main` stays untouched)

`hotfix/*` – Urgent fixes pushed directly to `main` and `release`

---

---

## 🆚 Fork vs Clone – What's the Difference?

| Concept | Fork | Clone |
|--------|------|-------|
| **Definition** | Makes a full copy of a repository under your GitHub account | Downloads (copies) a repository from GitHub to your local machine |
| **Used For** | Contributing to someone else's project without affecting the original repo | Working on code locally |
| **Where It Happens** | On GitHub (cloud) | On your computer (local) |
| **Relationship** | Maintains a connection to the original repo (can sync updates) | Has no inherent connection to the original once cloned |

### 💡 Real Use Case:
1. **Fork** a public repo → You now own a copy under your GitHub profile.
2. **Clone** that forked repo → Work on it locally.
3. Push changes → Open a Pull Request to contribute to the original repo.

---

##🤝 Working with Remote Repositories
`git remote -v` – Show remote URLs

`git clone <repo-url>` – Download a repo to your local system

HTTPS or SSH (with public key via ssh-keygen -t rsa)

`git pull` – Fetch and merge the latest from remote

`git push` – Push your local changes to GitHub

---

##🧳 Git Stash (Bonus Tip!)
Temporarily save uncommitted changes:

```bash
git stash

Retrieve it later:

```bash
git stash apply

---

##🍒 Git: Merge vs Rebase vs Cherry-Pick

`git merge`	Combines two branches and keeps all commit history.
`git rebase`	Rewrites commit history to create a linear structure.
`git cherry-pick <commit-id>`	Apply a single specific commit from one branch into another.

---

##🧼 Clean-Up
To delete a local repository:

```bash
rm -rf <repository-name>

---

##🗃️ Git Workflow (Quick Recap)
```bash
git add .
git commit -m "Meaningful message"
git push

##📌 Bonus Tips

`git log <branch>` – Check commit history of specific branch

`git checkout <branch> && git log` – Navigate and explore logs

`git cherry-pick <commit-id>` – Bring a single commit into current branch

`git stash` – Temporarily save your work without committing

