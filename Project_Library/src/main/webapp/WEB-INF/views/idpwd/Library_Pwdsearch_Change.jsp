<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관</title>
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script type="text/javascript">
	//window창 닫기=====================================================================================================
	function self_close() {
		window.close();
	}
	
	//엔터키 눌렀을때 실행=====================================================================================================
	function enterkey() {
		if( window.event.keyCode == 13 ){
			//엔터키 눌렀을때 실행할 내용
			pwd_change();
		}
	}
	
	//비밀번호 변경=====================================================================================================
	function pwd_change() {
		//파라미터
		var f = document.getElementById("pwd_f");
		var userPWD = f.userPWD.value.trim();
		var userPWD_re = f.userPWD_re.value.trim();
		
		//정규식
		var pwdReg = /^[a-zA-Z0-9]{5,15}$/;
		
		//유효성 검사
		//비밀번호
		if( userPWD != userPWD_re ){
			alert('비밀번호와 비밀번호 확인의 값이 다릅니다.');
			f.userPWD.value = "";
			f.userPWD_re.value = "";
			f.userPWD.focus();
			return;
		}
		if(!pwdReg.test(userPWD)){
			alert('비밀번호를 숫자와 영문자 조합으로 5~15자리를 사용해야 합니다.');
			f.userPWD.value = "";
			f.userPWD_re.value = "";
			f.userPWD.focus();
			return;
		}
		
		//ajax를 통해 파라미터 값을 전송
		var url = "pwd_find_change.do";
		var param = "userID=${user.userID}&email1=${user.email1}&email2=${user.email2}" 
		+ "&userPWD=" + encodeURIComponent(userPWD);
		sendRequest(url, param, pwd_resultFn, "POST");
		
	}
	function pwd_resultFn() {
		
		if( xhr.readyState == 4 && xhr.status == 200 ){
			//서버로부터 도착한 데이터
			var data = xhr.responseText;
			
			if( data == 'no' ){
				alert("비밀번호 변경이 실패하였습니다.");
				window.close();
				return;
			}
			
			alert("비밀번호가 변경되었습니다. 로그인 해주세요.");
			window.close();
			
		}
	}
</script>

</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td bgcolor="#999999" style="padding:5px 10px;" class="white12bold">아이디/비밀번호 찾기</td>
			</tr>
		</tbody>
	</table>
	
	<table width="700" class="grey12">
		<tbody><tr>
			<td style="padding:20px 0 0 0">
				<table width="660" align="center">
					<tbody>
						<tr>
							<td style="padding:15px; border-top:2px #cccccc solid; border-right:2px #cccccc solid; border-bottom:2px #cccccc solid; border-left:2px #cccccc solid;">
								<form name="pwd_f" id="pwd_f">
									<table width="620">
									  	<tbody>
										  	<tr>
										  		<td class="stitle" bgcolor="#666666">비밀번호 변경</td>
										  	</tr>
									  	</tbody>
								  	</table>
								  	
								  	<table width="620" cellspacing="1" class="regtable">
									  	<tbody>
											<tr>
											  	<td width="120" height="25" bgcolor="#f4f4f4">비밀번호</td>
											  	<td style="width:380px;">
											  		<input type="password" name="userPWD" id="userPWD" tabindex="1" placeholder="비밀번호를 입력해주세요." style="width:360px;">
											  	</td>
										  	</tr>
										  	<tr>
											  	<td height="25" bgcolor="#f4f4f4">비밀번호 확인</td>
											  	<td style="width:380px;">
											  		<input type="password" name="userPWD_re" id="userPWD_re" tabindex="2" placeholder="비밀번호를 다시 입력해주세요." style="width:360px;"
											  			autocomplete="off" onkeyup="enterkey();" required>
											  	</td>
										  	</tr>
										  	<tr>
											  	<td colspan="2" align="right"><div class="bts"><a href="javascript:pwd_change();" tabindex="4"><span style="width:80px; padding: 10px;">비밀번호 변경</span></a></div></td>
										  	</tr>
										</tbody>
									</table>
								</form>
								
							</td>
						</tr>
					</tbody>
				</table>
				
				<table align="right" >
					<tbody>
						<tr>
							<td height="40" style="padding:0 13px 0 0">
								<div class="bts"><a href="javascript:self_close();"><span style="width:50px">닫기</span></a></div>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
			</tr>
		</tbody>
	</table>
</body>
</html>