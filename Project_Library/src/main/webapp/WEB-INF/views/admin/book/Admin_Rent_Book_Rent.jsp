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
        
      		//대여 도서 대여============================================================================================
        	function rentbook_rent(rent_idx){
        		if( !confirm("대여 도서를 대여하시겠습니까?") ){
        			return;
        		}
        		location.href = "admin_rent_rent.do?rent_idx=" + rent_idx;
        	}
        
        	//대여 도서 반납============================================================================================
        	function rentbook_ret(rent_idx, rentbook_Isbn){
        		if( !confirm("대여 도서를 반납하시겠습니까?") ){
        			return;
        		}
        		location.href = "admin_rent_ret.do?rent_idx=" + rent_idx + "&rentbook_Isbn=" + rentbook_Isbn;
        	}
        	
        	//대여 도서 취소 및 거절============================================================================================
        	function rentbook_cancel(rent_idx, rentbook_Isbn){
        		if( !confirm("대여 도서의 예약을 취소하시겠습니까?") ){
        			return;
        		}
        		location.href = "admin_rent_cancel.do?check=2&rent_idx=" + rent_idx + "&rentbook_Isbn=" + rentbook_Isbn;
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
                        <h1 class="mt-4">대여 및 반납 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="admin_main.do">Admin</a></li>
                            <li class="breadcrumb-item active">대여 및 반납</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                               	대여 및 반납
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>회원ID</th>
                                                <th>책고유번호</th>
                                                <th>책이름</th>
                                                <th>대여일</th>
                                                <th>반납일</th>
                                                <th>대여여부</th>
                                                <th>비고</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>회원ID</th>
                                                <th>책고유번호</th>
                                                <th>책이름</th>
                                                <th>대여일</th>
                                                <th>반납일</th>
                                                <th>대여여부</th>
                                                <th>비고</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        	<c:forEach var="rent" items="${ rent_List }">
                                        		<tr>
                                        			<td>${ rent.userID }</td>
                                        			<td>${ rent.rentbook_Isbn }</td>
                                        			<td>${ rent.rentbook_Name }</td>
                                        			<td>
                                        				<fmt:parseDate value="${ rent.rent_Date }" pattern="yyyy-MM-dd HH:mm" var="rent_Date"/>
														<fmt:formatDate value="${ rent_Date }" pattern="yyyy-MM-dd"/>
                                        			</td>
                                        			<td>
                                        				<fmt:parseDate value="${ rent.rent_Redate }" pattern="yyyy-MM-dd HH:mm" var="rent_reDate"/>
														<fmt:formatDate value="${ rent_reDate }" pattern="yyyy-MM-dd"/>
                                        			</td>
                                        			<td>
                                        				<c:if test="${ rent.rent_Cancel eq 2 }">
										            		<c:if test="${ rent.rent_Check eq 2 }">
										            			예약
										            		</c:if>
										            		<c:if test="${ rent.rent_Check eq 1 }">
										            			대여 중
										            		</c:if>
										            		<c:if test="${ rent.rent_Check eq 0 }">
										            			반납
										            		</c:if>
									            		</c:if>
									            		<c:if test="${ rent.rent_Cancel eq 3 }">
									            			취소 요청
									            		</c:if>
									            		<c:if test="${ rent.rent_Cancel eq 1 }">
									            			취소
									            		</c:if>
                                        			</td>
                                        			<td>
                                        				<c:if test="${ rent.rent_Cancel eq 2 }">
                                        					<c:if test="${ rent.rent_Check eq 2 }">
	                                        					<input type="button" name="rent" value="대여" onclick="rentbook_rent(${rent.rent_idx});">
	                                        					<input type="button" name="cancel" value="예약 취소" onclick="rentbook_cancel('${rent.rent_idx}','${rent.rentbook_Isbn}');">
										            		</c:if>
										            		<c:if test="${ rent.rent_Check eq 1 }">
	                                        					<input type="button" name="rt" value="반납" onclick="rentbook_ret('${rent.rent_idx}','${rent.rentbook_Isbn}');">
										            		</c:if>
                                        				</c:if>
                                        				<c:if test="${ rent.rent_Cancel eq 3 }">
                                        					<input type="button" name="cancel" value="취소 승인" onclick="rentbook_cancel('${rent.rent_idx}','${rent.rentbook_Isbn}');">
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
