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
<div class="wrapper row4">
  <footer id="footer" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <div class="one_quarter first">
      <h6 class="heading">도서관</h6>
      <ul class="nospace btmspace-30 linklist contact">
        <li><i class="fa-user fa-fw fas"></i>대표이사 : OOO 도서관장</li>
        <li><i class="fas fa-map-marker-alt"></i>
          <address>
          	도서관 위치
          </address>
        </li>
        <li><i class="fas fa-phone"></i> +82 (010) 1234 5678</li>
        <li><i class="far fa-envelope"></i>ceo@library.com</li>
      </ul>
    </div>
    <div class="one_quarter">
      <h6 class="heading">About Us</h6>
      <ul class="nospace linklist">
        <li>이용약관</li>
        <li>개인정보처리방침</li>
        <li>청소년 보호정책</li>
        <li>중고매장</li>
        <li>>제휴/마케팅 안내</li>
      </ul>
    </div>
    <div class="one_quarter">
      <h6 class="heading">웹 & 모바일</h6>
      <ul class="nospace linklist">
        <li>Open API</li>
        <li>TTB</li>
        <li>Mobile/APP</li>
      </ul>
    </div>
    <div class="one_quarter">
      <h6 class="heading">고객센터 문의</h6>
      <p class="nospace btmspace-15">아래 빈칸에 이름과 전화번호를 남겨주시면 1시간 내에 대표님이 직접 전화를 드립니다</p>
      <form method="post" action="#">
        <fieldset>
          <legend>Newsletter:</legend>
          <input class="btmspace-15" type="text" value="" placeholder="이름">
          <input class="btmspace-15" type="text" value="" placeholder="전화번호">
          <button type="submit" value="submit">확인</button>
        </fieldset>
      </form>
    </div>
    <!-- ################################################################################################ -->
  </footer>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row5">
  <div id="copyright" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <p class="fl_left">Copyright &copy; 2020 - All Rights Reserved - <a href="#">JungHO Choi</a></p>
    <!-- ################################################################################################ -->
  </div>
</div>
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