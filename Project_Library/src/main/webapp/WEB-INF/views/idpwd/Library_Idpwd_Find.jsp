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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/nomal.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/font.css">
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
      <h1>아이디/비밀번호 찾기</h1>
        <div class="d_width clearfix">
            <div id="content">
                <div id="body_content">
                    <div class="find-wrap bg_gr tac">
                        <p class="tit">아이디/비밀번호 찾기</p>
                        <p class="txt">도서관 정회원(회원카드 발급한 자)중 아이핀 인증은 정상적으로 되나 아이디/비밀번호를 찾을 수 없는 경우<br> 신분증을 지참하여 도서관을 방문해주세요.
                        <span>실명확인을 하신 후</span> 정상적으로 아이디/비밀번호 찾기를 하실 수 있습니다.</p>
                        <div class="btn-wrap clearfix">
                            <div class="col_d2">
                                <div class="bx">
                                    <p class="tit">이메일로 찾기</p>
                                    <a href="#" target="_blank"onclick="window.open('idpwd_find_window.do','existId','left=0, top=0, width=740,height=420,toolboars=no,resizble=no,scrollbars=yes')"
                                     class="btn-d" title="이메일 인증(새창)">이메일 인증</a>
                                    <p class="txt">이메일인증은 도서관(주)에서 제공되며, 타인의 명의를 도용하실 경우 관련법령에 따라 처벌 받으실 수 있습니다.</p>
                                </div>
                            </div>
                        </div>
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