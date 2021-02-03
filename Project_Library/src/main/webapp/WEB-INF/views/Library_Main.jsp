<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<jsp:include page="Library_Menu_Top.jsp"/>

<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper bgded overlay" style="background-image:url('${pageContext.request.contextPath}/resources/images/backgrounds/background.jpg');">
  <div id="pageintro" class="hoc clear"> 
    <!-- ################################################################################################ -->
    <article>
      <p>모두가 즐기고 조용한 독서를 할 수 있는 공간</p>
      <h3 class="heading">도서관	</h3>
      <p>최고급 도서관 그리고 최상의 서비스까지 </p>
      <footer><a class="btn" href="">더 알아보기</a></footer>
    </article>
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
    <section id="introblocks">
      <div class="sectiontitle">
        <h6 class="heading">공지사항</h6>
      </div>
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
	          </tbody>
	        </table>
    </section>
    <!-- ################################################################################################ -->
    <hr class="btmspace-80">
    <!-- ################################################################################################ -->
	<section>
      <div class="sectiontitle">
        <h6 class="heading">신규 책</h6>
      </div>
      <ul class="nospace group overview">
      	<c:forEach var="rentbook" items="${ rentbook_list }" begin="0" end="2">
      	<li class="one_third">
      		<figure>
      			<a href="rentbook_view.do?page=1&rentbook_Isbn=${rentbook.rentbook_Isbn}">
      			<table>
				<tr>
					<td class="main_newbook_td1" style="width: 40%">
						<img src="${pageContext.request.contextPath}/resources/images/book_img/${rentbook.rentbook_Isbn}.PNG" style="height: 190px;">
					</td>
					<td class="main_newbook_td2" style="color: black;" style="width: 60%">
						제목 : ${ rentbook.rentbook_Name }<br>
						저자 : ${ rentbook.rentbook_Author }<br>
						줄거리 : <br>${ rentbook.rentbook_Content }
					</td>	
      			</tr>
      			</table>
      			</a>
      			<figcaption>
             		<h6 class="heading">${ rentbook.rentbook_Name }</h6>
              		<p>신규 책입니다.</p>
            	</figcaption>
      		</figure>
      	</li>
      </c:forEach>	
      </ul>
    </section>
    <!-- ################################################################################################ -->
    <!-- / main body -->
    <div class="clear"></div>
  </main>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper coloured">
  <article class="hoc cta clear"> 
    <!-- ################################################################################################ -->
    <h6 class="three_quarter first">초대박 오픈 이벤트! 저희 도서관을 이용해주시는 고객님 선착순 500분께 시설 추가 한시간 무료 이용권 지급해드립니다!</h6>
    <footer class="one_quarter"><a class="btn" href="#">예약하러 가기</a></footer>
    <!-- ################################################################################################ -->
  </article>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<div class="wrapper row3">
  <section class="hoc container clear"> 
    <!-- ################################################################################################ -->
    <div class="sectiontitle">
      <h6 class="heading">이달의 추천 도서</h6>
    </div>
   <ul class="nospace group overview">
      <c:forEach var="rentbook" items="${ rentbook_list }" begin="0" end="2">
      	<li class="one_third">
      		<figure>
      			<a href="rentbook_view.do?page=1&rentbook_Isbn=${rentbook.rentbook_Isbn}">
      			<table>
				<tr>
					<td class="main_newbook_td1" style="width: 40%">
						<img src="${pageContext.request.contextPath}/resources/images/book_img/${rentbook.rentbook_Isbn}.PNG" style="height: 190px;">
					</td>
					<td class="main_newbook_td2" style="color: black;" style="width: 60%">
						제목 : ${ rentbook.rentbook_Name }<br>
						저자 : ${ rentbook.rentbook_Author }<br>
						줄거리 : <br>${ rentbook.rentbook_Content }
					</td>	
      			</tr>
      			</table>
      			</a>
      			<figcaption>
             		<h6 class="heading">${ rentbook.rentbook_Name }</h6>
              		<p>신규 책입니다.</p>
            	</figcaption>
      		</figure>
      	</li>
      </c:forEach>
   </ul>
    <!-- ################################################################################################ -->
  </section>
</div>
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<!-- ################################################################################################ -->
<jsp:include page="Library_Menu_Footer.jsp"/>
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