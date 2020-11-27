<%-- 
    Document   : index
    Created on : 28-sep-2020, 13:54:03
    Author     : r0638823
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <%@include file="header.jspf" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index</title>
    </head>
    <body>
        <h2>Geef uw klantennummer</h2>
        <form method="post" action="<c:url value='ResController'/>">
             <label for="klantnr">Klantnr :</label>
            <input type="text" id="klantnr" name="klantnr" required>
            <input type="submit" name="submit" value="volgend">
        </form>
        <form method="post" action="<c:url value='ResController'/>">
            <input type="submit" name="submit" value="nieuwe klant"> 
        </form>
    <%@include file="footer.jspf" %>    
    </body>
</html>
