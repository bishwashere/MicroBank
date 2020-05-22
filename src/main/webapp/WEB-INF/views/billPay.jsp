<%@ page import="java.util.concurrent.ThreadLocalRandom" %><%--
  Created by IntelliJ IDEA.
  User: bishwasmishra
  Date: 11/05/20
  Time: 6:52 PM
  To change this template use File | Settings | File Templates.
--%>


<%--
  Created by IntelliJ IDEA.
  User: Owais Awan
  Date: 5/10/2020
  Time: 4:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.util.concurrent.ThreadLocalRandom" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
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
</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <%@include file="/WEB-INF/fragments/header.jsp"%>

    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Bill Pay</h1>
        </div>

        <div class="row">

            <div class="col-lg-6">
                <!-- Collapsable Card Example -->
                <div class="card shadow mb-4 card1">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardExample1" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Water Bill</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse" id="collapseCardExample1">
                        <div class="card-body">
                            Water Incorporation
                            <br> BENEFICIARY BANK: Wells Fargo Bank
                            <br> BENEFICIARY ACCOUNT NUMBER: B1801111555
                            <br><br>

                            <form class="user">
                                <div class="input-group">

                                    <div class="input-group-append">
                                        <input id="billNumber1" type="text" name ="billNumber" class="form-control bg-light border-0 small" placeholder="Enter bill Number" aria-label="Search" aria-describedby="basic-addon2">
                                        <button id="generateBill1" type="button" class="btn btn-primary btn-user btn-block">Generate Bill</button>
                                    </div>

                                </div>
                            </form>
                            <form id="accountPayForm1" class="form-inline" method="POST" action="billPay" style="display: none;">
                                <div class="form-group mt-2">Total Bill: <%=ThreadLocalRandom.current().nextInt(15,75)%>&nbsp;&nbsp;</div>
                                <div class="form-group mt-2">
                                    <label class="my-1 mr-2" for="account1">Pay From: </label>
                                    <select class="custom-select my-1 mr-sm-2 form-control" id="account1" name ="customerAccount">
                                        <option selected value="">Choose your account</option>
                                        <c:forEach var="acc" items="${myAccounts}">
                                            <option
                                                    value="<c:out value="${acc.accountNumber}"/>"
                                                    <c:if test="${account==acc.accountNumber}">selected</c:if> >
                                                <c:out value="${acc.user.firstName} ${acc.user.lastName} | ${acc.accountType} | ${acc.accountNumber}"/>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <input type="hidden" name="billNumber" value="11111">
                                <input type="hidden" name="account_number" value="1">
                                <input type="hidden" name="beneficiary" value="Water Incorporation">
                                <input type="hidden" name="bank" value="Wells Fargo Bank">
                                <input type="hidden" name="bank-account-number" value="1111555">
                                <input type="hidden" name="bill_type" value="water">
                                <button name="billPay" class="btn btn-primary btn-user btn-block mt-2">Pay</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <!-- Collapsable Card Example -->
                <div class="card shadow mb-4 card2">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardExample2" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Electricity Bill</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse" id="collapseCardExample2">
                        <div class="card-body">
                            Tesla Pvt. Ltd.
                            <br> BENEFICIARY BANK: Mid West One Bank
                            <br> BENEFICIARY ACCOUNT NUMBER: PQR01111555
                            <br><br>

                            <form class="user" method="POST" action="billPay">
                                <div class="input-group">

                                    <div class="input-group-append">
                                        <input id="billNumber2" type="text" name ="billNumber" class="form-control bg-light border-0 small" placeholder="Enter bill Number" aria-label="Search" aria-describedby="basic-addon2">
                                        <input type="hidden" name="beneficiary" value="Tesla Pvt. Ltd.">
                                        <input type="hidden" name="bank" value="Mid West Bank">
                                        <button id="generateBill2" type="button" class="btn btn-primary btn-user btn-block">Generate Bill</button>
                                    </div>

                                </div>
                            </form>

                            <form id="accountPayForm2" class="form-inline" method="POST" action="billPay" style="display: none;">
                                <div class="form-group mt-2">Total Bill: <%=ThreadLocalRandom.current().nextInt(15,75)%>&nbsp;&nbsp;</div>
                                <div class="form-group mt-2">
                                    <label class="my-1 mr-2" for="account2">Pay From: </label>
                                    <select class="custom-select my-1 mr-sm-2 form-control" id="account2" name ="customerAccount">
                                        <option selected value="">Choose your account</option>
                                        <c:forEach var="acc" items="${myAccounts}">
                                            <option
                                                    value="<c:out value="${acc.accountNumber}"/>"
                                                    <c:if test="${account==acc.accountNumber}">selected</c:if> >
                                                <c:out value="${acc.user.firstName} ${acc.user.lastName} | ${acc.accountType} | ${acc.accountNumber}"/>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <input type="hidden" name="billNumber" value="11111">
                                <input type="hidden" name="account_number" value="1">
                                <input type="hidden" name="beneficiary" value="Water Incorporation">
                                <input type="hidden" name="bank" value="Wells Fargo Bank">
                                <input type="hidden" name="bank-account-number" value="1801111777">
                                <input type="hidden" name="bill_type" value="electricity">
                                <button name="billPay" class="btn btn-primary btn-user btn-block mt-2">Pay</button>
                            </form>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <!-- Collapsable Card Example -->
                <div class="card shadow mb-4 card3">
                    <!-- Card Header - Accordion -->
                    <a href="#collapseCardExample3" class="d-block card-header py-3" data-toggle="collapse" role="button" aria-controls="collapseCardExample">
                        <h6 class="m-0 font-weight-bold text-primary">Credit Card Bill</h6>
                    </a>
                    <!-- Card Content - Collapse -->
                    <div class="collapse" id="collapseCardExample3">
                        <div class="card-body">
                            Discovery
                            <br> BENEFICIARY BANK: Mid West One Bank
                            <br> BENEFICIARY ACCOUNT NUMBER: ACC01111555
                            <br><br>

                            <form class="user" method="POST" action="billPay">
                                <div class="input-group">

                                    <div class="input-group-append">
                                        <input type="text" name ="billNumber" class="form-control bg-light border-0 small" placeholder="Enter Credit Card Number" aria-label="Search" aria-describedby="basic-addon2">

                                        <input type="hidden" name="beneficiary" value="Discovery">
                                        <input type="hidden" name="bank" value="Mid West One Bank">
                                        <button id="generateBill3" type="button" class="btn btn-primary btn-user btn-block">Generate Bill</button>
                                    </div>

                                </div>
                            </form>

                            <form id="accountPayForm3" class="form-inline" method="POST" action="billPay" style="display: none;">
                                <div class="form-group mt-2">Total Bill: <%=ThreadLocalRandom.current().nextInt(15,75)%>&nbsp;&nbsp;</div>
                                <div class="form-group mt-2">
                                    <label class="my-1 mr-2" for="account3">Pay From: </label>
                                    <select class="custom-select my-1 mr-sm-2 form-control" id="account3" name ="customerAccount">
                                        <option selected value="">Choose your account</option>
                                        <c:forEach var="acc" items="${myAccounts}">
                                            <option
                                                    value="<c:out value="${acc.accountNumber}"/>"
                                                    <c:if test="${account==acc.accountNumber}">selected</c:if> >
                                                <c:out value="${acc.user.firstName} ${acc.user.lastName} | ${acc.accountType} | ${acc.accountNumber}"/>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <input type="hidden" name="billNumber" value="22222">
                                <input type="hidden" name="account_number" value="1">
                                <input type="hidden" name="beneficiary" value="Water Incorporation">
                                <input type="hidden" name="bank" value="Wells Fargo Bank">
                                <input type="hidden" name="bank-account-number" value="1801111222">
                                <input type="hidden" name="bill_type" value="credit card">
                                <button name="billPay" class="btn btn-primary btn-user btn-block mt-2">Pay</button>
                            </form>

                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Footer -->
        <%@include file="/WEB-INF/fragments/footer.jsp"%>
        <!-- End of Footer -->
    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                <a class="btn btn-primary" href="login">Logout</a>
            </div>
        </div>
    </div>
</div>-->

<%@include file="/WEB-INF/fragments/jsSetUp.jsp"%>

<script>

    $(function () {
        // if last operation succeed, show a message
        <% if(request.getAttribute("showSuccess") != null && (boolean)request.getAttribute("showSuccess")) {%>
        Swal.fire("Congratulations! Your payment succeed!");
        <% } %>

        // bill number invalidation
        $("#generateBill1").on("click", function () {
            if($("#billNumber1").val() === "") {
                Swal.fire("Please enter your bill number");
                return;
            }

            $(".card1 .card-body").css("height", 280);
            $("#accountPayForm1").show();
        });

        $("#generateBill2").on("click", function () {
            if($("#billNumber2").val() === "") {
                Swal.fire("Please enter your bill number");
                return;
            }

            $(".card2 .card-body").css("height", 280);
            $("#accountPayForm2").show();
        });

        $("#generateBill3").on("click", function () {
            if($("#billNumber3").val() === "") {
                Swal.fire("Please enter your bill number");
                return;
            }

            $(".card3 .card-body").css("height", 280);
            $("#accountPayForm3").show();
        });

        // form invalidation
        $("#accountPayForm1").on('submit', function(evt) {
            if($("#account1").val() === "") {
                evt.preventDefault();
                Swal.fire("Please select your account");
                return;
            }

        });

        $("#accountPayForm2").on('submit', function() {
            if($("#account2").val() === "") {
                evt.preventDefault();
                Swal.fire("Please select your account");
                return;
            }
        });

        $("#accountPayForm3").on('submit', function() {
            if($("#account3").val() === "") {
                evt.preventDefault();
                Swal.fire("Please select your account");
                return;
            }
        });

    });



</script>

<script>
    $(function() {
        $("#quit").on("click", function() {
            Cookies.remove('USER_ID', { path: '' });
            location.href = "login";
        });
    });
</script>


</body>

</html>
</html>
