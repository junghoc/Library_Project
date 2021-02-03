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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/resources/common/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script>

	//선택 자리 예약시간 확인============================================================================================
	function select_time(seats_idx){
		console.log("seats_idx : " + seats_idx);
		location.href="room_select_time.do?seats_idx=" + seats_idx;
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
      <h6>열람실</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="study_room.do">열람실 예약</a></li>
           <ul>
              <li><a href="room_select_mult.do">멀티미디어실</a></li>
              <li><a href="room_select_read.do">열람실</a></li>
            </ul>
          <li><a href="my_study_room_book.do">내 예약</a></li>
        </ul>
      </nav>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- ################################################################################################ -->
    <div class="content three_quarter"> 
      <!-- ################################################################################################ -->
      <h1>멀티미디어실 좌석표</h1>
		<br>
		<c:choose>
			<c:when test="${hour < 9 or hour >= 18}">
				<p>총 좌석 : 24석</p>
			</c:when>
			<c:when test="${9 <= hour and hour < 18}">
				<p>총 좌석 : 24석 / 사용 중인 좌석  : ${ use_count }석 / 남은 좌석 : ${ 24 - use_count }석</p>
			</c:when>
		</c:choose>
		<hr>
		<br>
		<p align="center">			 
			<c:choose>
				<c:when test="${hour < 9 or hour >= 18}">
		   	  		<c:forEach var="seats" items="${seats_List}">
		    	  	
		    	  	<button type="button" class="btn btn-outline-dark btn-lg" onclick="select_time(${seats.seats_idx});">
		    	  		<fmt:formatNumber value="${seats.seats_idx}" minIntegerDigits="2"/>
		    	  	</button>
		    	  	<c:if test="${seats.seats_idx % 2 == 0 }">&nbsp;&nbsp;&nbsp;&nbsp; </c:if>
				    <c:if test="${(seats.seats_idx) % 6 == 0}"><br></c:if> <!-- 6 12 18 24 -->
						
					<c:if test="${seats.seats_idx % 12 == 0}"><br></c:if>
					</c:forEach>
		   		 </c:when>
		   	 
		    	<c:when test="${9 <= hour and hour < 12}">
		   	  		<c:forEach var="seats" items="${seats_List}">
		    	  	
		    	  		<c:if test="${seats.t1_user_id eq null }">
		    	  		<button type="button" class="btn btn-outline-dark btn-lg" onclick="select_time(${seats.seats_idx});"><fmt:formatNumber value="${seats.seats_idx}" minIntegerDigits="2"/></button>
		    	  		</c:if>
		    	  		
		    	  		<c:if test="${seats.t1_user_id ne null }">
		    	  		<button type="button" class="btn btn-secondary btn-lg" onclick="select_time(${seats.seats_idx});"><fmt:formatNumber value="${seats.seats_idx}" minIntegerDigits="2"/></button>
		    	  		</c:if>
		    	  		
		    	  		<c:if test="${seats.seats_idx % 2 == 0 }">&nbsp;&nbsp;&nbsp;&nbsp; </c:if>
					 	<c:if test="${(seats.seats_idx) % 6 == 0}"><br></c:if> <!-- 6 12 18 24 -->
						
						<c:if test="${seats.seats_idx % 12 == 0}"><br></c:if>
					</c:forEach>
		   	 </c:when>
		
		    	<c:when test="${12 <= hour and hour < 15}">
		   	  		<c:forEach var="seats" items="${seats_List}">
		    	  	
		    	  		<c:if test="${seats.t2_user_id eq null }">
		    	  		<button type="button" class="btn btn-outline-dark btn-lg" onclick="select_time('${seats.seats_idx}');"><fmt:formatNumber value="${seats.seats_idx}" minIntegerDigits="2"/></button>
		    	  		</c:if>
		    	  		
		    	  		<c:if test="${seats.t2_mem_idx ne null }">
		    	  		<button type="button" class="btn btn-secondary btn-lg" onclick="select_time('${seats.seats_idx}');"><fmt:formatNumber value="${seats.seats_idx}" minIntegerDigits="2"/></button>
		   					</c:if>
		    	  		
		    	  		<c:if test="${seats.seats_idx % 2 == 0 }">&nbsp;&nbsp;&nbsp;&nbsp; </c:if>
					 	<c:if test="${(seats.seats_idx) % 6 == 0}"><br></c:if> <!-- 6 12 18 24 -->
						
						<c:if test="${seats.seats_idx % 12 == 0}"><br></c:if>
					</c:forEach>
		   	 </c:when>
		    
		   	 <c:when test="${15 <= hour and hour < 18}">
		   	  		<c:forEach var="seats" items="${seats_List}">
		    	  	
		    	  		<c:if test="${seats.t3_user_id eq null }">
		    	  		<button type="button" class="btn btn-outline-dark btn-lg" onclick="select_time(${seats.seats_idx});"><fmt:formatNumber value="${seats.seats_idx}" minIntegerDigits="2"/></button>
		    	  		</c:if>
		    	  		
		    	  		<c:if test="${seats.t3_user_id ne null }">
		    	  		<button type="button" class="btn btn-secondary btn-lg" onclick="select_time(${seats.seats_idx});"><fmt:formatNumber value="${seats.seats_idx}" minIntegerDigits="2"/></button>
		    	  		</c:if>
		    	  		
		    	  		<c:if test="${seats.seats_idx % 2 == 0 }">&nbsp;&nbsp;&nbsp;&nbsp; </c:if>
					 	<c:if test="${(seats.seats_idx) % 6 == 0}"><br></c:if> <!-- 6 12 18 24 -->
						
						<c:if test="${seats.seats_idx % 12 == 0}"><br></c:if>
					</c:forEach>
		   	 </c:when>
			</c:choose>
		</p>
		<br>
		<hr>
		<br>
		<p align="right">
		<a onclick="history.go(-1)" title="뒤로가기" style="cursor: pointer;"><i class="fa-redo fa-fw fas"></i>뒤로 가기</a>
		</p>
		  <!-- Optional JavaScript -->
		    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
		    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" ></script>
		    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" ></script>
		    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>

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