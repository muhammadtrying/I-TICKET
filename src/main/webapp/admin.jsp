<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa; /* Light gray background */
        }

        .container {
            padding-top: 50px;
        }

        .btn-container {
            margin-bottom: 20px;
        }

        .navbar-brand:hover {
            color: #007bff; /* Change color on hover */
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top mb-2">
    <div class="container">
        <a class="btn-lg btn-dark offset-5 mb-2 " href="${pageContext.request.contextPath}/homepage.jsp">HOMEPAGE</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="btn-container">
        <a href="hallCrud.jsp" class="btn btn-primary btn-lg btn-block mt-4">HALL CRUD</a>
    </div>
    <div class="btn-container">
        <a href="movieCrud.jsp" class="btn btn-primary btn-lg btn-block">Movie CRUD</a>
    </div>
    <div class="btn-container">
        <a href="sessionCrud.jsp" class="btn btn-primary btn-lg btn-block">Session CRUD</a>
    </div>
    <div class="btn-container">
        <a href="report.jsp" class="btn btn-primary btn-lg btn-block">Report</a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
