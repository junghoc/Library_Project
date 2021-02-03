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
	
	//이메일 인증=====================================================================================================
	var authKey;
	function email_check() {
		//파라미터
		var email1 = document.getElementById('email1').value;
		var email2 = document.getElementById('email2').value;
		var email = email1 + "@" + email2;
		
		//ajax사용
		var url = "sendmail.do";
		var param = "email=" + encodeURIComponent(email);
		sendRequest(url, param, email_resultFn, "POST");
	}
	function email_resultFn() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
			//서버로부터 도착한 데이터
			authKey = xhr.responseText;
			
			alert("인증번호가 메일로 발송되었습니다.");
		}
	}
	
	//이메일 인증번호 인증=====================================================================================================
	function key_check() {
		var key = document.getElementById('key').value;
		//인증번호 확인
		if( key != authKey ){
			alert("인증번호 6자리를 잘못 입력하셨습니다.");
			document.getElementById('key').value = "";
			document.getElementById('key').focus();
			return;
		}
		
		alert("인증이 완료되었습니다.");
		location.href = "id_find_check.do?userName=${user.userName}&email1=${user.email1}&email2=${user.email2}";
		
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
								<form name="id_f" id="id_f">
									<table width="620">
									  	<tbody>
										  	<tr>
										  		<td class="stitle" bgcolor="#666666">이메일 인증</td>
										  	</tr>
									  	</tbody>
								  	</table>
								  	
								  	<table width="620" cellspacing="1" class="regtable">
									  	<tbody>
										  	<tr>
											  	<td height="25" bgcolor="#f4f4f4">e-Mail</td>
											  	<td style="width:380px;">
											  		<input name="email1" id="email1" placeholder="이메일을 입력해주세요" style="display:inline-block;" value="${user.email1}" readonly>
												   	<p style="display:inline-block; margin:0;"> @ </p>
												   	<input name="email2" id="email2" placeholder="ex)naver.com" style="display:inline-block; width:130px;" value="${user.email2}" readonly>
											  	</td>
											  	<td align="center">
											  	<div class="bts"><a href="javascript:email_check();" tabindex="4"><span style="width:80px">인증번호 전송</span></a></div></td>
										  	</tr>
										  	<tr>
											  	<td width="100" height="25" bgcolor="#f4f4f4">인증 번호</td>
											  	<td style="width:380px;">
											  		<input type="text" name="key" id="key" tabindex="1" placeholder="인증번호 6자리를 입력해주세요." style="width:335px;">
											  	</td>
											  	<td align="center"><div class="bts"><a href="javascript:key_check();" tabindex="4"><span style="width:80px">인증</span></a></div></td>
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