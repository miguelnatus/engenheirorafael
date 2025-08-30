<%
SET rs = CONEXAO.EXECUTE("SELECT id FROM tbl_paginas_ WHERE id = '28' and projhash='"&projHash&"' and p_sit='1';")
IF NOT rs.EOF THEN
id 	= rs("id")
imgUrl 	= getImgWhere(id,"1","paginas")
END IF
SET rs = NOTHING
%>
<div class="box3" style='background-image: url(<%=caminhoTemporario%>paginas/<%=id%>/<%=imgUrl%>);'>
<div class="container">
<div class="row justify-content-center">
<div class="col-lg-4 text-center">
<%if pag = "HOME" then%><img src="/assets/logo3.svg" alt='img' height="140"><%end if%>
<div class="fontbg <%if pag = "HOME" then%>mt-4<%end if%>"><%=REPLACE(g_fraseChamada,"**","<br>")%></div>
<div class="mt-4"><a class="btn btn-whats btnWhats" rel="noreferrer" target='_blank' href="<%=whatsapp%>">CHAME NO WHATSAPP</a></div>
</div>
</div>
</div>
</div>