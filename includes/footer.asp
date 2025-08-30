<div class="alturaFoot">
<footer class="bg-green">
<div class="container">
<div class="row">
<div class="col-12 text-center py-foot position-relative">
<div class="effect-logo"><div><img src="/assets/logo3.svg" alt="logo"></div></div>
<div style="position: relative;z-index: 2;">
<div><a href="<%=telefone%>" class="linkfooter1 fsLook ms-0 ligar"><%=u_tel1%></a></div>
<div class="mt-2"><a href="mailto:<%=u_email%>" class="linkfooter1 fsLook text-lowercase ms-0"><%=u_email%></a></div>
<div class="d-flex align-items-center justify-content-center d-lg-none mt-3">
<div class="align-items-center d-flex">
<div class="oval-verde footer"><a href="<%=instagram%>" rel="noreferrer" target='_blank'><img src="/assets/icons/insta2.svg" width="33" height="33" alt='img'></a></div>
</div>
</div>

</div>
</div>
</div>
</div>
</footer>
<div class="bg-yellow py-f">
<div class="container">	
<div class="row">
<div class="col-lg-12 text-center">
<div class="d-flex align-items-center flex-lg-row flex-column justify-content-lg-center">
<%
SET rs = CONEXAO.EXECUTE("SELECT m_link,m_titulo FROM tbl_menus_ WHERE projHash='"&projHash&"' AND m_sit='1' ORDER BY m_ordem ASC;")
IF NOT rs.EOF THEN
DO WHILE not rs.EOF
IF rs("m_titulo")   <> "HOME" THEN
espFoot1 			= "espFoot1"
ELSE
espFoot1 			= ""
END IF
response.write("<div class='"&espFoot1&"'><a href='/"&rs("m_link")&"' class='linkfooter2 ms-3'>"&rs("m_titulo")&"</a></div>")
response.write("</li>")
rs.MOVENEXT
LOOP
END IF
SET rs = NOTHING
%>
</div>
</div>	
</div>
</div>
</div>
</div>
<%IF g_btnWhats <> 2 THEN%>
<div class="posiBtnmobile">
<div class="position-relative">
<a class="btn btn-whats btnWhats" href='<%=whatsapp%>' rel="noreferrer" target='_blank'><%=g_titleBtn%></a>
<div class="imgButton"><a href="<%=whatsapp%>" class="btnWhats" rel="noreferrer" target='_blank'><img src="/assets/icons/whats.svg" height="45" alt='img'></a></div>
</div>
</div>
<%END IF%>