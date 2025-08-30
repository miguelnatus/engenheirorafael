function validate(input){
if(/^\s/.test(input.value))
input.value 		= '';
}

$("#email").on('change', function(){
emailVal        	= $("#email").val()    
var result 			= emailVal.match(/@/); 
var result2 		= emailVal.match(/.com/); 
if (result 			== null || result2 == null && emailVal != ""){
$("#email").val("");    
$("#email").attr("placeholder","E-mail inválido")
setTimeout(function(){
$("#email").attr("placeholder","digite seu e-mail")
},2000)          
}
});

$('.campoNome').on('input', function() {
if (/[0-9]/g.test(this.value)) {
$('.campoNome').val('');
}
});

$("#btnSends").on('click', function(){
nomeCompleto        = $("#nomeCompleto").val()
celular             = $("#celular").val()
email               = $("#email").val()
cidade              = $("#cidade").val()
mensagem            = $("#mensagem").val()
if(celular          == "" && email == "" ){
$("#btnSends").html("PREENCHA OS CAMPOS CORRETAMENTE").attr('disabled', true)
setTimeout(function(){
$("#btnSends").html("ENVIAR FORMULÁRIO").attr('disabled', false)
},2000)    
}else{
if(nomeCompleto     == "" || cidade == "" || mensagem == ""){
$("#btnSends").html("PREENCHA OS CAMPOS CORRETAMENTE").attr('disabled', true)
setTimeout(function(){
$("#btnSends").html("ENVIAR FORMULÁRIO").attr('disabled', false)
},2000)    
}else if($("#politica").is(":checked") == false){
$("#btnSends").html("PARA CONTINUAR, VOCÊ PRECISA ACEITAR A POLÍTICA DE PRIVACIDADE DESTE WEBSITE.").attr('disabled', true)
setTimeout(function(){
$("#btnSends").html("ENVIAR FORMULÁRIO").attr('disabled', false)
},2000)    
}else{
$("#btnSends").html("<div class='spinner-grow' role='status'></div><div class='spinner-grow' role='status'></div><div class='spinner-grow' role='status'></div>").attr('disabled', true)
$("#formContato").submit();
}
}
});

var behavior 		= function (val) {
return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
},
options 			= {
onKeyPress: function (val, e, field, options) {
field.mask(behavior.apply({}, arguments), options);
}
};
$(".campoCelular").mask(behavior, options);