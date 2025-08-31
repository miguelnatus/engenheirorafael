from django.contrib import admin
from .models import Servico, Portfolio, Contato, SiteConfig

@admin.register(Servico)
class ServicoAdmin(admin.ModelAdmin):
    list_display = ("titulo","ativo","ordem","atualizado_em")
    list_filter = ("ativo",)
    search_fields = ("titulo","resumo","descricao")
    prepopulated_fields = {"slug": ("titulo",)}

@admin.register(Portfolio)
class PortfolioAdmin(admin.ModelAdmin):
    list_display = ("titulo","cliente","ativo","ordem","atualizado_em")
    list_filter = ("ativo",)
    search_fields = ("titulo","cliente","descricao")
    prepopulated_fields = {"slug": ("titulo",)}

@admin.register(Contato)
class ContatoAdmin(admin.ModelAdmin):
    list_display = ("nome","email","telefone","lido","criado_em")
    list_filter = ("lido",)
    search_fields = ("nome","email","assunto","mensagem")

admin.site.register(SiteConfig)
