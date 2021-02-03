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
<script type="text/javascript">

	//예약 도서 취소============================================================================================
	function book_ccl(rent_idx) {
		if( !confirm("정말 취소하시겠습니까?") ){
			return;
		}
		location.href = "user_rent_ccl.do?rent_idx="+rent_idx;
	}
	
</script>
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
      <h1>대출이력 조회</h1>
      <form>
	      <div class="scrollable">
	        <table>
	          <tbody>
	            <tr>
	              <th align = "center">번호</th>
	              <th align = "center">책</th>
	              <th align = "center">대여일</th>
	              <th align = "center">반납일</th>
	              <th align = "center">대여현황</th>
	              <th align = "center">비고</th>
	            </tr>
	            <c:forEach var="rent" items="${rent_List}">
		            <tr>
		            	<td align = "center">${ rent.rent_idx }</td>
		            	<td align = "center">
		            		<a href="rentbook_view.do?page=1&rentbook_Isbn=${rent.rentbook_Isbn}" style="color:black;">${ rent.rentbook_Name }</a>
		            	</td>
		            	<td align = "center">
		            		<fmt:parseDate value="${ rent.rent_Date }" pattern="yyyy-MM-dd HH:mm" var="rentDate"/>
							<fmt:formatDate value="${ rentDate }" pattern="yyyy/MM/dd"/>
		            	</td>
		            	<td align = "center">
		            		<fmt:parseDate value="${ rent.rent_Redate }" pattern="yyyy-MM-dd HH:mm" var="reDate"/>
							<fmt:formatDate value="${ reDate }" pattern="yyyy/MM/dd"/>
		            	</td>
		            	<td align = "center">
		            		<c:if test="${ rent.rent_Cancel eq 2 }">
		            			<c:if test="${ rent.rent_Check eq 2 }">
			            			예약
			            		</c:if>
		            			<c:if test="${ rent.rent_Check eq 1 }">
			            			대여
			            		</c:if>
		            			<c:if test="${ rent.rent_Check eq 0 }">
			            			반납
			            		</c:if>
		            		</c:if>
		            		<c:if test="${ rent.rent_Cancel eq 3 }">
		            			취소 중
		            		</c:if>
		            		<c:if test="${ rent.rent_Cancel eq 1 }">
		            			취소
		            		</c:if>
		            		<c:if test="${ rent.rent_Cancel eq 0 }">
		            			거절
		            		</c:if>
		            	</td>
		            	<td align = "center">
			            	<c:if test="${ rent.rent_Cancel eq 2 && rent.rent_Check eq 2}">
			            		<input type="button" value="취소" onclick="book_ccl(${rent.rent_idx});">
			            	</c:if>
		            	</td>
		            </tr>
	            </c:forEach>
	            <c:if test="${ empty rent_List }">
	            	<tr>
						<td align = "center" colspan = "6">
							예약됬던 책들이 존재하지 않습니다.
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