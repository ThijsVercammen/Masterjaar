<%-- 
    Document   : nieuw_contact
    Created on : 3-nov-2020, 16:46:11
    Author     : Thijs Vercammen
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Nieuw contact</h1>
            <table>
                <tr>
                    <th>Naam</th>
                    <th>Soort Contact</th>
                    <th></th>
                </tr>
                <c:forEach var="burgers" items="${sessionScope.burgers}">
                    <form method="POST" action="/Contact-Tracing-war/Controller">
                        <input name="contact" value="${burgers.naam}" type="hidden">
                    <tr>
                        <td>${burgers.naam}</td>
                        <td>
                            <select name="soort_contact">
                                <option value="Nauw contact">Nauw Contact</option>
                                <option value="Gewoon contact">gewoon Contact</option>
                                <option value="Veilig contact">veilig Contact</option>
                            </select>
                        </td>
                        <td><input type="submit" name="submit" value="Voeg contact toe"></td>
                    </tr>
                    </form>
                </c:forEach>
            </table>
    </body>
</html>
