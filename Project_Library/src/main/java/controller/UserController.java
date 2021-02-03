package controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import service.ComService;
import service.UserService;
import util.View_Path;
import vo.CartVO;
import vo.KakaoPayReadyVO;
import vo.OrdersVO;
import vo.RentVO;
import vo.RentbookVO;
import vo.SeatsVO;
import vo.UserVO;

@Controller
public class UserController {

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	UserService user_Service;
	
	@Autowired
	ComService com_Service;
	
	//2)유저
	//<1>예약----------------------------------------------------------------------------------------------------------------------------
	//1.대여 도서 예약.......................................................................
	//선택 도서 예약 폼
	@RequestMapping("/user_rentbook_reserve_form.do")
	public String rentbook_reserve_form(Model model, String rentbook_Isbn, Integer page) {
		int nowPage = 1;
		//페지이가  null값인경우
		if( page != null ) {
			nowPage = page;
		}
		//선택 대여책 한건 조회
		RentbookVO rentbook_vo = user_Service.rentbook_view(rentbook_Isbn);
		model.addAttribute("rentbook", rentbook_vo);
		return View_Path.Search_View.VIEW_PATH + "Rentbook_Reserve.jsp?page=" + nowPage;
	}
	//선택 도서 예약
	@RequestMapping("/user_rentbook_reserve.do")
	public String user_rentbook_reserve(RentVO rent_vo, int page) {
		//세션에 저장된 user의 정보가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		rent_vo.setUserID(user.getUserID());
		//예약하기
		int res = user_Service.rentbook_reserve(rent_vo);
		return "redirect:rentbook_search.do?page="+page;
	}
	
	//2.판매도서 장바구니 담기.......................................................................
	//장바구니 담기 폼
	@RequestMapping("/user_sellbook_cart_form.do")
	public String user_sellbook_cart_form(Model model) {
		//세션에 저장된 user의 정보가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("login", "no");
			return View_Path.Log_View.VIEW_PATH + "Library_Login_Check.jsp";
		}
		//해당아이디의 cart정보 모두 가져오기
		List<CartVO> cart_list = user_Service.user_sellbook_cart(user.getUserID());
		//총합가지고오기
		int total = user_Service.user_sellbook_cart_total(user.getUserID());
		model.addAttribute("cart_list", cart_list);
		model.addAttribute("total", total);
		return View_Path.Search_View.VIEW_PATH + "Sellbook_Cart.jsp";
	}
	//선택 판매책 장바구니 담기
	@RequestMapping(value="/user_sellbook_cart.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> sellbook_cart(CartVO cart_vo){
		//세션에 저장된 user의 정보가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		
		//선택 판매책 장바구니에 담기(성공여부까지 확인)
		String result = user_Service.sellbook_cart(cart_vo, user);

		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	//선택 판매책 수량 변경
	@RequestMapping(value="/user_sellbook_cart_cnt.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> sellbook_cart_cnt(CartVO cart_vo){
		//선택 판매책 장바구니에서 수량 변경(성공여부까지 확인)
		String result = user_Service.sellbook_cart_cnt(cart_vo);

		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	//선택 판매책 삭제(update - 0)
	@RequestMapping(value="/user_sellbook_del.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> sellbook_del(int cart_idx){
		//선택 판매책 장바구니에서 삭제 변경(성공여부까지 확인)
		String result = user_Service.sellbook_del(cart_idx);
		
		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	//선택 판매책 삭제(다중)
	@RequestMapping("/user_sellbook_dels.do")
	@ResponseBody
	public HashMap<String, String> sellbook_dels( @RequestParam(value="check_arr") List<Integer> check_arr) {
		
		//선택 판매책 장바구니에서 삭제
		String result = user_Service.sellbook_dels(check_arr);

		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
		
	}
	
	//3.판매도서 구매.......................................................................
	//판매책 구매폼이동
	@RequestMapping("/user_sellbook_orders.do")
	public String sellbook_orders( @RequestParam(value="check_arr") List<Integer> check_arr, Model model) {
		//for (int j = 0; j < check_arr.size(); j++) {
		//	System.out.println(check_arr.get(j));
		//}
		
		List<CartVO> cart_list = user_Service.sellbook_orders(check_arr);
		if(cart_list == null) {
			//한개라도 데이터값을 가지고오지 못한경우 카트페이지 보낸다.
			return "redirect:user_sellbook_cart_form.do";
		}
		
		//구매할 책 토탈금액 
		int total = 0;
		for(int i = 0; i < cart_list.size(); i++ ) {
			total += (cart_list.get(i).getSellbook_Price() * cart_list.get(i).getCart_Cnt());
		}
		System.out.println("total : " + total);
		model.addAttribute("cart_list", cart_list);
		model.addAttribute("total", total);
		
		return View_Path.Search_View.VIEW_PATH + "Sellbook_Orders.jsp";
	}
	//구매 완료 페이지로 이동
	@RequestMapping("/sellbook_orders_finish.do")
	public String sellbook_orders_finish(Model model) {
		
		//session에 저장된 값 가져오기
		OrdersVO orders_vo = (OrdersVO)session.getAttribute("order");
		@SuppressWarnings("unchecked")
		List<CartVO> cart_list = (List<CartVO>)session.getAttribute("order_cart_list");
		
		//세션에 등록되어 있는 데이터 삭제
    	session.removeAttribute("order");
    	session.removeAttribute("order_cart_list");
		
		model.addAttribute("orders_vo", orders_vo);
		model.addAttribute("cart_list", cart_list);
		
		return View_Path.Search_View.VIEW_PATH + "Sellbook_Orders_Finish.jsp";
	}
		
	//<2>마이페이지----------------------------------------------------------------------------------------------------------------------------
	//개인정보 변경 폼
	@RequestMapping("/user_update_form.do")
	public String user_update_form() {
		return View_Path.User_View.VIEW_PATH + "Library_User_Update.jsp";
	}
	//회원정보수정
	@RequestMapping("/user_update.do")
	public String user_update( UserVO user_vo ) {
		//session 저장된 user의 정보 가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		//변경할 vo 유저 아이디정보 넣기
		user_vo.setUserID(user.getUserID());
		
		//정보수정
		UserVO user_update = user_Service.user_update(user_vo);
		
		//session에 정보 재 저장
		session = request.getSession();
		session.setAttribute("user", user_update);
		
		return "redirect:main.do";
	}
	//회원 탈퇴 폼
	@RequestMapping("/user_del_form.do")
	public String user_del_form() {
		return View_Path.User_View.VIEW_PATH + "Library_User_Del.jsp";
	}
	//회원 탈퇴
	@RequestMapping("/user_del.do")
	public String user_del(UserVO user_vo, Model model) {
		//session 저장된 user의 정보 가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		//변경할 vo 유저 아이디정보 넣기
		user_vo.setUserID(user.getUserID());
		
		//회원탈퇴
		int res = user_Service.user_del(user_vo);
		
		if(res == 1) {
			//로그아웃(세션에 등록된 데이터 삭제)
			session.removeAttribute("user");
		}
		
		model.addAttribute("result", res);
		
		return View_Path.User_View.VIEW_PATH + "Library_User_Del_Check.jsp";
	}
	//유저별 대여한 책 정보 조회 폼
	@RequestMapping("/user_rent_search_form.do")	
	public String user_rent_search_form(Model model) {
		//session 저장된 user의 정보 가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("login", "no");
			return View_Path.Log_View.VIEW_PATH + "Library_Login_Check.jsp";
		}
		//유저별 대여책의 정보 가져오기
		List<RentVO> rent_List = user_Service.user_rent_search(user.getUserID());
		model.addAttribute("rent_List", rent_List);
		return View_Path.User_View.VIEW_PATH + "Library_User_Rent_Search.jsp";
	}
	//선택 대여한 책 대여 취소버튼
	@RequestMapping("/user_rent_ccl.do")
	public String user_rent_ccl(int rent_idx) {
		//취소
		int res = user_Service.user_rent_ccl(rent_idx);
		return "redirect:user_rent_search_form.do";
	}
	//유저별 구매한 책 정보 조회 폼
	@RequestMapping("/user_sellbook_search_form.do")	
	public String user_sellbook_search_form(Model model) {
		//session 저장된 user의 정보 가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		if(user == null) {
			model.addAttribute("login", "no");
			return View_Path.Log_View.VIEW_PATH + "Library_Login_Check.jsp";
		}
		//유저별 구매책의 정보 가져오기
		List<OrdersVO> orders_List = user_Service.user_sellbook_search(user.getUserID());
		model.addAttribute("orders_List", orders_List);
		return View_Path.User_View.VIEW_PATH + "Library_User_Sellbook_Search.jsp";
	}
	//구매정보 상세보기
	@RequestMapping("/user_sellbook_view.do")
	public String user_sellbook_view(int orders_idx, Model model) {
		
		//선택 주문 정보를 orders_idx를 통해 가져오기
		OrdersVO orders_vo = user_Service.orders_select_idx(orders_idx);
		//선택 주문 정보의 디테일(카트의정보)을 orders_idx를 통해 가져오기
		List<CartVO> cart_list = user_Service.cart_list_idx(orders_idx);
		
		model.addAttribute("orders_vo", orders_vo);
		model.addAttribute("cart_list", cart_list);
		return View_Path.Search_View.VIEW_PATH + "Sellbook_Orders_Finish.jsp";
	}
	
	//<3>결제----------------------------------------------------------------------------------------------------------------------------
	//카카오페이
	@RequestMapping("/kakaoPay.do")
	public String kakaoPay(@RequestParam(value="check_arr") List<Integer> check_arr, OrdersVO orders_vo ) {
		
		//session 오더정보 저장
		session.setAttribute("orders", orders_vo); 
		
		KakaoPayReadyVO vo = user_Service.kakaoPayReady(orders_vo, check_arr);
		if( vo == null ) {
			//데이터값 불러오기실패 = 결제실패
			return View_Path.Search_View.VIEW_PATH + "Sellbook_Kakaopay.jsp";
		}
		String redirectUrl = "redirect:"+vo.getNext_redirect_pc_url();
		return redirectUrl;
	}
	
	//결제 성공
	@RequestMapping("/kakaoPaySuccess.do")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, @RequestParam(value="check_arr") List<Integer> check_arr) {
    	System.out.println("kakaoPaySuccess get............................................");
    	System.out.println("kakaoPaySuccess pg_token : " + pg_token);
    	
    	//session 저장된 orders의 정보 가져오기
    	OrdersVO orders_vo = (OrdersVO)session.getAttribute("orders");
        
    	//송장번호(10자리)
    	while(true) {
	    	String key = com_Service.getKey(10);
	    	//송장번호 중복체크 확인
	    	OrdersVO vo_check = user_Service.orders_invoice_check(key);
	    	if( vo_check == null ) {
	    		System.out.println("송장번호 중복안됨");
	    		orders_vo.setOrders_Invoice(key);
	    		break;
	    	}
    	}
    	
    	//주문 테이블에 정보 넣고 정보가져오기(추수 session에 담아주기)
    	OrdersVO vo = user_Service.orders_books(orders_vo);
    	
    	//장바구니에서 구매완료한 제품 변경 및 데이터 가져오기 (추후 session에 담아주기)
    	List<CartVO> cart_list = user_Service.sellbook_order_end(check_arr);
    	
    	//주문 상세보기 정보 넣기 
    	int res = user_Service.orders_detail(vo, cart_list);
    	
    	//세션에 등록되어 있는 데이터 삭제
    	session.removeAttribute("orders");
    	
    	//세션 등록
    	session.setAttribute("order", vo);
    	session.setAttribute("order_cart_list", cart_list);
    	
    	return View_Path.Search_View.VIEW_PATH + "Sellbook_Kakaopay.jsp";
    }
	
	//결제 실패
	@RequestMapping("/kakaoPaySuccessFail.do")
    public String KakaoPaySuccessFail(HttpServletRequest req, Model model) {
    	System.out.println("KakaoPaySuccessFail get............................................");
    	System.out.println("결제 실패");
        
    	
    	//세션에 등록되어 있는 데이터 삭제
    	session.removeAttribute("orders");
    	return View_Path.Search_View.VIEW_PATH + "Sellbook_Kakaopay.jsp";
    }
	
	//결제 취소
	@RequestMapping("/kakaoPayCancel.do")
    public String KakaoPayCancel(HttpServletRequest req, Model model) {
    	System.out.println("KakaoPayCancel get............................................");
    	System.out.println("결제 취소");
        
    	
    	//세션에 등록되어 있는 데이터 삭제
    	session.removeAttribute("orders");
    	return View_Path.Search_View.VIEW_PATH + "Sellbook_Kakaopay.jsp";
    }
		
	//<4>책 정보----------------------------------------------------------------------------------------------------------------------------
	//1.대여책 전체 검색.......................................................................
	@RequestMapping("/rentbook_search.do")
	public String rendbook_search(Model model, Integer page ) {
		int nowPage = 1;
		//페지이가  null값인경우
		if( page != null ) {
			nowPage = page;
		}
		//전체 책정보
		List<RentbookVO> rentbook_list = user_Service.rendbook_search(nowPage);
		//전체 책 갯수
		int book_count = user_Service.rentbook_count();
		//페이징 처리
		String pageMenu = user_Service.rentbook_pageMenu(nowPage);
		//포워딩
		model.addAttribute("rentbook_list", rentbook_list);
		model.addAttribute("book_count", book_count);
		model.addAttribute("pageMenu", pageMenu);
		//선택 게시물에서 메인메뉴로 나온경우
		request.getSession().removeAttribute("rentbook");
		return View_Path.Search_View.VIEW_PATH + "Rentbook_Search.jsp?page="+nowPage;
	}
	//컬럼별 내용 검색
	@RequestMapping("/rentbook_search_curlum.do")
	public String rentbook_search_curlum(Model model, String curlum, String search, Integer page ) {
		int nowPage = 1;
		//페지이가  null값인경우
		if( page != null ) {
			nowPage = page;
		}
		//컬럼별 검색 리스트
		List<RentbookVO> rentbook_list = user_Service.rentbook_search_curlum(nowPage, curlum, search);
		if( rentbook_list == null ) {
			return "redirect:rentbook_search.do";
		}
		//페이징 처리
		String pageMenu = user_Service.rentbook_search_pageMenu(nowPage, curlum, search);
		model.addAttribute("rentbook_list", rentbook_list);
		model.addAttribute("pageMenu", pageMenu);
		return View_Path.Search_View.VIEW_PATH + "Rentbook_Search.jsp?curlum="+curlum + "&page="+nowPage;
	}
	//선택 대여 도서 검색
	@RequestMapping("/rentbook_view.do")
	public String rentbook_view(Model model, int page, String rentbook_Isbn) {
		//선택 대여책 한건 조회
		RentbookVO rentbook_vo = user_Service.rentbook_view(rentbook_Isbn);
		//다중 새로고침 방지 위한 세션 생성
		session = request.getSession();
		String rentbook = (String)session.getAttribute("rentbook");
		if( rentbook == null ) {
			//처음으로  선택 책에 들어올경우 조회수 증가
			user_Service.rentbook_hits(rentbook_Isbn);
			session.setAttribute("rentbook", "rentbook");
		}
		model.addAttribute("rentbook", rentbook_vo);
		return View_Path.Search_View.VIEW_PATH + "Rentbook_View.jsp?page="+page;
	}
	//신규도서 안내(10권)
	@RequestMapping("/rentbook_new_form.do")
	public String rentbook_new_form(Model model) {
		//전체 책정보
		List<RentbookVO> rentbook_list = user_Service.rentbook_new();
		model.addAttribute("rentbook_list", rentbook_list);
		return View_Path.Search_View.VIEW_PATH + "Rentbook_New.jsp";
	}
	
	//2.판매책 전체 검색.......................................................................
	@RequestMapping("/sellbook_search.do")
    public ModelAndView sellbook_search(@RequestParam(required=false)String search, Integer page){
		int nowPage = 1;
		//페지이가  null값인경우
		if( page != null ) {
			nowPage = page;
		}
		//책관련 api를 가지고 온다
		ModelAndView mav = new ModelAndView();
		System.out.println("search : " + search);
        if(search != null && search != ""){
            mav.addObject("sellbook_list",user_Service.sellbook_search(search, nowPage));
            //페이징 처리
            String pageMenu = user_Service.sellbook_pageMenu(search, nowPage);
            mav.addObject("pageMenu", pageMenu);
        }
        mav.setViewName(View_Path.Search_View.VIEW_PATH + "Sellbook_Search.jsp?page="+nowPage);
        return mav;
    }
	//선택 판매책 상세보기 폼
	@RequestMapping("/sellbook_view.do")
	public ModelAndView sellbook_view(@RequestParam(required=false)String sellbook_Isbn, int page, String search) {
		//판매책 Isbn을  10자리로 나누기
		sellbook_Isbn = sellbook_Isbn.replace("%20", "");
		//책관련 api를 가지고 온다
		ModelAndView mav = new ModelAndView();
		mav.addObject("sellbook",user_Service.sellbook_view(sellbook_Isbn, 1, 1));
		mav.setViewName(View_Path.Search_View.VIEW_PATH + "Sellbook_View.jsp?page="+page+"&search="+search);
		return mav;
	}
	
	
	//<5>열람실----------------------------------------------------------------------------------------------------------------------------
	//열람실 선택 폼
	@RequestMapping("/study_room.do")
	public String study_room() {
		return View_Path.Studyroom_View.VIEW_PATH + "Study_Room.jsp";
	}
	//내 예약폼
	@RequestMapping("/my_study_room_book.do")
	public String my_study_room_book(Model model) {
		//session 저장된 user의 정보 가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		
		if(user == null) {
			model.addAttribute("login", "no");
			return View_Path.Log_View.VIEW_PATH + "Library_Login_Check.jsp";
		}

		//test
		//String userID = "chounsa555";
		//SeatsVO t1_seat = user_Service.my_study_room_t1(userID); 
		//SeatsVO t2_seat = user_Service.my_study_room_t2(userID); 
		//SeatsVO t3_seat = user_Service.my_study_room_t3(userID);

		//시간별로 로그인 유저 아이디로 자리예약 검색
		SeatsVO t1_seat = user_Service.my_study_room_t1(user.getUserID()); 
		SeatsVO t2_seat = user_Service.my_study_room_t2(user.getUserID()); 
		SeatsVO t3_seat = user_Service.my_study_room_t3(user.getUserID());
		
		if( t1_seat != null ) {
			System.out.println("1번 : "  + t1_seat.getSeats_idx());
		}
		if( t2_seat != null ) {
			System.out.println("2번 : "  + t2_seat.getSeats_idx());
		}
		if( t3_seat != null ) {
			System.out.println("3번 : "  + t3_seat.getSeats_idx());
		}
		
		model.addAttribute("t1_seat",t1_seat);
        model.addAttribute("t2_seat",t2_seat);
        model.addAttribute("t3_seat",t3_seat);
		
		return View_Path.Studyroom_View.VIEW_PATH + "Study_Room_My.jsp";
	}
	//예약 취소하기
	@RequestMapping(value="my_study_room_cancel.do",produces = "application/json; charset=utf8")
	@ResponseBody
	public HashMap<String, String> my_study_room_cancel(int seats_idx, int num){
		//세션에 저장된 user의 정보가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		
		//예약취소하기 (성공여부까지 확인)
		String result = user_Service.my_study_room_cancel(seats_idx, user, num);

		//성공여부를 hashmap에 담아 데이터 값을 돌려준다.
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", result);
		System.out.println(map.get("result"));
		return map;
	}
	//멀티미디어실 선택 폼으로 이동
	@RequestMapping("/room_select_mult.do")
	public String room_select_mult(Model model) {
		//멀티미디어실 리스트 가져오기
		List<SeatsVO> seats_List = user_Service.room_select_mult();
		
		//현재 시간
		Calendar currentDate = Calendar.getInstance(); 
		int hour = currentDate.get(Calendar.HOUR_OF_DAY); 
		System.out.println("현재 시간 : " + hour);
		
		//멀티시간별 사용중인 좌석
		int use_count = user_Service.mult_use_count(hour);

		model.addAttribute("seats_List", seats_List);
		model.addAttribute("hour", hour);
		model.addAttribute("use_count", use_count);
		return View_Path.Studyroom_View.VIEW_PATH + "Study_Room_Mult.jsp";		
	}
	//열람실 선택 폼으로 이동
	@RequestMapping("/room_select_read.do")
	public String room_select_read(Model model) {
		//열람실 리스트 가져오기
		List<SeatsVO> seats_List = user_Service.room_select_read();
		
		//현재 시간
		Calendar currentDate = Calendar.getInstance(); 
		int hour = currentDate.get(Calendar.HOUR_OF_DAY); 
		System.out.println("현재 시간 : " + hour);
		
		//멀티시간별 사용중인 좌석
		int use_count = user_Service.read_use_count(hour);

		model.addAttribute("seats_List", seats_List);
		model.addAttribute("hour", hour);
		model.addAttribute("use_count", use_count);
		return View_Path.Studyroom_View.VIEW_PATH + "Study_Room_Read.jsp";	
	}
	//선택 자리 예약시간 확인하는폼으로 이동
	@RequestMapping("/room_select_time.do")
	public String room_select_time(int seats_idx, Model model) {
		SeatsVO seat = user_Service.seat_select(seats_idx);
		
		//현재 시간
		Calendar currentDate = Calendar.getInstance(); 
		int hour = currentDate.get(Calendar.HOUR_OF_DAY); 
		System.out.println("현재 시간 : " + hour);
		
		model.addAttribute("seat", seat);
		model.addAttribute("hour", hour);
		return View_Path.Studyroom_View.VIEW_PATH + "Study_Room_Time.jsp";	
	}
	//선택좌석에 시간별로 예약하기(최대 3)
	@RequestMapping("/room_time_book.do")
	public String room_time_book( int seats_idx, Model model, @RequestParam(value="time") List<Integer> times) {
		//System.out.println("seats_idx : " + seats_idx);
		//for (int j = 0; j < times.size(); j++) {
		//	System.out.println(times.get(j));
		//}
		
		//세션에 저장된 user의 정보가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		
		String result = user_Service.room_time_book(seats_idx, user.getUserID(), times);
		
		if(result.equals("fail")) {
			return View_Path.Studyroom_View.VIEW_PATH + "Study_Room_Bookedcheck.jsp";
		}
		
		return "redirect:my_study_room_book.do";
	}
	
}
