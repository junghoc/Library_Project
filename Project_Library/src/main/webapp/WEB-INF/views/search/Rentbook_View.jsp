<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="">
<head>
<title>도서관</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="${pageContext.request.contextPath}/resources/common/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script type="text/javascript">
	//예약 폼============================================================================================
	function reserve_lent(){
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		location.href="user_rentbook_reserve_form.do?page=${param.page}&rentbook_Isbn=${param.rentbook_Isbn}";
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
      <div class="scrollable">
        <h1>책 정보</h1>
        <table border="1" align="center">
          <tbody>
            <tr>
              <td rowspan="6" align="center"><img style="width:149px; height:208px;" src="${pageContext.request.contextPath}/resources/images/book_img/${rentbook.rentbook_Isbn}.PNG"> </td>
            </tr>
            <tr>
				<td>제목 : ${rentbook.rentbook_Name}</td>
			</tr>
			<tr>
				<td>저자 : ${rentbook.rentbook_Author}</td>
			</tr>
			<tr>
				<td>출판사 : ${rentbook.rentbook_Company}</td>
			</tr>
			<tr>
				<td>ISBN : ${rentbook.rentbook_Isbn}</td>
			</tr>
			<tr>
				<td>출판일 : ${rentbook.rentbook_Year}</td>
			</tr>
			<tr>
				<th align="center" colspan="2">책소개</th>
			</tr>
			<tr>
				<td colspan="2" align="center">${rentbook.rentbook_Content}</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<c:if test="${ rentbook.rentbook_Reserve eq 1 }">
						<a onclick="reserve_lent();" title="예약" style="cursor: pointer; color: black;"><i class="fa-calendar-check fa-fw far"></i>예약</a>
					</c:if>
					<a onclick="location.href='rentbook_search.do?page=${param.page}'" title="목록보기" style="cursor: pointer; color: black;"><i class="fa-list fa-fw fas"></i>목록보기</a>
				</td>
			</tr>
          </tbody>
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