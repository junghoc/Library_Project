<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 : 관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>

<script type="text/javascript">

	//window창 닫기=====================================================================================================
	function self_close() {
		window.close();
	}

	//다음에서 주소검삭하는 기능=====================================================================================================
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
	
	//이메일 뒷부분 선택시 value값 이동=====================================================================================================
	$(document).ready(function(){
		$('#email2_sel').on('change',function(){
			document.getElementById("email2").value = this.value;
			if(this.value == ""){
				$('#email2').removeAttr("readonly");
			}else{
				$('#email2').attr("readonly", true);
			}
		})
	})
	
	//이메일 복구=====================================================================================================================
	function email_reset() {
		document.getElementById("email1").value = '${user.email1}';
		document.getElementById("email2").value = '${user.email2}';

	}
	
	//수정=====================================================================================================
	function update() {
		
		//아이디검색
		var f = document.getElementById("user_update");
		var userPWD = f.userPWD.value.trim();
		var tel = f.tel.value.trim();
		var email1 = f.email1.value;
		var email2 = f.email2.value;
		var address1 = f.address1.value;
		var address2 = f.address2.value;
		var address3 = f.address3.value.trim();
		
		//정규식
	    var pwdReg = /^[a-zA-Z0-9]{5,15}$/;
	    
	    /* console.log("f : " + f);
	    console.log("userPWD : " + userPWD);
	    console.log("tel : " + tel);
	    console.log("email1 : " + email1);
	    console.log("email2 : " + email2);
	    console.log("address1 : " + address1);
	    console.log("address2 : " + address2);
	    console.log("address3 : " + address3); */

	    //유효성 검사
	    if(userPWD == ""){
	    	alert('비밀번호를 숫자와 영문자 조합으로 5~15자리를 사용해야 합니다.');
	    	return;
	    }
	    
		//우편번호
		if(document.getElementById("address1").value == ""){
			alert("우편번호를 검색하세요.");
			return;
		}
		
		var params = "userID=${user.userID}&userPWD=" + userPWD + "&tel=" + tel
		 			 + "&email1=" + email1 + "&email2=" + email2 + "&address1=" + address1
		 			 + "&address2=" + address2 + "&address3=" + address3;
		
		$.ajax({
			url:'admin_user_update.do',
			type: 'post',
			data: params,
			dataType: 'json',
			success : function(data) {
				console.log(data.result);
				if(data.result == 'success'){
					alert("정보가 정상적으로 변경되었습니다.");
				}else{
					alert("작업이 실패하셨습니다. 다시 실행해주세요.");
				}
				//현제 페이지를 닫고 원래 페이지를 새로고침
				window.opener.document.location.href="admin_user_form.do";
				window.close();
			}
		});
	}
	
</script>

</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td bgcolor="#999999" style="padding:5px 10px;" class="white12bold">신규책 추가</td>
			</tr>
		</tbody>
	</table>
	
	<table width="950" class="grey12">
		<tbody><tr>
			<td style="padding:20px 0 0 0">
				<form id="user_update">
					<table width="940" align="center">
						<tbody>
							<tr>
							<td style="padding:15px; border-top:2px #cccccc solid; border-right:2px #cccccc solid; border-bottom:2px #cccccc solid; border-left:2px #cccccc solid;">
								<table width="900">
								  	<tbody>
									  	<tr>
									  		<td class="stitle">회원정보 수정</td>
									  	</tr>
								  	</tbody>
								</table>
								  	<table width="900" cellspacing="1" class="regtable">
									  	<tbody>
										  	<tr>
											  	<th bgcolor="#f4f4f4">아이디</th>
											  	<td>
											  		${ user.userID }
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">비밀번호</th>
											  	<td>
											  		<input type="password" name="userPWD" id="userPWD">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">이름</th>
											  	<td>
											  		${ user.userName }
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">주민번호</th>
											  	<td>
											  		${user.jumin1} - ${user.jumin2}******
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">이메일</th>
											  	<td>
											  		<input name="email1" id="email1" size="20" class="form-control w300 __ck" autocomplete="off" value="${ user.email1 }" onchange="email_change(this);">
													@
													<input name="email2" id="email2" placeholder="ex)naver.com" style="display:inline-block;" value="${ user.email2 }">
												   	<select name="email2_sel" id="email2_sel" style="display:inline-block;">
												   		<option value="">직접입력</option>
												   		<option value="naver.com">naver.com</option>
												   		<option value="daum.com">daum.com</option>
												   		<option value="google.com">google.com</option>
												   	</select>
													<input type="button" id="btnEmailReset" value="되돌리기" onclick="email_reset();" style="cursor:pointer"><br>
				  								</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">전화번호</th>
											  	<td>
											  		<input id="tel" name="tel" value="${ user.tel }">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">성별</th>
											  	<td>
											  		<c:if test="${user.gender eq 1 }">남자</c:if>
				   									<c:if test="${user.gender eq 2 }">여자</c:if>
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">우편번호</th>
											  	<td>
											  		<input name="address1" id="address1" value="${user.address1}" onclick="execDaumPostcode();" readonly>
													<input type="button" value="검색" onclick="execDaumPostcode();" style="cursor:pointer">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">주소</th>
											  	<td>
											  		<input name="address2" id="address2" value="${user.address2}" onclick="execDaumPostcode();" readonly>
											  	</td>
										  	</tr>
											<tr>
								              <th bgcolor="#f4f4f4">상세주소</th>
											  <td>
											   	<input name="address3" id="address3" value="${user.address3}">
											  </td>
								            </tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					
					<table align="right" style="margin-right:5px" >
						<tbody>
							<tr>
								<td height="40" style="padding:0 13px 0 0">
									<div class="bts">
										<a href="javascript:update();"><span style="width:50px">수정</span></a>
										<a href="javascript:self_close();"><span style="width:50px">닫기</span></a>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</form>	
				</td>
				</tr>
			</tbody>
		</table>

</body>
</html>