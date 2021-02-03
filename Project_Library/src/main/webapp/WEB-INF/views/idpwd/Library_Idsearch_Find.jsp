<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관</title>

	<script type="text/javascript">
		//window창 닫기=====================================================================================================
		function self_close() {
			window.close();
		}
		
		//비밀번호 변경=====================================================================================================
		function pwd_change() {
			location.href = "pwd_find_change_form.do?userID=${user.userID}&email1=${user.email1}&email2=${user.email2}";
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
								  	
								  	<table width="620" cellspacing="1" class="regtable" style=" border-top:1px #cccccc solid; border-right:1px #cccccc solid; border-bottom:1px #cccccc solid; border-left:1px #cccccc solid;">
									  	<tbody>
										  	<tr>
											  	<td align="center">회원님의 아이디는 <p>"${ user.userID }"</p> 입니다.</td>
										  	</tr>
										  	
										</tbody>
									</table>
									
									<table width="620">
									  	<tbody>
										  	<tr>
											  	<td align="center"><div class="bts"><a href="javascript:pwd_change();" tabindex="4"><span style="width:80px">비밀 번호 찾기</span></a></div></td>
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