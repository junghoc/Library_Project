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
        <script type="text/javascript">
	        //엔터키 효과=====================================================================================================
	        function enterkey(f) {
	    		if( window.event.keyCode == 13 ){
	    			//엔터키 눌렀을때 실행할 내용
	    			admin_login_go(f);
	    		}
	    	}
	        
	      	//관리자 로그인=====================================================================================================
	        function admin_login_go(f) {
	    		var f = document.getElementById("f");
	    		var adminID = f.adminID.value.trim();
	    		var pwd = f.adminPWD.value.trim();
	    		
	    		if( adminID == "" ){
	    			alert("아이디를 입력해주세요.");
	    			f.adminID.focus();
	    			return;
	    		}
	    		
	    		if( adminPWD == "" ){
	    			alert("비밀번호를 입력해주세요.");
	    			f.adminPWD.focus();
	    			return;
	    		}
	    		
	    		f.method = "post";
	    		f.action = "admin_login_check.do";
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
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">LOGIN</h3></div>
                                    <div class="card-body">
                                        <form id="f">
                                        	<input type="hidden" id="authority" name="authority" value="0">
                                            <div class="form-group">
                                                <label class="small mb-1" for="inputEmailAddress">ID</label>
                                                <input class="form-control py-4" id="adminID" name="adminID" placeholder="Enter ID" />
                                            </div>
                                            <div class="form-group">
                                                <label class="small mb-1" for="inputPassword">Password</label>
                                                <input class="form-control py-4" id="adminPWD" name="adminPWD" type="password" placeholder="Enter password" autocomplete="off"
													onkeyup="enterkey();" required />
                                            </div>
                                            <!-- <div class="form-group">
                                                <div class="custom-control custom-checkbox">
                                                    <input class="custom-control-input" id="rememberPasswordCheck" type="checkbox" />
                                                    <label class="custom-control-label" for="rememberPasswordCheck">Remember password</label>
                                                </div>
                                            </div> -->
                                            <div class="form-group d-flex align-items-center justify-content-between mt-4 mb-0">
                                                <!-- <a class="small" href="">비밀번호 찾기</a> -->
                                                <a class="btn btn-primary" onclick="admin_login_go(this.form);">Login</a>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center">
                                        <div class="small"><a href="admin_register_form.do">회원가입</a></div>
                                    </div>
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
