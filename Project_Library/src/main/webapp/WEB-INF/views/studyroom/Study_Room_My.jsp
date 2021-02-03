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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script type="text/javascript">
	//취소하기============================================================================================
	function room_cancel( num, seats_idx ) {
		console.log("seats_idx : " + seats_idx);
		console.log("num : " + num);
		if( !confirm("예약을 취소하시겠습니까?") ){
			return;
	    }
		
		//파라미터값 제이슨 형태로 변경  param1=10&param2=20 <- 만들어준다
		var params = "seats_idx=" + seats_idx + "&num=" + num;
		
		$.ajax({
			url:'my_study_room_cancel.do',
			type: 'post',
			data: params,
			dataType: 'json',
			success : function(data) {
				console.log(data.result);
				if(data.result == 'success'){
					location.href = "my_study_room_book.do";
				}else{
					alert("작업이 실패하셨습니다. 다시 실행해주세요.");
					location.href = "main.do";
				}
	
			}
		});
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
      <h1>내 예약</h1>
      <div class="scrollable">
        <table class="table">
          <thead>
			<tr>
				<th>시간</th>
				<th>장소</th>
				<th>좌석번호</th>
				<th>비고</th>
			</tr>
		</thead>
		<tr>
			<th>9:00 ~ 12:00</th>
			<c:if test="${ empty t1_seat }">
			  <td colspan="2">예약없음</td>
			  <td></td>
			</c:if>
			<c:if test="${ not empty t1_seat }">
				<c:if test="${ t1_seat.seats_idx < 25 }">
					<td>멀티미디어실</td>
				</c:if>
				<c:if test="${t1_seat.seats_idx > 24 }">
					<td>열람실</td>
				</c:if>
				<td>${ t1_seat.seats_idx }번 </td>
				<td> <button type="button"  class="btn btn-outline-dark btn-lg" onclick="room_cancel(1,'${ t1_seat.seats_idx }');">예약 취소</button></td>
			</c:if>
		</tr>
		<tr>
			<th>12:00 ~ 15:00</th>
			<c:if test="${ empty t2_seat }">
			  <td colspan="2">예약없음</td>
			  <td></td>
			</c:if>
			<c:if test="${ not empty t2_seat }">
				<c:if test="${ t2_seat.seats_idx < 25 }">
					<td>멀티미디어실</td>
				</c:if>
				<c:if test="${t2_seat.seats_idx > 24 }">
					<td>열람실</td>
				</c:if>
				<td>${ t2_seat.seats_idx }번 </td>
				<td> <button type="button"  class="btn btn-outline-dark btn-lg"onclick="room_cancel(2, '${ t2_seat.seats_idx }');">예약 취소</button></td>
			</c:if>
		</tr>
		<tr>
			<th>15:00 ~ 18:00</th>
			<c:if test="${ empty t3_seat }">
			  <td colspan="2">예약없음</td>
			  <td></td>
			</c:if>
			<c:if test="${ not empty t3_seat }">
				<c:if test="${ t3_seat.seats_idx < 25 }">
					<td>멀티미디어실</td>
				</c:if>
				<c:if test="${ t3_seat.seats_idx > 24 }">
					<td>열람실</td>
				</c:if>
				<td>${ t3_seat.seats_idx }번 </td>
				<td> <button type="button" class="btn btn-outline-dark btn-lg" onclick="room_cancel(3, '${ t3_seat.seats_idx }');">예약 취소</button></td>
			</c:if>
		</tr>
        </table>
      </div>
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