<%
servidor     = "localhost"
bancodedados = "engenheirorafael"
usuario      = "root"
senha        = "Ozoutros@123"
dominio      = Request.ServerVariables("server_name")

' cria o objeto de conexão global
Dim conn, connStr
Set conn = Server.CreateObject("ADODB.Connection")

connStr = "Driver={MySQL ODBC 8.0 Driver};" & _
          "Server="   & servidor     & ";" & _
          "Database=" & bancodedados & ";" & _
          "User="     & usuario      & ";" & _
          "Password=" & senha        & ";" & _
          "Option=3;"

conn.Open connStr
%>