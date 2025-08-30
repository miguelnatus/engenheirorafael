<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" lcid="1046"%>
<!--#include file="includes/global.asp"-->
<%
pag  			= "SERVIÇOS"
light 			= 1
id 				= makeNum(REQUEST("id"))
IF id 			> 0 THEN
SET rs 			= CONEXAO.EXECUTE("SELECT id,p_titulo,p_desc,p_title,p_description,p_keywords FROM tbl_paginas_ WHERE projHash='"&projHash&"' and id='"&id&"' and p_sit='1';") 
IF NOT rs.EOF THEN
p_titulo		= rs("p_titulo")
p_descricao		= rs("p_desc")
p_description	= rs("p_description")
p_keywords		= rs("p_keywords")


g_metaTitle		= rs("p_title")

IF g_metaTitle  = "" or isNull(g_metaTitle) THEN 
g_metaTitle 	= p_titulo
END IF

IF p_description<> "" then 
g_metaDesc		= p_description
end if

IF p_keywords 	<> "" then 
g_palavraChave	= p_keywords
end if

END IF
SET rs 			= NOTHING
ELSE
CONEXAO.CLOSE
SET CONEXAO = NOTHING
RESPONSE.REDIRECT("/home")
RESPONSE.END()
END IF
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<!--#include file="includes/head.asp"-->
</head>
<body>
<!--#include file="includes/navbar.asp"-->
<div class="boxGreenTitle">
<div class="container">
<div class="row">

<div class="col-lg-12">
<div class="titleServices"><%=Ucase(p_titulo)%></div>
</div>
</div>
</div>
</div>

<div class="pagInternas">
<div class="container">
<div class="row justify-content-center">
<div class="col-md-10 col-lg-6 order-2 order-lg-1 mt-4 mt-lg-0 small-demo">
<%
SET rsImg 		= CONEXAO.EXECUTE("SELECT arquivo FROM tbl_anexos_ WHERE codId='"&id&"' AND modulo='paginas' AND principal='1';")
IF NOT rsImg.EOF THEN
response.write("<a href='"&caminhoTemporario&"paginas/"&id&"/"&rsImg("arquivo")&"'><img src='"&caminhoTemporario&"paginas/"&id&"/"&rsImg("arquivo")&"' alt='img' loading='lazy' class='w-100'></a>")
END IF
SET rsImg 		= NOTHING
%>
</div>
<div class="col-md-10 col-lg-6 my-auto px-lg-4 px-xl-5 px-xxl-6 order-1 order-lg-2">
<div class="text-center">
<img src="/assets/fineLine.svg" alt="img2">
<h1 class="mt-3 mb-0 px-lg-3 title1"><%=p_titulo%></h1>
</div>
<div class="mt-lg-4 mt-3 px-lg-4">
<div class="lineText">
<p><%=p_descricao%></p>
</div>	
</div>
</div>
</div>
</div>
</div>

<div class="paddInternaBox">
<!--#include file="includes/boxHome.asp"-->
</div>
<!--#include file="includes/footer.asp"-->
<!--#include file="includes/scripts.asp"-->
</body>
</html>
<%	
CONEXAO.CLOSE
SET CONEXAO = NOTHING
%>