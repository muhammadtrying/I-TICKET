<%@ page import="uz.muhammadtrying.iticketproject.repo.HallRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Hall" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.MovieRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Movie" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie CRUD</title>
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
    MovieRepo movieRepo = new MovieRepo();
    List<Movie> movies = movieRepo.findAll();
    int i = 1;
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">Movie CRUD</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="admin.jsp">Admin Page</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="movieCreate.jsp">Create</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="movieDelete.jsp">Delete</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="table-container">
    <div class="container">
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Name</th>
                <th scope="col">§</th>
            </tr>
            </thead>
            <tbody>
            <% for (Movie movie : movies) { %>
            <tr>
                <th scope="row"><%= i++ %>
                </th>
                <%if (movie.getAttachment() == null) {%>
                <td><img width="60" src="photo.jpeg"
                         alt="photo"></td>
                <% } else {%>
                <td><img width="60" src="${pageContext.request.contextPath}/file?id=<%=movie.getAttachment().getId()%>"
                         alt="photo.jpeg"></td>
                <% }
                %>
                <td><%= movie.getName() %>
                </td>
                <td><a href="movieUpdate.jsp?id=<%=movie.getId()%>">Update🔄</a></td>
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
