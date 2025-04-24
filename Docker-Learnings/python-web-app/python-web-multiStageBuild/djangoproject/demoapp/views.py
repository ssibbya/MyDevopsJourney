from django.shortcuts import render

# Create your views here.
def welcome_view(request):
    return render(request, 'demoapp/welcome.html')
