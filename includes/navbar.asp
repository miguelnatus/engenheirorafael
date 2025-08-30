<div class="lineNav"></div>
<nav class="navbar navbar-expand-lg navbar-light bg-marrom">
<div class="container">
<div class="position-relative"><a class="navbar-brand" href="/home"><img src="/assets/logo.svg" width="279" height="55" alt="logo" class="h40"></a> <div class="logo2"><img src="/assets/logo2.svg" height="39" width="37" alt='img'></div> </div>
<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="menu">
<span class="navbar-toggler-icon"></span>
</button>
<div class="collapse navbar-collapse" id="menu">
<ul class="navbar-nav ms-lg-auto mt-2 mb-1 my-lg-0">
<%
SET rs = CONEXAO.EXECUTE("SELECT m_link,m_titulo FROM tbl_menus_ WHERE projHash='"&projHash&"' AND m_sit='1' ORDER BY m_ordem ASC;")
IF NOT rs.EOF THEN
DO WHILE not rs.EOF

IF rs("m_titulo") = pag THEN
active 		= "active"
ELSE
active 		= ""
END IF

response.write("<li class='nav-item'>")
response.write("<a class='nav-link "&active&"' href='/"&rs("m_link")&"'>"&rs("m_titulo")&"</a>")
response.write("</li>")
rs.MOVENEXT
LOOP
END IF
SET rs = NOTHING
%>	
<li class="nav-item d-flex align-items-center ms-lg-2">
<a class="btn-color btn ligar" href="<%=telefone%>"><%=u_tel1%></a>
</li>
<li class="nav-item align-items-center ms-3 d-none d-lg-flex">
<div class="oval-verde"><a href="<%=instagram%>" rel="noreferrer" target='_blank'><img src="/assets/icons/insta.svg" height="33" width="33" alt='img'></a></div>
</li>
</ul>
</div>
</div>
</nav>