from django.db import models
from django.utils.text import slugify

class SiteConfig(models.Model):
    chave = models.CharField(max_length=60, primary_key=True)
    valor = models.TextField()

    def __str__(self): return self.chave

class Servico(models.Model):
    titulo = models.CharField(max_length=160)
    slug = models.SlugField(max_length=160, unique=True, blank=True)
    resumo = models.CharField(max_length=255, blank=True)
    descricao = models.TextField(blank=True)
    imagem_capa = models.ImageField(upload_to="servicos/", blank=True, null=True)
    ordem = models.IntegerField(default=0)
    ativo = models.BooleanField(default=True)
    criado_em = models.DateTimeField(auto_now_add=True)
    atualizado_em = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.titulo)[:160]
        super().save(*args, **kwargs)

    def __str__(self): return self.titulo

class Portfolio(models.Model):
    titulo = models.CharField(max_length=160)
    slug = models.SlugField(max_length=160, unique=True, blank=True)
    descricao = models.TextField(blank=True)
    imagem_capa = models.ImageField(upload_to="portfolio/", blank=True, null=True)
    cliente = models.CharField(max_length=160, blank=True)
    data_obra = models.DateField(null=True, blank=True)
    ativo = models.BooleanField(default=True)
    ordem = models.IntegerField(default=0)
    criado_em = models.DateTimeField(auto_now_add=True)
    atualizado_em = models.DateTimeField(auto_now=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.titulo)[:160]
        super().save(*args, **kwargs)

    def __str__(self): return self.titulo

class Contato(models.Model):
    nome = models.CharField(max_length=160)
    email = models.EmailField()
    telefone = models.CharField(max_length=40, blank=True)
    assunto = models.CharField(max_length=200, blank=True)
    mensagem = models.TextField()
    ip = models.GenericIPAddressField(null=True, blank=True)
    user_agent = models.CharField(max_length=255, blank=True)
    lido = models.BooleanField(default=False)
    criado_em = models.DateTimeField(auto_now_add=True)

    def __str__(self): return f"{self.nome} - {self.assunto or 'contato'}"
