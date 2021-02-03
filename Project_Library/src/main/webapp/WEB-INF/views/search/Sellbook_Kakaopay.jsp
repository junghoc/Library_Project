<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	//시작과 동시에 total에 값 넣기============================================================================================
	window.onload = function () {
		if(${not empty param.pg_token}){
			alert("결제가 완료되었습니다.");
			window.opener.document.location.href="sellbook_orders_finish.do";
			window.close();
		}else {
			alert("결제가 정상적으로 이루어지지 않았습니다.");
			window.opener.document.location.href="user_sellbook_cart_form.do";
			window.close();
		}
	}
</script>
</head>
<body>

</body>
</html>