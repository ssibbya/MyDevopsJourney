# Django Application with Docker - Dev Setup & Containerization

This guide walks you through setting up a simple Django application from source, customizing it, and finally containerizing it using Docker.

---

## 🛠️ Setup Django in a Virtual Environment

If you need a development version of Django, you can download and install Django from its Git repository. Let’s do this from within a virtual environment.

### 1. Update Local Package Index
```bash
sudo apt update
```

### 2. Check Python Version
```bash
python3 -V
```
**Output Example:**
```
Python 3.10.4
```

### 3. Install `pip` and `venv`
```bash
sudo apt install python3-pip python3-venv
```

### 4. Clone the Django Git Repository
```bash
git clone git://github.com/django/django ~/django-dev
```

### 5. Change to Django Directory
```bash
cd ~/django-dev
```

### 6. Create a Virtual Environment
```bash
python3 -m venv my_env
```

### 7. Activate Virtual Environment
```bash
source my_env/bin/activate
```

### 8. Install Django in Editable Mode
```bash
pip install -e ~/django-dev
```

### 9. Verify Installation
```bash
django-admin --version
```
**Output Example:**
```
4.0.4.2
```

You now have the latest version of Django in your virtual environment.

---

## 🚀 Create Django Project & App

### 1. Start the Project
```bash
django-admin startproject djangoproject
```
**Project Structure:**
```
djangoproject/
├── manage.py
└── djangoproject/
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    ├── asgi.py
    └── wsgi.py
```

### 2. Create a Django App
```bash
python manage.py startapp demoapp
```
**App Structure:**
```
demoapp/
├── __init__.py
├── admin.py
├── apps.py
├── migrations/
│   └── __init__.py
├── models.py
├── tests.py
└── views.py
```

---

## 🛠️ Configuration & Routing

### 1. Update `djangoproject/urls.py`
Add routing to include the app’s URL configuration.

### 2. Create View and Template
Update `demoapp/views.py` to include a view.
Create the template at `demoapp/templates/welcome.html`.

### 3. Update Settings
Edit `djangoproject/settings.py` to:
- Add your IP to `ALLOWED_HOSTS`
- Add `'demoapp'` to `INSTALLED_APPS`
- Set `TEMPLATES` directories path if needed

---

## 📁 Final Project Structure
```
python-web-app/
│
├── demoapp/
│   ├── templates/
│   │   └── welcome.html
│   ├── views.py
│   └── urls.py
├── djangoproject/
│   └── settings.py
├── Dockerfile
├── requirements.txt
└── README.md
```

---

## 🐳 Dockerize Django App

### 1. Navigate to Project Root
```bash
cd python-web-app/
```

### 2. Create `Dockerfile`
Refer to your existing `Dockerfile`.

### 3. Create `requirements.txt`
Refer to your app's dependencies. Example:
```
Django>=4.0,<5.0
```

### 4. Build Docker Image
```bash
docker build -t my-python-app .
```

#### Run the Docker Container
```
docker run -p 8000:8000 -it <dockerimage_id>
```
#### ❓ Why -p 8000:8000?

The -p flag maps port 8000 of your local machine to port 8000 of the container. This is necessary because Django runs on port 8000 by default inside the container. Without this, you won't be able to access the app from your browser via http://localhost:8000 or http://<public-ip>:8000.

Visit the App

Open a browser and go to:
```
http://<public-ip>:8000/demoapp/
```

Now your Django app is running inside a container and accessible via a web browser!

#### ✅ Summary

- Installed Django from source

- Created a Django project and app
 
- Configured URLs, views, templates, and settings

- Containerized the project using Docker

- Ran it using port mapping to access via browser

Happy developing! 🎉
