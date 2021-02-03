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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/font.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/booksearch.css" media="all">	
<script type="text/javascript">
	//엔터키============================================================================================
	function enterkeydown() {
		if( event.keyCode == 13 ){
			//엔터키 눌렀을때 실행할 내용
			send();
		}
	}
	
	//컬럼별 내용검색============================================================================================
	function send(){
		var ff = document.getElementById("rentbook_searchform");
		var curlum = ff.curlum.value;
		var search = ff.search.value.trim();
		//유효성검사
		if( search == ''){
			alert("검색할 내용을 입력하세요");
			return;
		}
		ff.method = "get";
		ff.action = "rentbook_search_curlum.do";
		ff.submit();
	}
	
	//예약 폼============================================================================================
	function reserve_lent(rentbook_Isbn){
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		location.href="user_rentbook_reserve_form.do?page=${param.page}&rentbook_Isbn=" + rentbook_Isbn;
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
      <div class="scrollable" style="width: 1000px;">
        <h1>소장자료 검색</h1>
        <form name="rentbook_searchform" id="rentbook_searchform">		
			<div class="board-search mtp10">
				<span>검색항목</span>
				<select name="curlum" class="text form-control form-inline w100 mlp10">
					<option value="" selected="selected">검색항목</option>
					<option value="rentbook_Name" <c:if test="${param.curlum eq 'rentbook_Name'}"> selected="selected"</c:if>>책이름</option>
					<option value="rentbook_Category" <c:if test="${param.curlum eq 'rentbook_Category'}"> selected="selected"</c:if>>카테고리</option>
					<option value="rentbook_Company" <c:if test="${param.curlum eq 'rentbook_Company'}"> selected="selected"</c:if>>출판사</option>
					<option value="rentbook_Author" <c:if test="${param.curlum eq 'rentbook_Author'}"> selected="selected"</c:if>>저자</option>
				</select>
				<input type="text" name="search" onkeydown="enterkeydown();" class="text form-control form-inline w400" placeholder="검색어를 입력하세요">		 
				<a onclick="send();" title="검색" class="btn-d">검색</a>
			</div>			
			<div class="clearfix">
				<p class="left mtp20">
					검색결과 ${book_count}건 검색
				</p>	
			</div>
		</form>
		<div class="board-list mtp20">
		<form name="searchPage">
			<table>
				<thead><tr>
					<th class="field" align="center" width="10%">이미지</th>
					<th class="field" align="center" width="19%">제목</th>
					<th class="field" align="center" width="12%">저자</th>
					<th class="field" align="center" width="9%">출판사</th>
					<th class="field" align="center" width="7%">카테고리</th>
					<th class="field" align="center" width="7%">자료상태</th>
					<th class="field" align="center" width="5%">예약</th>
				</tr></thead>
				<c:forEach var="rentbook" items="${ rentbook_list }">
					<tbody style="border : none; border-bottom:1px solid #D7D7D7; "><tr width="350">
						<td align="center">
							<a href="rentbook_view.do?page=${param.page}&rentbook_Isbn=${rentbook.rentbook_Isbn}" style="color: black;"><img src="${pageContext.request.contextPath}/resources/images/book_img/${rentbook.rentbook_Isbn}.PNG" style="height:190px; width: 133px;"></a>
						</td>
						<td align="center" style="vertical-align: middle; color: black;">
							<a href="rentbook_view.do?page=${param.page}&rentbook_Isbn=${rentbook.rentbook_Isbn}" style="color: black;">
								${ rentbook.rentbook_Name }</a>
						</td>
						<td align="center" style="vertical-align: middle;">
							${ rentbook.rentbook_Author } 지음
						</td>
						<td align="center" style="vertical-align: middle;">
							${ rentbook.rentbook_Company }
						</td>
						<td align="center" style="vertical-align: middle;">
							${ rentbook.rentbook_Category }
						</td>
						<td align="center" style="vertical-align: middle;">
							<c:if test="${rentbook.rentbook_Reserve eq 1}">
								대출가능
							</c:if>
							<c:if test="${rentbook.rentbook_Reserve ne 1}">
								대출불가
							</c:if>
						</td>
						<td align="center" style="vertical-align: middle;">
							<c:if test="${rentbook.rentbook_Reserve eq 1}">
								<a onclick="reserve_lent('${rentbook.rentbook_Isbn}');" class="btn-d btn-main">예약</a>
							</c:if>
						</td>
					</tr></tbody>
				</c:forEach>
				<tr align = "center">
					<td colspan = "7" style="border-top: 1px solid #D7D7D7;"> 
						${ pageMenu }
					</td>
				</tr>
			</table>
		</form>
		</div>
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