<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>도서관 : 관리자 페이지</title>
        <link href="${pageContext.request.contextPath}/resources/admin/css/styles.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/common/js/httpRequest.js"></script>
      	<script type="text/javascript">
      		var b_idCheck = false;
      	
      		//아이디 중복체크=====================================================================================================
     		function admin_check_id(f) {
				var adminID = f.adminID.value.trim();
				
				if(adminID == ""){
					alert("아이디를 입력해주세요");
					return;
				}
     			
				var url = "admin_id_check.do";
				var param = "adminID=" + encodeURIComponent(adminID);
				
				sendRequest(url, param, id_resultFn, "POST");
				
			}
			function id_resultFn() {
				
				if( xhr.readyState == 4 && xhr.status == 200 ){
					//서버로부터 도착한 데이터
					var data = xhr.responseText;
					
					var json = eval(data);
					
					if( json[0].result == 'no' ){
						alert(json[1].adminID + "은(는) 이미 사용중입니다.");
						return;
					}
					
					//확정유무
					if( !confirm(json[1].adminID + "을 사용하시겠습니까?")){
						return;
					}
					document.getElementById("adminID").readOnly = true;
					b_idCheck = true;
							
							
				}
				
			}
     		
     		//부서 선택=====================================================================================================
     		function select_de(departmentNum) {
				if(departmentNum == 20){
					document.getElementById("department").value = "정보서비스과";
				}else if(departmentNum == 30){
					document.getElementById("department").value = "지식문화과";
				}else if(departmentNum == 40){
					document.getElementById("department").value = "도서관정책과";
				}else if(departmentNum == 50){
					document.getElementById("department").value = "도서판매과";
				}else {
					document.getElementById("department").value = "";
				}
			}
     		
     		//회원가입=====================================================================================================
			function send() {
				var f = document.getElementById("f");
     			var adminID = f.adminID.value;
				var adminPWD = f.adminPWD.value.trim();
				var adminPWD_re = f.adminPWD_re.value.trim();
				var email = f.email.value.trim();
				var adminName = f.adminName.value.trim();
				var tell = f.tell.value.trim();
				var departmentNum = f.departmentNum.value;
				
				//정규식
			    var pwdReg = /^[a-zA-Z0-9]{5,15}$/;
			    var nameReg = /^[가-힣]{2,4}$/;
				var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
				
				//유효성검사
			    //중복체크
			    if(b_idCheck == false){
			    	alert("아이디 중복체크를 안하셨습니다.");
			    	return;
			    }
				//비밀번호
				if( adminPWD != adminPWD_re ){
					alert('비밀번호와 비밀번호 확인의 값이 다릅니다.');
					f.adminPWD.value = "";
					f.adminPWD_re.value = "";
					f.adminPWD.focus();
					return;
				}
				if(!pwdReg.test(adminPWD) || adminPWD == "" || adminPWD_re == "" ){
					alert('비밀번호를 숫자와 영문자 조합으로 5~15자리를 사용해야 합니다.');
					f.adminPWD.value = "";
					f.adminPWD_re.value = "";
					f.adminPWD.focus();
					return;
				}
				//이메일
				if(!emailReg.test(email)){
					alert('이메일을 정확히 입력해주세요.');
					f.email.value = "";
					f.email.focus();
					return;
				}
				//이름
				if(!nameReg.test(adminName) || adminName == ""){
					alert('한글 이름으로 2~4자리를 사용해야합니다.');
					f.adminName.value = "";
					f.adminName.focus();
					return;
				}
				//부서
				if(departmentNum == ""){
					alert("부서를 선택해주세요.");
					return;
				}
				
				f.method = "post";
				f.action = "admin_register.do";
				f.submit();
				
			}
      	</script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">회원가입</h3></div>
                                    <div class="card-body">
                                        <form id="f">
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputID">ID<span class="point-red fwb text-lg">*</span></label>
                                                        <input class="form-control py-4" id="adminID" name="adminID" type="text" placeholder="Enter ID" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                    	<p>&nbsp;</p>
                                                        <input type="button" value="중복체크" onclick="admin_check_id(this.form);">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputPassword">PWD<span class="point-red fwb text-lg">*</span></label>
                                                        <input class="form-control py-4" id="adminPWD" name="adminPWD" type="password" placeholder="Enter password" />
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputConfirmPassword">Confirm PWD<span class="point-red fwb text-lg">*</span></label>
                                                        <input class="form-control py-4" id="adminPWD_re" name="adminPWD_re" type="password" placeholder="Confirm password" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="inputEmailAddress">Email<span class="point-red fwb text-lg">*</span></label>
                                                <input class="form-control py-4" id="email" name="email" type="email" aria-describedby="emailHelp" placeholder="Enter email address" />
                                            </div>
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputtName">Name<span class="point-red fwb text-lg">*</span></label>
                                                        <input class="form-control py-4" id="adminName" name="adminName" type="text" placeholder="Enter first name" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputTel">TEL</label>
                                                        <input class="form-control py-4" id="tel" name="tell" type="text" placeholder="01012345678" 
                                                        	onkeypress="if((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;" style="ime-mode:disabled"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="inputTel">부서선택<span class="point-red fwb text-lg">*</span></label>
                                                        <input class="form-control py-4" id="department" name="department" type="text" readonly/>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <p style="margin-bottom: 7px;">&nbsp;</p>
                                                        <select name="departmentNum" id="departmentNum" style="width: 200px; height: 40px;" onchange="select_de(this.value);">
													   		<option value="">부서를 선택해주세요</option>
													   		<option value="20">정보서비스과</option>
													   		<option value="30">지식문화과</option>
													   		<option value="40">도서관정책과</option>
													   		<option value="50">도서판매과</option>
													   	</select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group mt-4 mb-0"><a class="btn btn-primary btn-block" onclick="send();">회원가입</a></div>
                                        </form>
                                    </div>
                                    <!-- <div class="card-footer text-center">
                                        <div class="small"><a href="login.html">Have an account? Go to login</a></div>
                                    </div> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2020</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/admin/js/scripts.js"></script>
    </body>
</html>
