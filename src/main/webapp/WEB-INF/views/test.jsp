<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath();
%>
<script type="text/javascript">


</script>
<form name="myFrm" action="<%=ctxPath%>/user/register" method="POST">
<input type="text" name="userid"/>
<button type="submit">submit</button>
</form>