<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 : 관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
<script type="text/javascript">
	//window창 닫기============================================================================================
	function self_close() {
		window.close();
	}
	
	//책 추가============================================================================================
	function book_insert() {
		var f = document.getElementById("rentbook_insert");
		//파라미터 받기
		var rentbook_Isbn = f.rentbook_Isbn.value;
		var rentbook_Name = f.rentbook_Name.value;
		var rentbook_Category = f.rentbook_Category.value;
		var rentbook_Company = f.rentbook_Company.value;
		var rentbook_Content = f.rentbook_Content.value;
		var rentbook_Author = f.rentbook_Author.value;
		var rentbook_Year = f.rentbook_Year.value;
		var photo = f.photo.value;

		console.log("rentbook_Isbn : " + rentbook_Isbn);
		console.log("rentbook_Name : " + rentbook_Name);
		console.log("rentbook_Category : " + rentbook_Category);
		console.log("rentbook_Company : " + rentbook_Company);
		console.log("rentbook_Content : " + rentbook_Content);
		console.log("rentbook_Author : " + rentbook_Author);
		console.log("rentbook_Year : " + rentbook_Year);
		console.log("photo : " + photo);
		
		//유효성 검사
		if(rentbook_Isbn == ''){
			alert("Isbn을 작성해 주세요");
			return;
		}
		if(rentbook_Name == ''){
			alert("책이름을 작성해 주세요");
			return;
		}
		if(rentbook_Category == ''){
			alert("카테고리를 작성해 주세요");
			return;
		}
		if(rentbook_Company == ''){
			alert("출판사를 작성해 주세요");
			return;
		}
		if(rentbook_Content == ''){
			alert("내용을 작성해 주세요");
			return;
		}
		if(rentbook_Author == ''){
			alert("저자를 작성해 주세요");
			return;
		}
		if(rentbook_Year == ''){
			alert("출판년도를 작성해 주세요");
			return;
		}
		if( photo == '' ){
			alert("사진을 선택해주세요");
			return;
		}
		
		var params = new FormData(f);
		
		//var params = $("form[id=rentbook_insert]").serialize() + "&photo=" + photo;
		console.log("params : " + params)

		$.ajax({
			url:'admin_rentbook_insert_window.do',
			enctype: 'multipart/form-data',
			type: 'post',
			data: params,
			processData: false,
            contentType: false,
            cache: false,
			dataType: 'json',
			success : function(data) {
				console.log(data.result);
				if(data.result == 'success'){
					alert("대여 도서가 정상적으로 등록되었습니다.");
				}else{
					alert("작업이 실패하셨습니다. 다시 실행해주세요.");
				}
				//현제 페이지를 닫고 원래 페이지를 새로고침
				window.opener.document.location.href="admin_book_form.do";
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
				<td bgcolor="#999999" style="padding:5px 10px;" class="white12bold">신규책 추가</td>
			</tr>
		</tbody>
	</table>
	<table width="950" class="grey12">
		<tbody><tr>
			<td style="padding:20px 0 0 0">
				<form id="rentbook_insert">
				<table width="940" align="center">
					<tbody>
						<tr>
							<td style="padding:15px; border-top:2px #cccccc solid; border-right:2px #cccccc solid; border-bottom:2px #cccccc solid; border-left:2px #cccccc solid;">
									<table width="900">
									  	<tbody>
										  	<tr>
										  		<td class="stitle">신규책</td>
										  	</tr>
									  	</tbody>
								  	</table>
								  	
								  	<table width="900" cellspacing="1" class="regtable">
									  	<tbody>
										  	<tr>
											  	<th bgcolor="#f4f4f4">책고유번호</th>
											  	<td>
											  		<input type="text" name="rentbook_Isbn" id="rentbook_Isbn" tabindex="1">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">책이름</th>
											  	<td>
											  		<input type="text" name="rentbook_Name" id="rentbook_Name" tabindex="1">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">카테고리</th>
											  	<td>
											  		<input type="text" name="rentbook_Category" id="rentbook_Category" tabindex="1">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">출판사</th>
											  	<td>
											  		<input type="text" name="rentbook_Company" id="rentbook_Company" tabindex="1">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">줄거리</th>
											  	<td>
											  		<textarea id="rentbook_Content" name="rentbook_Content" rows = "9" cols = "60"></textarea>
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">저자</th>
											  	<td>
											  		<input type="text" name="rentbook_Author" id="rentbook_Author" tabindex="1">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">출판년도</th>
											  	<td>
											  		<input type="text" name="rentbook_Year" id="rentbook_Year" tabindex="1" placeholder="ex)2020-01-01">
											  	</td>
										  	</tr>
										  	<tr>
											  	<th bgcolor="#f4f4f4">책 이미지</th>
											  	<td>
											  		사진 : <input type="file" id="photo" name="photo">
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
								<a href="javascript:book_insert();"><span style="width:50px">책 추가</span></a>
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