
<%--
  Created by IntelliJ IDEA.
  User: Honghua Zhao
  Date: 5/11/2020
  Time: 5:23 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    <title>Transfer money</title>
</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <%@include file="/WEB-INF/fragments/header.jsp"%>

        <!-- Begin Page Content -->
        <div class="container-fluid">

            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h1 class="h3 mb-0 text-gray-800">Transfer money</h1>
            </div>

            <div style="height: 500px">
                <form id="transfer-form" class="form">
                    <div class="form-group">
                        <label class="">From</label>
                        <select id="from" class="form-control" name="from">
                            <option value="">Please select your account</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="">To</label>
                        <select id="to" class="form-control" name="to">
                            <option value="">Please select target account</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Amount</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="inputGroupPrepend">$</span>
                            </div>
                            <input type="number" class="form-control" id="amount" required step="0.01" placeholder="0.00">
                            <div class="invalid-feedback">
                                Please choose a correct amount.
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <div style="text-align: center;">
                        <button type="reset" class="btn btn-warning">Reset</button>
                        <button type="submit" class="btn btn-primary">Transfer money</button>
                    </div>
                </form>

                <div id="transfer-success" style="display: none; text-align: center;">
                    <h2>Success!</h2>
                    <button id="transfer-again" class="btn btn-outline-primary" >Another transfer?</button>
                </div>
            </div>

            <!-- Footer -->
            <%@include file="/WEB-INF/fragments/footer.jsp"%>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <%@include file="/WEB-INF/fragments/jsSetUp.jsp"%>
<script>
    $(function () {
        let userId = "<%=request.getAttribute("userId")%>";
        $("#from").attr("disabled","disabled");
        $("#to").attr("disabled","disabled");

        // get account transfer from
        $.ajax("api/accounts", {
            type: "GET",
            data_type: "json",
            data: {
                userid: userId
            }
        }).done(function (data) {
            if(data.code === 0) {
                let from = $("#from");
                for(let v of data.accounts) {
                    let tag = "<option value=\"" + v.accountNumber + "\">" + v.user.firstName + " " + v.user.lastName
                        + " | " + v.accountNumber + " | " + v.accountType + "</option>";

                    from.append(tag);
                }
                from.removeAttr("disabled");
            }

        }).fail(function () {

        });

        // get account transfer to
        $.ajax("api/accounts", {
            type: "GET",
            data_type: "json",
            data: {
                userid: 0
            }
        }).done(function (data) {
            if(data.code === 0) {
                let to = $("#to");
                for(let v of data.accounts) {
                    let tag = "<option value=\"" + v.accountNumber + "\">" + v.user.firstName + " " + v.user.lastName
                        + " | " + v.accountNumber + " | " + v.accountType + "</option>";

                    to.append(tag);
                }
                to.removeAttr("disabled");
            }

        }).fail(function () {

        });

        // remove the same account with from_account
        $("#from").on("change", function (evt) {
            let fromAccount = $("#from").val();
            $("#to option").each(function () {
                if($(this).attr("value") === fromAccount) {
                    $(this).remove();
                }
            });
        });

        // submit transfer
        $("#transfer-form").on("submit", function (evt) {
            evt.preventDefault();

            let from = $("#from").val();
            let to = $("#to").val();
            let amount = $("#amount").val();

            if(from === "") {
                Swal.fire("Please select your account");
                return;
            }
            if(to === "") {
                Swal.fire("Please select target account");
                return;
            }

            if(from === to) {
                Swal.fire("You cannot transfer money to a same account");
                return;
            }
            if(parseFloat(amount) <= 0 ) {
                Swal.fire("Please input currect amount");
                return;
            }

            $.ajax("api/transfer", {
                type: "POST",
                data_type: "json",
                data: {
                    from : from,
                    to: to,
                    amount: amount
                }
            }).done(function (data) {
                if(data.code === 0) {
                    $("#transfer-form").hide("slow");
                    $("#transfer-success").show("slow");

                    $("#from").val("");
                    $("#to").val("");
                    $("#amount").val("");
                } else {
                    Swal.fire(data.msg);
                }

            }).fail(function () {
                Swal.fire("Network error, please try again later");
            });
        });

        // transfer agin
        $("#transfer-again").on("click", function (evt) {
            $("#transfer-success").hide("slow");
            $("#transfer-form").show("slow");
        });

    });

</script>
</body>
</html>