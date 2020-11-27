<%-- 
    Document   : reserveer
    Created on : 28-sep-2020, 14:21:35
    Author     : r0638823
    Name        : Thijs Vercammen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reserveer</title>
    </head>
    <body>
        <%@include file="header.jspf" %>
        <h2>Welkom, uw klantnr is ${sessionScope.klantnr} </h2> 
        <h3>Maak uw reservatie</h3>
        <form method="post" action="<c:url value='ResController'/>">
            <label for="pickup">Pick_up Location :</label>
            <select name="Plocaties" size="1">
                <c:forEach var="loc" items="${applicationScope.locatieList}">
                    <option value="${loc.lnaam}">${loc.lnaam}</option>
                </c:forEach>
            </select>
            <br>
            <label for="types">Vehicle Type :</label>
            <select name="types" size="1">
                <c:forEach var="typ" items="${applicationScope.typeList}">
                    <option value="${typ.wnaam}">${typ.wnaam}</option>
                </c:forEach>
            </select>
            <br>
            <label for="Drop_of">Drop_of Location :</label>
            <select name="Dlocaties" size="1">
                <c:forEach var="loc" items="${applicationScope.locatieList}">
                    <option value="${loc.lnaam}">${loc.lnaam}</option>
                </c:forEach>
            </select>
            <br>
            <label for="Pdate">Pick up Date :</label>
            <input type="date" id="Pdate" name="Pdate" required>
            <br>
            <label for="Ddate">Drop off Date :</label>
            <input type="date" id="Ddate" name="Ddate" required>
            <br>
            <!--label for="days">Nr of days :</label>
            <input type=number id="aantdagen" name="aantdagen">
            <br-->
            <input type="Submit" name="submit" value="reserveer">           
        </form>
        <%@include file="footer.jspf" %>    
    </body>
</html>
