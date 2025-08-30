<%
'|||||||||||||||||||||||||||||||||||||||||||'
'FUNÇÃO: CONEXÃO COM O BANCO DE DADOS
'|||||||||||||||||||||||||||||||||||||||||||'
DIM Conexao
SUB ConexaoDB(acao)
IF (acao) THEN
%><!--#include file="arquivo.asp"--><%
SET conexao 			= Server.CreateObject("ADODB.Connection") 
conexao.open("DRIVER={MySQL ODBC 3.51 Driver};SERVER="&servidor&";DATABASE="&bancodedados&";USER="&usuario&";PASSWORD="&senha&";OPTION=16384;")
ELSE
conexao.Close()
SET conexao 			= NOTHING
END IF
END SUB

FUNCTION getRegistro(tabela, campo, valor)
IF valor 				<> "" THEN
strSQL_i 				= "SELECT " & campo & " FROM " & tabela & " WHERE id = " & valor & ";"
SET rs_i 				= conexao.execute(strSQL_i)
IF NOT Rs_i.BOF AND NOT Rs_i.EOF THEN
getRegistro 			= Rs_i(campo)
END IF
ELSE
getRegistro 			= ""
END IF
FechaRs(Rs_i)
END FUNCTION

FUNCTION makeNum(texto)
IF isNull(texto) OR isEmpty(texto) THEN
texto 					= "0"
END IF
SET objRegExp 			= New RegExp
objRegExp.Pattern 		= "([^0-9])*"
objRegExp.IgnoreCase 	= TRUE
objRegExp.Global 		= TRUE
makeNum 				= objRegExp.Replace(texto, "")
SET objRegExp 			= NOTHING
IF Len(makeNum) 		= 0 OR makeNum = "" THEN makeNum = 0
makeNum 				= CDBl(makeNum)
END FUNCTION

FUNCTION DataMySQL(data, formato)
IF isDate(data) 		= FALSE then Exit FUNCTION
sDia					= Day( data )
sMes					= Month( data )
sHoras					= Hour( data )
sMinutos				= Minute( data )
sSegundos				= Second( data )
IF sDia 				<= 9 THEN sDia = "0" & sDia
IF sMes 				<= 9 THEN sMes = "0" & sMes
IF sHoras 				<= 9 THEN sHoras = "0" & sHoras
IF sMinutos 			<= 9 THEN sMinutos = "0" & sMinutos
IF sSegundos 			<= 9 THEN sSegundos = "0" & sSegundos
IF formato 				= "1" THEN
DataMySQL 				= Year(data) & "-" & sMes & "-" & sDia
ELSEIF formato 			= "2" THEN
DataMySQL 				= Year(data) & "-" & sMes & "-" & sDia & " " & sHoras & ":" & sMinutos & ":" & sSegundos
ELSE
DataMySQL 				= Year(data) & "-" & sMes & "-" & sDia & "T" & sHoras & ":" & sMinutos & ":" & sSegundos
END IF
End FUNCTION

FUNCTION makeStr(texto)
IF isNull(texto) OR isEmpty(texto) THEN
makeStr 				= ""
ELSE
makeStr 				= Trim(texto)
makeStr 				= Replace(makeStr,"<","")
makeStr 				= Replace(makeStr,">","")
makeStr 				= Replace(makeStr,"'","")
makeStr 				= Replace(makeStr,"""","")
makeStr 				= Replace(makeStr,"\","\\")
makeStr 				= Replace(makeStr,Chr(34),"")
makeStr 				= Replace(makeStr,Chr(39),"")
makeStr 				= Replace(makeStr,Chr(60),"")
makeStr 				= Replace(makeStr,Chr(62),"")
makeStr 				= Replace(makeStr, Chr(160), "")
tempMake 				= Lcase(makeStr)
IF inStr(tempMake, "update")	> 0 AND inStr(tempMake, "set")		> 0 THEN makeStr = ""
IF inStr(tempMake, "select")	> 0 AND inStr(tempMake, "from")		> 0 THEN makeStr = ""
IF inStr(tempMake, "drop")		> 0 AND inStr(tempMake, "database")	> 0 THEN makeStr = ""
IF inStr(tempMake, "drop")		> 0 AND inStr(tempMake, "table")	> 0 THEN makeStr = ""
IF inStr(tempMake, "create")	> 0 AND inStr(tempMake, "table")	> 0 THEN makeStr = ""
IF inStr(tempMake, "insert")	> 0 AND inStr(tempMake, "into")		> 0 THEN makeStr = ""
IF inStr(tempMake, "delete")	> 0 AND inStr(tempMake, "from")		> 0 THEN makeStr = ""
IF inStr(tempMake, "flush")		> 0 AND inStr(tempMake, "table")	> 0 THEN makeStr = ""
IF inStr(tempMake, "show")		> 0 AND inStr(tempMake, "table")	> 0 THEN makeStr = ""
END IF
End FUNCTION
'|||||||||||||||||||||||||||||||||||||||||||'
'FUNÇÃO: ' PAGINAÇÂO'
'|||||||||||||||||||||||||||||||||||||||||||'
SUB PaginadorNovo(strPagina, intPag, TotPag, TotReg, TotRegPag)
TotalPages 				= TotPag
PagAtual 				= intPag

IF intPag 				> 1 THEN 
ResulInicio 			= intPag*TotRegPag-TotRegPag+1
ELSE
ResulInicio 			= 1
END IF

IF intPag 				= TotPag THEN 
ResulFim 				= TotReg
ELSEIF intPag 			= 1 THEN
ResulFim 				= TotRegPag
ELSE
ResulFim 				= intPag*TotRegPag
END IF

IF TotalPages 			> 1 THEN 
strLINK 				= strPagina
strLINK 				= REPLACE(strLINK, "&", "&amp;")
RESPONSE.WRITE ("<div class='row py-5'><div class='col-lg-12'>")
RESPONSE.WRITE ("<nav>")
RESPONSE.WRITE ("<ul class='pagination mb-0 justify-content-center'>")
var01 					= LEN(PagAtual) 'Lê o tamanho do numero
var02 					= var01 - 1 'subtrai um da variavel , retirando o digito menos sig.
var03 					= LEFT(PagAtual,var02) 'obtem os digitos mais  sig. do numero
var04 					= RIGHT(PagAtual,1)'obtem o digito menos sig. do numero
var05 					= var03 & 0 ' Acrecenta ZERO no final

IF var04 				<> 0 THEN	' condição se o digito menos sig. é Zero
inicial 				= var05 + 1
final 					= inicial + 9  
ELSE
inicial 				= var05 - 9  
final 					= var05
END IF

indice_i 				= var04 - 1 'ultimo digito  - 1
indice_f 				= 10 - var04 ' 10 - digito menos sig.

IF CInt(final) 			> CInt(TotalPages) THEN final = TotalPages

IF PagAtual 			> 1 THEN 
RESPONSE.WRITE 			("<li class='page-item'><a class='page-link' aria-label='Previous' href='"&strLINK&"&p="&PagAtual-1&"'><span aria-hidden='true'>&laquo;</span></a></li>")

IF PagAtual 			> 10 THEN
RESPONSE.WRITE ("<a href='"&strLINK&"&p="&inicial-1&"'></a>")
END IF

END IF

FOR i 					= inicial TO final

IF CInt(i)				= CInt(PagAtual) THEN
RESPONSE.WRITE ("<li class='page-item '><a class='page-link activePag' href='"&strLINK&"&p="&PagAtual&"'>"&i&"</a></li>")
END IF

IF CInt(i) 				< CInt(PagAtual) THEN
RESPONSE.WRITE ("<li class='page-item'><a class='page-link' href='"&strLINK&"&p="&i&"'>"&i&"</a></li>")
END IF

IF CInt(i)	 			> CInt(PagAtual) THEN
RESPONSE.WRITE ("<li class='page-item'><a class='page-link' href='"&strLINK&"&p="&i&"'>"&i&"</a></li>")
END IF

NEXT

IF CInt(PagAtual) 		<> CInt(TotalPages) THEN
RESPONSE.WRITE 	("<li class='page-item'><a class='page-link' aria-label='Next' href='"&strLINK&"&p="&PagAtual+1&"'><span aria-hidden='true'>&raquo;</span></a></li>")
END IF 

RESPONSE.WRITE "</ul>"
RESPONSE.WRITE "</nav>"
RESPONSE.WRITE "</div>"
RESPONSE.WRITE "</div>"
END IF

END SUB

'|||||||||||||||||||||||||||||||||||||||||||'
FUNCTION getRegistroWhere(tabela, campo, valor, Where)
strSQL_i 				= "SELECT " & campo & " FROM " & tabela & " WHERE "&Where&" = '" & valor & "';"
SET rs_i 				= CONEXAO.EXECUTE(strSQL_i)
IF NOT Rs_i.BOF AND NOT Rs_i.EOF THEN
getRegistroWhere 		= Rs_i(campo)
END IF
FechaRs(Rs_i)
END FUNCTION

'|||||||||||||||||||||||||||||||||||||||||||'
FUNCTION getImgWhere(valor, principal, modulo)
strSQL_i 				= "SELECT arquivo FROM tbl_anexos_ WHERE codId = '"&valor&"' and principal = '"&principal&"' and modulo='"&modulo&"';"
SET rs_i 				= CONEXAO.EXECUTE(strSQL_i)

IF NOT Rs_i.BOF AND NOT Rs_i.EOF THEN
getImgWhere 			= Rs_i("arquivo")
END IF
FechaRs(Rs_i)
END FUNCTION

'|||||||||||||||||||||||||||||||||||||||||||'
FUNCTION getImgTipoFoto(valor, principal, modulo,tipoFoto)
strSQL_i 				= "SELECT arquivo FROM tbl_anexos_ WHERE codId = '"&valor&"' and principal = '"&principal&"' AND tipoFoto ='"&tipoFoto&"' and modulo='"&modulo&"';"
SET rs_i 				= CONEXAO.EXECUTE(strSQL_i)

IF NOT Rs_i.BOF AND NOT Rs_i.EOF THEN
getImgTipoFoto 			= Rs_i("arquivo")
END IF

FechaRs(Rs_i)
End FUNCTION

FUNCTION Iif(condicao, verdadeiro, falso)
IF condicao THEN
Iif 					= verdadeiro
ELSE
Iif 					= falso
END IF	
END FUNCTION

FUNCTION FechaRs(NomeRs) 
IF IsObject(NomeRs) THEN 
IF NomeRs.State 		= 1 THEN 
NomeRs.Close 
END IF  
SET NomeRs 				= nothing 
END IF
END FUNCTION 

' REMOVE OS CARACTERS ESPECIAIS
FUNCTION MontaURL(conteudo)
MontaURL 				= TRIM(conteudo)
MontaURL 				= LCASE(REPLACE(MontaURL," ",""))
MontaURL 				= LCASE(REPLACE(MontaURL,"|","-"))
MontaURL 				= LCASE(REPLACE(MontaURL,",",""))
MontaURL 				= LCASE(REPLACE(MontaURL,"+",""))
MontaURL 				= LCASE(REPLACE(MontaURL,"\",""))
MontaURL 				= LCASE(REPLACE(MontaURL,"&","-"))
MontaURL 				= LCASE(REPLACE(MontaURL,"/",""))
MontaURL 				= LCASE(REPLACE(MontaURL,"%",""))
MontaURL 				= LCASE(REPLACE(MontaURL,"-#39;",""))
MontaURL 				= TirarAcento(MontaURL)
END FUNCTION


FUNCTION TirarAcento(ByVal Palavra)
CAcento 				= "àáâãäèéêëìíîïòóôõöùúûüÀÁÂÃÄÈÉÊËÌÍÎÒÓÔÕÖÙÚÛÜçÇñÑ"
SAcento 				= "aaaaaeeeeiiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcCnN"
Texto 					= ""
IF Palavra 				<> "" THEN

FOR X 					= 1 TO LEN(Palavra)
Letra 					= MID(Palavra,X,1)
Pos_Acento 				= INSTR(CAcento,Letra)
IF Pos_Acento 			> 0 THEN Letra = MID(SAcento,Pos_Acento,1)
Texto 					= Texto & Letra
NEXT

TirarAcento 			= Texto
END IF
END FUNCTION


FUNCTION checkUserAgent()
SET Regex 				= NEW RegExp
WITH Regex
.Pattern 				= "(Mobile\sSafari|Linux;\sAndroid|Mobile)"
.IgnoreCase 			= TRUE
.Global 				= TRUE
END WITH

Match 					= Regex.test(Request.ServerVariables("HTTP_USER_AGENT"))
IF Match THEN
user_agent 				= "Phone"
END IF

SET Regex 				= NEW RegExp
WITH Regex
.Pattern 				= "(windows\sNT|Macintosh)"
.IgnoreCase 			= TRUE
.Global 				= TRUE
END WITH
Match 					= Regex.test(Request.ServerVariables("HTTP_USER_AGENT"))

IF Match THEN
user_agent 				= "PC"
END IF

SET Regex 				= NEW RegExp
WITH Regex
.Pattern 				= "(ipad)"
.IgnoreCase 			= TRUE
.Global 				= TRUE
END WITH

Match 					= Regex.test(Request.ServerVariables("HTTP_USER_AGENT"))

IF Match THEN
user_agent 				= "Tablet"
END IF

checkUserAgent 			= user_agent
END FUNCTION
%>

INSERT INTO auth_usuarios (nome, email, senha_md5, is_admin) -> VALUES ('miguelnatus', 'miguelnatus@gmail.com', MD5('Ozoutros@123'), 1);