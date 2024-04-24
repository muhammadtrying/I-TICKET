<%@ page import="java.util.UUID" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.SeatRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Seat" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Hall" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Session" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.SessionRepo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PURCHASE</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
</head>
<body>
<%
    SeatRepo seatRepo = new SeatRepo();
    SessionRepo sessionRepo = new SessionRepo();
    UUID chosenSeatId = UUID.fromString(request.getParameter("id"));
    Seat chosenSeat = seatRepo.findById(chosenSeatId);
    Hall hall = chosenSeat.getHall();
    Session chosenSession = sessionRepo.findById(UUID.fromString(request.getParameter("sessionId")));
%>

<div class="container mt-3">
    <div class="row mb-3">
        <div class="col">
            <a href="hallView.jsp?chosenMovieId=<%= chosenSession.getMovie().getId() %>&id=<%= chosenSession.getId() %>"
               class="btn btn-secondary">Back</a>
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Seat Information</h5>
                    <p class="card-text">Selected Seat Number: <%= chosenSeat.getSeatNumber() %>
                    </p>
                    <p class="card-text">Hall: <%= hall.getName() %>
                    </p>
                    <p class="card-text">Movie: <%= chosenSession.getMovie().getName() %>
                    </p>
                    <form action="${pageContext.request.contextPath}/auth-servlet" method="post">
                        <input type="hidden" name="seatId" value="<%= chosenSeat.getId() %>">
                        <input type="hidden" name="function" value="emailSending">
                        <input type="hidden" name="seatId" value="<%=chosenSeat.getId()%>">
                        <input type="hidden" name="chosenSessionId" value="<%=chosenSession.getId()%>">
                        <div class="form-group">
                            <label for="customerName">Your Name</label>
                            <input type="text" class="form-control" id="customerName" name="username" required>
                        </div>
                        <div class="form-group">
                            <label for="customerEmail">Your Email</label>
                            <input type="email" class="form-control" id="customerEmail" name="email" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Confirm Purchase</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
