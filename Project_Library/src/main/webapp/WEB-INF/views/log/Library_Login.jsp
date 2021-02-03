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
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/layout.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/font.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/common.css" media="all">	
<script type="text/javascript">
	//엔터키 눌렀을때 실행=====================================================================================================
	function enterkey() {
		if( window.event.keyCode == 13 ){
			//엔터키 눌렀을때 실행할 내용
			login_Go();
		}
	}
	
	//로그인=====================================================================================================
	function login_Go() {
		//파라미터
		var f = document.getElementById("login_frm");
		var userID = f.userID.value.trim();
		var userPWD = f.userPWD.value.trim();
		
		//유효성검사
		if( userID == "" ){
			alert("아이디를 입력해주세요.");
			f.userID.focus();
			return;
		}
		
		if( userPWD == "" ){
			alert("비밀번호를 입력해주세요.");
			f.userPWD.focus();
			return;
		}
		
		f.method = "post";
		f.action = "login_check.do";
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
      <div class="body_head_login"><h1>로그인</h1></div>
      <div class="d_width clearfix">
        <div id="content">
            <div id="body_content">
                <div id="loginwrap" class="clearfix">
                    <div class="tit-wrap">
                        <p class="tit">도서관<span>LIBRARY</span></p>
                        <p class="txt">도서관의 회원이 되시면 더욱 많은 혜택과 서비스를 이용하실 수 있습니다!</p>
                    </div>
                    <form id="login_frm" name="login_frm">
                    	<input type="hidden" id="authority" name="authority" value="1">
                        <div class="cont">
                            <div class="input-wrap">
                                <p><i class="fas fa-user"></i><input type="text" class="text" id="userID" name="userID" placeholder="아이디" title="아이디 입력"></p>
                                <p><i class="fas fa-key"></i><input type="password" class="text" id="userPWD" name="userPWD" placeholder="비밀번호" title="비밀번호 입력" autocomplete="off"
                                                            onkeyup="enterkey();" required></p>
                                <a href="#" onclick="login_Go();" class="btn-d btn-red btn-login" title="로그인 페이지로 이동">로그인</a>
                            </div>
                            <div class="login-guide">
                                <p>아직 도서관 회원이 아니신가요?<a href="register_join.do" class="btn_d btn_small btn_blue" title="회원가입 페이지로 이동">회원가입</a></p>
                                <p>아이디/비밀번호를 잊으셨나요?<a href="idpwd_find_form.do" title="아이디/비밀번호 찾기 페이지로 이동">아이디/비밀번호 찾기</a></p>
                            </div>
                        </div>
                    </form>
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