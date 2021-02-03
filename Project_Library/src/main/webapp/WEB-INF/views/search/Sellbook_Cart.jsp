<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/cart.css" media="all">
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
	            
	            document.getElementById('address1').value = data.zonecode;
	            document.getElementById("address2").value = addr;            
	            document.getElementById("address3").focus();
	        }
	    }).open();
	}
	
	//시작과 동시에 total에 값 넣기============================================================================================
	window.onload = function () {
		var regexp = /\B(?=(\d{3})+(?!\d))/g;
		var total = '${total}';
		console.log('total : ' + total);
		document.getElementById("total_pr").value = total.toString().replace(regexp, ',');
		document.getElementById("total_mid").value = total.toString().replace(regexp, ',');
		document.getElementById("total_fin").value = total.toString().replace(regexp, ',');

	}	
		
	//checkbox의 체크 확인여부에따라 값 변경============================================================================================
	var total = '${total}';
	$(document).ready(function(){
		$("input[name='chkbx']").click(function(){
			var frm = $(this).val()-1;
			var size = ${fn:length(cart_list)};
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			var check = document.getElementsByName('chkbx')[frm].checked;
			
			var price = document.getElementsByName('price')[frm].value;
			var cnt = document.getElementsByName('cnt')[frm].value;
			
			var sum = (parseInt(price) * parseInt(cnt));
			
			if(check){
				total = parseInt(total) + parseInt(sum);
				console.log('total ? ' + total);
				document.getElementById("total_pr").value = (""+total).toString().replace(regexp, ',');
				document.getElementById("total_mid").value = (""+total).toString().replace(regexp, ',');
				document.getElementById("total_fin").value = (""+total).toString().replace(regexp, ',');
			}else if(!check){
				total = parseInt(total) - parseInt(sum);
				console.log('total ? ' + total);
				document.getElementById("total_pr").value = (""+total).toString().replace(regexp, ',');
				document.getElementById("total_mid").value = (""+total).toString().replace(regexp, ',');
				document.getElementById("total_fin").value = (""+total).toString().replace(regexp, ',');
			}

		});
	 });

	//수량 변경하기============================================================================================
	function sellbook_cnt(cart_idx, index) {
		//해당 index의 cnt값 가져오기
		var cart_Cnt = document.getElementsByName("cart_Cnt")[index].value;
		console.log('cart_idx : ' + cart_idx);
		console.log('index : ' + index);
		console.log('cart_Cnt : ' + cart_Cnt);
		
		var params = "cart_idx=" + cart_idx + "&cart_Cnt=" + cart_Cnt;
		
		$.ajax({
			url:'user_sellbook_cart_cnt.do',
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
	
	//선택 판매책 삭제하기(한개)============================================================================================
	function sellbook_del(cart_idx) {
		
		if(!confirm("정말 삭제하시겠습니까?")){
			return;
		}
		var params = "cart_idx=" + cart_idx;
		
		$.ajax({
			url:'user_sellbook_del.do',
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
	
	//선택 판매책 삭제하기(여러개)============================================================================================
	function sellbook_dels(){
		if($("input:checkbox[name=chkbx]:checked").length == 0){
			alert("취소할 책이 없습니다. 확인 후 다시 시도해주세요.");
			return;
		}
		//배열 선언
		var check_arr = [];
		
		//체크된 cart_idx값을 array에 저장
		$('input[name="chkbx"]:checked').each(function(i){//체크된 리스트 저장
			check_arr.push($(this).val());
        });
		for(var i = 0; i < check_arr.length; i++){
			console.log(check_arr[i]);
		}

		 
		var params = {"check_arr" : check_arr};
		
		$.ajax({
			url:'user_sellbook_dels.do',
			type: 'post',
			data: params,
			dataType: 'json',
			success : function(data) {
				if(data.result == 'success'){
					location.href = "user_sellbook_cart_form.do";
				}else{
					alert("작업이 실패하셨습니다. 다시 실행해주세요.");
				} 
	
			}
		});
		
	}	

	//구매 폼으로 이동(1권)============================================================================================
	function sellbook_order(cart_idx){
		var check_arr = [];
		check_arr.push(cart_idx);
		for(var i = 0; i < check_arr.length; i++){
			alert(check_arr[i]);
		}
		//구매 폼으로 이동
		location.href = "user_sellbook_orders.do?check_arr=" + check_arr;
		
	}
	
	//구매 폼으로 이동============================================================================================
	function sellbook_orders(){
		if($("input:checkbox[name=chkbx]:checked").length == 0){
			alert("구입할 책을 선택해 주세요");
			return;
		}
		//배열 선언
		var check_arr = [];
		
		//체크된 cart_idx값을 array에 저장
		$('input[name="chkbx"]:checked').each(function(i){//체크된 리스트 저장
			check_arr.push($(this).val());
        });
		for(var i = 0; i < check_arr.length; i++){
			console.log(check_arr[i]);
		}

		//체크가된 값만 보내준다 
		var params = {"check_arr" : check_arr,
					  "address1" : $("#address1").val(),
					  "address2" : $("#address2").val(),
					  "address3" : $("#address3").val()};
		
		//구매 폼으로이동
		location.href = "user_sellbook_orders.do?check_arr=" + check_arr;
		
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
        <h1>구매도서 카트</h1>
        <div id="wrapperContent">
		<div class="progbar">
			<h1 class="cart">
				<strong>카트</strong> &gt; 결제 &gt; 완료
			</h1>	
		</div>
		<!--  prgress bar & 나의 계좌 // -->
		<!-- // 장바구니 -->
		<form name="frmCartList">
		<div id="divCart">
		<div class="tbl_w cartTopItem" style="margin-bottom: 0;">
			<table class="tbl_l" style="margin-bottom: 0;">
				<colgroup>
					<col width="5%">
					<col width="30%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="25%">
				</colgroup>
				<thead>
					<tr>
						<th style="vertical-align:middle;">
							<input type="checkbox" class="chkbx" id="chkCartHeader" onclick="" checked="checked">
						</th>
						<th style="text-align: center;">
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
						<th>
							<em class="orde">주문</em>
						</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div id="divNormalCart" class="tbl_w gendig">
			<table class="tbl_l" style="table-layout:fixed;">
				<colgroup>
					<col width="5%">
					<col width="30%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="25%">
				</colgroup>
				<c:forEach var="cart" items="${ cart_list }" varStatus="status">
				<tbody>   
					<tr>
						<td class="cb">			
							<input type="checkbox" name="chkbx" class="chkbx" checked="checked" value="${cart.cart_idx}">
							<input type="hidden" name="price" class="chkbx" value="${cart.sellbook_Price}">
							<input type="hidden" name="cnt" class="chkbx" value="${cart.cart_Cnt}">
						</td>
						<td class="le">
							<a href="" class="pd_a">
								[도서]<br> 
								${ cart.sellbook_Name }
							</a>							
						</td>
						<td>
							<fmt:formatNumber value="${ cart.sellbook_Price }" pattern="###,###원"/>
						</td>
						<td>
							<input type="text" name="cart_Cnt" value="${ cart.cart_Cnt }" class="ipubx num" maxlength="4" style="text-align: center; margin-left: 30px;"><br>
							<a onclick="sellbook_cnt('${cart.cart_idx}','${status.index}')" title="변경" class="bw chgnum">변경</a>
						</td>
						<td>
							<strong>
								<fmt:formatNumber value="${ cart.sellbook_Price * cart.cart_Cnt }" pattern="###,###원"/>
							</strong>
						</td>
						<td>	
							<p class="dvmsg"><strong>내일</strong><br>도착예정</p>
						</td>
						<td class="goods_order">
							<p class="ordbtnw">
								<a onclick="sellbook_order('${cart.cart_idx}');" title="주문하기" class="bw ordpd">주문하기</a>
								<a onclick="sellbook_del('${cart.cart_idx}');" title="삭제하기" class="bw pddel">삭제하기</a>
							</p>
						</td>                        
					</tr>
				</tbody>
				</c:forEach>	
					<tfoot>
						<tr>
							<td colspan="7" class="tot">
								도서관 상품 총 금액 : <strong>
												<input id="total_pr" size="5"
												style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;display:inline-block;
													   background:#f5f5f5; text-align:right; font-weight:bold;margin-right: 2px;" readonly>원
											   </strong>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div class="tbl_w">
			</div>

			<div class="chkpd_w">
				선택한 상품 
				<a onclick="sellbook_orders();" class="bw ordpd">주문하기</a>
				<a onclick="sellbook_dels()" title="삭제하기" class="bw pddel2">삭제하기</a>
			</div>

			<!-- #################### 상품 최종 결제금액 시작  #################### -->
			<div class="calcTbArea">
				<table width="100%">
					<caption>최종 결제 금액 표</caption>
					<colgroup>
						<col width="*">
						<col span="3" width="239">
					</colgroup>
					<thead>
					<tr>
						<th scope="col">총 상품금액</th>
						<th scope="col">총 추가금액</th>
						<th scope="col" class="saleCol">총 할인금액</th>
						<th scope="col" class="priceCol lastCol">최종 결제금액</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>
							<em class="yes_b">
								<input id="total_mid" size="5"
									style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;display:inline-block;
										   background:#cae0f0; font-weight:bold;text-align:right; margin-bottom: 2px;" readonly>원
							</em>
							<em class="icon_settle ico_settle_plus">+</em>
						</td>
						<td class="totalCol">
							<em class="yes_b">0</em>원
							<em class="icon_settle ico_settle_minus">+</em>
						</td>
						<td class="saleCol">
							<em class="yes_b">0</em>원
							<em class="icon_settle ico_settle_equal">+</em>
						</td>
						<td class="priceCol lastCol">
							<em class="yes_b">
								<input id="total_fin" size="5"
									style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;display:inline-block;
										   background:#d4e3f1; font-weight:bold;text-align:right; margin-bottom: 2px;color:#a13b66; " readonly>원
							</em>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			
		<!-- #################### 상품 최종 결제금액 끝  #################### -->
		<div class="dlvifo_w" style="">
			<div class="dlvifo_tw">
				<h3 class="dlvifo_t">배송일 안내</h3>
			</div>
			<div class="dlv_w">
				<h5>   
					<strong>우편번호</strong> : <input name="address1" id="address1" placeholder="우편번호" value="${ user.address1 }" onclick="execDaumPostcode();" readonly style="display:inline-block; width: 400px; font-size:1.2rem;">
				   	<a onclick="execDaumPostcode();" title="배송지 변경" class="bw chgdlv">배송지 변경</a>
				</h5>
				<h5>   
					<strong>주소</strong> : <input name="address2" id="address2" placeholder="주소" value="${ user.address2 }" onclick="execDaumPostcode();" readonly style="display:inline-block; width: 400px; font-size:1.2rem;">
				</h5>
				<h5>   
					<strong>상세주소</strong> : <input name="address3" id="address3" value="${ user.address3 }" style="display:inline-block; width: 400px; font-size:1.2rem;">
				</h5>
			</div>
		</div>
		
		<div class="btn_area">
			<a onclick="sellbook_orders();"><img id="btnOrderCart" src="http://image.yes24.com/sysimage/orderN/b_orderMem.gif" alt="회원주문"></a>
			<a href="sellbook_search.do"><img src="http://image.yes24.com/sysimage/orderN/b_goshopping.gif" alt="쇼핑계속하기"></a>
		</div>
		</div>
		</form>
		<!--  장바구니 // -->
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