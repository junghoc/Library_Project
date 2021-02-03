<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${ !empty sessionScope.user }">
	<script>
		alert("감사합니다. 또 이용해주세요.");
		location.href="logout.do";
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