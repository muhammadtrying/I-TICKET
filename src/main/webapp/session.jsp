<%@ page import="uz.muhammadtrying.iticketproject.repo.SessionRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Session" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.User" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Available Sessions</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        body {
            padding-top: 20px;
            background-color: #f8f9fa; /* Light gray background */
        }

        .session-item {
            background-color: #fff; /* White background for session items */
            border: 1px solid #dee2e6; /* Light gray border */
            border-radius: 5px;
            margin-bottom: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Shadow effect */
            transition: transform 0.3s ease; /* Smooth transition on hover */
        }

        .session-item:hover {
            transform: translateY(-5px); /* Move session item up on hover */
        }

        .session-details {
            padding: 10px;
        }

        .session-title {
            margin-bottom: 5px;
            font-size: 18px;
            font-weight: bold;
        }

        .session-info {
            font-size: 14px;
            color: #6c757d; /* Gray text color */
        }
    </style>
</head>
<body>
<%
    SessionRepo sessionRepo = new SessionRepo();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d hh:mm a");
    UUID chosenMovieId = UUID.fromString(request.getParameter("chosenMovie"));
    List<Session> sessions = sessionRepo.findAll().stream().filter(session1 -> session1.getMovie().getId().equals(chosenMovieId)).toList();
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/homepage.jsp">Home</a>
    </div>
</nav>

<div class="container mt-4">
    <h2 class="text-center mb-4">Sessions</h2>
    <%for (Session sessionItem : sessions) {%>
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="session-item">
                <div class="session-details">
                    <div class="session-title">
                        <a href="hallView.jsp?chosenMovieId=<%=chosenMovieId%>&id=<%=sessionItem.getId()%>"><%=sessionItem.getMovie().getName()%> - at <%=sessionItem.getHall().getName()%></a>
                    </div>
                    <div class="session-info">
                        <%=sessionItem.getTime().format(formatter)%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%}%>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
