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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/order_finish.css" media="all">
<script type="text/javascript">
	//다음에서 주소검삭하는 기능============================================================================================
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            
	            var addr = ''; 
	            var extraAddr = ''; 
	            
	            if (data.userSelectedType === 'R') { 
	                addr = data.roadAddress;
	            } else { 
	                addr = data.jibunAddress;
	            }    
	            
	            document.getElementById('address1_one').value = data.zonecode;
	            document.getElementById("address2_one").value = addr;            
	            document.getElementById("address3_one").focus();
	        }
	    }).open();
	}
	
	//시작과 동시에 total에 값 넣기============================================================================================
	window.onload = function () {
		document.getElementById('address1_one').value = '${user.address1}';
		document.getElementById('address2_one').value = '${user.address2}';
		document.getElementById('address3_one').value = '${user.address3}';
		document.getElementById('userName_one').value = '${user.userName}';
		document.getElementById('tel_one').value = '${user.tel}'
	}
		
	//checkbox의 체크 확인여부에따라 값 변경============================================================================================
	var addrcheck = true;
	function howdeliver(event) {
		var address1_one = document.getElementById('address1_one');
		var address2_one = document.getElementById('address2_one');
		var address3_one = document.getElementById('address3_one');
		var userName_one = document.getElementById('userName_one');
		var tel_one = document.getElementById('tel_one');
		//alert(event.target.value);
		if(event.target.value == "MEMBER"){
			//회원정보 동일 선택
			address1_one.value = '${user.address1}';
			address2_one.value = '${user.address2}';
			address3_one.value = '${user.address3}';
			userName_one.value = '${user.userName}';
			tel_one.value = '${user.tel}'
			addrcheck = true;
		}else if(event.target.value == "NEW"){
			//회원정보 동일 선택
			address1_one.value = "";
			address2_one.value = "";
			address3_one.value = "";
			//유저이름을 찾지 못해서 아이디를 직접검색 후 값을 넣어줌.
			document.getElementById('userName_one').value = "";
			tel_one.value = "";
			addrcheck = false;
		}
	}
	
	//주문하기============================================================================================
	var payAgree = false;
	function books_order() {
		var chkPayAgree = document.getElementById('chkPayAgree');
		if(!chkPayAgree.checked){
			alert("구매 동의를 체크해주시기 바랍니다.");
			return;
		}
		
		var address1_one = document.getElementById('address1_one').value;
		var address2_one = document.getElementById('address2_one').value;
		var address3_one = document.getElementById('address3_one').value;
		var userName_one = document.getElementById('userName_one').value;
		var tel_one = document.getElementById('tel_one').value;
		
		//주소 새로입력
		if(addrcheck = false){
			//유효성 검사
			if( address1_one == "" || address3_one == ""){
				alert("주소를 입력해 주세요");
				return;
			}
			if( tel_one == "" ){
				alert("전화번호를 입력해 주세요");
				return;
			}
			
		}
		
		//결제 수단 선택
		var rdoPaymentMethod = $('input[name=rdoPaymentMethod]:checked').val();
		//alert(rdoPaymentMethod);
		if(rdoPaymentMethod == 2){
			window.name = "kakaopay";
			var total = '${total}';
			var openWin = window.open(
					'kakaoPay.do?check_arr=${param.check_arr}&userID=${user.userID}&orders_Amount='
					+ total + '&userName_one=' + userName_one + '&tel_one=' + tel_one + '&address1_one=' + address1_one
					+ '&address2_one=' + address2_one + '&address3_one=' + address3_one,
					'existId','left=500, top=100, width=1000,height=1000,toolboars=no,resizble=no,scrollbars=yes');
		}	

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
      <div class="scrollable">
        <h1>구매완료</h1>
        	<div id="yesWrap" class="">
		<div id="wrapperContent">
			<!-- // prgress bar & 나의 계좌 -->
			<div class="progbar" style="margin-bottom: 0px;">
				<h1 class="finish">카트 &gt; 결제 &gt; <strong>완료</strong></h1>
			</div>
			<!--  prgress bar & 나의 계좌 // -->

			<!--// 완료 메세지 -->
			<div class="fns_t_w">
				<h2 class="fns_t"><span class="msgl">${user.userName}<p style="display: inline-block; color: black;">님, 항상 도서관을 이용해주셔서 감사합니다!</p></span><span class="msgr"></span></h2>
				<p class="ordnum" id="txtcoupUseDAfter" onclick="">[주문번호 : <strong>${ orders_vo.orders_Invoice }</strong>] 결제가 안전하게 처리되었습니다.</p>									
			</div>
			<!-- 완료 메세지 //-->

			<!-- 코로나 배송 지연 메시지 영역 시작 -->
			<div class="odrDeliMsg">
				<dl>
					<dt>코로나19로 인한 배송지연</dt>
					<dd>
						코로나19 확산으로 배송 물량이 급증하여 평소보다 배송이 다소 지연될 수 있습니다.<br>
						택배 기사님이 조금 늦게 방문하시더라도 고객님들의 넓은 양해 부탁드립니다.
					</dd>
				</dl>
			</div>
			<!-- 코로나 배송 지연 메시지 영역 끝 -->
			
			<!-- // 배송지 정보   -->
			<div class="dlv_adrs_w">
				<h3 style=""><span class="tbl_t dlv_adrsinf">배송지 정보</span></h3>
				<div class="dlv_adrs_bx" style="">
					<ul class="dlv_l" id="divNormalDlv" style="padding-left: 0px;">
						<li>받는 분 : 최정호</li>
						<li class="clearfix" style="height: 20px;">
							<div class="putAddrLiLft">
								주소 
							</div>
							<div class="putAddrLiRgt">
								<span class="putAddrArea clearfix" style="vertical-align:middle">
									<em class="putAddrTxt">: (${ orders_vo.address1_one }) ${ orders_vo.address2_one }, ${ orders_vo.address3_one }</em>
								</span>
							</div>
						</li>
					</ul>		
				</div>
			</div>
			<!--  // 배송지 정보  -->
	
			<!--// 주문상품 -->
			<div class="fns_tbl_w">
				<h3><span class="tbl_t ord_pd">주문상품</span></h3>
				<table class="tbl_l fns_tbl_l" style="border-left: 0px; border-right: 0px;">
					<colgroup>
						<col width="140">
						<col width="90">
						<col width="40">
						<col width="90">
						<col width="50">
					</colgroup>
					<thead>
						<tr>
							<th style="border-left: 0px; border-right: 0px;">
								<em class="name">상품명</em>
							</th>
							<th style="border-left: 0px; border-right: 0px;">
								<em class="fpri">정가</em>
							</th>
							<th style="border-left: 0px; border-right: 0px;">
								<em class="numb">수량</em>
							</th>
							<th style="border-left: 0px; border-right: 0px;">
								<em class="tota">합계</em>
							</th>
							<th style="border-left: 0px; border-right: 0px;">
								<em class="tota">비고</em>
							</th>
						</tr>
					</thead>
					<c:forEach var="cart" items="${ cart_list }" >
						<tbody>
							<tr class="last"> 
								<td class="le" style="border-left: 0px; border-right: 0px;">
									<a href="sellbook_view.do?sellbook_Isbn=${ cart.sellbook_Isbn }&page=1&search=" class="pd_a">[도서]<br>
									${ cart.sellbook_Name }</a>            
								</td>
								<td style="border-left: 0px; border-right: 0px;">
									<fmt:formatNumber value="${ cart.sellbook_Price }" pattern="###,###원"/>
								</td>
								<td style="border-left: 0px; border-right: 0px;">${ cart.cart_Cnt }</td>
								<td style="border-left: 0px; border-right: 0px;">
									<strong><fmt:formatNumber value="${ cart.sellbook_Price * cart.cart_Cnt }" pattern="###,###원"/></strong>
								</td>
								<td style="border-left: 0px; border-right: 0px;">
									<c:if test="${ orders_vo.orders_Check eq 1 }">
										배송 중
									</c:if>
									<c:if test="${ orders_vo.orders_Check eq 0 }">
										배송 완료
									</c:if>
								</td>
							</tr>
						</tbody>
					</c:forEach>
				</table>
			</div>
			<!--// 결제정보 -->
	
			<!--// 결제정보 세부 -->
			<div class="payinf_w">
				<h3><span class="tbl_t payinf">결제정보</span></h3>	
				
				<!-- #################### 상품 최종 결제금액 시작  #################### -->
				<div class="calcTbArea mgb0">
					<table style="height: 79px; width: 640px;">
						<colgroup>
							<col width="*">
							<col span="2" width="213">
						</colgroup>
						<thead style="width: 640px;">
							<tr>
								<th scope="col" style="width: 213px;">총 상품금액</th>
								<th scope="col" style="width: 213px;">총 추가금액</th>
								<th scope="col" class="saleCol" style="width: 213px;">총 할인금액</th>
							</tr>
						</thead>
						<tbody style="width: 640px;">
							<tr>
								<td style="height: 39px;">
									<em class="yes_b" style="width: 213px;"><fmt:formatNumber value="${ orders_vo.orders_Amount }" pattern="###,###"/></em>원
									<em class="icon_settle ico_settle_plus">+</em>
								</td>
								<td style="z-index: 3;">
									<em class="yes_b" style="width: 213px;">0</em>원
									<em class="icon_settle ico_settle_minus">+</em>
								</td>
								<td class="saleCol">
									<em class="yes_b" style="width: 213px;">0</em>원
									<em class="icon_settle ico_settle_equal">+</em>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="calcTotBox">
						<div class="calcTotBoxTb">
							<div class="calcTotBoxCell">
								<p class="cell_tit">최종 결제금액</p>
								<p class="cell_price"><em class="yes_b"><fmt:formatNumber value="${ orders_vo.orders_Amount }" pattern="###,###"/></em>원</p>
							</div>
						</div>
					</div>
				</div>
				<!-- #################### 상품 최종 결제금액 끝  #################### -->

				<p class="noti">주문내역은 마이페이지에서 다시 확인 하실 수 있습니다.</p>
			</div>
			<!-- 결제정보 // -->
	
			<!--// 주문버튼 -->
			<div class="btn_area">
				<a href="user_sellbook_search_form.do"><img src="https://secimage.yes24.com/sysimage/orderN/b_goMypage.gif" alt="마이페이지로 이동"></a>
				<a href="main.do"><img src="https://secimage.yes24.com/sysimage/orderN/b_goMain.gif" alt="메인으로 이동"></a>
			</div>
			<!-- 주문버튼 //-->

		</div>
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