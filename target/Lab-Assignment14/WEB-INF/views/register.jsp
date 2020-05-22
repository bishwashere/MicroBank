<%--
  Created by IntelliJ IDEA.
  User: bishwasmishra
  Date: 11/05/20
  Time: 6:28 PM
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

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-5 d-none d-lg-block bg-login-image"></div>
                <div class="col-lg-7">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">Register at MicroBank!</h1>
                        </div>
                        <form class="user" method="POST" action="register">
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input pattern="^[a-zA-Z].*" title="Please enter first name." type="text" class="form-control form-control-user" id="firstName" name="firstName" placeholder="First Name" required>
                                </div>
                                <div class="col-sm-6">
                                    <input pattern="^[a-zA-Z].*" title="Please enter last name." type="text" class="form-control form-control-user" id="lastName" name="lastName" placeholder="Last Name" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input type="email" class="form-control form-control-user" id="inputEmail" name="inputEmail" placeholder="Email Address" required>
                                </div>
                                <div class="col-sm-6">
                                    <input pattern="^[a-zA-Z1-9].*" title="Please enter user name." type="username" class="form-control form-control-user" id="userName" name="userName" placeholder="Username" required>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <input pattern="^[a-zA-Z1-9].*" title="Please enter password." type="password" class="form-control form-control-user" id="inputPassword" name="inputPassword" placeholder="Password" required>
                                </div>
                                <div class="col-sm-6">
                                    <input pattern="^[a-zA-Z1-9].*" title="Please enter password."  type="password" class="form-control form-control-user" id="repeatPassword" name="repeatPassword2" placeholder="Repeat Password" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <input pattern="(^\d{3}-?\d{2}-?\d{4}$|^XXX-XX-XXXX$)" type="text" class="form-control form-control-user" id="ssnNumber" name="ssnNumber" placeholder="SSN Number. Fo ex: 981-87-4758" required>
                            </div>
                            <button class="btn btn-primary btn-user btn-block">Register Account</button>
                        </form>
                        <hr>
                        <div class="text-center">
                            <a class="small" href="login">Already have an account? Login!</a>
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

                    <h4 class="modal-title" id="myModalLabel">Success Message</h4>
                </div>
                <div class="modal-body">
                    <p><span> You are successfully registered at MicroBank!.</span></p>
                </div>
                <div class="modal-footer">
                    <a class="btn btn-primary" href="login">Login Now</a>
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
        var modelAttributeValue = "<%=request.getAttribute("Success")%>";
        console.log("modelAttributeValue Success",modelAttributeValue);
        if (modelAttributeValue === "true") {
            $('#myModal').modal('show');
        }
    });

    /*]]>*/
</script>

</body>

</html>

