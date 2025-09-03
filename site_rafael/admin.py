from django.contrib import admin
from .models import Servico, Portfolio, Contato, Banner, Atuacao
from django.utils.html import format_html
from django.utils.text import slugify

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
    list_display    = ["c_nome", "c_email", "c_telefone", "c_cidade", "c_dc"]
    search_fields   = ["c_nome", "c_email", "c_cidade", "c_mensagem"]
    list_filter     = []  # não há 'lido' no model
    ordering        = ["-id"]
    date_hierarchy  = "c_dc"


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


@admin.register(Atuacao)
class AtuacaoAdmin(admin.ModelAdmin):
    list_display   = ("p_titulo", "p_resumo", "p_sit", "ordem", "thumb", "atualizado_em", "ver_no_site")
    list_filter    = ["p_sit"]
    search_fields  = ["p_titulo", "p_resumo", "p_desc"]
    ordering       = ["ordem", "id"]
    prepopulated_fields = {"slug": ("p_titulo",)}

    @admin.display(description="Imagem")
    def thumb(self, obj):
        if obj.imagem:
            return format_html('<img src="{}" style="height:40px;border-radius:4px;">', obj.imagem.url)
        return "-"

    @admin.display(description="Ver no site")
    def ver_no_site(self, obj):
        if obj.id and obj.slug:
            return format_html('<a href="/atuacao/{}/{}/" target="_blank">Abrir</a>', obj.id, obj.slug)
        return "-"


#