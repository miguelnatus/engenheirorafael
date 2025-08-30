<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" lcid="1046"%>
<!--#include file="includes/global.asp"-->
<%
pag  		 =	"SERVIÇOS"
g_metaTitle  =	"Serviços"
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
<div class="titleServices">SERVIÇOS</div>
</div>

</div>
</div>
</div>

<div class="pagInternas">
<div class="container">




<div class="row justify-content-center row-cols-1 row-cols-md-2 row-cols-lg-3 gy-lg-5x">
<%
SET rs 			= CONEXAO.EXECUTE("SELECT id,p_titulo,p_descricao FROM tbl_paginas_ WHERE p_menuId='14' ORDER BY p_ordem ASC;")
IF NOT rs.EOF THEN
DO WHILE not rs.EOF
%>
<div class="col text-center text-md-start">
<%
SET rsImg 		= CONEXAO.EXECUTE("SELECT arquivo FROM tbl_anexos_ WHERE codId='"&rs("id")&"' AND modulo='paginas' AND principal='1';")
IF NOT rsImg.EOF THEN
response.write("<a href='/atuacao/"&rs("id")&"/"&MontaURL(rs("p_titulo"))&"'><img src='"&caminhoTemporario&"paginas/"&rs("id")&"/"&rsImg("arquivo")&"' alt='img' loading='lazy' class='br4 w-100'></a>")
END IF
SET rsImg 		= NOTHING
%>
<h3 class="mt-3 mb-0 h3title"><%=rs("p_titulo")%></h3>
<div class="mt-2 desctitle"><p><%=rs("p_descricao")%></p></div>
<div><a href="/atuacao/<%=rs("id")%>/<%=MontaURL(rs("p_titulo"))%>" class="btn btn-more">VER MAIS</a></div>
</div>
<%
rs.MOVENEXT
LOOP
END IF
SET rs = NOTHING
%>
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