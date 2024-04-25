<%@ page import="java.util.UUID" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.SessionRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Session" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Hall" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Movie" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Seat" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.SeatRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.enums.Status" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>HALL</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        .seat-icon {
            font-size: 30px;
            color: #333;
            margin: 5px;
        }
    </style>
</head>
<body>
<%
    UUID chosenSessionId = UUID.fromString(request.getParameter("id"));
    SessionRepo sessionRepo = new SessionRepo();
    Session chosenSession = sessionRepo.findById(chosenSessionId);
    Hall hall = chosenSession.getHall();
    Movie movie = chosenSession.getMovie();
    SeatRepo seatRepo = new SeatRepo();
    List<Seat> seatsInChosenHall = new ArrayList<>(seatRepo.findAll().stream()
            .filter(seat -> seat.getSession().getId().equals(chosenSession.getId())).toList());
    UUID chosenMovieId = UUID.fromString(request.getParameter("chosenMovieId"));
%>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card text-center">
                <div class="card-body">
                    <a class="btn-dark btn-lg" href="session.jsp?chosenMovie=<%=chosenMovieId%>">Back</a>
                    <h5 class="card-title mt-4">Hall: <%= hall.getName() %>
                    </h5>
                    <h6 class="card-subtitle mb-2 text-muted">Movie: <%= movie.getName() %>
                    </h6>
                    <div class="seating-plan">
                        <%
                            int rowCount = 0;
                            for (Seat seat : seatsInChosenHall) {
                                String seatIcon = seat.getStatus() == Status.FREE ? "fa-chair" : "fa-times-circle";
                        %>
                        <% if (rowCount % 4 == 0) { %>
                        <div class="row justify-content-center">
                            <% } %>
                            <div class="col-3 mb-4">
                                <div class="seat">
                                    <i class="fas <%= seatIcon %> seat-icon"></i>
                                    <span>
    <a <% if (seat.getStatus().equals(Status.FREE)) { %>
            href="purchase.jsp?sessionId=<%=chosenSession.getId()%>&id=<%=seat.getId()%>" <% } %>>
        <%= seat.getSeatNumber() %>
    </a>
</span>
                                </div>
                            </div>
                            <% if (rowCount % 4 == 3 || rowCount == seatsInChosenHall.size() - 1) { %>
                        </div>
                        <% } %>
                        <% rowCount++;
                        } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>
