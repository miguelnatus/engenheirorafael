<script src="/dist/js/bootstrap.min.js"></script>
<script src="/dist/js/jquery-3.5.1.js"></script>
<script src="/dist/js/js.cookie.min.js"></script>
<script src="/dist/js/jquery.mask.min.js"></script>
<script src="/dist/js/scripts.js"></script>
<%if light = 1 then%><script src="/dist/js/simple-lightbox.min.js"></script><script>$(function(){$('.small-demo a').simpleLightbox();})</script><%end if%>



<script>
$('.btnWhats').click(function() {
    gtag('event', 'conversion', {
        'send_to': 'AW-11435831814/tzK4CPLC54YZEIbkg80q'
    });
});

</script>
<script>
// R - OCULTA O ITEM AO CHEGAR NO DESTINO
jQuery(document).scroll(function() {
var alturaTotal = jQuery(document).height() - $(".alturaFoot").height()
var scroll = jQuery(window).scrollTop() + jQuery(window).height();
if(scroll >= alturaTotal) {
$('.posiBtnmobile').fadeOut();
} else {
$('.posiBtnmobile').fadeIn();
}
});
</script>