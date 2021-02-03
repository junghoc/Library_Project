<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
        <script type="text/javascript">
        
        	//유저의 정보 새 페이지로 띄우기=====================================================================================================
        	function user_update(userID) {
        		window.name = "Admin_User";
				var openWin = window.open('admin_user_update_window_form.do?userID=' + userID,'existId','left=500, top=100, width=1000,height=500,toolboars=no,resizble=no,scrollbars=yes');
			}
        	
        	//유저 벤처리=====================================================================================================
        	function user_del(userID) {
				if( !confirm("정말 삭제하시겠습니까?") ){
					return;
				}
				location.href = "admin_user_del.do?userID=" + userID;
			}
        	
        	//유저 삭제 복구 =====================================================================================================
        	function user_restore(userID) {
        		if( !confirm("복구하시겠습니까?") ){
					return;
				}
				location.href = "admin_user_restore.do?userID=" + userID;
			}
        	
        </script>
    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand" href="admin_main.do">Admin</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" />
                    <div class="input-group-append">
                        <button class="btn btn-primary" type="button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="admin_logout.do">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Book</div>
                            <a class="nav-link collapsed" href="admin_book_form.do" data-toggle="collapse" data-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-book"></i></div>
                               	 책
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="admin_book_form.do">기존 및 신규책 관리</a>
                                    <a class="nav-link" href="admin_rent_form.do">대여 및 반납 관리</a>
                                    <a class="nav-link" href="admin_orders_form.do">판매 주문 관리</a>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">User</div>
                            <a class="nav-link" href="admin_user_form.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
								회원 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">Board</div>
                            <a class="nav-link collapsed" href="admin_gongji_form.do" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                               	 열린마당
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="admin_board_gongji_form.do">공지사항 관리</a>
                                    <a class="nav-link" href="admin_board_form.do">자유게시판 관리</a>
                                </nav>
                            </div>
                            <div class="sb-sidenav-menu-heading">Place</div>
                            <a class="nav-link" href="admin_study_room_form.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-reader"></i></div>
								열람실 관리
                            </a>
                            <c:if test="${ admin.departmentNum eq 10 }">
	                            <div class="sb-sidenav-menu-heading">Manager</div>
	                            <a class="nav-link" href="admin_employees_form.do">
	                                <div class="sb-nav-link-icon"><i class="fas fa-user-tie"></i></div>
									직원관리
	                            </a>
                            </c:if>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in:</div>
                        ${admin.adminName}님
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">유저 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="admin_main.do">Admin</a></li>
                            <li class="breadcrumb-item active">유저 관리</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                               	유저관리
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>회원이름</th>
                                                <th>Email</th>
                                                <th>Tel</th>
                                                <th>성별</th>
                                                <th>우편번호</th>
                                                <th>주소</th>
                                                <th>상세주소</th>
                                                <th>나이</th>
                                                <th>비고</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>ID</th>
                                                <th>회원이름</th>
                                                <th>Email</th>
                                                <th>Tel</th>
                                                <th>성별</th>
                                                <th>우편번호</th>
                                                <th>주소</th>
                                                <th>상세주소</th>
                                                <th>나이</th>
                                                <th>비고</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        	<c:forEach var="user" items="${ user_List }">
                                        		<tr>
                                        			<td>${ user.userID }</td>
                                        			<td>${ user.userName }</td>
                                        			<td>${ user.email1 }@${ user.email2 }</td>
                                        			<td>${ user.tel }</td>
                                        			<td>
                                        				<c:if test="${ user.gender eq 1 }">
                                        				남
                                        				</c:if>
                                        				<c:if test="${ user.gender eq 2 }">
                                        				여
                                        				</c:if>
                                        			</td>
                                        			<td>${ user.address1 }</td>
                                        			<td>${ user.address2 }</td>
                                        			<td>${ user.address3 }</td>
                                        			<td>${ user.age }</td>
                                        			<td>
                                        				<c:if test="${ user.enabled eq 1 }">
                                       						<input type="button" value="수정" title="수정" onclick="user_update('${ user.userID }');">
                                        					<input type="button" value="삭제" title="삭제" onclick="user_del('${ user.userID }');">
                                        				</c:if>
                                        				<c:if test="${ user.enabled eq 0 }">
                                        					<input type="button" value="복구" title="복구" onclick="user_restore('${ user.userID }');">
                                        				</c:if>
                                        			</td>
                                        		</tr>
                                        	</c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
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
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/admin/assets/demo/datatables-demo.js"></script>
    </body>
</html>
