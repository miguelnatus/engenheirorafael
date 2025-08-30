<div id="slide" class="carousel slide" data-bs-ride="carousel">
<div class="carousel-inner">
<%
contadorBanner 		= 0
SET rsBan 			= CONEXAO.EXECUTE("SELECT id, b_titulo,b_subtitulo FROM tbl_banners_ WHERE id>0 and projHash='"&projHash&"' AND b_tipo='"&typeScreen&"' AND b_sit=1 ORDER BY id DESC")
IF NOT rsBan.EOF THEN
DO WHILE not rsBan.EOF
IF contadorBanner   = 0 THEN
activeSlide 	 	= "active"
ELSE
activeSlide 	 	= ""
END IF	
fotoBanner 			= getImgWhere(rsBan("id"),"1","banners")
%>
<div class="carousel-item <%=activeSlide%>">
<img src="<%=caminhoTemporario&"banners/"&rsBan("id")&"/"&fotoBanner%>" class="d-block w-100" alt="banner">
</div>
<%
contadorBanner 		= contadorBanner + 1
rsBan.MOVENEXT
LOOP
END IF
SET rsBan 				= NOTHING
%>
</div>
<%IF contadorBanner > 1 THEN%>
<button class="carousel-control-prev" type="button" data-bs-target="#slide" data-bs-slide="prev">
<span class="carousel-control-prev-icon" aria-hidden="true"></span>
<span class="visually-hidden">Previous</span>
</button>
<button class="carousel-control-next" type="button" data-bs-target="#slide" data-bs-slide="next">
<span class="carousel-control-next-icon" aria-hidden="true"></span>
<span class="visually-hidden">Next</span>
</button>
<%END IF%>
</div>