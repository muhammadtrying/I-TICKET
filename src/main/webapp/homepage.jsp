<%@ page import="uz.muhammadtrying.iticketproject.repo.MovieRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Movie" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: muhammad
  Date: 24/04/24
  Time: 3:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie Ticket Platform</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 50px;
        }

        .logout-btn {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .advertising {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<%
    MovieRepo movieRepo = new MovieRepo();
    List<Movie> movies = movieRepo.findAll();
    User currentUser = (User) session.getAttribute("currentUser");
%>
<div class="container">
    <%if (currentUser.getUsername().equals("Eshmat13")) {%>
    <a href="admin.jsp" class="btn btn-primary btn-lg">Admin</a>
    <% }
    %>
    <a href="${pageContext.request.contextPath}/log-out" class="btn btn-primary logout-btn">Log Out</a>
    <h2 class="text-center mb-4">Movie Ticket Platform</h2>
    <div class="row">
        <%for (Movie movie : movies) {%>
        <div class="col-md-4">
            <div class="advertising">
                <h3 class="text-center"><%=movie.getName()%>
                </h3>
                <%if (movie.getAttachment() == null) {%>
                <p><img width="220" src="photo.jpeg"
                        alt="photo.jpeg"></p>
                <% } else { %>
                <p><img width="220" src="${pageContext.request.contextPath}/file?id=<%=movie.getAttachment().getId()%>"
                        alt="photo.jpeg"></p>
                <% } %>
                <a href="session.jsp?chosenMovie=<%=movie.getId()%>" class="btn btn-primary btn-block">Buy Ticket</a>
            </div>
        </div>
        <%}%>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
