package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.AdminService;
import service.UserService;
import util.View_Path;
import vo.AdminVO;
import vo.BoardVO;
import vo.Board_ComVO;
import vo.CartVO;
import vo.GongjiVO;
import vo.OrdersVO;
import vo.RentVO;
import vo.RentbookVO;
import vo.SeatsVO;
import vo.UserVO;

@Controller
public class AdminController {

	@Autowired
	AdminService admin_Service;
	
	@Autowired
	UserService user_Service;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	//<0>공통사항
	//0.메인 화면 선택----------------------------------------------------------------------------------------------------------------------------
	//관리자 메인페이지
	@RequestMapping("/admin_main.do")
	public String admin_main_form(Model model) {
		//대여 도서 리스트
		List<RentVO> rent_List = admin_Service.admin_rent_list();
		//System.out.println("크기 : " + rent_List.size());
				
		model.addAttribute("rent_List", rent_List);
		return View_Path.Admin_View.VIEW_PATH + "Admin_Main.jsp";
	}
	
	//1.로그인--------------------------------------------------------------------------------------------------------------------------------
	//로그인 폼화면
	@RequestMapping("/admin_login_form.do")
	public String admin_login_form() {
		return View_Path.Admin_View.VIEW_PATH + "Admin_Login.jsp";
	}
	//로그인
	@RequestMapping("/admin_login_check.do") 
	public String login_check(AdminVO vo) { 
		AdminVO admin =	admin_Service.login_check(vo); 
		//아이디 or 비밀번호가 일치하지 않는경우 session 저장을 안해준다. 
		if(admin == null) { return View_Path.Admin_View.VIEW_PATH + "Admin_Login_Check.jsp"; } 
		//session에 정보 저장 
		session = request.getSession();
		session.setAttribute("admin", admin); //세션 유지시간
		session.setMaxInactiveInterval(60 * 60);//1시간 
		return View_Path.Admin_View.VIEW_PATH + "Admin_Login_Check.jsp"; 
	}
	
	//2.회원가입--------------------------------------------------------------------------------------------------------------------------------
	//회원가입 폼
	@RequestMapping("/admin_register_form.do")
	public String admin_register_form() {
		return View_Path.Admin_View.VIEW_PATH + "Admin_Register.jsp";
	}
	//아이디 중복체크
	@RequestMapping("/admin_id_check.do")
	@ResponseBody
	public String admind_check(String adminID) {
		//중복되는 아이디 확인 후 회원가입이 가능한지 확인
		String resultStr = admin_Service.id_check(adminID);
		return resultStr;
	}
	//회원가입
	@RequestMapping("/admin_register.do")
	public String admin_register(AdminVO vo) {
		int res = admin_Service.regi_insert(vo);
		return "admin_login_form.do";
	}
	//로그아웃 폼
	@RequestMapping("/admin_logout.do")
	public String logout_form() {
		session.removeAttribute("admin");
		return "admin_login_form.do"; 
	}
	
	//<1>관리자
	//1.회원 관리----------------------------------------------------------------------------------------------------------------------------
	//회원 관리 페이지 폼으로 이동
	@RequestMapping("/admin_user_form.do")
	public String admin_user_form(Model model) {
		//모든 유저의 정보를 가지고 온다
		List<UserVO> user_List = admin_Service.admin_user_list();
		model.addAttribute("user_List", user_List);
		return View_Path.Admin_User_View.VIEW_PATH + "Admin_User.jsp";
	}
	//회원 삭제
	@RequestMapping("/admin_user_del.do")
	public String admin_user_del(String userID) {
		int res = admin_Service.admin_user_del(userID);
		return "redirect:admin_user_form.do";
	}
	//회원 삭제 복구
	@RequestMapping("/admin_user_restore.do")
	public String admin_user_restore(String userID) {
		int res = admin_Service.admin_user_restore(userID);
		return "redirect:admin_user_form.do";
	}
	//회원 정보 수정폼
	@RequestMapping("/admin_user_update_window_form.do")
	public String admin_user_update_window_form(String userID, Model model) {
		//선택 회원의 정보 가져오기
		UserVO user = admin_Service.admin_user_info(userID);
		model.addAttribute("user", user);
		return View_Path.Admin_User_View.VIEW_PATH + "Admin_User_Update_Window.jsp";
	}
	//회원정보 수정
	@RequestMapping(value="/admin_user_update.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> admin_user_update(UserVO vo) {
		//System.out.println("userID : " + vo.getUserID());
		//System.out.println("userPWD : " + vo.getUserPWD());
		//System.out.println("tel : " + vo.getTel());
		//System.out.println("email : " + vo.getEmail1());
		//System.out.println("emai2 : " + vo.getEmail2());
		//System.out.println("address1 : " + vo.getAddress1());
		//System.out.println("address2 : " + vo.getAddress2());
		//System.out.println("address3 : " + vo.getAddress3());
		
		//회원정보 수정(성공여부확인)
		String result = admin_Service.admin_user_update(vo);
		
		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	
	//2.도서 관리----------------------------------------------------------------------------------------------------------------------------
	//기존 및 신규책 관리 폼 이동
	@RequestMapping("/admin_book_form.do")
	public String admin_book_form(Model model) {
		//대여도서 정보 가져오기
		List<RentbookVO> rentbook_List = admin_Service.admin_rentbook_list();
		
		model.addAttribute("rentbook_List", rentbook_List);
		return View_Path.Admin_Book_View.VIEW_PATH + "Admin_Rent_Book.jsp";
	}
	//신규책 추가 폼 이동
	@RequestMapping("/admin_rentbook_insert_window_form.do")
	public String admin_rentbook_insert_window_form() {
		return View_Path.Admin_Book_View.VIEW_PATH + "Admin_Rent_Book_Window.jsp";
	}
	//신규책 추가 
	@RequestMapping(value="/admin_rentbook_insert_window.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> admin_rentbook_insert_window(RentbookVO vo) throws IllegalStateException, IOException {
		//System.out.println("rentbook_Isbn : " + vo.getRentbook_Isbn());
		//System.out.println("rentbook_Name : " + vo.getRentbook_Name());
		//System.out.println("rentbook_Category : " + vo.getRentbook_Category());
		//System.out.println("rentbook_Company : " + vo.getRentbook_Company());
		//System.out.println("rentbook_Content : " + vo.getRentbook_Content());
		//System.out.println("rentbook_Author : " + vo.getRentbook_Author());
		//System.out.println("rentbook_Year : " + vo.getRentbook_Year());
		//System.out.println("photo : " + vo.getPhoto());
		
		//신규책 추가하기
		String result = admin_Service.admin_rentbook_insert(vo);
		
		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	//대여 도서 삭제
	@RequestMapping("/admin_rentbook_del.do")
	public String admin_rentbook_del(String rentbook_Isbn) {
		int res = admin_Service.admin_rentbook_del(rentbook_Isbn);
		return "redirect:admin_book_form.do";
	}
	
	//3.주문 관리----------------------------------------------------------------------------------------------------------------------------
	//대여 주문조회
	@RequestMapping("/admin_rent_form.do")
	public String admin_rent_form(Model model) {
		
		//대여 도서 리스트
		List<RentVO> rent_List = admin_Service.admin_rent_list();
		
		model.addAttribute("rent_List", rent_List);
		return View_Path.Admin_Book_View.VIEW_PATH + "Admin_Rent_Book_Rent.jsp";
	}
	//도서 대여
	@RequestMapping("/admin_rent_rent.do")
	public String admin_rent_rent(int rent_idx) {
		int res = admin_Service.admin_rent_rent(rent_idx);
		return "redirect:admin_rent_form.do";
	}
	//도서 취소
	@RequestMapping("/admin_rent_cancel.do")
	public String admin_rent_cancel(int rent_idx, int check, String rentbook_Isbn) {
		//도서 취소
		int res = admin_Service.admin_rent_cancel(rent_idx);
		//대여도서를 다시 대여 가능하게 변경
		int result = admin_Service.admin_rentbook_change(rentbook_Isbn);
		
		if(check == 1) {
			//관리자 메인화면에서 취소 버튼눌렀을 경우
			return "redirect:admin_main.do";
		}else {
			//도서 반납관레 페이지에서 취소버튼 눌렀을 경우
			return "redirect:admin_rent_form.do";
		}
	}
	//도서 반납
	@RequestMapping("/admin_rent_ret.do")
	public String admin_rent_ret(int rent_idx, String rentbook_Isbn) {
		//도서 반납
		int res = admin_Service.admin_rent_ret(rent_idx);
		//대여도서를 다시 대여 가능하게 변경
		int result = admin_Service.admin_rentbook_change(rentbook_Isbn);
		return "redirect:admin_rent_form.do";
	}
	//판매 주문 조회
	@RequestMapping("/admin_orders_form.do")
	public String admin_orders_form(Model model) {
		//도서 주문 리스트
		List<OrdersVO> orders_List = admin_Service.admin_orders_list();
		
		model.addAttribute("orders_List", orders_List);
		return View_Path.Admin_Book_View.VIEW_PATH + "Admin_Orders_Book.jsp";
	}
	//선택 판매 도서 배송 완료
	@RequestMapping("/admin_orders_finish.do")
	public String admin_orders_finish(int orders_idx) {
		//배송완료
		int res = admin_Service.admin_orders_finish(orders_idx);
		return "redirect:admin_orders_form.do";
	}
	//선택 판매도서의 주문 정보
	@RequestMapping("/admin_orders_view_window_form.do")
	public String admin_orders_view_window_form(int orders_idx, Model model) {
		//선택 판매도서의 주문 정보 가지고오기
		List<CartVO> cart_list = user_Service.cart_list_idx(orders_idx);
		model.addAttribute("cart_list", cart_list);
		return View_Path.Admin_Book_View.VIEW_PATH + "Admin_Orders_Book_Window.jsp";
	}
	
	//4.열람실 관리----------------------------------------------------------------------------------------------------------------------------
	//열람실 관리(멀티미디어실 + 열람실)
	@RequestMapping("/admin_study_room_form.do")
	public String admin_study_room_form(Model model) {
		//열람실 리스트 전부 가져오기
		List<SeatsVO> seats_List = admin_Service.admin_seats_list();
		
		model.addAttribute("seats_List", seats_List);
		return View_Path.Admin_Studyroom_View.VIEW_PATH + "Admin_Study_Room.jsp";
	}
	//열람실 초기화(전부다 빈자리로 만들기)
	@RequestMapping("/admin_study_room_reset.do")
	public String admin_study_room_reset() {
		int res = admin_Service.admin_study_room_reset();
		return "redirect:admin_study_room_form.do";
	}
	
	//5.게시판 관리----------------------------------------------------------------------------------------------------------------------------
	//(1) 공지 게시판..........................................
	//공지 게시판 폼으로 이동
	@RequestMapping("/admin_board_gongji_form.do")
	public String admin_board_gongji_form(Model model) {
		//공지사항 정보 가져오기
		List<GongjiVO> gongji_List = admin_Service.admin_gongji_list();
		model.addAttribute("gongji_List", gongji_List);
		return View_Path.Admin_Board_View.VIEW_PATH + "Admin_Board_Gongji.jsp";
	}
	//선택 공지글 삭제
	@RequestMapping("/admin_board_gongji_del.do")
	public String admin_board_gongji_del(int gongji_idx) {
		int res = admin_Service.admin_board_gongji_del(gongji_idx);
		return "redirect:admin_board_gongji_form.do";		
	}
	//선택 일반글 복구
	@RequestMapping("/admin_board_gongji_restore.do")
	public String admin_board_gongji_restore(int gongji_idx) {
		int res = admin_Service.admin_board_gongji_restore(gongji_idx);
		return "redirect:admin_board_gongji_form.do";		
	}
	//선택 공지글 공지글로 변경
	@RequestMapping("/admin_board_gongji_main.do")
	public String admin_board_gongji_main(int gongji_idx) {
		int res = admin_Service.admin_board_gongji_main(gongji_idx);
		return "redirect:admin_board_gongji_form.do";		
	}
	//선택 공지글 정보를 새 페이지로 띄우기
	@RequestMapping("/admin_board_gongji_update_window_form.do")
	public String admin_board_gongji_update_window_form(int gongji_idx, Model model) {
		//선택 공지사항 정보 가져오기
		GongjiVO gongji = admin_Service.admin_gongji_idx(gongji_idx);
		model.addAttribute("gongji", gongji);
		return View_Path.Admin_Board_View.VIEW_PATH + "Admin_Board_Gongji_Update_Window.jsp"; 
	}
	//선택 공지사항 정보 업데이트
	@RequestMapping(value="/admin_board_gongji_update.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> admin_board_gongji_update(GongjiVO vo) {
		//System.out.println("gongji_idx : " + vo.getGongji_idx());
		//System.out.println("gongji_subject : " + vo.getGongji_subject());
		//System.out.println("&gongji_content : " + vo.getGongji_content());
		
		//세션에 저장된 admin의 정보가져오기
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		//vo에 세션의  관리자 아이디 저장
		vo.setAdminID(admin.getAdminID());
		vo.setDepartmentNum(admin.getDepartmentNum());
		
		//선택 공지사항 글 수정(성공여부확인)
		String result = admin_Service.admin_board_gongji_update(vo);
		
		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	//새로운 공지글 작성 폼으로 이동
	@RequestMapping("/admin_board_gongji_insert_window_form.do")
	public String admin_board_gongji_insert_window_form() {
		return View_Path.Admin_Board_View.VIEW_PATH + "Admin_Board_Gongji_Insert_Window.jsp"; 
	}
	//새로운 공지글 작성
	@RequestMapping(value="/admin_board_gongji_insert.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> admin_board_gongji_insert(GongjiVO vo) {
		//System.out.println("gongji_subject : " + vo.getGongji_subject());
		//System.out.println("&gongji_content : " + vo.getGongji_content());
		
		//세션에 저장된 admin의 정보가져오기
		AdminVO admin = (AdminVO)session.getAttribute("admin");
		//vo에 세션의  관리자 아이디 저장
		vo.setAdminID(admin.getAdminID());
		vo.setDepartmentNum(admin.getDepartmentNum());
		
		//선택 공지사항 글 수정(성공여부확인)
		String result = admin_Service.dmin_board_gongji_insert(vo);
		
		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	
	//(2) 자유 게시판..........................................
	//자유 게시판 폼으로 이동
	@RequestMapping("/admin_board_form.do")
	public String admin_board_form(Model model) {
		//자유게시판 정보 가져오기
		List<BoardVO> board_List = admin_Service.admin_board_list();
		model.addAttribute("board_List", board_List);
		return View_Path.Admin_Board_View.VIEW_PATH + "Admin_Board.jsp";
	}
	//선택 자유게시판글 삭제
	@RequestMapping("/admin_board_del.do")
	public String admin_board_del(int board_idx) {
		int res = admin_Service.admin_board_del(board_idx);
		return "redirect:admin_board_form.do";
	}
	//선택 자유게시판글 복구
	@RequestMapping("/admin_board_restore.do")
	public String admin_board_restore(int board_idx) {
		int res = admin_Service.admin_board_restore(board_idx);
		return "redirect:admin_board_form.do";
	}
	//선택 게시판 글 새로운 창으로 띄우기
	@RequestMapping("/admin_board_update_window_form.do")
	public String admin_board_update_window_form(int board_idx, Model model, Integer page) {
		//페이징처리 시작, 끝, 페이지를 가져오기
		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}
		//선택 자유게시판 정보 가져오기
		BoardVO board = admin_Service.admin_board_info(board_idx);
		//선택 자유게시판의 댓글 가져오기
		List<Board_ComVO> com_List = admin_Service.admin_board_com_list(nowPage, board_idx);
		//선택 자유게시판의 페이징 처리
		String pageMenu = admin_Service.admin_board_com_pageMenu(nowPage, board_idx);
		
		model.addAttribute("board", board);
		model.addAttribute("com_List", com_List);
		model.addAttribute("pageMenu", pageMenu);
		return View_Path.Admin_Board_View.VIEW_PATH + "Admin_Board_Update_Window.jsp?page=" +nowPage;
	}
	
	//(2-1) 자유 게시판 댓글..........................................
	//선택 댓글 삭제
	@RequestMapping("/admin_board_com_del.do")
	public String admin_board_com_del(int board_idx, int board_com_idx, int page) {
		int res = admin_Service.admin_board_com_del(board_com_idx);
		return "redirect:admin_board_update_window_form.do?board_idx=" + board_idx + "&page=" + page;
	}
	//선택 댓글 복구
	@RequestMapping("/admin_board_com_restore.do")
	public String admin_board_com_restore(int board_idx, int board_com_idx, int page) {
		int res = admin_Service.admin_board_com_restore(board_com_idx);
		return "redirect:admin_board_update_window_form.do?board_idx=" + board_idx + "&page=" + page;
	}
	
	//6.직원 관리----------------------------------------------------------------------------------------------------------------------------
	//직원 관리 폼으로 이동
	@RequestMapping("/admin_employees_form.do")
	public String admin_employees_form(Model model) {
		//직원 리스트 가지고 오기
		List<AdminVO> admin_List = admin_Service.admin_empl_list();
		
		model.addAttribute("admin_List", admin_List);
		return View_Path.Admin_Employees_View.VIEW_PATH + "Admin_Employees.jsp";
	}
	//직원 관리 승인
	@RequestMapping("/admin_employee_approval.do")
	public String admin_employee_approval(String adminID) {
		int res = admin_Service.admin_employee_approval(adminID);
		return "redirect:admin_employees_form.do";
	}
	
	
	
}
