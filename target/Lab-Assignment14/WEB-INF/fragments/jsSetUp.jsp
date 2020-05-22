<%--
  Created by IntelliJ IDEA.
  User: Owais Awan
  Date: 5/11/2020
  Time: 3:10 AM
  To change this template use File | Settings | File Templates.
--%>


<!-- Bootstrap core JavaScript-->
<script src="<%=application.getContextPath() %>/js/jquery.min.js"></script>
<script src="<%=application.getContextPath() %>/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="<%=application.getContextPath() %>/js/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="<%=application.getContextPath() %>/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="<%=application.getContextPath() %>/js/chart.js"></script>

<!-- Page level custom scripts -->
<script src="<%=application.getContextPath() %>/js/chart-area-demo.js"></script>
<script src="<%=application.getContextPath() %>/js/chart-pie-demo.js"></script>

<!-- Alert and message box -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<!-- Js cookie -->
<script src="https://cdn.jsdelivr.net/npm/js-cookie@rc/dist/js.cookie.min.js"></script>

<!-- common js function -->
<script>
$(function() {
    $("#quit").on("click", function() {
        Cookies.remove('USER_ID', { path: '' });
        location.href = "login";
    });
});
</script>