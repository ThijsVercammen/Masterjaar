<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reserveer.aspx.cs" Inherits="CarResN.Views.Home.Reserveer" %>
<asp:Content ContentPlaceHolderID="Inhoud" ID="MainContentContent" runat="server">
<!DOCTYPE html>
<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
        <h1>RESERVEREN</h1>
        <%= Session["klantnr"].ToString() %>
</body>
</html>
