<%-- 
    Document   : test_aanvragen
    Created on : 3-nov-2020, 16:46:26
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
        <h1>Test Status</h1>
        <h2>Huidige Status van de test: ${testStatus}</h2>
        
        <c:choose>
            <c:when test="${testStatus == 'In uitvoering'}">
                <p>Test ID: ${sessionScope.test.testnr}</p>
            </c:when>
            <c:otherwise>
                <form action="/Contact-Tracing-war/Controller" method="POST">
                    <input type="submit" name="submit" value="Test Aanvragen">
                </form>
            </c:otherwise>
        </c:choose>
    </body>
</html>
