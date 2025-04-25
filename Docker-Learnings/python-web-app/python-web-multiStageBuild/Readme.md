# Django Web App - Multi-Stage Docker Build

This project demonstrates how to containerize a Django web application using **multi-stage builds** in Docker, resulting in a significantly reduced image size and improved performance.

**Final Image Size:** **156 MB** (reduced from 600 MB)

---

## 🧱 Project Structure
├── Dockerfile 
├── requirements.txt 
└── README.md
  ├── djangoproject/  
    ├── manage.py 
    ├── djangoproject/ 
    └── demoapp/ 
      └── templates
        └── demoapp
          └── .html
          
---

## 🚀 Step-by-Step: Multi-Stage Docker Build

### 1. Create Your Django App

Run the following commands to create a new Django project and app:

```bash
django-admin startproject djangoproject
cd djangoproject
python manage.py startapp demoapp
```
2. Add Your App to INSTALLED_APPS
In djangoproject/settings.py, add the demoapp to the INSTALLED_APPS list:

```python
INSTALLED_APPS = [
    ...
    'demoapp',
]
```
3. Create a Minimal requirements.txt
The requirements.txt should include the necessary dependencies for your Django app:

```shell
Django>=4.0,<5.0
```
4. Create Your Multi-Stage Dockerfile
Here’s the Dockerfile that utilizes a multi-stage build to reduce the image size:
Refer https://github.com/ssibbya/MyDevopsJourney/tree/main/Docker-Learnings/python-web-app/Dockerfile

### 🛠️ Build & Run
Build the Docker Image
```bash
docker build -t my-django-app .
```
Run the Container
```bash
docker run -p 8000:8000 -it my-django-app
```
Access the app via: http://localhost:8000/

---

## 🧩 Key Challenges & Fixes

| Challenge                                                     | Solution                                                                 |
|---------------------------------------------------------------|--------------------------------------------------------------------------|
| `manage.py` not found                                         | Ensure correct `WORKDIR` and file path in `CMD` (e.g., `/app/djangoproject/manage.py`) |
| `ModuleNotFoundError: No module named 'djangoproject.settings'` | Make sure your Django `settings.py` is in the correct project directory structure |
| `TemplateDoesNotExist`                                        | Verify templates are in the right path and added to `TEMPLATES['DIRS']` in `settings.py` |
| `DisallowedHost` error                                        | Add public IP or domain to `ALLOWED_HOSTS` in `settings.py`              |
| Large image size (600MB)                                      | Solved by using multi-stage build with `python:slim` and separating dependencies |

---

## 🐳 Why Multi-Stage Build?

- ✅ **Reduced Image Size**
- ✅ **Better Security** (no build tools in final image)
- ✅ **Cleaner & Faster Deployments**
- ✅ **Easier CI/CD Optimization**

---

## 📦 Docker Hub Deployment (Optional)

Tag and push the image to Docker Hub:

```bash
doker login
docker tag my-django-app yourusername/my-django-app:latest
docker push yourusername/my-django-app:latest
```
