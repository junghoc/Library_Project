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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/font.css" media="all">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/common/css/about.css" media="all">	
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
      <h6>도서관 안내</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="about_pre.do">인사말</a></li>
          <li><a href="about_come.do">오시는 길</a></li>
          <li><a href="about_organization.do">조직도</a></li>
        </ul>
      </nav>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- ################################################################################################ -->
    <div class="content three_quarter"> 
      <!-- ################################################################################################ -->
      <div id="body_content">
                <div class="greeting">
                <div class="tit-wrap">
                    <p class="tit1">안녕하십니까?</p>
                    <p class="tit2">도서관에 오신 것을 진심으로 환영합니다.</p>
                        </div>
                        <div class="img-wrap">
                            <div class="img"><img src="${pageContext.request.contextPath}/resources/images/other/greeting.png" alt="도서관 이미지"></div>
                            <div class="txt">
                                <p>책은 행복한 삶의 시작이며 삶을 풍요롭게 합니다.</p>
                                <p>21세기는 문화의 세기이며 지식과 정보가 사회발전의 원동력이 되는 시대입니다.<br>도서관은 이용자들이 필요로 하는 지식과 정보를 제공하고<br>이용자 중심의 열린 문화공간이 될 수 있도록 최선의 노력을 다할 것이며,<br>디지털 정보를 신속히 제공하여 지식정보화 시대를 선도하는 도서관으로서<br> 소임을 다하겠습니다.<br><br>많은 관심과 이용을 바랍니다.<br>감사합니다.</p>
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