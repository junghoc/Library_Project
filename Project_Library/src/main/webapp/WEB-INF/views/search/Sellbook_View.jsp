<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="">
<head>
<title>도서관</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="${pageContext.request.contextPath}/resources/common/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	//상품 수량 증가============================================================================================
	function cnt_add(f) {
		f.cart_Cnt.value++;
	}
	
	//상품 수량 감소============================================================================================
	function cnt_del(f) {
		//수량이 1개일경우 감소 되지 않도록한다.
		if(f.cart_Cnt.value == 1){
			return;
		}
		f.cart_Cnt.value--;
	}
	
	//장바구니 폼============================================================================================
	function sellbook_cart(isbn, title, price){
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		//해당 form의 데이터값을  param1=10&param2=20 <- 만들어준다
		var params = $('#cart_form').serialize() + "&sellbook_Isbn=" + isbn + "&sellbook_Name=" + title + "&sellbook_Price=" + price;
		
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
		var params = $('#cart_form').serialize() + "&sellbook_Isbn=" + isbn + "&sellbook_Name=" + title + "&sellbook_Price=" + price;
		
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
        <h1>판매 책 정보</h1>
        <form id="cart_form" name="cart_form">
        <table border="1" align="center">
          <tbody>
            <tr>
              <td rowspan="8" align="center"><img alt="" src="${sellbook[0].image}" style="width:145px; height:208px; "> </td>
            </tr>
            <tr>
				<td>제목 : ${ sellbook[0].title }</td>
			</tr>
			<tr>
				<td>저자 : ${ sellbook[0].author }</td>
			</tr>
			<tr>
				<td>출판사 : ${ sellbook[0].publisher }</td>
			</tr>
			<tr>
				<td>
					출판일 : <fmt:parseDate value='${ sellbook[0].pubdate }' var='trading_day' pattern='yyyymmdd'/>
						  <fmt:formatDate value="${trading_day}" pattern="yyyy.mm.dd"/>
				</td>
			</tr>
			<tr>
				<td>가격 : <fmt:formatNumber value="${ sellbook[0].price }" pattern="###,###원"/></td>
			</tr>
			<tr>
				<td>배송료 : 국내 배송 무료</td>
			</tr>
			<tr>
				<td>
					수량 : <input type="text" id="cart_Cnt" name="cart_Cnt" value="1" size="10" readonly style="display: inline-block; width: 25px;">
					<input type="button" value=" + " onclick="cnt_add(this.form);" style="display: inline-block;">
					<input type="button" value=" - " onclick="cnt_del(this.form);" style="display: inline-block;">
				</td>
			</tr>
			<tr>
				<th align="center" colspan="2">책소개</th>
			</tr>
			<tr>
				<td colspan="2" align="center">${ sellbook[0].description }</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<a onclick="sellbook_cart('${sellbook[0].isbn}','${ sellbook[0].title }','${ sellbook[0].price }');" title="장바구니 담기" style="cursor: pointer; color: black;"><i class="fa-cart-plus fa-fw fas"></i>장바구니 담기</a>
					<a onclick="order_cart('${sellbook[0].isbn}','${ sellbook[0].title }','${ sellbook[0].price }');" title="바로 구매" style="cursor: pointer; color: black;"><i class="fa-won-sign fa-fw fas"></i>바로 구매</a>
					<a onclick="location.href='sellbook_search.do?page=${param.page}&search=${param.search}'" title="목록보기" style="cursor: pointer; color: black;"><i class="fa-list fa-fw fas"></i>목록보기</a>
				</td>
			</tr>
          </tbody>
        </table>
        </form>
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