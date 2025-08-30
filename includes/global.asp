<!--#include file="functions.asp"-->
<%
Response.ContentType 	= "text/html"
Response.AddHeader 		"Content-Type", "text/html;charset=UTF-8"
Response.CodePage 		= 65001
Response.CharSet 		= "UTF-8"
ConexaoDB(true)

' ***************** INFORMAÇÕES DO SITE ***************** '
arquivo 				= REPLACE(REPLACE(Request.Servervariables("HTTP_X_ORIGINAL_URL"),".asp",""),"/","")
urlWebsite 				= Request.Servervariables("HTTP_HOST")
caminhoAnexo 			= "https://painel."&urlWebsite&"/anexos"
caminhoTemporario 		= "https://painelwebsite.conectsis.com.br/anexos/"
projId 					= 4

SET rsProj 				= CONEXAO.EXECUTE("SELECT projHash,empresa,dominio FROM tbl_projetos_ WHERE id='"&projId&"' AND status='1';")
IF NOT rsProj.EOF THEN
empresa 				= rsProj("empresa")
dominio 				= rsProj("dominio")
projHash 				= rsProj("projHash")
ELSE
RESPONSE.REDIRECT("/manutencao")
RESPONSE.END()
END IF
SET rsProj 				= NOTHING

SET rsConf 				= CONEXAO.EXECUTE("SELECT * FROM tbl_configuracoes_ WHERE projHash='"&projHash&"';")
IF NOT rsConf.EOF THEN
g_destaque 				= rsConf("g_destaque")
g_horario 				= rsConf("g_horario")
g_btnWhats 				= rsConf("g_btnWhats")
g_titleBtn 				= rsConf("g_titleBtn")
g_linkMapa 				= rsConf("g_linkMapa")
g_fraseChamada 			= rsConf("g_fraseChamada")
g_textoChamada 			= rsConf("g_textoChamada")
g_metaTitle 			= rsConf("g_metaTitle")
g_metaDesc 				= rsConf("g_metaDesc")
g_palavraChave 			= rsConf("g_palavraChave")
g_facebook 				= rsConf("g_facebook")
g_insta 				= rsConf("g_insta")
g_link 					= rsConf("g_link")
g_pint 					= rsConf("g_pint")
g_politica 				= rsConf("g_politica")
g_servidor 				= rsConf("g_servidor")
g_smtp 					= rsConf("g_smtp")
g_mail 					= rsConf("g_mail")
g_senha 				= rsConf("g_senha")
g_senha 				= rsConf("g_senha")
facebook 				= "https://fb.com/"&g_facebook
instagram 				= "https://instagram.com/"&g_insta
END IF
SET rsConf 				= NOTHING


SET rsUnid 				= CONEXAO.EXECUTE("SELECT * FROM tbl_unidades_ WHERE projHash='"&projHash&"';")
IF NOT rsUnid.EOF THEN
u_unidade 				= rsUnid("u_unidade")
u_tel1 					= rsUnid("u_tel1")
u_tel2 					= rsUnid("u_tel2")
u_cep 					= rsUnid("u_cep")
u_endereco 				= rsUnid("u_endereco")
u_numero 				= rsUnid("u_numero")
u_complemento 			= rsUnid("u_complemento")
u_bairro 				= rsUnid("u_bairro")
u_cidade 				= rsUnid("u_cidade")
u_uf 					= rsUnid("u_uf")
u_mapa 					= rsUnid("u_mapa")
u_email 				= rsUnid("u_email")
whats 					= REPLACE(REPLACE(REPLACE(REPLACE(u_tel1,"(",""),")",""),"-","")," ","")
whatsApp 				= "https://wa.me/55"&whats
telefone 				= "tel:+55"&REPLACE(REPLACE(REPLACE(REPLACE(u_tel1,"(",""),")",""),"-","")," ","")
END IF
SET rsUnid 				= NOTHING

emailDisparo			= u_email

SET rsTag 				= CONEXAO.EXECUTE("SELECT * FROM tbl_tags_ WHERE projHash='"&projHash&"';")
IF NOT rsTag.EOF THEN
tagManager 				= rsTag("tagManager")
tagGlobal 				= rsTag("tagGlobal")
tagAnalytics 			= rsTag("tagAnalytics")
tagConversion 			= rsTag("tagConversion")
tagGVerification 		= rsTag("tagGVerification")
tagFVerification 		= rsTag("tagFVerification")
tagPVerification 		= rsTag("tagPVerification")
END IF
SET rsTag 				= NOTHING

paginaId 				= makeNum(REQUEST("id"))

IF checkUserAgent() 	= "PC" THEN
typeScreen 				= "0"
ELSEIF checkUserAgent()	= "Phone" THEN
typeScreen 				= "1"
END IF

%>