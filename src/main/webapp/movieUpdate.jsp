<%@ page import="java.util.UUID" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.MovieRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Movie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Movie</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background */
        }

        .container {
            margin-top: 50px;
        }

        .form-container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container label {
            font-weight: bold;
        }

        .form-container input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }

        .form-container input[type="text"]:focus {
            outline: none;
            border-color: #007bff;
        }

        .form-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    UUID movieId = UUID.fromString(request.getParameter("id"));
    MovieRepo movieRepo = new MovieRepo();
    Movie movie = movieRepo.findById(movieId);
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="movieCrud.jsp">Back</a>
    </div>
</nav>

<div class="container">
    <div class="form-container">
        <h2 class="text-center mt-5">Update Movie</h2>
        <form action="${pageContext.request.contextPath}/movieServlet?id=<%=movie.getId()%>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="function" value="update">
            <div class="form-group">
                <label for="name">Movie Name:</label>
                <input value="<%=movie.getName()%>" type="text" id="name" name="name" placeholder="Enter movie name"
                       required class="form-control">
            </div>
            <div class="form-group">
                <label for="name">Movie Photo:</label>
                <input type="file" id="photo" name="photo" required class="form-control">
                <%if (movie.getAttachment() == null) {%>
                <img width="60" src="photo.jpeg"
                     alt="">
                <%} else {%>
                <img width="60" src="${pageContext.request.contextPath}/file?id=<%=movie.getAttachment().getId()%>"
                     alt="">
                <%}%>
            </div>
            <div class="form-group">
                <input type="submit" value="Update Movie" class="btn btn-primary btn-block">
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
