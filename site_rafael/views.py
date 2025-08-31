from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpRequest, HttpResponse
from .models import Servico, Portfolio, Contato
from django.core.mail import send_mail

def home(request: HttpRequest):
    servicos = Servico.objects.filter(ativo=True).order_by("ordem","id")[:12]
    return render(request, "home.html", {"servicos": servicos})

def servicos(request: HttpRequest):
    servicos = Servico.objects.filter(ativo=True).order_by("ordem","id")
    return render(request, "servicos.html", {"servicos": servicos})

def atuacao(request: HttpRequest, id: int, slug: str):
    # no ASP usava id e slug; aqui aceitamos ambos
    svc = get_object_or_404(Servico, id=id)
    return render(request, "servico_detalhe.html", {"servico": svc})

def contato(request: HttpRequest):
    return render(request, "contato.html")

def send_contato(request: HttpRequest):
    if request.method != "POST":
        return redirect("contato")
    nome = request.POST.get("nome","").strip()
    email = request.POST.get("email","").strip()
    telefone = request.POST.get("telefone","").strip()
    assunto = request.POST.get("assunto","").strip()
    mensagem = request.POST.get("mensagem","").strip()

    c = Contato.objects.create(
        nome=nome, email=email, telefone=telefone, assunto=assunto,
        mensagem=mensagem, ip=request.META.get("REMOTE_ADDR"),
        user_agent=request.META.get("HTTP_USER_AGENT","")[:255]
    )
    # opcional: envia e-mail (console em dev)
    send_mail(
        subject=f"[Site] {assunto or 'Contato'} - {nome}",
        message=mensagem,
        from_email=email or None,
        recipient_list=["voce@seu-dominio.com"],
        fail_silently=True,
    )
    return render(request, "contato_ok.html", {"contato": c})
