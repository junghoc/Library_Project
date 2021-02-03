<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${ login eq 'no' }">
	<script>
		alert("로그인이후에 이용해주세요.");
		location.href="login_form.do"
	</script>
</c:if>

<c:if test="${ !empty sessionScope.user }">
	<script>
		alert("${user.userName}님 환영합니다.");
		location.href="main.do";
	</script>
</c:if>

<c:if test="${ empty sessionScope.user }">
	<script>
		alert("정보를 잘못 입력하셨습니다. 다시 입력해주세요.");
		location.href="login_form.do"
	</script>
</c:if>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관</title>
</head>
<body>

</body>
</html>