<%@ page import="java.util.UUID" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Session" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.SessionRepo" %><%--
   Created by IntelliJ IDEA.
   User: muhammad
   Date: 24/04/24
   Time: 8:44 PM
   To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Purchase Result</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
</head>
<body>
<%
    String purchaseResult = (String) request.getAttribute("purchase");
    UUID sessionId = (UUID) request.getAttribute("chosenSessionId");
    SessionRepo sessionRepo = new SessionRepo();
    Session chosenSession = sessionRepo.findById(sessionId);
    UUID chosenMovieId = chosenSession.getMovie().getId();
%>
<div class="container mt-3">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="alert alert-<%= purchaseResult.equals("success") ? "success" : "danger" %>" role="alert">
                <%= purchaseResult.equals("success") ? "Purchase successful!" : "Purchase failed!" %>
            </div>
            <a href="${pageContext.request.contextPath}/hallView.jsp?chosenMovieId=<%=chosenMovieId%>&id=<%=request.getSession().getAttribute("chosenSessionId")%>"
               class="btn btn-secondary">Back</a>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
