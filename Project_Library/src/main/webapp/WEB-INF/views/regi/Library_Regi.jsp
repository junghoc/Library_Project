<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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

var b_idCheck = false;
var b_authKeyCheck = false;

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

//아이디 중복체크=====================================================================================================
function id_check() {
	var userID = document.getElementById('userID').value.trim();
	
	if( userID == '' ){
		alert("아이디를 입력하세요");
		return;
	}
	
	//정규식
	var idReg = /^[a-z]+[a-z0-9]{3,11}$/;
	if( !idReg.test( userID ) ) {
         alert("아이디는 영문자로 시작하는 4~12자 영문자 또는 숫자이어야 합니다.");
         document.getElementById('id').value = "";
         document.getElementById('id').focus();
         return;
     }

	var url = "id_check.do";
	var param = "userID=" + encodeURIComponent(userID);
	
	sendRequest(url, param, id_resultFn, "POST");
	
}
function id_resultFn() {
	
	if( xhr.readyState == 4 && xhr.status == 200 ){
		//서버로부터 도착한 데이터
		var data = xhr.responseText;
		
		var json = eval(data);
		
		if( json[0].result == 'no' ){
			alert(json[1].userID + "은(는) 이미 사용중입니다.");
			return;
		}
		
		//확정유무
		if( !confirm(json[1].userID + "을 사용하시겠습니까?")){
			return;
		}
		document.getElementById("userID").readOnly = true;
		b_idCheck = true;
				
	}
	
}

//자동줄바꿈=====================================================================================================
function keyCheck(objName,objSize,nextObjName){
	//(현재input의 이름, 현재input의 사이즈, 다음input의 이름)
	if( objName.value.length == objSize ){
		//value의 사이즈와 input의 사이즈가 같으면..
    	nextObjName.focus();
   		return;
	}
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

//회원가입=====================================================================================================================
function send(f) {
	//파라미터 받기
	var userPWD = f.userPWD.value.trim();
	var userPWD_re = f.userPWD_re.value.trim();
	var userName = f.userName.value.trim();
	var jumin1 = f.jumin1.value.trim();
	var jumin2 = f.jumin2.value.trim();
	var tel = f.tel.value.trim();
	var gender = f.gender.value;
	var address1 = f.address1.value;
	var address2 = f.address2.value;
	var address3 = f.address3.value.trim();
	
	//정규식
    var pwdReg = /^[a-zA-Z0-9]{5,15}$/;
    var nameReg = /^[가-힣]{2,4}$/;

    //유효성 검사
    //중복체크
    if(b_idCheck == false){
    	alert("아이디 중복체크를 안하셨습니다.");
    	return;
    }
	//비밀번호
	if( userPWD != userPWD_re ){
		alert('비밀번호와 비밀번호 확인의 값이 다릅니다.');
		f.userPWD.value = "";
		f.userPWD_re.value = "";
		f.userPWD.focus();
		return;
	}
	if(!pwdReg.test(userPWD) || userPWD == "" || userPWD_re == "" ){
		alert('비밀번호를 숫자와 영문자 조합으로 5~15자리를 사용해야 합니다.');
		f.userPWD.value = "";
		f.userPWD_re.value = "";
		f.userPWD.focus();
		return;
	}
	
	//이름
	if(!nameReg.test(userName) || userName == ""){
		alert('한글 이름으로 2~4자리를 사용해야합니다.');
		f.userName.value = "";
		f.userName.focus();
		return;
	}
	
	//이메일
    if(b_authKeyCheck == false){
    	alert("이메일 인증을 안하셨습니다.");
    	return;
    }
	
	//성별
	if(jumin2 == 3 || jumin2 == 1){
		if(gender != 1){
			alert("성별을 잘못 선택하셨습니다.");
			return;
		}
	}
	if(jumin2 == 2 || jumin2 == 4){
		if(gender != 2){
			alert("성별을 잘못 선택하셨습니다.");
			return;
		}
	}
	
	//우편번호
	if(address1 == ""){
		alert("우편번호를 검색하세요.");
		return;
	} 
	
	f.method = "post";
	f.action = "register.do";
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
      <h6>회원 공간</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="login_form.do">로그인</a></li>
          <li><a href="register_join.do">회원가입</a></li>
          <li><a href="idpwd_find_form.do">아이디/비밀번호 찾기</a></li>
        </ul>
      </nav>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- ################################################################################################ -->
    <div class="content three_quarter"> 
      <!-- ################################################################################################ -->
      <h1>회원가입</h1>
      <div>
	      <span class="point-red fwb text-lg">*</span> 표시 항목은 반드시 입력하셔야 합니다.
      </div>
      <form>
	      <div class="scrollable">
	        <table>
	          <tbody>
	            <tr>
	              <th>아이디<span class="point-red fwb text-lg">*</span></th>
	              <td>
	              	<input name="userID" id="userID" placeholder="아이디를 입력해주세요" style="display:inline-block;">
	                <input type="button" id="btnIdCheck" value="중복 체크" onclick="id_check();" style="cursor:pointer; display:inline-block;">
	                <p style="margin:5px 0; font-size:10px; color:red;">※ 회원아이디는 4~12자리의 영문자와 숫자조합으로만 작성하실 수 있습니다</p>
	              </td>
	            </tr>
	            <tr>
	              <th>비밀번호<span class="point-red fwb text-lg">*</span></th>
	              <td>
				  	<input type="password" name="userPWD" id="userPWD">
				  	<p style="margin:5px 0; font-size:10px; color:red;">※ 비밀번호는 5~15자리의 영문자와 숫자조합으로만 작성하실 수 있습니다</p>
				  </td>
	            </tr>
	            <tr>
	              <th>비밀번호 확인<span class="point-red fwb text-lg">*</span></th>
	              <td>
	              	<input type="password" name="userPWD_re" id="userPWD_re">
	              	<p style="margin:5px 0; font-size:10px; color:red;">※ 비밀번호와 동일하게 작성해야 합니다</p>
	              </td>
	            </tr>
	            <tr>
	              <th>이름<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="userName" id="userName" placeholder="ex)홍길동">
				  </td>
	            </tr>
	            <tr>
	              <th>주민번호<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="jumin1" id="jumin1" size="8" placeholder="ex)19990101" style="display:inline-block;" 
				   	onkeyup="keyCheck(this,this.size,this.form.jumin2)" onkeypress="if((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;" style="ime-mode:disabled">
				   	<p style="display:inline-block; margin:0;"> - </p>
				   	<input name="jumin2" id="jumin2" size="1" style="display:inline-block; width:25px;"
				   	onkeyup="keyCheck(this,this.size,this.form.email1)" onkeypress="if((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;" style="ime-mode:disabled">
				   	<p style="display:inline-block; margin:0;">******</p>
				  </td>
	            </tr>
	            <tr>
	              <th>이메일<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="email1" id="email1" placeholder="이메일을 입력해주세요" style="display:inline-block;">
				   	<p style="display:inline-block; margin:0;"> @ </p>
				   	<input name="email2" id="email2" placeholder="ex)naver.com" style="display:inline-block;">
				   	<select name="email2_sel" id="email2_sel" style="display:inline-block;" onclick="">
				   		<option value="">직접입력</option>
				   		<option value="naver.com">naver.com</option>
				   		<option value="daum.com">daum.com</option>
				   		<option value="google.com">google.com</option>
				   	</select>
				   	<input type="button" id="btnEmailCheck" value="인증번호" onclick="email_check(this.form);" style="cursor:pointer; display:inline-block;">
					<p style="margin:5px 0; font-size:10px; color:red;">※ 이메일을 인증을 해야 합니다</p>
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
				   	<input name="tel" id="tel" placeholder="ex)01012345678" onkeypress="if((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;" style="ime-mode:disabled">
				   	<p style="margin:5px 0; font-size:10px; color:red;">※ '-'없이 번호만 입력해주세요</p>
				  </td>
	            </tr>
	            <tr>
	              <th>성별<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<p style="border:1px solid black; display:inline-block; margin: 5px 0; margin-right: 5px;  padding: 3px;">
				   		<input type="radio" id="mmm_lbl" name="gender" checked value="1" style="display:inline-block;">남자 
				   	</p>
					<p style="border:1px solid black; display:inline-block; margin: 5px 0; padding: 3px;">
						<input type="radio" id="www_lbl" name="gender" value="2" style="display:inline-block;">여자
					</p>
				  </td>
	            </tr>
	            <tr>
	              <th>우편번호<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="address1" id="address1" placeholder="우편번호" onclick="execDaumPostcode();" readonly style="display:inline-block;">
				   	<input type="button" value="검색" onclick="execDaumPostcode();" style="cursor:pointer; display:inline-block;">
				  </td>
	            </tr>
	            <tr>
	              <th>주소<span class="point-red fwb text-lg">*</span></th>
				  <td>
				   	<input name="address2" id="address2" placeholder="주소" onclick="execDaumPostcode();" readonly>
				  </td>
	            </tr>
	            <tr>
	              <th>상세주소</th>
				  <td>
				   	<input name="address3" id="address3" placeholder="상세 주소를 입력해주세요.">
				  </td>
	            </tr>
	          </tbody>
	        </table>
	        <p><input type="button" value="회원가입" onclick="send(this.form);" style="cursor:pointer"></p>
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