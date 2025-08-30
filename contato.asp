<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" lcid="1046"%>
<!--#include file="includes/global.asp"-->
<%
pag  =	"CONTATO"
g_metaTitle  =	"Contato"
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
<div class="titleServices">CONTATO</div>
</div>

</div>
</div>
</div>

<div class="pagInternas">
<div class="container">

<div class="row justify-content-center">

<div class="col-lg-7">

<form class="row" action="/send" method="post" id="formContato">

<div class="col-md-6 pe-lg-0">
<div class="form-floating mb-3">
<input type="text" class="form-control formCont campoNome" id="nomeCompleto" name="nomeCompleto" autocomplete="off" placeholder="nomeCompleto" oninput="validate(this)" required="">
<label for="nomeCompleto">Nome Completo</label>
</div>
</div>

<div class="col-md-6">
<div class="form-floating mb-3">
<input type="tel" class="form-control formCont campoCelular validaCelularContato" id="celular" name="celular" autocomplete="off" placeholder="celular" required="" maxlength="15">
<label for="celular">Celular</label>
</div>
</div>

<div class="col-md-6 pe-lg-0">
<div class="form-floating mb-3">
<input type="email" class="form-control formCont" id="email" name="email" autocomplete="off" placeholder="email" required="">
<label for="email">E-mail</label>
</div>
</div>

<div class="col-md-6">
<div class="form-floating mb-3">
<input type="text" class="form-control formCont" id="cidade" name="cidade" autocomplete="off" placeholder="cidade" oninput="validate(this)" required="">
<label for="cidade">Cidade</label>
</div>
</div>

<div class="col-12">
<div class="form-floating mb-3">
<textarea class="form-control formCont" id="mensagem" name="mensagem" placeholder="mensagem" style="height: 150px;" oninput="validate(this)" required=""></textarea>
<label for="mensagem">Mensagem</label>
</div>
</div>

<div class="col-12 mb-2">
<div class="form-check">
<input type="checkbox" class="form-check-input" id="politica" required="">
<label class="form-check-label" for="politica"><a role='button'  data-bs-toggle="modal" data-bs-target="#modalPoli"><u class='modalPolitica'>Li e concordo com a Política de Privacidade</u></a></label>
</div>
</div>

<div class="form-row">
<div class="col-12">
<button type="button" class="btn btn-dark" style="padding: .375rem .75rem;width: 100%;" id="btnSends">ENVIAR FORMULÁRIO</button>
</div>
</div>

</form>
</div>

</div>

</div>
</div>

<div class="paddInternaBox">
<!--#include file="includes/boxHome.asp"-->
</div>
<!--#include file="includes/footer.asp"-->



<!-- Modal -->
<div class="modal fade" id="modalPoli" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<div class="modal-title font-fut text-uppercase" id="exampleModalLabel">POLÍTICA DE PRIVACIDADE</div>
<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body font-book">
<%=g_politica%>
</div>
<div class="modal-footer">
<button type="button" class="btn-color btn" data-bs-dismiss="modal">Aceito</button>

</div>
</div>
</div>
</div>

<!--#include file="includes/scripts.asp"-->


</body>




</html>
<%
CONEXAO.CLOSE
SET CONEXAO = NOTHING
%>