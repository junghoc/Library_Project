<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script type="text/javascript">

	var b_authKeyCheck = true;
	
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
	
	//이메일 인증메일 보내기===============================================================================================================
	var authKey;
	function email_check(f) {
		//파라미터값 받기
		var email1 = f.email1.value;
		var email2 = f.email2.value;
		var email = email1 + "@" + email2;
		alert(email);
		var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
		
		//이메일
		if(!emailReg.test(email)){
			alert('이메일을 정확히 입력해주세요.');
			f.email1.value = "";
			f.email2.value = "";
			f.email2_sel.value = "";
			f.email1.focus();
			return;
		}
		
		var url = "sendmail.do";
		var param = "email=" + encodeURIComponent(email);
		
		sendRequest(url, param, email_resultFn, "POST"); 
		
	}
	function email_resultFn() {
		
		if( xhr.readyState == 4 && xhr.status == 200 ){
			//서버로부터 도착한 난수키(6자리)
			authKey = xhr.responseText;
			
			alert("인증번호가 메일로 발송되었습니다.");
			document.getElementById('keyfrom').style = "display:";
			
		}
		
	}
	
	//이메일 인증번호 인증=====================================================================================================================
	function authKey_check(f) {
		var key_check = f.key_check.value.trim();
		
		if( key_check != authKey ){
			alert("인증번호 6자리를 잘못 입력하셨습니다.");
			document.getElementById('key_check').value = "";
			document.getElementById('key_check').focus();
			return;
		}
		
		alert("인증이 완료되었습니다.");
		b_authKeyCheck = true;
		//사용가능한 이메일라면 readOnly 처리
		document.getElementById("email1").readOnly = true;
		document.getElementById("email2").readOnly = true;
		document.getElementById("key_check").readOnly = true;
		document.getElementById("email2_sel").style = "display:none";
		document.getElementById("btnKeyCheck").style = "display:none";
		
	}
	
	//이메일 변경 이벤트=====================================================================================================================
	function email_change(email) {
	
		if(email.value != '${user.email1}'){
			alert("이메일이 변경되었습니다. 이메일 인증을 해주세요.");
			b_authKeyCheck = false;
			document.getElementById("email1").value = email.value;
			document.getElementById('btnEmailCheck').style = "cursor:pointer; display:inline-block;";
			document.getElementById('btnEmailReset').style = "cursor:pointer; display:inline-block;";
		}
		
	}
	
	//이메일 복구=====================================================================================================================
	function email_reset() {
		document.getElementById("email1").value = '${user.email1}';
		document.getElementById("email2").value = '${user.email2}';
		document.getElementById('btnEmailCheck').style = "cursor:pointer; display:none;";
		document.getElementById('btnEmailReset').style = "cursor:pointer; display:none;";

		b_authKeyCheck = true;
	}
		
	//수정============================================================================================
	function update(f) {
		//파라미터 받기
		var userPWD = f.userPWD.value.trim();
		var userPWD_re = f.userPWD_re.value.trim();
		var tel = f.tel.value.trim();
		var email = document.getElementById("email1").value;
		var emai2 = document.getElementById("email2").value;
		var address1 = f.address1.value;
		var address2 = f.address2.value;
		var address3 = f.address3.value.trim();
		
		//정규식
	    var pwdReg = /^[a-zA-Z0-9]{5,15}$/;
	
	    //유효성 검사
		//비밀번호
		if(userPWD != ""){
			if(!pwdReg.test(userPWD)){
				alert('비밀번호를 숫자와 영문자 조합으로 5~15자리를 사용해야 합니다.');
				f.userPWD.value = "";
				f.userPWD_re.value = "";
				f.userPWD.focus();
				return;
			}
			if( userPWD != userPWD_re ){
				alert('비밀번호와 비밀번호 확인의 값이 다릅니다.');
				f.userPWD.value = "";
				f.userPWD_re.value = "";
				f.userPWD.focus();
				return;
			}
		}else{
			f.userPWD.value = "no_change";
		}
		
		//이메일
	    if(b_authKeyCheck == false){
	    	alert("이메일 인증을 안하셨습니다.");
	    	return;
	    }
	
	  	//우편번호
		if(address1 == ""){
			alert("우편번호를 검색하세요.");
			return;
		}
		
		/* console.log("pwd : " + userPWD);
		console.log("pwd_re : " + userPWD_re);
		console.log("tel : " + tel);
		console.log("email : " + email);
		console.log("emai2 : " + emai2);
		console.log("address1 : " + address1);
		console.log("address2 : " + address2);
		console.log("address3 : " + address3); */
	
		f.method = "post";
		f.action = "user_update.do";
		f.submit();
		
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
      <h1>개인정보 변경</h1>
      <div>
	      <span class="point-red fwb text-lg">*</span> 표시 항목은 반드시 입력하셔야 합니다.
      </div>
      <form>
	      <div class="scrollable">
	        <table>
	          <tbody>
	            <tr>
	              <th>아이디</th>
	              <td>${user.userID}</td>
	            </tr>
	            <tr>
	              <th>비밀번호</th>
	              <td>
				  	<input type="password" name="userPWD" id="userPWD">
				  	<p style="margin:5px 0; font-size: 10px;">※ 비밀번호 변경시에만 입력하세요.</p>
				  </td>
	            </tr>
	            <tr>
	              <th>비밀번호 확인</th>
	              <td>
	              	<input type="password" name="userPWD_re" id="userPWD_re">
	              </td>
	            </tr>
	            <tr>
	              <th>이름</th>
				  <td>${user.userName}</td>
	            </tr>
	            <tr>
	              <th>주민번호<span class="point-red fwb text-lg">*</span></th>
				  <td>		   	
				   	<p style="display:inline-block; margin:0;">${user.jumin1} - ${user.jumin2}******</p>
				  </td>
	            </tr>
	            <tr>
	              <th>이메일<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="email1" id="email1" value="${user.email1}" style="display:inline-block;" onchange="email_change(this);">
				   	<p style="display:inline-block; margin:0;"> @ </p>
				   	<input name="email2" id="email2" placeholder="ex)naver.com" style="display:inline-block;" value="${user.email2}">
				   	<select name="email2_sel" id="email2_sel" style="display:inline-block;" onclick="">
				   		<option value="">직접입력</option>
				   		<option value="naver.com">naver.com</option>
				   		<option value="daum.com">daum.com</option>
				   		<option value="google.com">google.com</option>
				   	</select>
				   	<input type="button" id="btnEmailCheck" value="인증번호" onclick="email_check(this.form);" style="cursor:pointer; display:none;">
				   	<input type="button" id="btnEmailReset" value="되돌리기" onclick="email_reset();" style="cursor:pointer; display:none;">
					<p style="margin:5px 0; font-size:10px; color:red;">※ 이메일 변경 시 인증을 해야 합니다</p>
				  </td>
	            </tr>
	            <tr id="keyfrom" style="display:none;">
	              <th>인증번호</th>
				  <td>
				   	<input name="key_check" id="key_check" placeholder="인증번호 6자리를 입력해주세요" style="display:inline-block;">
				   	<input type="button" id="btnKeyCheck" name="btnKeyCheck" value="인증" onclick="authKey_check(this.form);" style="cursor:pointer; display:inline-block;">
				  </td>
	            </tr>
	            <tr>
	              <th>휴대폰 번호</th>
				  <td>
				   	<input name="tel" id="tel" value="${user.tel}">
				  </td>
	            </tr>
	            <tr>
	              <th>성별<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<c:if test="${user.gender eq 1 }">남자</c:if>
				   	<c:if test="${user.gender eq 2 }">여자</c:if>
				  </td>
	            </tr>
	            <tr>
	              <th>우편번호<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="address1" id="address1" placeholder="우편번호" onclick="execDaumPostcode();" readonly style="display:inline-block;" value="${user.address1}">
				   	<input type="button" value="검색" onclick="execDaumPostcode();" style="cursor:pointer; display:inline-block;">
				  </td>
	            </tr>
	            <tr>
	              <th>주소<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="address2" id="address2" placeholder="주소" onclick="execDaumPostcode();" readonly value="${user.address2}">
				  </td>
	            </tr>
	            <tr>
	              <th>상세주소</th>
				  <td>
				   	<input name="address3" id="address3" placeholder="상세 주소를 입력해주세요." value="${user.address3}">
				  </td>
	            </tr>
	          </tbody>
	        </table>
	        <p>
	        	<input type="button" value="수정" onclick="update(this.form);" style="cursor:pointer; display:inline-block;">
	        	<input type="button" value="취소" onclick="location.href='main.do'" style="cursor:pointer; display:inline-block;">
	        </p>
	      </div>
      </form>
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