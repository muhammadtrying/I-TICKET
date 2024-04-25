<%@ page import="java.util.List" %>
<%@ page import="uz.muhammadtrying.iticketproject.repo.PurchaseRepo" %>
<%@ page import="uz.muhammadtrying.iticketproject.entity.Purchase" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REPORT</title>
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
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy hh:mm a");
    PurchaseRepo purchaseRepo = new PurchaseRepo();
    List<Purchase> purchases = purchaseRepo.findAll();
    if (request.getAttribute("filteredPurchases") != null) {
        purchases = (List<Purchase>) request.getAttribute("filteredPurchases");
    }
    int i = 1;
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
</nav>

<div class="table-container">
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin.jsp">Back</a>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col"><a href="${pageContext.request.contextPath}/filter-purchases?filter=all">#</a></th>
                <th scope="col"><a href="${pageContext.request.contextPath}/filter-purchases?filter=hall">Hall</a></th>
                <th scope="col"><a href="${pageContext.request.contextPath}/filter-purchases?filter=movie">Movie</a>
                </th>
                <th scope="col"><a href="${pageContext.request.contextPath}/filter-purchases?filter=sessionTime">Session
                    Time</a></th>
                <th scope="col"><a href="${pageContext.request.contextPath}/filter-purchases?filter=price">Price</a>
                </th>
                <th scope="col"><a href="${pageContext.request.contextPath}/filter-purchases?filter=user">User</a></th>
                <th scope="col"><a href="${pageContext.request.contextPath}/filter-purchases?filter=purchasedAt">Purchased
                    At</a></th>
            </tr>
            </thead>
            <tbody>
            <% for (Purchase purchase : purchases) { %>
            <tr>
                <th scope="row"><%= i++ %>
                </th>
                <td><%= purchase.getHall() %>
                </td>
                <td><%=purchase.getMovie()%>
                </td>
                <td><%=purchase.getSessionTime()%>
                </td>
                <td><%=purchase.getPrice()%>
                </td>
                <td><%=purchase.getUser().getUsername()%>
                </td>
                <td><%=purchase.getPurchaseDate().format(formatter)%>
                </td>
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
