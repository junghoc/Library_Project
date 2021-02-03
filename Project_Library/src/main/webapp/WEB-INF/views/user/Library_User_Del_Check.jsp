<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ result eq 0 }">
	<script>
		alert("회원탈퇴가 정상적으로 이루어지지 않았습니다.\n다시 시도 후 정상적인 작업이 이루어 지지 않는경우 고객센터에 문의를 남겨주세요.");
		location.href = "user_del_form.do";
	</script>
</c:if>
<c:if test="${ result eq 1 }">
	<script>
	alert("정상적으로 회원 탈퇴가 되었습니다. 감사합니다.\n문의가 있을 경우 고객상담실에 연락 부탁드립다.");
	location.href = "main.do";
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