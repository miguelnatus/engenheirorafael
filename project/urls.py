from django.contrib import admin
from django.urls import path, re_path
from django.conf import settings
from django.conf.urls.static import static
from site_rafael import views

urlpatterns = [
    path("admin/", admin.site.urls),

    path("", views.home, name="home"),
    path("home", views.home),
    path("servicos", views.servicos, name="servicos"),
    re_path(r"^atuacao/(?P<id>\d+)/(?P<slug>[_0-9a-z-]+)$", views.atuacao, name="atuacao"),
    path("contato", views.contato, name="contato"),
    path("send", views.contato, name="send_contato"),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
