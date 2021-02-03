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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/order.css" media="all">
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
        <h1>구매도서</h1>
        	<div id="yesWrap" class="">
		<div id="wrapperContent">	
			<div class="progbar">
			<h1 class="pay">카트 &gt; <strong>결제</strong> &gt; 완료</h1>
			</div>
		
			<div id="divGoodsOrderDetail" style="">
				<!--// 상품확인 -->
				<div id="divGoods">
					<h3><span class="tbl_t pdchk">상품확인</span></h3>
					<table class="tbl_l fns_tbl_l">
						<colgroup>
							<col width="140">
							<col width="90">
							<col width="70">
							<col width="90">
							<col width="80">
						</colgroup>
						<thead>
							<tr>
								<th>
									<em class="name">상품명</em>
								</th>
								<th>
									<em class="fpri">정가</em>
								</th>
								<th>
									<em class="numb">수량</em>
								</th>
								<th>
									<em class="tota">합계</em>
								</th>
								<th>
									<em class="ddat">배송일</em>
								</th>
							</tr>
						</thead>
						<c:forEach var="cart" items="${ cart_list }" varStatus="status">
						<input type="hidden" name="cart_idx" value="${ cart.cart_idx }">
							<tbody>
								<tr class="last">
									<td class="le">
										<a href="" class="pd_a">[도서] <br> 
											${ cart.sellbook_Name }
										</a>
									</td>
									<td>
										<fmt:formatNumber value="${ cart.sellbook_Price }" pattern="###,###원"/>
									</td>
									<td>${ cart.cart_Cnt }</td>
									<td>
										<strong><fmt:formatNumber value="${ cart.sellbook_Price * cart.cart_Cnt }" pattern="###,###원"/></strong>
									</td>
									<td>
										<p class="dvmsg">내일<br>도착예정</p>
									</td>
								</tr>
							</tbody>
						</c:forEach>
					</table>
					<div class="dlvifo_w2 dbr_none" style="">
						<div class="dlvifo_tw">
							<h3 class="dlvifo_t">배송일 안내</h3>
						</div>
						<div class="dlv_w">
							<ul class="dlv_l">
								<li id="lblDeliveryDatePaymentYes24Dom">예스24배송 : 내일 도착예정</li>
							</ul>
							<p class="noti">날씨나 택배사 사정에 따라 배송이 지연될 수 있습니다.</p>        
						</div>
					</div>

					<ul class="info_w mgt10">
						<li><strong>도서정가제 대상 도서는 최대 10% 할인 + 5% 적립 혜택 가능</strong> (쿠폰은 최대 할인 및 적립 범위 내에서만 적용 가능)</li>	
						<li><strong>5만원 이상 구매시 2천원 추가적립 :</strong> 외국도서(eBook 포함), 잡지, CD/LP, DVD/Blu-ray, 문구/GIFT, 중고도서 2천원 이상 포함 시 </li>
					</ul>

					<!-- #################### 상품 최종 결제금액 시작  #################### -->
					<div class="calcTbArea mgb0">
						<table style="width: 640px;">
							
							<colgroup>
								<col width="*">
								<col span="2" width="213">
							</colgroup>
							<thead style="width: 639px; height: 40px;">
							<tr>
								<th scope="col" style="width: 213px; height: 40px;">총 상품금액</th>
								<th scope="col" style="width: 213px; height: 40px;">총 추가금액</th>
								<th scope="col" style="width: 213px; height: 40px;" class="saleCol">총 할인금액</th>
							</tr>
							</thead>
							
							<tbody style="width: 639px; height: 40px;">
							<tr>
								<td>
									<em class="yes_b"><fmt:formatNumber value="${ total }" pattern="###,###"/></em>원
									<em class="icon_settle ico_settle_plus">+</em>
								</td>
								<td style="z-index: 3;">
									<em class="yes_b" id="txtTotalDelvFare">0</em>원
									<em class="icon_settle ico_settle_minus">+</em>
								</td>
								<td class="saleCol">
									<em class="yes_b" id="txtSaleAmount">0</em>원
									<em class="icon_settle ico_settle_equal">+</em>
								</td>
							</tr>
							</tbody>
						</table>
						<div class="calcTotBox">
							<div class="calcTotBoxTb">
								<div class="calcTotBoxCell">
									<p class="cell_tit" style="margin-top: 5px; margin-bottom: 5px;">최종 결제금액</p>
									<p class="cell_price"><em class="yes_b" id="txtTotalAmount"><fmt:formatNumber value="${ total }" pattern="###,###"/></em>원</p>
								</div>
							</div>
						</div>
					</div>
					<!-- #################### 상품 최종 결제금액 끝  #################### -->
				</div>
	
				<!-- // 배송주소 -->
				<div id="divDelvAddr" class="pay_w" style="margin-top: 10px;">
					<h3><span class="tbl_t dlv_address">배송주소</span></h3>
					<div class="col2">
						<div class="inf_mem">
							<h4 class="tbl_t">주문고객</h4>
							<hr style="width: 280px;">
							<table cellpadding="0" cellspacing="0" class="tbl_pay" style="border:none; border-right:0px; boder-left:0px; boder-bottom:0px; border-top:2px;">
								<tbody><tr>
									<td style="width: 75px; color: #3a85c8; border-right:0px; border-left: 0px; background:#ffffff;">
										이름
									</td>
									<td style="border-right:0px; border-left: 0px; background:#ffffff;">
										<input type="text" id="userName" name="userName" class="ipubx" value="${ user.userName }">
									</td>
								</tr>
								<tr>
									<td style="width: 75px; color: #3a85c8; border-right:0px; border-left: 0px; background:#ffffff;">
										핸드폰
									</td>
									<td class="num_p" style="border-right:0px; border-left: 0px; background:#ffffff;">
										<input type="text" id="tel" name="tel" class="ipubx" maxlength="20" style="width: 190px;" value="${ user.tel }">								
									</td>
								</tr>	
								<tr>
									<td style="width: 75px; color: #3a85c8; border-right:0px; border-left: 0px; background:#ffffff;">
										이메일
									</td>
									<td class="eml_w" style="border-right:0px; border-left: 0px; background:#ffffff;">
										<input type="text" id="email1" name="email1" class="ipubx" value="${ user.email1 }" style="display:inline-block; width:85px;">
										@
										<input type="text" id="email2" name="email2" class="ipubx" value="${ user.email2 }" style="display:inline-block; width:85px;">
									</td>
								</tr>
							</tbody></table>
						</div>

						<table cellpadding="0" cellspacing="0" class="tbl_pay" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
							<tbody><tr>
								<td style="width: 115px; color: #3a85c8; border-right:0px; border-left: 0px; ">배송방법</td>
								<td class="dlv_mtd" style="border-right:0px; border-left: 0px; background: #ffffff;">
								<div style="">
									<span class="rdb_w"><label><input type="radio" id="rdoDelvGbNormal" name="rdoDelvGb" value="Normal" class="rdbtn" checked="checked" style="display:inline-block;"> 일반택배</label></span>
								</div></td>
							</tr>
						</tbody></table>
						<div class="scard_w" style="width: 640px;">
							<table cellpadding="0" cellspacing="0" class="tbl_pay" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
								<tbody><tr id="tr_delv_addr">
									<td style="width: 115px; color: #3a85c8; border-right:0px; border-left: 0px; ">
										배송지
									</td>
									<td class="dlv_adrs" style="border-right:0px; border-left: 0px; background: #ffffff;">
										<span class="rdb_w"><input type="radio" id="rdoDelvAddrSetModeMember" name="rdoDelvAddrSetMod" onclick="howdeliver(event);" value="MEMBER" class="rdbtn" style="display:inline-block;" checked="checked"> 회원정보동일</span>
										<span class="rdb_w"><input type="radio" id="rdoDelvAddrSetModeNew" name="rdoDelvAddrSetMod" onclick="howdeliver(event);" value="NEW" class="rdbtn" style="display:inline-block;"> 새로입력</span>
									</td>
								</tr>
							</tbody></table>
						</div>
						<table cellpadding="0" cellspacing="0" class="tbl_pay" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
							<tbody><tr id="trOrdNmNormal" style="">
								<td style="width: 115px; color: #3a85c8; border-right:0px; border-left: 0px; ">
									이름
								</td>
								<td style="border-right:0px; border-left: 0px; background: #ffffff;">
									<input id="userName_one" name="userName_one" type="text" class="ipubx">
								</td>
							</tr>
							<tr id="trDelvAddrNormal" style="">
								<td style="width: 115px; color: #3a85c8; border-right:0px; border-left: 0px; ">
									배송주소
								</td>
								<td style="border-right:0px; border-left: 0px; background: #ffffff;">
									<input type="text" id="address1_one" name="address1_one" class="ipubx" size="7" onclick="execDaumPostcode();" readonly="readonly" style="display:inline-block;">
									<a onclick="execDaumPostcode();" title="주소 찾기" class="bw sch_address" id="aZipFind">주소 찾기</a><br>
									<p style="margin:5px 0;">도로명 주소 <input type="text" id="address2_one" name="address2_one" onclick="execDaumPostcode();" class="ipubx" style="width:320px;vertical-align:middle;" readonly="readonly"></p>
									<p style="line-height:20px;">
										상세 주소&nbsp;&nbsp;&nbsp; <input type="text" id="address3_one" name="address3_one" class="ipubx" style="width:320px;vertical-align:middle;">
									</p>
									<p class="nt">주소/우편번호 체계가 새롭게 변경되었습니다. <br>정확하고 빠른 배송을 위해 입력된 주소를 확인하시고 업데이트 해주시기 바랍니다.</p>
									
								</td>
							</tr>
							<tr id="trDelvMobNoNormal" style="">
								<td style="width: 110px; color: #3a85c8; border-right:0px; border-left: 0px; ">
									핸드폰
								</td>
								<td class="num_p" style="height: 22px; border-right:0px; border-left: 0px; background: #ffffff;">
									<input type="text" id="tel_one" name="tel_one" class="ipubx" maxlength="4" style="width:320px;">
									<span class="nt" style="padding-left: 0px; margin-top: 10px;">연락처는 하나만 입력하셔도 결제가 가능합니다.</span>
								</td>
							</tr>				
						</tbody></table>		
					</div>			
				</div>
				<!-- 배송주소 // -->
			
				<!-- // 결제방법 -->
				<div class="pay_w">
					<h3>
						<span class="tbl_t paym_t" id="lblOrderPaymentMethodTitle">결제방법</span>		
					</h3>
					<div class="col2">
						<div class="added_w" id="divPayMethodValues" style="margin-top: -8px;">
							<div style="" class="added">
								<table cellpadding="0" cellspacing="0" class="tbl_pay" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
									<tbody><tr style="">
										<td style="width: 75px; color: #3a85c8; border-right:0px; border-left: 0px; background: #ffffff;">
											영수증
										</td>
										<td style="border-right:0px; border-left: 0px; background: #ffffff;">
											<span class="rdb_w" style="display:inline-block; width:75px;">
												<label><input type="radio" id="rdoCashRecptPubY" value="Y" name="rdoCashRecptPub" class="rdbtn" checked="checked" style="display:inline-block;"> 가격표시</label>
											</span>
											<label style="display:inline-block;"><input type="radio" id="rdoCashRecptPubN" name="rdoCashRecptPub" value="N" onclick="" class="rdbtn" style="display:inline-block;"> 가격 표시 안함</label>
										</td>
									</tr>
									<tr style="">
										<td style="width: 75px; color: #3a85c8; border-right:0px; border-left: 0px; background: #ffffff;">
											택배사<br>직원에게
										</td>
										<td class="eml_w" style="border-right:0px; border-left: 0px; background: #ffffff;">
											<input type="text" id="txtDelvMsg" value="" class="ipubx" maxlength="25">
											<span class="info11">택배회사 송장에 출력되는 메세지입니다.<br>예: 부재시 경비실에 맡겨주세요</span>
										</td>
									</tr>
									<tr>
										<td style="width: 75px; color: #3a85c8; border-right:0px; border-left: 0px; background: #ffffff;">받는분께<br>메세지</td>
										<td class="eml_w" style="border-right:0px; border-left: 0px; background: #ffffff;">
											<input type="text" id="txtPostMsg" value="" class="ipubx" maxlength="36">
											<span class="info11">받는분께 메세지는 영수증 상단에 출력<br>공백포함 36자 가능</span>
										</td>
									</tr>
								</tbody></table>
							</div>
							<!-- 부가옵션 // -->

							<!-- 최종결제금액 -->
							<div class="final_pay" id="divFinalPay" style="height: 69px;">
								<span class="prc_t">최종결제 금액 :</span>
								<span id="spnOrderAmount" class="prc"><em><fmt:formatNumber value="${ total }" pattern="###,###원"/></em></span>							
							</div>
							<div class="agree_pay">
								<p class="txt_agtee_pay" style="font-size:12px;">주문하실 상품, 가격, 배송정보, 할인정보 등을 확인하였으며, 구매에 동의하시겠습니까?</p>
								<p style="font-size:12px;"><input type="checkbox" id="chkPayAgree" name="chkPayAgree" class="chkbx" style="display:inline-block;"> <label for="chkPayAgree" style="display:inline-block;"><strong>동의합니다.</strong></label> (전자상거래법 제 8조 제2항)</p>
							</div>
							<!-- 최종결제금액 -->
							<div class="btn_area">
								<a id="btnPayment" onclick="books_order();">
									<img src="https://secimage.yes24.com/sysimage/orderN/b_pay.gif" alt="결제하기">
								</a>
							</div>
						</div>
					
						<!-- ############################################################ 결제수단 선택 영역 시작 ############################################################ -->
						<div id="settleTpWrap" class="settleTpArea" style="">
							<!-- ######################### 일반 결제수단 선택 영역 시작 ######################### -->
							<div id="settleTp_nor" class="settleTpGrp selectOn">
								<div class="settleTpGrp_tit" style="width: 640px; height: 60px; line-height: 60px; padding-left: 19px;">
									<span class="settleTpTxt" style="font-size: 14px; font-weight: bold;">다른 결제 수단</span>	
								</div>
								<div class="settleTpGrp_cont">
									<!--// 카드사 선택 -->
									<div class="scard_w" style="width: 640px;">
										<table cellpadding="0" cellspacing="0" class="tbl_pay tbl_scard" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
										<tbody>
											<!-- <tr style=" ">
												<td style="width: 110px; color:#3a85c8; border-right:0px; border-left: 0px; background: #ffffff;">계좌이체</td>
												<td class="dlv_mtd" style="border-right:0px; border-left: 0px; background: #ffffff;">
													<span class="rdb_w"><label><input type="radio" id="rdoAccountTransfer" name="rdoPaymentMethod" value="1" checked="checked" class="rdbtn" style="display:inline-block;"> 계좌이체 (수수료 없음)</label> </span>	
												</td>
											</tr> -->
											<tr style="  ">
												<td style="width: 110px; color:#3a85c8; border-right:0px; border-left: 0px; background: #ffffff;">간편결제</td>
												<td class="dlv_mtd" style="border-right:0px; border-left: 0px; background: #ffffff;">
													<span class="rdb_w">
														<label style="display:inline-block;">
															<input type="radio" id="rdoKakaoPay_NEW" name="rdoPaymentMethod" value="2" checked="checked" class="rdbtn" style="display:inline-block;">
															카카오페이
														</label>
														<img src="https://secimage.yes24.com/sysimage/common/icon/ico_kakaopay.gif" alt="kakaopay" style="margin-top:-3px;vertical-align:top;"> 
													</span>	
												</td>
											</tr>
										</tbody></table>
									</div>
									<!-- 결제 방법 선택 //-->
		
									<!--// 계좌이체 안내 -->
									<!-- <div id="divPayMthdBankRTime" class="scard_w" style="width: 640px;">
										<table cellpadding="0" cellspacing="0" id="" class="tbl_pay" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
											<tbody><tr>
												<td style="width: 110px; color:#3a85c8; border-right:0px; border-left: 0px; background: #ffffff;">
													계좌이체<br>안내
												</td>
												<td style="border-right:0px; border-left: 0px; background: #ffffff;">
													<ul class="smsg_l">
														<li>결제금액이 입력하신 계좌에서 자동으로 이체되는 서비스로 계좌이체시 본인인증 필요.<br>(법인/개인사업자 계좌는 일부 은행만 가능) </li>
													</ul>
												</td>
											</tr>
										</tbody></table>
									</div> -->
									<!-- 계좌이체 안내 //-->
								</div>
							</div>
							<!-- ######################### 일반 결제수단 선택 영역 끝 ######################### -->
						</div>
						<!-- ############################################################ 결제수단 선택 영역 끝 ############################################################ -->
	
						<!-- 카카오페이 결제 안내 -->
						<div id="divPayMethodKakaoNewPayInfo" class="scard_w">
							<table cellpadding="0" cellspacing="0" id="" class="tbl_pay" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">
							<tbody>
								<tr>
									<td style="width: 115px; color:#3a85c8; border-right:0px; border-left: 0px;">카카오페이<br>결제 안내</td>
									<td style="border-right:0px; border-left: 0px; background: #ffffff;">
										<ul class="smsg_l">
											<li>카카오톡에서 신용/체크카드 연결하고, 결제도 지문으로 쉽고 편리하게 이용하세요!</li>
											<li>본인명의 스마트폰에서 본인명의 카드 등록 후 사용 가능</li>
											<li>(카드등록 : 카카오톡 &gt; 더보기 &gt; 카카오페이 &gt; 카드)</li>
											<li>30만원 이상 결제, ARS 추가 인증 필요</li>
											<li>이용가능 카드사 : 모든 국내 신용/체크카드</li>
											<li>
												<strong>카카오페이는 무이자할부 및 제휴카드 혜택 내용과 관계가 없으며, 자세한 사항은 카카오페이 공지사항에서 확인하실 수 있습니다.</strong>
											</li>
										</ul>
									</td>
								</tr>
							</tbody>
							</table>
						</div>
						<!-- 카카오페이 결제 안내 // -->
					</div>
				</div>
				<!-- 결제방법 //-->
			</div>	
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