<%--
   Created by IntelliJ IDEA.
   User: muhammad
   Date: 24/04/24
   Time: 8:28 PM
   To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
    String code = (String) request.getAttribute("code");
%>
<div class="container mt-3">
    <div class="row mb-3">
        <div class="col">
            <a href="#" class="btn btn-secondary">Back</a>
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/auth-servlet" method="post">
                <input type="hidden" name="realCode" value="<%=code%>">
                <input type="hidden" name="function" value="verify">
                <div class="form-group">
                    <label for="codeInput">Enter Code:</label>
                    <input autofocus name="enteredCode" required type="text" class="form-control" id="codeInput" placeholder="Enter code">
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
