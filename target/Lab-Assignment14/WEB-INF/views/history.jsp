<%--
  Created by IntelliJ IDEA.
  User: Honghua Zhao
  Date: 5/11/2020
  Time: 5:30 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath() %>/css/all.css" >
    <link rel="stylesheet" type="text/css" href="<%=application.getContextPath() %>/css/sb-admin-2.css" >
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <title>Transaction History</title>
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <%@include file="/WEB-INF/fragments/header.jsp"%>

    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Transaction History</h1>

            <form class="form-inline float-right">
                <label class="my-1 mr-2" for="account">Account:</label>
                <select class="custom-select my-1 mr-sm-2" id="account">
                    <option selected>Choose your account</option>

                    <c:forEach var="acc" items="${myAccounts}">
                    <option
                            value="<c:out value="${acc.accountNumber}"/>"
                            <c:if test="${account==acc.accountNumber}">selected</c:if> >
                            <c:out value="${acc.user.firstName} ${acc.user.lastName} | ${acc.accountType} | ${acc.accountNumber}"/>
                        </option>
                    </c:forEach>
                </select>
            </form>
        </div>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>From Account</th>
                    <th>To Account</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Desc</th>
                    <th>Date Time</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${transactionSummaries}">
                <tr>
                    <td><c:out value="${item.fromAccount}"/></td>
                    <td><c:out value="${item.toAccount}"/></td>
                    <td><c:out value="${item.transactionType}"/></td>
                    <td><fmt:formatNumber type="number" value="${item.amount}" pattern="#.00"/></td>
                    <td><c:out value="${item.transactionDesc}"/></td>
                    <td><c:out value="${item.transactionDate}"/></td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>

            </tfoot>
        </table>


        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item <c:if test="${ pageIndex == 1 }">disabled</c:if>">
                    <a class="page-link" href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach var="j" begin="1" end="${totalPages}">
                <li class="page-item  <c:if test="${ pageIndex == j }">active</c:if>">
                    <a class="page-link" href="history?account=<c:out value="${account}"/>&page=<c:out value="${j}"/>"><c:out value="${j}"/></a>
                </li>
                </c:forEach>
                <li class="page-item <c:if test="${ pageIndex == totalPages }">disabled</c:if>">
                    <a class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>


        <!-- Footer -->
        <%@include file="/WEB-INF/fragments/footer.jsp"%>
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<%@include file="/WEB-INF/fragments/jsSetUp.jsp"%>
<script>
    $("#account").on("change", function () {
        let accountNumber = $("#account").val();
        let pageIndex = <%=request.getAttribute("pageIndex")%>;

        location.href = "history?account=" + accountNumber + "&page=" + pageIndex;
    });

</script>
</body>
</html>