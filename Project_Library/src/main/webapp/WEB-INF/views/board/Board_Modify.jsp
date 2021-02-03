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
	//수정============================================================================================
	function modify(){
		//파라미터 받기
		var f = document.getElementById("modify_form");
		var board_subject = f.board_subject.value;
		var board_content = f.board_content.value;
		
		//유효성검사
		if(board_subject.trim() == ""){
			alert("제목을 작성해주세요.");
			f.board_subject.value = "";
			f.board_subject.focus();
			return;
		}
		if(board_content.trim() == ""){
			alert("내용을 작성해주세요.");
			f.board_content.value = "";
			f.board_content.focus();
			return;
		}
		
		var url = "user_board_modify.do";
		var param = "board_idx=${board_vo.board_idx}&board_subject=" + board_subject + "&board_content=" + board_content;
		sendRequest(url, param, resultFn, "POST");
		
	}
	function resultFn(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = xhr.responseText;
			if(data == 'yes'){
				alert("글을 수정되었습니다.");
				location.href = "board_view.do?page=${param.page}&board_idx=${board_vo.board_idx}";
			}
		}
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
      <h1>자유게시판</h1>
	  <form id="modify_form">
	      <div class="scrollable">
	        <table>
	          <tbody>
	            <tr>
	              	<th>제목</th>
				  	<td><input name="board_subject" id="board_subject" value="${board_vo.board_subject}"></td>
	            </tr>
	            <tr>
					<th>작성자</th>
					<td>${board_vo.userName}</td>
				</tr>
	            <tr>
					<th>작성일</th>
					<td>${board_vo.board_regDate}</td>
				</tr>
				<tr>
					<td style="height:300px;" colspan="2">
						<textarea name="board_content" id="board_content" rows = "16" cols = "100">${board_vo.board_content}</textarea>
					</td>
				</tr>
	          </tbody>
	        </table>
	        <div align="right">
				<!-- 글 수정 -->
				<a href="#" onclick = "modify();" style="cursor:pointer; color:black;"><i class="fa-edit fa-fw fas"></i>수정</a>
				<!-- 글 취소 -->
				<a href="#" onclick = "javascript:location.href='board_view.do?page=${param.page}&board_idx=${board_vo.board_idx}'" style="cursor:pointer; color:black;"><i class="fa-file-excel fa-fw fas"></i>취소</a>
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