<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" lcid="1046"%>
<!--#include file="includes/global.asp"-->
<%
pag 		= "HOME"
light 		= "1"
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
<!--#include file="includes/head.asp"-->
</head>

<body>
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-53RGG7HP"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->


<!--#include file="includes/navbar.asp"-->
<!--#include file="includes/banner.asp"-->


<%
SET rs 			= CONEXAO.EXECUTE("SELECT id,p_titulo,p_desc FROM tbl_paginas_ WHERE projHash='"&projHash&"' and id='26' and p_sit='1';") 
IF NOT rs.EOF THEN
%>
<div class="box1">
<div class="container">
<div class="row justify-content-center">
<div class="col-md-10 col-lg-6 my-lg-auto order-2 order-lg-1 mt-4">
<%
SET rsImg 		= CONEXAO.EXECUTE("SELECT arquivo FROM tbl_anexos_ WHERE codId='"&rs("id")&"' AND modulo='paginas' AND principal='1';")
IF NOT rsImg.EOF THEN
response.write("<a href='/atuacao/"&rs("id")&"/"&MontaURL(rs("p_titulo"))&"'><img src='"&caminhoTemporario&"paginas/"&rs("id")&"/"&rsImg("arquivo")&"' alt='img' loading='lazy' class='w-100'></a>")
END IF
SET rsImg 		= NOTHING
%>
</div>
<div class="col-md-10 col-lg-6 my-auto px-xxl-6 px-xxl-5 order-1 order-lg-2">
<div class="text-center">
<img src="/assets/fineLine.svg" alt="img2">
<h1 class="mt-3 mb-0 px-lg-3 title1"><%=rs("p_titulo")%></h1>
</div>
<div class="mt-lg-4 mt-3 px-lg-4">
<div class="lineText text-center text-md-start">
<%=rs("p_desc")%>
</div>	
</div>
</div>
</div>
</div>
</div>
<div class="container d-md-none">
<hr class="mt-0" style="margin-bottom: 2rem;">
</div>
<%
END IF
SET rs 			= NOTHING
%>






<div class="box2">
<div class="container">
<div class="row mb3r">
<div class="col-lg-12 text-center">
<h2 class="h2title">ÁREAS DE ATUAÇÃO</h2>
</div>
</div>


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

<!--#include file="includes/boxHome.asp"-->



<%
SET rs 			= CONEXAO.EXECUTE("SELECT id,p_titulo,p_desc FROM tbl_paginas_ WHERE projHash='"&projHash&"' and id='27' and p_sit='1';") 
IF NOT rs.EOF THEN
%>
<div class="box4">
<div class="container">
<div class="row">
<div class="col-lg-5 pe-xl-5 my-lg-auto">
<div class="titleFooter"><%=rs("p_titulo")%></div>
<div class="descFooter mt-3 text-center text-md-start"><%=rs("p_desc")%></div>
</div>
<div class="col-lg-7 mt-4 mt-lg-0">
<div class="row g-3">
<!-- / -->
<div class="col-6">
<div class="row gy-3">
<%
SET rsImg 		= CONEXAO.EXECUTE("SELECT * FROM tbl_anexos_ WHERE codId='"&rs("id")&"' AND modulo='paginas' ORDER BY ordem ASC limit 2;")
IF NOT rsImg.EOF THEN
DO WHILE not rsImg.EOF
imagem 			= caminhoTemporario&"paginas/"&rs("id")&"/"&rsImg("arquivo")
%>
<div class="col-12 small-demo">
<a href="<%=imagem%>"><img src="<%=imagem%>" class="w-100 br4" alt='img'></a>
</div>
<%
rsImg.MOVENEXT
LOOP
END IF
SET rsImg 		= NOTHING
%>
</div>
</div>
<!-- / -->
<div class="col-6">
<div class="row gy-3">
<%
SET rsImg 		= CONEXAO.EXECUTE("SELECT * FROM tbl_anexos_ WHERE codId='"&rs("id")&"' AND modulo='paginas' ORDER BY ordem ASC limit 2,4;")
IF NOT rsImg.EOF THEN
DO WHILE not rsImg.EOF
imagem 			= caminhoTemporario&"paginas/"&rs("id")&"/"&rsImg("arquivo")
%>
<div class="col-12 small-demo">
<a href="<%=imagem%>"><img src="<%=imagem%>" class="w-100 br4" alt='img'></a>
</div>
<%
rsImg.MOVENEXT
LOOP
END IF
SET rsImg 		= NOTHING
%>
</div>
</div>
<!-- / -->
</div>
</div>
</div>
</div>
</div>
<%
END IF
SET rs 			= NOTHING
%>

<!--#include file="includes/footer.asp"-->
<!--#include file="includes/scripts.asp"-->
</body>
</html>
<%
CONEXAO.CLOSE
SET CONEXAO = NOTHING
%>