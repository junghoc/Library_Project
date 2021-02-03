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
     		 
        	//선택 공지글 정보 새 페이지로 띄우기=====================================================================================================
        	function gongji_update(gongji_idx) {
        		window.name = "Admin_Gongji";
				var openWin = window.open('admin_board_gongji_update_window_form.do?gongji_idx=' + gongji_idx,'existId','left=500, top=100, width=1000,height=500,toolboars=no,resizble=no,scrollbars=yes');
			}
        	
        	//선택 공지글 삭제=====================================================================================================
        	function gongji_del(gongji_idx) {
				if( !confirm("정말삭제하시겠습니까?") ){
					return;
				}
				location.href = "admin_board_gongji_del.do?gongji_idx=" + gongji_idx;
			}
        	
        	//선택 일반글 복구=====================================================================================================
        	function gongji_restore(gongji_idx) {
        		if( !confirm("복구하시겠습니까?") ){
					return;
				}
				location.href = "admin_board_gongji_restore.do?gongji_idx=" + gongji_idx;
			}
        	
        	//선택 공지글 일반글로 변경=====================================================================================================
        	function gongji_nomal(gongji_idx) {
        		if( !confirm("일반글로 변경하시겠습니까?") ){
					return;
				}
        		location.href = "admin_board_gongji_restore.do?gongji_idx=" + gongji_idx;
			}

        	//선택 공지글 공지글로 변경=====================================================================================================
        	function gongji_main(gongji_idx) {
        		if( !confirm("공지글로 변경하시겠습니까?") ){
					return;
				}
				location.href = "admin_board_gongji_main.do?gongji_idx=" + gongji_idx;
			}

        	//새로운 공지글 작성=====================================================================================================
        	function open_window() {
				window.name = "Admin_Book";
				var openWin = window.open('admin_board_gongji_insert_window_form.do','existId','left=500, top=100, width=1000,height=500,toolboars=no,resizble=no,scrollbars=yes');
				
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
                        <h1 class="mt-4">공지사항 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="admin_main.do">Admin</a></li>
                            <li class="breadcrumb-item active">공지사항</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                               	공지사항
                               	<div align="right">
                               		<i class="fas fa-book-medical"></i>
                               		<a href="javascript:open_window();" title="공지글 작성(새창)">공지글 작성</a>
                               	</div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>부서</th>
                                                <th>작성자</th>
                                                <th>제목</th>
                                                <th>작성일</th>
                                                <th>삭제유무</th>
                                                <th>비고</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>번호</th>
                                                <th>부서</th>
                                                <th>작성자</th>
                                                <th>제목</th>
                                                <th>작성일</th>
                                                <th>삭제유무</th>
                                                <th>비고</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        	<c:forEach var="gongji" items="${ gongji_List }">
                                        		<tr>
                                        			<td>${ gongji.gongji_idx }</td>
                                        			<td>${ gongji.department }</td>
                                        			<td>${ gongji.adminID }</td>
                                        			<td>${ gongji.gongji_subject }</td>
                                        			<td>
                                        				<fmt:parseDate value="${ gongji.gongji_regDate }" pattern="yyyy-MM-dd HH:mm" var="gongji_regDate"/>
														<fmt:formatDate value="${ gongji_regDate }" pattern="yyyy-MM-dd"/>
                                        			</td>
                                        			<td>
                                        				<c:if test="${ gongji.gongji_del_info eq 2 }">
                                        					공지 글
                                        				</c:if>
                                        				<c:if test="${ gongji.gongji_del_info eq 1 }">
                                        					일반 글
                                        				</c:if>
                                        				<c:if test="${ gongji.gongji_del_info eq 0 }">
                                        					삭제된 글
                                        				</c:if>
                                        			</td>
                                        			<td>
                                        				<c:if test="${ gongji.gongji_del_info eq 2 }">
                                       						<input type="button" value="일반글" title="일반글" onclick="gongji_nomal('${ gongji.gongji_idx }');">
                                       						<input type="button" value="수정" title="수정" onclick="gongji_update('${ gongji.gongji_idx }');">
                                        					<input type="button" value="삭제" title="삭제" onclick="gongji_del('${ gongji.gongji_idx }');">
                                        				</c:if>
                                        				<c:if test="${ gongji.gongji_del_info eq 1 }">
                                       						<input type="button" value="공지글" title="공지글" onclick="gongji_main('${ gongji.gongji_idx }');">
                                       						<input type="button" value="수정" title="수정" onclick="gongji_update('${ gongji.gongji_idx }');">
                                        					<input type="button" value="삭제" title="삭제" onclick="gongji_del('${ gongji.gongji_idx }');">
                                        				</c:if>
                                        				<c:if test="${ gongji.gongji_del_info eq 0 }">
                                        					<input type="button" value="복구" title="복구" onclick="gongji_restore('${ gongji.gongji_idx }');">
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
