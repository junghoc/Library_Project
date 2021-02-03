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
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script>
	//마우스 클릭 이벤트============================================================================================
	function mouseup() {
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
	}

	//수정 폼============================================================================================
	function modify(){
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		//로그인은 했지만 작성자가 일치하지 않는 경우
		if( ${user.userID ne board_vo.userID} ){
			return;
		}
		//로그인후 작성자가 일치하는 경우
		location.href = "user_board_modify_form.do?page=${param.page}&board_idx=${board_vo.board_idx}";
		
	}
	
	//삭제============================================================================================
	function del(){
		//로그인이 되어있지 않는 경우
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		//로그인은 했지만 작성자가 일치하지 않는 경우
		if( ${user.userID ne board_vo.userID} ){
			return;
		}
		//삭제 확인 유무
		if(confirm("삭제하시겠습니까?")){
			var url = "user_board_delete.do";
			var param = "board_idx=${board_vo.board_idx}";
			sendRequest(url, param, resultFn, "POST");
		}
		
	}
	function resultFn(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data  =xhr.responseText;
			if(data == 'yes'){
				alert("글을 삭제하였습니다");
				location.href = "board_list.do?page=${param.page}";
			}
		}
	}
	
	//엔터키============================================================================================
	function enterkeydown(f) {
		if( event.keyCode == 13 ){
			//엔터키 눌렀을때 실행할 내용
			board_comment(f);
		}
	}
	
	//댓글달기============================================================================================
	function board_comment(f) {
		if( ${ empty sessionScope.user } ){
			alert("로그인후 이용해주세요.");
			return;
		}
		var board_com_content = f.board_com_content.value.trim();
		if(board_com_content == ""){
			alert("댓글을 작성해주세요.");
			f.board_com_content.value = "";
			return;
		}
		f.method = "post";
		f.action = "user_board_com_write.do?page=${param.page}&board_idx=${board_vo.board_idx}";
		f.submit();
	}
	
	//댓글 삭제============================================================================================
	function board_com_del(board_com_idx, userID){
		if(userID == '${user.userID}' ){
			if(confirm("삭제하시겠습니까?")){
				var url = "user_board_com_del.do";
				var param = "board_com_idx=" + board_com_idx;
				sendRequest(url, param, resultF, "POST");
			}
		}
	}
	function resultF(){
		if(xhr.readyState == 4 && xhr.status == 200){
			var data  =xhr.responseText;
			if(data == 'yes'){
				alert("글을 삭제하였습니다");
				location.href = "board_view.do?board_idx=${param.board_idx}&page=${param.page}";
			}
		}
	}
	
	//무한 스크롤============================================================================================
	var page = 1;
	var blackList = 3;//댓글을 3개씩 보여줌
	//totalPage를 구한다
	var com_totalPage = parseInt(${board_com_count}/blackList);
	if(${board_com_count}/blackList != 0){
		++com_totalPage;
	}
	//총 페이지수가 현재 페이지보다 크다면 실행
	$(window).scroll(function() {
		if( com_totalPage > page ){
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
				//console.log("userName : " + board[0].getUserName );
		    	//console.log(++page);
		    	++page;
		    	console.log(page);
		    	//맨아래가 될때마다 3개씩 보여준다
		    	var start = (page - 1) * blackList;
		    	var end = start + blackList;
		    	//end값이 댓글 총갯수보다 큰경우
		    	if(end > '${board_com_count}'){
		    		end = ${board_com_count - 1};
		    	}
		    	//console.log("start : " + start);
		    	//console.log("end : " + end);
		    	//html에 작성하여 댓글 보여주기
		    	/* '<c:forEach var="board_com" items="${ board_com_List }" begin="3" end="5" step="1">'	
			  	$("#infiniteScroll").append(
			  				
			  	   	"<article><header>" +
			  	   	"<figure class='avatar'><img src='${pageContext.request.contextPath}/resources/images/other/avatar.png' alt=''></figure>" +
			  	   	"<address>By ${board_com.userName}</address>" +
			  	   	"<time datetime='2045-04-06T08:15+00:00'>${ board_com.board_com_regDate }</time>" +
			  	   	"</header>" +
			  	   	"<div class='comcont'><p><pre>${ board_com.board_com_content }</pre></p></div>" +
			  	   	"<div align='right'><a href='#' onclick = 'javascript:board_com_del('${board_com.board_com_idx}', '${board_com.userID}');' style='cursor:pointer; color:black;'><i class='fa-trash fa-fw fas'></i>글삭제</a></div>" +
			  	   	"</article><hr>" 
			  	
			  	); 
		    	'</c:forEach>' */
		    }
		} 
	});
		
	
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
	  <form>
	      <div class="scrollable">
	        <table>
	          <tbody>
	            <tr>
	              	<th>제목</th>
				  	<td>${board_vo.board_subject}</td>
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
					<td style="height:300px;" colspan="2"><pre>${ board_vo.board_content }</pre></td>
				</tr>
	          </tbody>
	        </table>
	        <div align="right">
				<!-- 글 수정 -->
				<a onclick = "javascript:modify();" style="cursor:pointer; color:black;"><i class="fa-edit fa-fw fas"></i>수정</a>
				<!-- 글 삭제 -->
				<a onclick = "javascript:del();" style="cursor:pointer; color:black;"><i class="fa-trash fa-fw fas"></i>글삭제</a>
				<!-- 목록으로 돌아기기  -->
				<a onclick = "javascript:location.href='board_list.do?page=${param.page}'" style="cursor:pointer; color:black;"><i class="fa-list fa-fw fas"></i>목록보기</a>
	        </div>
	      </div>
      </form>
      <br>
      <hr>
      <br>
      <!-- ################################################################################################ -->
      <div id="comments">
        <h6>댓글 달기</h6>
        <form id="comment_form">
          <div class="one_third first">
            <label for="name">
	            ${ user.userName }
            </label>
          </div>
          <c:if test="${ empty sessionScope.user }">
	          <div class="block clear">
	            <textarea name="board_com_content" id="board_com_content" cols="20" rows="2" placeholder="로그인후 이용해주세요" readonly onmouseup="mouseup();" ></textarea>
	          </div>
          </c:if>
          <c:if test="${ !empty sessionScope.user }">
	          <div class="block clear">
	            <textarea name="board_com_content" id="board_com_content" cols="20" rows="2" placeholder="댓글을 달아주세요" onkeydown="enterkeydown(this.form);"></textarea>
	          </div>
          </c:if>
          <div>
            <input type="button" value="댓글달기" onclick="board_comment(this.form);">
          </div>
        </form>
        <h6>전체 댓글</h6>
        <ul>
          <li id="infiniteScroll">
          	<c:if test="${ empty board_com_List }">
          		<article>
	              <div class="comcont">
	                <p>댓글이 없습니다.</p>
	              </div>
	            </article>
          	</c:if>
          	<c:if test="${ !empty board_com_List }">
          		<c:forEach var="board_com" items="${ board_com_List }">
	          		<article>
		              <header>
		                <figure class="avatar"><img src="${pageContext.request.contextPath}/resources/images/other/avatar.png" alt=""></figure>
		                <address>
		                By ${ board_com.userName }
		                </address>
		                <time datetime="2045-04-06T08:15+00:00">${ board_com.board_com_regDate }</time>
		              </header>
		              <div class="comcont">
		                <p><pre>${ board_com.board_com_content }</pre></p>
		              </div>
		              <div align="right">
		              	<!-- 글 삭제 -->
						<a onclick = "javascript:board_com_del('${board_com.board_com_idx}', '${board_com.userID}');" style="cursor:pointer; color:black;"><i class="fa-trash fa-fw fas"></i>글삭제</a>
		              </div>
		            </article>
		            <hr>
          		</c:forEach>
          	</c:if>
          </li>
        </ul>
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