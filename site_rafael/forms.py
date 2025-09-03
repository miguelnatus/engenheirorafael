# site_rafael/forms.py
from django import forms
from .models import Contato

PROIBIDOS = ("http://", "https://", "@")

class ContatoForm(forms.ModelForm):
    nomeCompleto = forms.CharField(label="Nome", max_length=160)
    celular      = forms.CharField(label="Celular", max_length=40, required=False)
    email        = forms.EmailField(label="E-mail", required=False)
    cidade       = forms.CharField(label="Cidade", max_length=120)
    mensagem     = forms.CharField(label="Mensagem", widget=forms.Textarea)

    class Meta:
        model  = Contato
        fields = []  # usaremos os campos acima e mapeamos na view

    def clean(self):
        data = super().clean()
        nome  = data.get("nomeCompleto","")
        cidade= data.get("cidade","")
        msg   = data.get("mensagem","")

        # obrigatórios: nome, cidade, mensagem e (celular OU email)
        if not nome or not cidade or not msg:
            raise forms.ValidationError("Preencha nome, cidade e mensagem.")
        if not data.get("celular") and not data.get("email"):
            raise forms.ValidationError("Informe celular ou e-mail.")

        # regra antispam do ASP: nenhum dos 3 pode conter http/https/@
        for campo_val in (msg, nome, cidade):
            for token in PROIBIDOS:
                if token.lower() in campo_val.lower():
                    raise forms.ValidationError("Remova links/endereços da mensagem, nome ou cidade.")

        return data
