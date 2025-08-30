<%
' IF tagManager 			<> "" THEN
' response.write("<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);})(window,document,'script','dataLayer','GTM-"&tagManager&"');</script>")
' END IF
IF tagGlobal 			<> "" THEN
response.write("<script async src='https://www.googletagmanager.com/gtag/js?id=AW-"&tagGlobal&"'></script>")
response.write("<script>function gtag(){dataLayer.push(arguments)}window.dataLayer=window.dataLayer||[],gtag('js',new Date),gtag('config','AW-"&tagGlobal&"');</script>")
END IF
IF tagAnalytics 		<> "" THEN
response.write("<script async src='https://www.googletagmanager.com/gtag/js?id=UA-"&tagAnalytics&"'></script>")
response.write("<script>window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments);}gtag('js', new Date());gtag('config', 'UA-"&tagAnalytics&"');</script>")
END IF
IF tagFVerification 		<> "" THEN
response.write("<meta name='facebook-domain-verification' content='"&tagFVerification&"' />")
END IF
IF tagPVerification 		<> "" THEN
response.write("<meta name='p:domain_verify' content='"&tagPVerification&"' />")
END IF
%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="/assets/favicon.png" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/dist/css/style.css">
<%if light = 1 then%><link rel="stylesheet" type="text/css" href="/dist/css/simplelightbox.min.css"><%end if%>
<meta property="og:title"        content="<%=g_metaTitle%>"/>
<meta property="og:description"	 content="<%=g_metaDesc%>"/>
<meta name="description" 		 content="<%=g_metaDesc%>"/>
<meta name="keywords" 			 content="<%=g_palavraChave%>"/>
<title><%=g_metaTitle%></title>
<%=favicon%>

<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-M28WRNLR');</script>
<!-- End Google Tag Manager -->



<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M28WRNLR"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->