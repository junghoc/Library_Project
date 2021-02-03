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
	
	//이메일 뒷부분선택=====================================================================================================
	//id
	function id_email(mail_back) {
		if( mail_back == 'naver.com' ){
			document.getElementsByName("email2")[0].value = mail_back;
			document.getElementsByName("email2")[0].readOnly = true;
		}else if( mail_back == 'daum.com' ){
			document.getElementsByName("email2")[0].value = mail_back;
			document.getElementsByName("email2")[0].readOnly = true;
		}else if( mail_back == 'google.com' ){
			document.getElementsByName("email2")[0].value = mail_back;
			document.getElementsByName("email2")[0].readOnly = true;
		}else{
			document.getElementsByName("email2")[0].value = "";
			document.getElementsByName("email2")[0].readOnly = false;
		}
		
	}
	//pwd
	function pwd_email(mail_back) {
		if( mail_back == 'naver.com' ){
			document.getElementsByName("email2")[1].value = mail_back;
			document.getElementsByName("email2")[1].readOnly = true;
		}else if( mail_back == 'daum.com' ){
			document.getElementsByName("email2")[1].value = mail_back;
			document.getElementsByName("email2")[1].readOnly = true;
		}else if( mail_back == 'google.com' ){
			document.getElementsByName("email2")[1].value = mail_back;
			document.getElementsByName("email2")[1].readOnly = true;
		}else{
			document.getElementsByName("email2")[1].value = "";
			document.getElementsByName("email2")[1].readOnly = false;
		}
		
	}
	
	//아이디 찾기=====================================================================================================
	function id_search() {
		//파라미터
		var f = document.getElementById("id_f");
		var userName = f.userName.value.trim();
		var email1 = f.email1.value.trim();
		var email2 = f.email2.value.trim();
		var email = email1 + "@" + email2;
		
		//정규식
		var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
		
		//유효성 검사
		//이메일
		if(!emailReg.test(email)){
			alert('이메일을 정확히 입력해주세요.');
			f.email1.value = "";
			f.email1.focus();
			return;
		}
		
		var url = "id_find.do";
		var param = "userName=" + encodeURIComponent(userName)
			+ "&email1=" + encodeURIComponent(email1)
			+ "&email2=" + encodeURIComponent(email2); 
		
		sendRequest(url, param, id_resultFn, "POST");
		
	}
	function id_resultFn() {
		
		if( xhr.readyState == 4 && xhr.status == 200 ){
			//서버로부터 도착한 데이터
			var data = xhr.responseText;
			var json = eval(data);
			
			if(json[0].res == "no"){
				alert("일치하는 정보가 없습니다.");
				location.href = "idpwd_find_window.do";
				return;
			}
			var userName = document.getElementById("userName").value;
			var email1 = json[2].email1;
			var email2 = json[3].email2;
			
			location.href = "id_find_check_form.do?userName=" + userName
					+ "&email1=" + email1 + "&email2=" + email2;
				
		}
		
	}
	
	//비밀번호 찾기=====================================================================================================
	function pw_search() {
		//파라미터
		var f = document.getElementById("pw_f");
		var userID = f.userID.value.trim();
		var email1 = f.email1.value.trim();
		var email2 = f.email2.value.trim();
		var email = email1 + "@" + email2;
		
		//정규식
		var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
		
		//유효성검사
		//아이디
		if(userID == ""){
			alert('아이디를 입력해주세요.');
			f.userID.value = "";
			f.userID.focus();
			return;
		}
		//이메일
		if(!emailReg.test(email)){
			alert('이메일을 정확히 입력해주세요.');
			f.email1.value = "";
			f.email1.focus();
			return;
		}
		
		//Ajax를 통해 파라미터를 서버로 전송
		var url = "pwd_find.do";
		var param = "userID=" + encodeURIComponent(userID)
			+ "&email1=" + encodeURIComponent(email1)
			+ "&email2=" + encodeURIComponent(email2);
		
		sendRequest(url, param, pwd_resultFn, "POST");
		
	}
	function pwd_resultFn() {
		
		if( xhr.readyState == 4 && xhr.status == 200 ){
			//서버로부터 도착한 데이터
			var data = xhr.responseText;
			var json = eval(data);

			if(json[0].res == "no"){
				alert("정보를 잘못 입력하셨습니다.");
				return;
			}
			
			var userID = json[1].userID;
			var email1 = json[2].email1;
			var email2 = json[3].email2;
			
			location.href = "pwd_find_check_form.do?userID=" + userID
					+ "&email1=" + email1 + "&email2=" + email2;
			
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
								<form name="id_f" id="id_f">
									<table width="620">
									  	<tbody>
										  	<tr>
										  		<td class="stitle" bgcolor="#666666">아이디 찾기</td>
										  	</tr>
									  	</tbody>
								  	</table>
								  	
								  	<table width="620" cellspacing="1" class="regtable">
									  	<tbody>
										  	<tr>
											  	<td width="100" height="25" bgcolor="#f4f4f4">이름</td>
											  	<td width="130">
											  		<input type="text" name="userName" id="userName" tabindex="1">
											  	</td>
										  	</tr>
										  	<tr>
											  	<td height="25" bgcolor="#f4f4f4">e-Mail</td>
											  	<td>
											  		<input name="email1" id="email1" placeholder="이메일을 입력해주세요" style="display:inline-block;">
												   	<p style="display:inline-block; margin:0;"> @ </p>
												   	<input name="email2" id="email2" placeholder="ex)naver.com" style="display:inline-block; width:130px;">
												   	<select name="email2_sel" id="email2_sel" style="display:inline-block;" onchange="id_email(this.value);">
												   		<option value="">직접입력</option>
												   		<option value="naver.com">naver.com</option>
												   		<option value="daum.com">daum.com</option>
												   		<option value="google.com">google.com</option>
												   	</select>
											  	</td>
										  	</tr>
										  	<tr>
											  	<td colspan="2" align="right"><div class="bts"><a href="javascript:id_search();" tabindex="4"><span style="width:80px; padding: 10px;">아이디 찾기</span></a></div></td>
										  	</tr>
										</tbody>
									</table>
								</form>
							</td>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<td style="padding:15px; border-top:2px #cccccc solid; border-right:2px #cccccc solid; border-bottom:2px #cccccc solid; border-left:2px #cccccc solid;">
								<form name="pw_f" id="pw_f">
								  	<table width="620">
									  	<tbody>
										  	<tr>
										  		<td class="stitle" bgcolor="#666666">비밀번호 찾기</td>
										  	</tr>
										</tbody>
									</table>
										  	
									<table width="620" cellspacing="1" class="regtable">
										<tbody>
											<tr>
												<td width="100" height="25" bgcolor="#f4f4f4">ID</td>
												<td width="130">
													<input type="text" name="userID" id="userID" tabindex="5">
												</td>
											</tr>
											<tr>
											  	<td height="25" bgcolor="#f4f4f4">e-Mail</td>
											  	<td colspan="2">
											  		<input name="email1" id="email1" placeholder="이메일을 입력해주세요" style="display:inline-block;">
												   	<p style="display:inline-block; margin:0;"> @ </p>
												   	<input name="email2" id="email2" placeholder="ex)naver.com" style="display:inline-block; width:130px;">
												   	<select name="email2_sel" id="email2_sel" style="display:inline-block;" onchange="pwd_email(this.value);">
												   		<option value="">직접입력</option>
												   		<option value="naver.com">naver.com</option>
												   		<option value="daum.com">daum.com</option>
												   		<option value="google.com">google.com</option>
												   	</select>
											  	</td>
										  	</tr>
										  	<tr>
												<td colspan="2" align="right"><div class="bts"><a href="javascript:pw_search();" tabindex="4"><span style="width:80px; padding: 10px;">비밀번호 찾기</span></a></div></td>
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