

<%--
  Created by IntelliJ IDEA.
  User: Owais Awan
  Date: 5/10/2020
  Time: 4:01 PM
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="/WEB-INF/fragments/cssSetUp.jsp"%>
</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <%@include file="/WEB-INF/fragments/header.jsp"%>

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                </div>

                <!-- Content Row -->
                <div class="row">

                    <!-- Accounts Example -->
                    <c:forEach var="account" items="${accounts}">
                        <div class="col-xl-6 col-md-12 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Account Type: <c:out value="${account.accountType}"/> </div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">Account Title: <c:out value="${account.accountTitle}"/></div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">Account Number: <c:out value="${account.accountNumber}"/></div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">Balance: <c:out value="${account.balance}"/></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>



                </div>


                <!-- Content Row -->

                <div class="row">


                    <!-- Area Chart -->
                    <div class="col-xl-8 col-lg-7">

                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">All Accounts Debit/Credit Summary</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-area">
                                    <canvas id="lineChart"></canvas>
                                </div>
                            </div>
                        </div>

                    </div>

                        <!-- Pie Chart Owais -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">All Accounts Spending Statistics</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="requestsPieChart"></canvas>
                                    </div>
                                    <div class="mt-4 text-center small">
                    <span class="mr-2">
                      <i class="fas fa-circle text-primary"></i> Transfers %
                    </span>
                                        <span class="mr-2">
                      <i class="fas fa-circle text-success"></i> Payments %
                    </span>
                                        <span class="mr-2">
                      <i class="fas fa-circle text-info"></i> Others %
                    </span>
                                    </div>
                                </div>
                            </div>
                        </div>



<%--                </div>--%>
<%--                <!-- Content Row -->--%>
<%--                --%>
<%--            </div>--%>
<%--            <!-- /.container-fluid -->--%>

        </div>
        <!-- End of Main Content -->

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

<script src="<%=application.getContextPath() %>/js/jquery.min.js"></script>
<script src="<%=application.getContextPath() %>/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="<%=application.getContextPath() %>/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="<%=application.getContextPath() %>/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="<%=application.getContextPath() %>/js/chart.min.js"></script>

<!-- Js cookie -->
<script src="https://cdn.jsdelivr.net/npm/js-cookie@rc/dist/js.cookie.min.js"></script>


<script type="text/javascript">
    /*<![CDATA[*/

    $(document).ready(function () {

        // var pieChartData = [40.00,50.00,10.00];
        var pieChartData = new Array();

        <%
           float [] list = (float[])request.getAttribute("pieChartData");
           for(int count=0; count <list.length; count++) {
        %>
        pieChartData[<%= count %>]='<%= list[count] %>';//dont miss the single quotes here
        <% } %>

        console.log(pieChartData);
        var ctx = document.getElementById("requestsPieChart");
        var myPieChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ["Fund Transfer", "Bill Payment", "Other Spendings"],
                datasets: [{
                    data: pieChartData,
                    backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc'],
                    hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
                    hoverBorderColor: "rgba(234, 236, 244, 1)",
                }],
            },
            options: {
                maintainAspectRatio: false,
                tooltips: {
                    backgroundColor: "rgb(255,255,255)",
                    bodyFontColor: "#858796",
                    borderColor: '#dddfeb',
                    borderWidth: 1,
                    xPadding: 15,
                    yPadding: 15,
                    displayColors: false,
                    caretPadding: 10,
                },
                legend: {
                    display: false
                },
                cutoutPercentage: 80,
            },
        });


    });
    /*]]>*/
</script>


<script type="text/javascript">
    /*<![CDATA[*/

    $(document).ready(function () {

        var debitData = new Array();
        <%
           int[] debitDatalist = (int[])request.getAttribute("debitData");
           for(int count=0; count <debitDatalist.length; count++) {
        %>
        debitData[<%= count %>]='<%= debitDatalist[count] %>';//dont miss the single quotes here
        <% } %>

        var creditData = new Array();
        <%
           int[] creditDatalist = (int[])request.getAttribute("creditData");
           for(int count=0; count <creditDatalist.length; count++) {
        %>
        creditData[<%= count %>]='<%= creditDatalist[count] %>';//dont miss the single quotes here
        <% } %>

        <%--var bagsRequested = [[${bagsRequested}]];--%>
        <%--var bagsReceived  = [[${bagsReceived}]];--%>

        var ctxL = document.getElementById("lineChart").getContext('2d');
        var myLineChart = new Chart(ctxL, {
            type: 'line',
            data: {
                labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                datasets: [{
                    label: "Debit",
                    data: debitData,
                    backgroundColor: [
                        'rgba(105, 0, 132, .2)',
                    ],
                    borderColor: [
                        'rgba(200, 99, 132, .7)',
                    ],
                    borderWidth: 2
                },
                    {
                        label: "Credit",
                        data: creditData,
                        backgroundColor: [
                            'rgba(0, 137, 132, .2)',
                        ],
                        borderColor: [
                            'rgba(0, 10, 130, .7)',
                        ],
                        borderWidth: 2
                    }
                ]
            },
            options: {
                maintainAspectRatio: false,
                layout: {
                    padding: {
                        left: 10,
                        right: 25,
                        top: 25,
                        bottom: 0
                    }
                }
            }
        });


    });
    /*]]>*/
</script>


<!-- common js function -->
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
