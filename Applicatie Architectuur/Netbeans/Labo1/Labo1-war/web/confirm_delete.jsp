<%-- 
    Document   : confirm_delete
    Created on : 16-nov-2020, 13:57:51
    Author     : Thijs Vercammen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Reservation removed</h1>
        <form method="post" action="ResController">
            <input type="submit" name="submit" value="ok">
        </form>
    </body>
</html>
