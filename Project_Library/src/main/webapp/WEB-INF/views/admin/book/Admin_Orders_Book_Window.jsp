<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 : 관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script type="text/javascript">
	
	//window창 닫기============================================================================================
	function self_close() {
		window.close();
	}
	
</script>

</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td bgcolor="#999999" style="padding:5px 10px;" class="white12bold">구매 정보</td>
			</tr>
		</tbody>
	</table>
	<table width="100%" class="grey12">
		<tbody><tr>
			<td style="padding:20px 0 0 0">
				<form id="rentbook_insert">
				<table width="100%" align="center">
					<tbody>
						<tr>
							<td style="padding:15px; border-top:2px #cccccc solid; border-right:2px #cccccc solid; border-bottom:2px #cccccc solid; border-left:2px #cccccc solid;">
									<table width="100%">
									  	<tbody>
										  	<tr>
										  		<td class="stitle"><strong>${ cart_list[0].userID }님의 구매정보</strong></td>
										  	</tr>
									  	</tbody>
								  	</table>
								  	
								  	<table width="100%" cellspacing="1" class="regtable">
									  	<tbody>
										  	<tr>
											  	<th bgcolor="#f4f4f4">책고유번호</th>
											  	<th bgcolor="#f4f4f4">책이름</th>
											  	<th bgcolor="#f4f4f4">가격</th>
											  	<th bgcolor="#f4f4f4">수량</th>
											  	<th bgcolor="#f4f4f4">총가격</th>
										  	</tr>
										  	<c:forEach var="cart" items="${ cart_list }">
										  		<tr>
										  			<td>${ cart.sellbook_Isbn }</td>
										  			<td>${ cart.sellbook_Name }</td>
										  			<td>
										  				<fmt:formatNumber value="${ cart.sellbook_Price }" pattern="###,###원"/>
										  			</td>
										  			<td>${ cart.cart_Cnt }</td>
										  			<td>
										  				<fmt:formatNumber value="${ cart.sellbook_Price * cart.cart_Cnt }" pattern="###,###원"/>
										  			</td>
										  		</tr>
										  	</c:forEach>
										  	<tr>
											  	<td colspan="5" style="text-align:right;">
											  		<strong><fmt:formatNumber value="${ param.orders_Amount }" pattern="###,###"/>원</strong>
											  	</td>
										  	</tr>
										</tbody>
									</table>
							</td>
						</tr>
					</tbody>
				</table>
				
				<table align="right" style="margin-right:5px" >
					<tbody>
						<tr>
							<td height="40" style="padding:0 13px 0 0">
								<a href="javascript:self_close();"><span style="width:50px">닫기</span></a></div>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</td>
			</tr>
		</tbody>
	</table>

</body>
</html>