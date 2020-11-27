<%-- 
    Document   : gebruiker_overview
    Created on : 3-nov-2020, 16:29:01
    Author     : Thijs Vercammen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <c:url var="nieuw_contact" value="Controller" scope="session">
            <c:param name="submit" value="nieuw_contact"/>
        </c:url>
        <c:url var="test_aanvragen" value="/Controller" scope="session">
            <c:param name="submit" value="test_aanvragen"/>
        </c:url>
        <title>Overview</title>
    </head>
    <body>
        <h1>Burger Overview</h1>
        <h1>Goedendag ${remoteUser}</h1>
        <h2>Menu: </h2>
        <form action="/Contact-Tracing-war/Controller" method="POST">
            <input type="submit" name="submit" value="nieuw contact">
            <br>
            <input type="submit" name="submit" value="niewe test">
            <br>
            <input type="submit" name="submit" value="Huidig risico">
        </form>
        <h2>Besmettings risico</h2>
        <!--p>uw huidig besmettingsrisico is: ${sessionScope.burger.risicostatus.naam}</p-->
    </body>
</html>
