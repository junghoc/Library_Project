<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="">
<head>
<title>도서관</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="${pageContext.request.contextPath}/resources/common/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
</head>
<body id="top">
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row0">
  <div id="topbar" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <div class="fl_left">
      <ul class="nospace">
       <li><a href="main.do"><i class="fas fa-home fa-lg"></i></a></li>
       	<li><a href="about_pre.do">About</a></li>
        <c:if test="${ empty sessionScope.user }">
	        <li><a href="login_form.do">Login</a></li>
	        <li><a href="register_join.do">Register</a></li>
        </c:if>
		<c:if test="${ !empty sessionScope.user }">
	        <li><a href="logout_form.do">Logout</a></li>
	        <li><a href="user_sellbook_cart_form.do">Cart</a></li>
        </c:if>
      </ul>
    </div>
    <c:if test="${ empty sessionScope.user }">
	    <div class="fl_right">
	      <ul class="nospace">
	        <li><i class="fas fa-phone rgtspace-5"></i> +82 (010) 1234 5678</li>
	        <li><i class="fas fa-envelope rgtspace-5"></i> test123@naver.com</li>
	      </ul>
	    </div>
    </c:if>
    <c:if test="${ !empty sessionScope.user }">
	    <div class="fl_right">
	      <ul class="nospace">
	        <li><i class="fas fa-user rgtspace-5"></i> ${user.userName}님</li>
	        <li><i class="fas fa-envelope rgtspace-5"></i> ${user.email1}@${user.email2}</li>
	      </ul>
	    </div>
    </c:if>
    <!-- ################################################################################################ -->
  </div>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row1">
  <header id="header" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <div id="logo" class="one_quarter first">
      <h1><a href="main.do">도서관</a></h1>
      <p>행복과 기쁨을 함께하는 우리</p>
    </div>
    <div class="one_quarter"><strong><i class="fas fa-phone rgtspace-5"></i> Call Us:</strong> +82 (010) 1234 5678</div>
    <div class="one_quarter"><strong><i class="far fa-clock rgtspace-5"></i> Mon. - Sat.:</strong> 08.00am - 18.00pm</div>
    <div class="one_quarter">
     <!--  <form action="#" method="post">
        <label>
          <select>
            <option value="" selected="selected" disabled="disabled">Language</option>
            <option value="korean">Korean</option>
            <option value="korean">한국어</option>
          </select>
        </label>
      </form> -->
    </div>
    <!-- ################################################################################################ -->
  </header>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row2">
  <nav id="mainav" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <ul class="clear">
      <li><a class="drop" href="about_pre.do">도서관 안내</a>
        <ul>
          <li><a href="about_pre.do">인사말</a></li>
          <li><a href="about_come.do">오시는 길</a></li>
          <li><a href="about_organization.do">조직도</a></li>
        </ul>
      </li>
      <li><a class="drop" href="rentbook_search.do">자료 검색</a>
        <ul>
          <li><a href="rentbook_search.do">소장자료 검색</a></li>
          <li><a href="rentbook_new_form.do">신규 도서</a></li>
          <li><a href="sellbook_search.do">판매자료 검색</a></li>
        </ul>
      </li>
      <li><a class="drop" href="board_gongji_list.do">열린마당</a>
        <ul>
          <li><a href="board_gongji_list.do">공지사항</a></li>
          <li><a href="board_list.do">자유게시판</a></li>
        </ul>
      </li>
      <li><a class="drop" href="study_room.do">열람실</a>
        <ul>
          <li><a href="study_room.do">열람실 예약</a></li>
          <li><a href="my_study_room_book.do">내 예약</a></li>
        </ul>
      </li>
      <li><a class="drop" href="user_rent_search_form.do">내서재</a>
        <ul>
          <li><a href="user_rent_search_form.do">대출이력 조회</a></li>
          <li><a href="user_sellbook_search_form.do">구매도서 조회</a></li>
          <li><a href="user_sellbook_cart_form.do">구매도서 카트</a></li>
          <li><a href="user_update_form.do">개인정보변경</a></li>
          <li><a href="user_del_form.do">회원탈퇴</a></li>
        </ul>
      </li>
    </ul>
    <!-- ################################################################################################ -->
  </nav>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- JAVASCRIPTS -->
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.backtotop.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/layout/scripts/jquery.mobilemenu.js"></script>
</body>
</html>