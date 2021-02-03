<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script type="text/javascript">
	
	//window창 닫기=====================================================================================================
	function self_close() {
		window.close();
	}
	
	//책 추가=====================================================================================================
	function gongji_insert() {
		var f = document.getElementById("gongji_insert");
		//파라미터 받기
		var gongji_subject = f.gongji_subject.value;
		var gongji_content = f.gongji_content.value;
		
		console.log("gongji_subject : " + gongji_subject);
		console.log("gongji_content : " + gongji_content);
		
		//유효성 검사
		if( gongji_subject == '' ){
			alert("제목을 입력하세요")
			f.gongji_subject.focus();
			return;
		}
		if( gongji_content == '' ){
			alert("내용은 한글자 이상 입력해야 합니다")
			f.gongji_content.focus();
			return;
		}
		
		var params = "gongji_subject=" + gongji_subject + "&gongji_content=" + gongji_content;

		$.ajax({
			url:'admin_board_gongji_insert.do',
			type: 'post',
			data: params,
			dataType: 'json',
			success : function(data) {
				console.log(data.result);
				if(data.result == 'success'){
					alert("정보가 정상적으로 변경되었습니다.");
				}else{
					alert("작업이 실패하셨습니다. 다시 실행해주세요.");
				}
				//현제 페이지를 닫고 원래 페이지를 새로고침
				window.opener.document.location.href="admin_board_gongji_form.do";
				window.close();
			}
		});
		
	}
	
</script>

</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td bgcolor="#999999" style="padding:5px 10px;" class="white12bold">공지사항 글 작성</td>
			</tr>
		</tbody>
	</table>
	
	<table width="950" class="grey12">
		<tbody><tr>
			<td style="padding:20px 0 0 0">
				<form id="gongji_insert">
					<table width="940" align="center">
						<tbody>
							<tr>
								<td style="padding:15px; border-top:2px #cccccc solid; border-right:2px #cccccc solid; border-bottom:2px #cccccc solid; border-left:2px #cccccc solid;">
									<table width="900">
									  	<tbody>
										  	<tr>
										  		<td class="stitle">공지사항 글 작성</td>
									  	</tr>
									  	</tbody>
								  	</table>
								  	
								  	<table width="900" cellspacing="1" class="regtable">
									  	<tbody>
										  	<tr>
											  	<th bgcolor="#f4f4f4">제목</th>
											  	<td><input name="gongji_subject" id="gongji_subject"></td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">부서</th>
											  	<td>
											  		<c:if test="${ admin.departmentNum eq 10 }">도서관장</c:if>
											  		<c:if test="${ admin.departmentNum eq 20 }">정보서비스과</c:if>
											  		<c:if test="${ admin.departmentNum eq 30 }">지식문화과</c:if>
											  		<c:if test="${ admin.departmentNum eq 40 }">도서관정책과</c:if>
											  		<c:if test="${ admin.departmentNum eq 50 }">도서판매과</c:if>
												</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">작성자</th>
											  	<td>${ admin.adminID }</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">내용</th>
											  	<td>
													<textarea name="gongji_content" id="gongji_content" rows="9" cols="60"></textarea>
												</td>
										  	</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				
					<table align="right" style="margin-right:5px" >
						<tbody>
							<tr>
								<td height="40" style="padding:0 13px 0 0">
									<div class="bts"><a href="javascript:gongji_insert();"><span style="width:50px">글작성</span></a>
									<a href="javascript:self_close();"><span style="width:50px">닫기</span></a></div>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</td>
			</tr>
		</tbody>
	</table>

</body>
</html>