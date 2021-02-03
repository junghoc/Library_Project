<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${ !empty sessionScope.admin }">
	<script>
		alert("${admin.adminName}님 환영합니다.");
		location.href="admin_main.do";
	</script>
</c:if>

<c:if test="${ empty sessionScope.admin }">
	<script>
		alert("정보를 잘못 입력하셨습니다. 다시 입력해주세요.");
		location.href="admin_login_form.do"
	</script>
</c:if>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 : 관리자 페이지</title>
</head>
<body>

</body>
</html>