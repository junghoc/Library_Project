<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
      <h6>열린마당</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="board_gongji_list.do">공지사항</a></li>
          <li><a href="board_list.do">자유게시판</a></li>
        </ul>
      </nav>
      <!-- ################################################################################################ -->
    </div>
    <!-- ################################################################################################ -->
    <!-- ################################################################################################ -->
    <div class="content three_quarter"> 
      <!-- ################################################################################################ -->
      <h1>공지사항</h1>
	  <form>
	      <div class="scrollable">
	        <table>
	          <tbody>
	            <tr>
	              <th align = "center" style="width:10%">번호</th>
	              <th align = "center">제목</th>
	              <th align = "center" style="width:15%">작성자</th>
	              <th align = "center" style="width:15%">등록일</th>
	              <th align = "center" style="width:10%">조회</th>
	              <th align = "center" style="width:10%">비고</th>
	            </tr>
	            <c:forEach  var = "gongji" items = "${ gongji_List }">
		            <c:if test="${gongji.gongji_del_info eq 2 }">
				    	<tr>
				           	<td align = "center">공지</td>
							<td align = "center">
					            <a href = "board_gongji_view.do?gongji_idx=${ gongji.gongji_idx }&page=${empty param.page ? 1 : param.page}" style="color: black;" >
									${ gongji.gongji_subject }
								</a>
							</td>
							<td align = "center">
								${ gongji.department }
							</td>
							<td align = "center">
								<fmt:parseDate value="${ gongji.gongji_regDate }" pattern="yyyy-MM-dd HH:mm" var="Date"/>
								<fmt:formatDate value="${ Date }" pattern="yyyy/MM/dd"/>
							</td>
							<td align = "center">${ gongji.gongji_readhit }</td>
							<td align = "center"></td>
				           </tr>
		            </c:if>
	            </c:forEach>
	            <c:forEach  var = "gongji" items = "${ gongji_List }">
		            <tr>
		            	<td align = "center">${ gongji.gongji_idx }</td>
						<td align = "center">
							<a href = "board_gongji_view.do?gongji_idx=${ gongji.gongji_idx }&page=${empty param.page ? 1 : param.page}" style="color: black;" >
								${ gongji.gongji_subject }
							</a>
						</td>
						<td align = "center">
							${ gongji.department }
						</td>
						<td align = "center">
							<fmt:parseDate value="${ gongji.gongji_regDate }" pattern="yyyy-MM-dd HH:mm" var="Date"/>
							<fmt:formatDate value="${ Date }" pattern="yyyy/MM/dd"/>
						</td>
						<td align = "center">${ gongji.gongji_readhit }</td>
						<td align = "center"></td>
		            </tr>
	            </c:forEach>
	            <c:if test = "${ empty gongji_List }">
					<tr>
						<td align = "center" colspan = "6">
							현재 등록된 글이 없습니다
						</td>
					</tr>
				</c:if>
				<tr align = "center">
					<td colspan = "6" style="border-top: 1px solid #D7D7D7;"> 
						${ pageMenu }
					</td>
				</tr>
	          </tbody>
	        </table>
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