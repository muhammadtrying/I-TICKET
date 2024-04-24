<%@ page import="uz.muhammadtrying.iticketproject.repo.MovieRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Movie" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.HallRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Hall" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.Month" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.UUID" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.SessionRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Session" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Session</title>
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

        .form-container input[type="text"],
        .form-container select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }

        .form-container input[type="text"]:focus,
        .form-container select:focus {
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
    UUID sessionId = UUID.fromString(request.getParameter("id"));
    MovieRepo movieRepo = new MovieRepo();
    List<Movie> movies = movieRepo.findAll();
    HallRepo hallRepo = new HallRepo();
    List<Hall> halls = hallRepo.findAll();
    LocalDateTime startDateTime = LocalDateTime.of(2024, Month.MAY, 1, 0, 0);
    List<LocalDateTime> dateTimeList = new ArrayList<>();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d hh:mm a");
    SessionRepo sessionRepo = new SessionRepo();
    Session chosenSession = sessionRepo.findById(sessionId);
    for (int i = 0; i < 8; i++) {
        dateTimeList.add(startDateTime.plusHours(i * 3));
    }
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container">
        <a class="navbar-brand" href="sessionCrud.jsp">Back</a>
    </div>
    </div>
</nav>

<div class="container">
    <div class="form-container">
        <h2 class="text-center mb-4">Update Session</h2>
        <form action="${pageContext.request.contextPath}/session-servlet?id=<%=chosenSession.getId()%>" method="post">
            <input type="hidden" name="function" value="update">
            <div class="form-group">
                <label for="movie">Movie:</label>
                <select id="movie" name="movie" class="form-control" required>
                    <%for (Movie movie : movies) {%>
                    <option <%
                        if (chosenSession.getMovie().getId().equals(movie.getId())) {%>
                            selected
                            <% }%>
                            value="<%=movie.getId()%>"><%=movie.getName()%>
                    </option>
                    <%}%>
                </select>
            </div>
            <div class="form-group">
                <label for="hall">Hall:</label>
                <select id="hall" name="hall" class="form-control" required>
                    <%for (Hall hall : halls) {%>
                    <option <%if (chosenSession.getHall().getId().equals(hall.getId())) {%>
                            selected
                            <% }%> value="<%=hall.getId()%>"><%=hall.getName()%>
                    </option>
                    <%}%>
                </select>
            </div>
            <div class="form-group">
                <label for="time">Time:</label>
                <select name="time" id="time">
                    <%for (LocalDateTime localDateTime : dateTimeList) {%>
                    <option <%if (chosenSession.getTime().equals(localDateTime)) {%>
                            selected
                            <% }%> value="<%=localDateTime%>">
                        <%=localDateTime.format(formatter)%>
                    </option>
                    <%}%>
                </select>
            </div>
            <div class="form-group">
                <input type="submit" value="Update Session" class="btn btn-primary btn-block">
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
