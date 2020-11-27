<%-- 
    Document   : klant
    Created on : 5-okt-2020, 13:34:09
    Author     : r0638823
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <%@include file="header.jspf" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registreer</title>
    </head>
    <body>
        <h2>U bent nog geen klant, gelieve u hieronder te registreren.</h2>
        <form method="post" action="<c:url value='ResController'/>">
            <label for="klantnaam">Naam :</label>
            <input type="text" id="klantnaam" name="klantnaam">
            <br>
            <label for="klantadres">Adres :</label>
            <input type="text" id="klantadres" name="klantadres">
            <br>
            <label for="postcode">Postcode :</label>
            <input type="text" id="postcode" name="postcode">
            <br>
            <label for="gemeente">Gemeente :</label>
            <input type="text" id="gemeente" name="gemeente">
            <br>
            <input type="submit" name="submit" value="registreer">
        </form>
        <%@include file="footer.jspf" %>    
    </body>
</html>
