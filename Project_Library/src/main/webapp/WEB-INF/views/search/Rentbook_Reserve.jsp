<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript">
	//예약 날짜 선택시 이벤트처리============================================================================================
	$(document).ready(function(){
		$('#rent_Date').on('change',function(){
			var select = this.value;
			var selectArr = select.split('-');
			var day = new Date(selectArr[0], selectArr[1]-1, selectArr[2])
			day = new Date(day.setDate(day.getDate() + 7)).toISOString().split('T')[0];
			document.getElementById("rent_Redate").value = day;
		})
	})

	//예약============================================================================================
  	function rentbook_reserve(){
  		//파라미터 찾기
		var f = document.getElementById("reserve");
  		var rent_Date = f.rent_Date.value;
  		
  		//유효성검사
  		if(rent_Date == ""){
  			alert("날짜를 선택해 주세요 ");
  			return;
  		}
  		
  		f.method = "post";
   		f.action ="user_rentbook_reserve.do?page=${param.page}&rentbook_Isbn=${param.rentbook_Isbn}";
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
      <h6>자료 검색</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="rentbook_search.do">소장자료 검색</a></li>
          <li><a href="rentbook_new_form.do">신규 도서</a></li>
          <li><a href="sellbook_search.do">판매자료 검색</a></li>
        </ul>
      </nav>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- ################################################################################################ -->
    <div class="content three_quarter"> 
      <!-- ################################################################################################ -->
      <h1>책 예약</h1>
      <div class="scrollable">
        <form id="reserve">
        	<input type="hidden" id="rentbook_Name" name="rentbook_Name" value="${rentbook.rentbook_Name}"> 
	        <table border="1" align="center">
	          <tbody>
	            <tr style="border-bottom: 1px solid #D7D7D7;">
	            	<td rowspan="6" style="height: 150px; vertical-align: middle;" align="center">
	              		<img alt="" src="${pageContext.request.contextPath}/resources/images/book_img/${rentbook.rentbook_Isbn}.PNG">
	              	</td>
	            </tr>
	            <tr style="border-top: 1px solid #D7D7D7;">
					<th>
	 					제목 :
	 				</th>
	 				<td>
	 					${rentbook.rentbook_Name}
	 				</td>
				</tr>
	            <tr>
					<th>
	 					ID :
	 				</th>
	 				<td>
	 					${ user.userID }
	 				</td>
				</tr>
				<tr>
					<th>
	 					예약 :
	 				</th>
	 				<td>
	 					예약
	 				</td>
				</tr>
				<tr>
					<th>
	 					대여 날짜 :
	 				</th>
	 				<td>
	 					<p><input id="rent_Date" name="rent_Date" type="date"></p>
	 				</td>
				</tr>
				<tr style="border-bottom: 1px solid #D7D7D7;">
					<th>
	 					반납 날짜 :
	 				</th>
	 				<td>
	 					<p><input id="rent_Redate" name="rent_Redate" type="date" readonly></p>
	 				</td>
				</tr>
				<tr>
					<td colspan="3" align="right">
	 					<a onclick="rentbook_reserve();" title="예약" style="cursor: pointer; color: black;"><i class="fa-calendar-check fa-fw far"></i>예약</a>
	 					<a onclick="history.go(-1)" title="이전화면" style="cursor: pointer; color: black;"><i class="fa-redo fa-fw fas"></i>이전화면</a>
	 				</td>
				</tr>
	          </tbody>
	        </table>
        </form>
        <script>
	        var today = new Date();
	        today = new Date(today.setDate(today.getDate() + 1)).toISOString().split('T')[0];
	        document.getElementById("rent_Date").setAttribute('min', today);
		</script>
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