<%@ page import="java.util.List" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.SessionRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Session" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Session Delete</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        body {
            padding-top: 50px;
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 20px;
        }

        .btn-container {
            margin-bottom: 20px;
        }

        .navbar-brand:hover {
            color: #007bff; /* Change color on hover */
        }

        /* Center content */
        .table-container {
            margin: 20px;
        }
    </style>
</head>
<body>
<%
    SessionRepo sessionRepo = new SessionRepo();
    List<Session> sessions = sessionRepo.findAll();
    int i = 1;
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d hh:mm a");
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="sessionCrud.jsp">Back</a>
    </div>
</nav>

<div class="table-container">
    <div class="container">
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Movie</th>
                <th scope="col">Date</th>
                <th scope="col">Hall</th>
                <th scope="col">§</th>
            </tr>
            </thead>
            <tbody>
            <% for (Session sessionItem : sessions) { %>
            <tr>
                <th scope="row"><%= i++ %>
                </th>
                <td><%=sessionItem.getMovie().getName()%>
                </td>
                <td><%=sessionItem.getTime().format(formatter)%>
                </td>
                <td><%=sessionItem.getHall().getName()%>
                </td>
                <td><a href="${pageContext.request.contextPath}/session-servlet?id=<%=sessionItem.getId()%>">Delete❌</a></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
