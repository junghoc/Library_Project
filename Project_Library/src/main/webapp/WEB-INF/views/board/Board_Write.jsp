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
<script>
	//새글 작성============================================================================================
	function send_check(){
		//파라미터 정보 가져오기
		var f = document.ff;
		var board_subject = f.board_subject.value.trim();
		var board_content = f.board_content.value.trim();
		
		//유효성 검사
		if(board_subject == ''){
			alert("제목을 입력하세요!");
			f.board_subject.value = "";
			return;
		}
		if(board_content == ''){
			alert("내용은 한 글자 이상 입력해야 합니다.");
			f.board_content.value = "";
			return;
		}
		
		f.method = 'post';
		f.action = 'user_board_write.do';
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
      <h1>자유 게시판 글 쓰기</h1>
	  <form name="ff">
	      <div class="scrollable">
	        <table>
	          <tbody>
		        <tr>
					<th>제목</th>
					<td><input name="board_subject" id="board_subject" style="width:250px"></td>
				</tr>			
				<tr>
					<th>작성자</th>
					<td>${user.userName}</td>
				</tr>
				<tr>			
					<td style="height:300px;" colspan="2">
						<textarea name="board_content" id="board_content" rows="18" cols="100"></textarea>
					</td>			
	          </tbody>
	        </table>
	        <div align="right">
	        	<a href="#" onclick = "send_check();" style="cursor:pointer; color:black;"><i class="fa-edit fa-fw fas"></i>글쓰기</a>
	        	<a href="#" onclick = "javascript:location.href='board_list.do'" style="cursor:pointer; color:black;"><i class="fa-file-excel fa-fw fas"></i>취소</a>
	        </div>
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