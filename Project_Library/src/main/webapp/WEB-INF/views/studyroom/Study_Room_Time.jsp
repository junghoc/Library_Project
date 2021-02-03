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
<script>

	//선택좌석 예약하기============================================================================================
	function time_book(f){	//유효성 검사 작성해야함
		//체크박스 재대로 되는지 확인(스프링은 자동적으로 같은이름을 form으로 넘길시 자동적으로 리스트화 하여서 받을수있다.)
		if($("input:checkbox[name=time]:checked").length == 0){
			alert("예약할 시간을 선택해주세요");
			return;
		}
		//배열 선언
		var check_arr = [];
		//체크된 값을 array에 저장
		$('input[name="time"]:checked').each(function(i){//체크된 리스트 저장
			check_arr.push($(this).val());
        });
		for(var i = 0; i < check_arr.length; i++){
			console.log(check_arr[i]);
		}
		alert("넘어간다잉");
		
		f.action="room_time_book.do";
		f.submit();
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
      <h1>Select_Time</h1>
      <form id="time_book">
      	<input type="hidden" id="seats_idx" name="seats_idx" value="${seat.seats_idx}">
		<table border="1">
		<tr>
			<th>${seat.seats_idx}번 좌석</th>
		</tr>
		<tr>
			<td>
				<c:if test="${hour < 12 or hour >= 18}">
					<c:if test="${seat.t1_user_id eq null}">
						<input type="checkbox" name="time" value="1" >9시 ~ 12시
					</c:if>
					<c:if test="${seat.t1_user_id ne null}">
						<input type="checkbox" disabled><del>9시 ~ 12시</del>
					</c:if>
				</c:if>
				<c:if test="${hour >= 12 and hour < 18 }">
					<input type="checkbox" disabled><del>9시 ~ 12시</del>
				</c:if>
			
				<c:if test="${hour < 15 or hour >= 18}">
					<c:if test="${seat.t2_user_id eq null}">
						<input type="checkbox" name="time" value="2" >12시 ~ 15시
					</c:if>
					<c:if test="${seat.t2_user_id ne null}">
						<input type="checkbox" disabled><del>12시 ~ 15시</del>
					</c:if>
				</c:if>
				<c:if test="${hour >= 15 and hour < 18}">
					<input type="checkbox" disabled><del>12시 ~ 15시</del>
				</c:if>

				<c:if test="${seat.t3_user_id eq null}">
					<input type="checkbox" name="time" value="3">15시 ~ 18시
				</c:if>
				<c:if test="${seat.t3_user_id ne null}">
					<input type="checkbox" disabled><del>15시 ~ 18시</del>
				</c:if>
			
			</td>
		</tr>
		<tr>
			<td><input type="button" value="예약하기" onclick="time_book(this.form);"></td>
		</tr>
	</table>
	  </form>
		<p align="right">
		<a onclick="history.go(-1)" title="뒤로가기" style="cursor: pointer; color:black;"><i class="fa-redo fa-fw fas"></i>뒤로 가기</a>
		</p>		
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