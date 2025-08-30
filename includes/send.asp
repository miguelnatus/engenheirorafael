<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" lcid="1046"%>
<!--#include file="global.asp"-->
<%
IF Request.ServerVariables("REQUEST_METHOD") 												= "POST" THEN
nomeCompleto 								 												= makeStr(REQUEST("nomeCompleto"))
celular 									 												= makeStr(REQUEST("celular"))
email 										 												= makeStr(REQUEST("email"))
cidade 										 												= makeStr(REQUEST("cidade"))
mensagem 									 												= makeStr(REQUEST("mensagem"))


SET objCDOSYSMail 		 																	= Server.CreateObject("CDO.Message") 
SET objCDOSYSCon 		 																	= Server.CreateObject("CDO.Configuration")
objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver")			= g_smtp
objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport")		= 587
objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing")				= 2
objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")		= 1 
objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername")			= g_mail
objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword")			= g_senha
objCDOSYSCon.Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout")	= 30 
objCDOSYSCon.Fields.UPDATE 
SET objCDOSYSMail.Configuration 															= objCDOSYSCon

' FORMULARIO DE ATENDIMENTO
IF nomeCompleto  <> "" AND cidade <> "" AND mensagem <> "" AND ( celular <> "" OR email <> "") THEN	
corpoMensagem = ""
corpoMensagem = corpoMensagem & "<table class='table' width='100%' style='padding: 10px;background-color: #282d25;'>"
corpoMensagem = corpoMensagem & "<tbody>"
corpoMensagem = corpoMensagem & "<tr>"
corpoMensagem = corpoMensagem & "<td>"
corpoMensagem = corpoMensagem & "<center><img src='"&urlWebsite&"/assets/logoPng.png' height='55'></center>"
corpoMensagem = corpoMensagem & "<table class='table' width='100%' style='background-color: #fff; margin-top: 10px;margin-bottom: 20px; padding: 30px'>"
corpoMensagem = corpoMensagem & "<tbody>"
corpoMensagem = corpoMensagem & "<tr>"
corpoMensagem = corpoMensagem & "<td style='text-align:center;'>"
corpoMensagem = corpoMensagem & "<h2 style='padding-top:20px;margin:0;font-weight: 600;'>Um novo contato está querendo falar com você:</h2>"
corpoMensagem = corpoMensagem & "<p style='margin-top: 20px;'>"
corpoMensagem = corpoMensagem & "<b>Nome:</b> " 				& nomeCompleto 	& "<br>"

IF celular 	  <> "" THEN
corpoMensagem = corpoMensagem & "<b>Celular:</b> " 				& celular 		& "<br>"
END IF 

IF email 	  <> "" THEN
corpoMensagem = corpoMensagem & "<b>E-mail:</b> " 				& email 		& "<br>"
END IF

corpoMensagem = corpoMensagem & "<b>Cidade:</b> " 				& cidade 		& "<br>"
corpoMensagem = corpoMensagem & "<b>Mensagem:</b> " 			& mensagem 		& "<br>"
corpoMensagem = corpoMensagem & "</p>"
corpoMensagem = corpoMensagem & "<p style='margin-top: 20px;line-height: 22px; text-decoration: none;color: #333'>"
corpoMensagem = corpoMensagem & "</p>"
corpoMensagem = corpoMensagem & "<p style='margin-top: 30px;margin-bottom: 0px;color: #ccc; font-size: 14px'>Esta é uma mensagem automática.</p>"
corpoMensagem = corpoMensagem & "</td>"
corpoMensagem = corpoMensagem & "</tr>"
corpoMensagem = corpoMensagem & "</tbody>"
corpoMensagem = corpoMensagem & "</table>"
corpoMensagem = corpoMensagem & "</td>"
corpoMensagem = corpoMensagem & "</tr>"
corpoMensagem = corpoMensagem & "</tbody>"
corpoMensagem = corpoMensagem & "</table>"
ELSE
CONEXAO.CLOSE
SET CONEXAO 																				= NOTHING
RESPONSE.WRITE "<script>alert('Preencha os campos corretamente'); document.location='/contato';</script>"
RESPONSE.END()
END IF

objCDOSYSMail.ReplyTo 	 																	= g_mail
objCDOSYSMail.Subject 	 																	= "Formulário Website"
objCDOSYSMail.FROM 		 																	= g_mail
objCDOSYSMail.To 		 																	= emailDisparo
objCDOSYSMail.HtmlBody 	 																	= corpoMensagem
validacao 				 																	= mensagem
validacao2 				 																	= nomeCompleto
validacao3 				 																	= cidade
campo1 					 																	= "http://"
campo2 					 																	= "https://"
campo3 					 																	= "@"
IF (instr(validacao,campo1) = 0 and instr(validacao,campo2) = 0 and instr(validacao,campo3) = 0 AND instr(validacao2,campo1) = 0 and instr(validacao2,campo2) = 0 and instr(validacao2,campo3) = 0 AND instr(validacao3,campo1) = 0 and instr(validacao3,campo2) = 0 and instr(validacao3,campo3) = 0) then

CONEXAO.EXECUTE("INSERT INTO tbl_contatos_(c_dc,c_nome,c_telefone,c_email,c_cidade,c_mensagem,c_origem,projhash) VALUES ('"&DataMySQL(now,1)&"','"&nomeCompleto&"','"&celular&"','"&email&"','"&cidade&"','"&mensagem&"','2', '"&projhash&"')")
objCDOSYSMail.Send 
END IF

RESPONSE.WRITE "<script>alert('E-mail enviado com sucesso'); document.location='/home';</script>"

END IF



%>