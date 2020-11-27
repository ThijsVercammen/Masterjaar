<%-- 
    Document   : overzicht
    Created on : 5-okt-2020, 13:59:38
    Author     : r0638823
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <%@include file="header.jspf" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>bedankt voor de reservatie ${sessionScope.klantnr}</h2>
        <h3>reservaties:</h3>
        <ul>
        <c:forEach var="res" items="${sessionScope.reservaties}">
            <li>klantNr: ${res.knr.knr}</li>
            <li>Model: ${res.wnr.wnaam}</li>
            <li>Pick-up: ${res.lnrvan.lnaam}</li>
            <li>Pick-up datum: ${res.datumvan}</li>
            <li>Drop-off: ${res.lnrnaar.lnaam}</li>
            <li>Drop-of datum: ${res.datumres}</li>
            <li>Basisprijs: €${res.wnr.prijs}</li>
            <li>Met BTW: €${res.wnr.prijs+(initParam.btw*res.wnr.prijs/100)}</li>
            <li>Met korting: €${res.wnr.prijs-(initParam.korting*res.wnr.prijs/100)+(initParam.btw*res.wnr.prijs/100)}</li>
            <li>
                <form method="post" action="<c:url value='ResController'/>">
                    <input hidden="" id="res_nr" name="res_nr" value="${res.mr}">
                    <input type="Submit" name="submit" value="delete" >
                </form>
            </li>
            <br>
        </c:forEach>
            <!--li>aantal bestellingen: ${sessionScope.aantal}</li>
            <li>Totale basisprijs: ${sessionScope.totaal}</li>
            <li>Totale prijs met BTW: ${sessionScope.totaal+(initParam.btw*res.prijs/100)}</li-->
        </ul>
        
        <form method="post" action="<c:url value='ResController'/>">
            <input type="Submit" name="submit" value="volgende reservatie" >
        </form>
<%@include file="footer.jspf" %>    
    </body>
</html>
