<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script type="text/javascript">

    const value = '${boolLogin}';
    console.log('value '+value);
    if(value) {
        localStorage.setItem("login", value);
    }
    // else {
    //     localStorage.setItem("login", false);
    // }

    location.href = '${redirectUrl}';
</script>
