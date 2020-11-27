<%-- 
    Document   : login
    Created on : 17-nov-2020, 13:17:54
    Author     : Thijs Vercammen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Login</h1>
        <form method=post action="j_security_check">
            <table>
                <tr> <td> Naam: </td> <td> <input type="text" name="j_username" /></td></tr>
                <tr> <td> Paswoord:</td><td><input type="password" name="j_password" /></td></tr>
            </table>
            <input type="submit" />
        </form>
    </body>
</html>
