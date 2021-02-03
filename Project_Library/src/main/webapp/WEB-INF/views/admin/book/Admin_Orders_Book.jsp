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
     		
        	//해당 주문 정보 보기============================================================================================
        	function orders_view(orders_idx, orders_Amount) {
				window.name = "Admin_Book";
				var openWin = window.open('admin_orders_view_window_form.do?orders_idx=' + orders_idx + "&orders_Amount=" + orders_Amount,'existId','left=500, top=100, width=1000,height=600,toolboars=no,resizble=no,scrollbars=yes');
				
			}
     		
        	//배송완료============================================================================================
        	function orders_finish(orders_idx) {
        		if( !confirm("배송이 완료되었는지 다시 확인해 주세요.") ){
        			return;
        		}
        		location.href = "admin_orders_finish.do?orders_idx=" + orders_idx;
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
                        <h1 class="mt-4">판매 주문 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="admin_main.do">Admin</a></li>
                            <li class="breadcrumb-item active">책</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                               	기존 도서
                               	<div align="right">
                               	<i class="fas fa-book-medical"></i>
                               	<a href="javascript:open_window();" title="신규책 추가(새창)">책 추가</a></div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>주문번호</th>
                                                <th>ID</th>
                                                <th>수취인</th>
                                                <th>전화번호</th>
                                                <th>총 금액</th>
                                                <th>결제일</th>
                                                <th>송장번호</th>
                                                <th>결제수단</th>
                                                <th>배송현황</th>
                                                <th>비고</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                               	<th>주문번호</th>
                                                <th>ID</th>
                                                <th>수취인</th>
                                                <th>전화번호</th>
                                                <th>총 금액</th>
                                                <th>결제일</th>
                                                <th>송장번호</th>
                                                <th>결제수단</th>
                                                <th>배송현황</th>
                                                <th>비고</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        	<c:forEach var="orders" items="${ orders_List }">
                                        		<tr>
                                        			<td>${ orders.orders_idx }</td>
                                        			<td>${ orders.userID }</td>
                                        			<td>${ orders.userName_one }</td>
                                        			<td>${ orders.tel_one }</td>
                                        			<td>
                                        				<fmt:formatNumber value="${ orders.orders_Amount }" pattern="###,###원"/>
                                        			</td>
                                        			<td>
                                        				<fmt:parseDate value="${ orders.orders_date }" pattern="yyyy-MM-dd HH:mm" var="ordersDate"/>
														<fmt:formatDate value="${ ordersDate }" pattern="yyyy-MM-dd"/>
                                        			</td>
                                        			<td>${ orders.orders_Invoice }</td>
                                        			<td>${ orders.orders_Payment == 1 ? "카카오페이" : "무통장" } : ${ orders.orders_State == 0 ? "완료" : "진행중" } </td>
                                        			<td>${ orders.orders_Check == 1 ? "배송중" : "배송완료" }</td>
                                        			<td>
                                        				<%-- <c:if test="${ order.orders_Payment eq 0 }">
                                        					<input type="button" value="입금완료" onclick="orders_pay('${ order.orders_idx }');">
                                        				</c:if> --%>
                                        				<input type="button" value="주문정보" onclick="orders_view('${ orders.orders_idx }', '${ orders.orders_Amount }');">
                                        				<c:if test="${ orders.orders_Check == 1 }">
                                        					<input type="button" value="배송완료" onclick="orders_finish('${ orders.orders_idx }');">
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
