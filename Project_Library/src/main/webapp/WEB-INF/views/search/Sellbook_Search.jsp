<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="">
<head>
<title>도서관</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link
	href="${pageContext.request.contextPath}/resources/common/layout/styles/layout.css"
	rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/common/css/font.css"
	media="all">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/common/css/booksearch.css"
	media="all">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	//엔터키============================================================================================
	function enterkeydown() {
		if( event.keyCode == 13 ){
			//엔터키 눌렀을때 실행할 내용
			send();
		}
	}
	
	//컬럼별 내용검색============================================================================================
	function sellbook_send(){
		var ff = document.getElementById("sellbook_search");
		var search = ff.search.value;
		//유효성검사
		if( search == ''){
			alert("검색할 내용을 입력하세요");
			return;
		}
		ff.method = "get";
		ff.action = "sellbook_search.do";
		ff.submit();
	}
	
	//장바구니 폼============================================================================================
	function sellbook_cart(isbn, title, price){
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		//해당 form의 데이터값을  param1=10&param2=20 <- 만들어준다
		var params = $('#sellbook_page').serialize() + "&sellbook_Isbn=" + isbn + "&sellbook_Name=" + title + "&sellbook_Price=" + price;
		
		$.ajax({
			url:'user_sellbook_cart.do',
			type: 'post',
			data: params,
			dataType: 'json',
			success : function(data) {
				console.log(data.result);
				if(data.result == 'success'){
					if(confirm("장바구니 창으로 가시겠습니까?")){
						location.href = "user_sellbook_cart_form.do";
					}
				}else{
					alert("작업이 실패하셨습니다. 다시 실행해주세요.");
					location.href = "sellbook_search.do";
				}
	
			}
		});
	}	
	
	//바로주문 폼============================================================================================
	function order_cart(isbn, title, price){
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		//해당 form의 데이터값을  param1=10&param2=20 <- 만들어준다
		var params = $('#sellbook_page').serialize() + "&sellbook_Isbn=" + isbn + "&sellbook_Name=" + title + "&sellbook_Price=" + price;
		
		$.ajax({
			url:'user_sellbook_cart.do',
			type: 'post',
			data: params,
			dataType: 'json',
			success : function(data) {
				console.log(data.result);
				if(data.result == 'success'){
					location.href = "user_sellbook_cart_form.do";
				}else{
					alert("작업이 실패하셨습니다. 다시 실행해주세요.");
					location.href = "sellbook_search.do";
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
	<jsp:include page="../Library_Menu_Top.jsp" />
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<div class="wrapper bgded overlay"
		style="background-image:url('${pageContext.request.contextPath}/resources/images/backgrounds/background.jpg');">
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
					<h1>판매자료 검색</h1>
					<form name="sellbook_search" id="sellbook_search">
						<div class="board-search mtp10">
							<span>검색항목</span> <input type="text" id="search" name="search"
								onkeydown="enterkeydown();"
								class="text form-control form-inline w400"
								placeholder="검색어를 입력하세요"> <a
								onclick="sellbook_send();" title="검색" class="btn-d">검색</a>
						</div>
					</form>
					<div class="board-list mtp20">
						<c:if test="${ !empty sellbook_list }">
							<form name="sellbook_page" id="sellbook_page">
								<input type="hidden" id="cart_Cnt" name="cart_Cnt" value="1">
								<table>
									<thead>
										<tr>
											<th class="field" align="center" width="10%">이미지</th>
											<th class="field" align="center" width="19%">제목</th>
											<th class="field" align="center" width="12%">저자</th>
											<th class="field" align="center" width="9%">출판사</th>
											<th class="field" align="center" width="10%">가격</th>
											<th class="field" align="center" width="9%">비고</th>
										</tr>
									</thead>
									<c:forEach var="sellbook" items="${ sellbook_list }">
										<tbody style="border: none; border-bottom: 1px solid #D7D7D7;">
											<tr width="350">
												<td align="center"><a
													href="sellbook_view.do?page=${param.page}&sellbook_Isbn=${ sellbook.isbn }&search=${param.search}"
													style="color: black;"><img src="${sellbook.image}"></a>
												</td>
												<td align="center"
													style="vertical-align: middle; color: black;"><a
													href="sellbook_view.do?page=${param.page}&sellbook_Isbn=${ sellbook.isbn }&search=${param.search}"
													style="color: black;"> ${ sellbook.title }</a></td>
												<td align="center" style="vertical-align: middle;">${ sellbook.author }
													지음</td>
												<td align="center" style="vertical-align: middle;">${ sellbook.publisher }
												</td>
												<td align="center" style="vertical-align: middle;"><fmt:formatNumber
														value="${ sellbook.price }" pattern="###,###원" /></td>
												<td align="center" style="vertical-align: middle;"><a
													onclick="order_cart('${ sellbook.isbn }','${ sellbook.title }', '${ sellbook.price }');"
													class="btn-d btn-main" title="바로 구매"
													style="margin-bottom: 5px;">바로 구매</a> <a
													onclick="sellbook_cart('${ sellbook.isbn }','${ sellbook.title }', '${ sellbook.price }');"
													class="btn-d btn-main" title="장바구니에 담기">장바구니에 담기</a></td>
											</tr>
										</tbody>
									</c:forEach>
									<tr align="center">
										<td colspan="7" style="border-top: 1px solid #D7D7D7;">
											${ pageMenu }</td>
									</tr>
								</table>
							</form>
						</c:if>
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
	<jsp:include page="../Library_Menu_Footer.jsp" />
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<!-- ################################################################################################ -->
	<a id="backtotop" href="#top"><i class="fas fa-chevron-up"></i></a>
	<!-- JAVASCRIPTS -->
	<script
		src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.backtotop.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>