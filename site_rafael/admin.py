from django.contrib import admin
from .models import Servico, Portfolio, Contato, Banner
from django.utils.html import format_html

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


@admin.register(Banner)
class BannerAdmin(admin.ModelAdmin):
    list_display    = ["id", "thumb", "titulo", "ativo", "atualizado_em"]
    list_filter     = ["ativo"]
    search_fields   = ["titulo"]
    readonly_fields = ["criado_em", "atualizado_em", "preview"]
    fields          = ["titulo", "ativo", "imagem", "preview", "criado_em", "atualizado_em"]
    ordering        = ["-id"]

    @admin.display(description="Imagem")
    def thumb(self, obj):
        return format_html('<img src="{}" style="height:40px;border-radius:4px;">', obj.imagem.url) if obj.imagem else "-"

    @admin.display(description="Preview")
    def preview(self, obj):
        return format_html('<img src="{}" style="max-width:400px;border-radius:8px;">', obj.imagem.url) if obj.imagem else "Sem imagem"
