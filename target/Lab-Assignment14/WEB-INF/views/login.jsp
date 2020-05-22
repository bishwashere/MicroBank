<%--
  Created by IntelliJ IDEA.
  User: Owais Awan
  Date: 5/10/2020
  Time: 2:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="/WEB-INF/fragments/cssSetUp.jsp"%>
</head>

<body class="bg-gradient-primary">

<div class="container">

    <!-- Outer Row -->
    <div class="row justify-content-center">

        <div class="col-xl-10 col-lg-12 col-md-9">

            <div class="card o-hidden border-0 shadow-lg my-5">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                        <div class="col-lg-6">
                            <div class="p-5">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4">Welcome to MircoBank!</h1>
                                </div>
                                <form class="user"method="POST" action="login">
                                    <div class="form-group">
                                        <input pattern="^[a-zA-Z1-9].*" title="Please enter user name." type="text" class="form-control form-control-user" id="username" name="username"  placeholder="Enter username..." required>
                                    </div>
                                    <div class="form-group">
                                        <input pattern="^[a-zA-Z1-9].*" title="Please enter password." type="password" class="form-control form-control-user" id="password" name="password" placeholder="Password" required>
                                    </div>

                                    <button class="btn btn-primary btn-user btn-block" type="submit">Login</button>
                                    <hr>
                                </form>
                                <hr>

                                <div class="text-center">
                                    <a class="small" href="register">Create an Account!</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">

                        <h4 class="modal-title" id="myModalLabel">Error Message</h4>
                    </div>
                    <div class="modal-body">
                        <p><span> You have entered incorrect user name or password.</span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

</div>

<!-- Bootstrap core JavaScript-->
<script src="<%=application.getContextPath() %>/js/jquery.min.js"></script>
<script src="<%=application.getContextPath() %>/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="<%=application.getContextPath() %>/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="<%=application.getContextPath() %>/js/sb-admin-2.min.js"></script>

<script type="text/javascript">
    /*<![CDATA[*/

    $(document).ready(function() {
        var modelAttributeValue = "<%=request.getAttribute("error")%>";
        console.log("modelAttributeValue error",modelAttributeValue);
        if (modelAttributeValue === "true") {
            $('#myModal').modal('show');
        }
    });

    /*]]>*/
</script>


</body>

</html>

