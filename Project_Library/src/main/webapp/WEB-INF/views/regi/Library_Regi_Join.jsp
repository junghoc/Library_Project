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
      <div id="content">
		<div id="body_head" class="tit_bg8">	
            <div id="body_title" class="clearfix">
                <h1>회원가입
        </h1>		
            </div>	
        </div>
      <div id="body_content">
		<div class="join-wrap2">
			<div class="btn-wrap clearfix tac">
				<div class="col_d2">
					<div class="bx">
						<a href="register_form.do">
						<p class="tit"><i class="fa-user-plus fa-fw fas"></i> 신규회원가입</p>
						<p class="tit2">도서회원가입신청</p>
						<p class="txt">도서관을 처음 방문하시는 이용자는 신규회원으로 가입 후 <br>도서관에 방문하시어 별도의 신청 절차 없이 본인확인 후(신분증) <br>도서회원증을 발급 받을 수 있습니다.</p>
						</a>					</div>
				</div>
			</div>

			<ul class="bg_gr bu mtp10">
				<li>도서관(근방 여러 작은도서관)의 소장자료를 대출하고, 기타 도서관 서비스를 이용하기 위해서는 회원가입 후  책이음카드<br> 발급 후 이용이 가능합니다.</li>
				<li>카드발급 이력이 없으신 분들은 '신규회원가입', 카드발급 이력이 있으신 분들은  '기존 도서회원' 으로 홈페이지 아이디를<br> 생성하시고, 통합도서회원증(책이음카드)로 발급받으시기 바랍니다.</li>
			</ul>
			<h3>회원가입대상 및 증빙서류(현장 확인용)</h3>
			<table class="t3 mtp10">
			<caption>회원가입 대상 및 증빙서류 안내 표입니다.</caption>
			<tbody>
			<tr>
				<th>성인,청소년,아동</th>
				<td>신분증(주민등록증, 학생증, 청소년증)
				아동일 경우, 보호자 신분증과 가족관계 증명서류(의료보험증, 주민등록등본 등)</td>
			</tr>
			<tr>
				<th>직장 근무자</th>
				<td>재직증명서</td>
			</tr>
			<tr>
				<th>학교 학생</th>
				<td>학생증 또는 재학증명서</td>
			</tr>
			<tr>
				<th>재외동포</th>
				<td>재외동포 입증서류(사증, 호구부, 거민증 등)</td>
			</tr>
			<tr>
				<th>외국인등록자</th>
				<td>외국인등록증, 횡성군 거주를 증명할 수 있는 서류</td>
			</tr>
			</tbody>
			</table>
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