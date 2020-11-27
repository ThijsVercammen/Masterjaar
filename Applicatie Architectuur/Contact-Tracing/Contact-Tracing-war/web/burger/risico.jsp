<%-- 
    Document   : risico
    Created on : 18-nov-2020, 15:15:08
    Author     : Thijs Vercammen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Risico Pagina</h1>
        <h2>Huidig Risico: ${sessionScope.risico}</h2>
        <table>
                <tr>
                    <th>Naam</th>
                    <th>Soort Contact</th>
                </tr>
                <c:forEach var="c" items="${sessionScope.con}">
                    <tr>
                        <td>${c.contact.naam}</td>
                        <td>${c.soortContact}</td>
                    </tr>
                </c:forEach>
            </table>
    </body>
</html>
