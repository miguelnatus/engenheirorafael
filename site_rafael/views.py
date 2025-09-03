from django.shortcuts import render, get_object_or_404, redirect
from django.conf import settings
from django.http import HttpRequest
from django.core.mail import EmailMultiAlternatives
from .models import Contato, Atuacao, Contato, Banner
from django.core.mail import send_mail
from django.template.loader import render_to_string
from .forms import ContatoForm
from django.contrib import messages

EMAIL_DESTINO = getattr(settings, "CONTACT_EMAIL_TO", None)

def home(request):
    banners = Banner.objects.filter(ativo=True).order_by("id")
    atuacoes = Atuacao.objects.filter(p_sit=True).order_by("ordem", "id")
    return render(request, "home.html", {"banners": banners, "atuacoes": atuacoes})

def servicos(request: HttpRequest):
    atuacoes = Atuacao.objects.filter(p_sit=True).order_by("ordem", "id")
    return render(request, "servicos.html", {"atuacoes": atuacoes})


def atuacao(request, id, slug):
    atuacao = get_object_or_404(Atuacao, pk=id, p_sit=True)
    return render(request, "servico_detalhe.html", {"atuacao": atuacao})

def contato(request):
    if request.method == "POST":
        form = ContatoForm(request.POST)
        if form.is_valid():
            nome     = form.cleaned_data["nomeCompleto"].strip()
            celular  = form.cleaned_data.get("celular","").strip()
            email    = form.cleaned_data.get("email","").strip()
            cidade   = form.cleaned_data["cidade"].strip()
            mensagem = form.cleaned_data["mensagem"].strip()

            # salva no banco (campos como no ASP)
            contato = Contato.objects.create(
                c_nome=nome,
                c_telefone=celular,
                c_email=email,
                c_cidade=cidade,
                c_mensagem=mensagem,
                c_origem="2",
            )

            # e-mail (HTML), semelhante ao corpo do ASP
            if EMAIL_DESTINO:
                ctx_email = {
                    "logo_url": getattr(settings, "CONTACT_LOGO_URL", "/static/logo.png"),
                    "nome": nome, "celular": celular, "email": email,
                    "cidade": cidade, "mensagem": mensagem,
                    "site_url": getattr(settings, "SITE_URL", "http://localhost:8000"),
                }
                subject = "Formulário Website"
                html = render_to_string("emails/contato.html", ctx_email)
                msg = EmailMultiAlternatives(subject, html, EMAIL_DESTINO, [EMAIL_DESTINO], reply_to=[EMAIL_DESTINO])
                msg.attach_alternative(html, "text/html")
                try:
                    msg.send(fail_silently=True)
                except Exception:
                    pass  # não falhar a UX se o e-mail não puder ser enviado

            messages.success(request, "E-mail enviado com sucesso.")
            return redirect("home")  # ou redirect("contato_ok")

        # inválido
        messages.error(request, "Preencha os campos corretamente.")
    else:
        form = ContatoForm()

    return render(request, "contato.html", {"form": form})
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
