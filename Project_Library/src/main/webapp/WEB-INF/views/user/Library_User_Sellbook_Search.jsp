<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:if test="${ empty sessionScope.user }">
	<script>
		alert("로그인 후 이용해주세요.");
		location.href="login_form.do";
	</script>
</c:if>
<!DOCTYPE html>
<html lang="">
<head>
<title>도서관</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="${pageContext.request.contextPath}/resources/common/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
</head>
<body id="top">
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<jsp:include page="../Library_Menu_Top.jsp"/>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper bgded overlay" style="background-image:url('${pageContext.request.contextPath}/resources/images/backgrounds/background.jpg');">
  <div id="breadcrumb" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <h6 class="heading">도서관</h6>
    <!-- ################################################################################################ -->
    <ul>
      <li><a href="main.do">Home</a></li>
    </ul>
    <!-- ################################################################################################ -->
  </div>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <!-- ################################################################################################ -->
    <div class="sidebar one_quarter first"> 
      <!-- ################################################################################################ -->
      <h6>내서재</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="user_rent_search_form.do">대출이력 조회</a></li>
          <li><a href="user_sellbook_search_form.do">구매도서 조회</a></li>
          <li><a href="user_sellbook_cart_form.do">구매도서 카트</a></li>
          <li><a href="user_update_form.do">개인정보변경</a></li>
          <li><a href="user_del_form.do">회원탈퇴</a></li>
        </ul>
      </nav>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- ################################################################################################ -->
    <div class="content three_quarter"> 
      <!-- ################################################################################################ -->
      <h1>구매도서 조회</h1>
      <form>
	      <div class="scrollable">
	        <table>
	          <tbody>
	            <tr>
	              <th align = "center" style="width:10%">주문 번호</th>
	              <th align = "center" style="width:15%">주문일</th>
	              <th align = "center">수취인</th>
	              <th align = "center" style="width:15%">총 금액</th>
	              <th align = "center" style="width:15%">결제수단</th>
	              <th align = "center" style="width:15%">비고</th>
	            </tr>
	            <c:forEach var="orders" items="${orders_List}">
		            <tr>
		            	<td align = "center">${ orders.orders_idx }</td>
		            	<td align = "center">
		            		<fmt:parseDate value="${ orders.orders_date }" pattern="yyyy-MM-dd HH:mm" var="ordersDate"/>
							<fmt:formatDate value="${ ordersDate }" pattern="yyyy/MM/dd"/>
		            	</td>
		            	<td align = "center">
		            		<a href="user_sellbook_view.do?orders_idx=${ orders.orders_idx }" style="color:black;">${ orders.userName_one }</a>
		            	</td>
		            	<td align = "center">
		            		<fmt:formatNumber value="${ orders.orders_Amount }" pattern="###,###원"/>
		            	</td>
		            	<td align = "center">
		            		<c:if test="${ orders.orders_Payment eq 1 }">
		            			카카오 페이
		            		</c:if>
		            		<c:if test="${ orders.orders_Payment eq 0 }">
		            			무통장 입금
		            		</c:if>
		            	</td>
		            	<td align = "center">
			            	<c:if test="${ orders.orders_Check eq 1 }">
			            		배송 중
			            	</c:if>
			            	<c:if test="${ orders.orders_Check eq 0 }">
			            		배송 완료
			            	</c:if>
		            	</td>
		            </tr>
	            </c:forEach>
	            <c:if test="${ empty orders_List }">
	            	<tr>
						<td align = "center" colspan = "6">
							구매한 책들이 존재하지 않습니다.
						</td>
					</tr>
	            </c:if>
	          </tbody>
	        </table>
	      </div>
      </form>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- / main body -->
    <div class="clear"></div>
  </main>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<jsp:include page="../Library_Menu_Footer.jsp"/>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
<!-- JAVASCRIPTS -->
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.backtotop.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>