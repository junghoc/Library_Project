package service;


import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import com.google.gson.Gson;

import common.Common;
import dao.CartDAO;
import dao.OrdersDAO;
import dao.RentDAO;
import dao.RentbookDAO;
import dao.SeatsDAO;
import dao.UserDAO;
import util.Paging;
import vo.SellbookVO;
import vo.UserVO;
import vo.CartVO;
import vo.KakaoPayReadyVO;
import vo.OrdersVO;
import vo.Orders_DetailVO;
import vo.RentVO;
import vo.RentbookVO;
import vo.SeatsVO;


@Service("user_Service")
public class UserService {
	
	@Autowired
	RentbookDAO rentbook_dao;
	
	@Autowired
	RentDAO rent_dao;
	
	@Autowired
	CartDAO cart_dao;
	
	@Autowired
	SeatsDAO seats_dao;
	
	@Autowired
	OrdersDAO orders_dao;
	
	@Autowired
	UserDAO user_dao;

	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//2)유저
	//<1>예약----------------------------------------------------------------------------------------------------------------------------
	//1.대여 도서 예약.....................................................
	//선택도서 예약
	public int rentbook_reserve( RentVO rent_vo ) {
		int res = rent_dao.rentbook_reserve(rent_vo);
		//해당 책의 예약유무 변경
		if( res == 1) {
			//도서예약이 성공적으로 이루어 졌을 경우
			int reserve = rentbook_dao.rentbook_reserve(rent_vo.getRentbook_Isbn());
		}
		return res;
	}
	
	//2. 장바구니.....................................................
	//해당아이디의 cart정보 모두 가져오기
	public List<CartVO> user_sellbook_cart(String userID){
		List<CartVO> cart_list = cart_dao.user_sellbook_cart(userID);
		return cart_list;
	}
	//해당아이디 cart의 총합구하기
	public int user_sellbook_cart_total(String userID){
		int total = cart_dao.user_sellbook_cart_total(userID);
		return total;
	}
	//선택 판매책 장바구니에 담기
	public String sellbook_cart(CartVO cart_vo, UserVO user) {
		//판매책 Isbn에 %20을 제거
		String book_Isbn = cart_vo.getSellbook_Isbn().replace("%20", "");
				
		//<b>태그를 제거하고 저장
		Pattern pattern = Pattern.compile("<.*?>");
		Matcher matcher = pattern.matcher(cart_vo.getSellbook_Isbn());
		book_Isbn = matcher.replaceAll("");
		
		//제목에 <b>태그를 제거
		matcher = pattern.matcher(cart_vo.getSellbook_Name());
		String sellbook_Name = matcher.replaceAll("");

		//vo에 저장하기
		cart_vo.setUserID(user.getUserID());
		cart_vo.setSellbook_Isbn(book_Isbn);
		cart_vo.setSellbook_Name(sellbook_Name);
		
		//System.out.println("sellbook_Name : " + cart_vo.getSellbook_Name());
		//System.out.println("sellbook_Price : " + cart_vo.getSellbook_Price());
		//System.out.println("sellbook_Isbn : " + cart_vo.getSellbook_Isbn());
		//System.out.println("cart_Cnt : " + cart_vo.getCart_Cnt());
		//System.out.println("userID : " + cart_vo.getUserID());
		
		//선택 판매책 장바구니에 담기
		int res = cart_dao.sellbook_cart(cart_vo);
		
		//성공여부 확인
		String result = "fail";
		if( res == 1 ) {
			result = "success";
		}
		return result;	
	}
	//선택 판매책 수량 변경
	public String sellbook_cart_cnt(CartVO cart_vo) {
		//System.out.println("cart_idx : " + cart_vo.getCart_idx());
		//System.out.println("cart_Cnt : " + cart_vo.getCart_Cnt());
		//선택 판매책 장바구니에서 수량 변경
		int res = cart_dao.sellbook_cart_cnt(cart_vo);
		
		//성공여부 확인
		String result = "fail";
		if( res == 1 ) {
			result = "success";
		}
		return result;
	}
	//선택 판매책 삭제(update - 0)
	public String sellbook_del(int cart_idx) {
		//선택 판매책 장바구니에서 수량 변경
		int res = cart_dao.sellbook_del(cart_idx);
		
		//성공여부 확인
		String result = "fail";
		if( res == 1 ) {
			result = "success";
		}
		return result;
	}
	//선택 판매책 삭제(다중)
	public String sellbook_dels(List<Integer> check_arr) {
		int res = 0;
		String result = "fail";
		
		//선택 판매책 장바구니에서 수량 변경(1개씩 삭제 변경)
		for(int i = 0; i < check_arr.size(); i++ ) {
			res = cart_dao.sellbook_del(check_arr.get(i));
			if(res == 0) {
				//삭제 실패
				for(int j = 0; j < i; j++) {
					//작업실패했으므로 i번째 전까지의 값을 되돌려 놓는다
					cart_dao.sellbook_re(check_arr.get(j));
				}
				break;
			}
		}
		
		//성공여부 확인
		if( res == 1 ) {
			result = "success";
		}
		return result;
	}
	//장바구니에서 구매완료한 제품 변경
	public List<CartVO> sellbook_order_end(List<Integer> check_arr) {
		//장바구니에서 구매완료한 제품 변경
		int res = 0;
		List<CartVO> cart_vo = new ArrayList<CartVO>();
		for(int i = 0; i < check_arr.size(); i++ ) {
			//구매 도서의 카트를의 데이터 변경 및 데이터가져오기
			res = cart_dao.sellbook_order_end(check_arr.get(i));
			CartVO vo = cart_dao.sellbook_orders(check_arr.get(i));
			cart_vo.add(vo);
		}
		return cart_vo;
	}
	
	//3.판매도서 구매.......................................................................
	//판매책 구매폼이동
	public List<CartVO> sellbook_orders(List<Integer> check_arr){
		List<CartVO> cart_list = new ArrayList<CartVO>();
		//선택 판매책 리스트 가지고오기
		for(int i = 0; i < check_arr.size(); i++ ) {
			CartVO vo = cart_dao.sellbook_orders(check_arr.get(i));
			if(vo == null) {
				//데이터값 가지고오기 실패
				cart_list = null;
				break;
			}
			cart_list.add(vo);
		}
		return cart_list;
	}
	//주문 도서 책 정보 추가 및 가져오기
	public OrdersVO orders_books(OrdersVO orders_vo) {
		//주문도서책 정보 저장
		int res = orders_dao.orders_books(orders_vo);
		//주문도서 정보가지고오기
		OrdersVO vo = orders_dao.orders_invoice_check(orders_vo.getOrders_Invoice());
		
		return vo;
	}
	//송장번호 확인
	public OrdersVO orders_invoice_check(String orders_Invoice) {
		//송장번호 중복확인
		OrdersVO vo_check = orders_dao.orders_invoice_check(orders_Invoice);
		return vo_check;
	}
	//주문 상세보기 정보 넣기
	public int orders_detail(OrdersVO orders_vo, List<CartVO> cart_list) {
		int res = 0;
		
		//상세보기 vo 데이터 넣기
		Orders_DetailVO detail_vo = new Orders_DetailVO();
		detail_vo.setOrder_idx(orders_vo.getOrders_idx());
		
		for(int i = 0; i < cart_list.size(); i++) {
			detail_vo.setCart_idx(cart_list.get(i).getCart_idx());
			detail_vo.setO_detail_Cnt(cart_list.get(i).getCart_Cnt());
			//데이터 insert
			res = orders_dao.orders_detail(detail_vo);
		}
		
		return res;
	}
			
	//<2>마이페이지----------------------------------------------------------------------------------------------------------------------------
	//회원정보 수정
	public UserVO user_update(UserVO user_vo) {

		UserVO user_update;
		int res = 0;
		//비밀번호 변경 x
		if( user_vo.getUserPWD().equals("no_change") ) {
			//개인정보 변경(비밀번호 x)
			res = user_dao.user_update_nopwd(user_vo);
			//해당 id로 해당 데이터 가져오기
			user_update = user_dao.user_search_id(user_vo.getUserID());
		}else {
			//비밀번호 변경 o
			//비밀번호 암호화
			System.out.println("기존 pwd : " + user_vo.getUserPWD());
			String pwd = bcryptPasswordEncoder.encode(user_vo.getUserPWD());
			user_vo.setUserPWD(pwd);;
			System.out.println("인코딩 pwd : " + pwd);
			//비밀번호 변경
			res = user_dao.user_update_yespwd(user_vo);
			user_update = user_dao.user_search_id(user_vo.getUserID());
		}	
		
		return user_update;
	}
	//회원 탈퇴
	public int user_del(UserVO user_vo) {
		UserVO voBase = user_dao.user_search_id(user_vo.getUserID());
		int res;
		
		//비밀번호 체크
		if( !bcryptPasswordEncoder.matches(user_vo.getUserPWD(), voBase.getUserPWD()) ) {
			res = 0;
			return res;
		}
		
		//비밀번호 일치 회원탈퇴 
		res = user_dao.user_del(user_vo.getUserID());
		
		return res;
	}
	//유저별 대여책의 정보 가져오기
	public List<RentVO> user_rent_search(String userID){
		List<RentVO> rent_List = rent_dao.user_rent_search(userID);
		return rent_List;
	}
	//선택 대여한 책 대여 취소버튼
	public int user_rent_ccl(int rent_idx) {
		int res = rent_dao.user_rent_ccl(rent_idx);
		return res;
	}
	//유저별 구매책의 정보 가져오기
	public List<OrdersVO> user_sellbook_search(String userID){
		List<OrdersVO> orders_List = orders_dao.user_sellbook_search(userID);
		return orders_List;
	}
	//선택 주문정보 가져오기
	public OrdersVO orders_select_idx(int orders_idx) {
		OrdersVO orders_vo = orders_dao.orders_select_idx(orders_idx);
		return orders_vo;
	}
	//선택 주문 정보의 디테일(카트의정보)을 orders_idx를 통해 가져오기
	public List<CartVO> cart_list_idx(int orders_idx) {
		List<CartVO> cart_list = cart_dao.cart_list_idx(orders_idx);
		return cart_list;
	}
	
	//<3>결제----------------------------------------------------------------------------------------------------------------------------
	private static final String HOST = "https://kapi.kakao.com";
	private KakaoPayReadyVO kakaoPayReadyVO;
	public KakaoPayReadyVO kakaoPayReady(OrdersVO orders_vo, List<Integer> check_arr) {
		 
		String param = check_arr.get(0).toString();
		//System.out.println("param : " + param);
		for( int i = 1; i < check_arr.size(); i++) {
			param += "," + check_arr.get(i).toString();
			//System.out.println("param : " + param);
		}
			
        RestTemplate restTemplate = new RestTemplate();
	 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "카카오 어드민키");
        //headers.add("Accept", MediaType.APPLICATION_JSON_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", "528899");
        params.add("partner_user_id", orders_vo.getUserID());
        params.add("item_name", "도서관책");
        params.add("quantity", "1");
        params.add("total_amount", Integer.toString(orders_vo.getOrders_Amount()));
        params.add("tax_free_amount", "0");
        params.add("approval_url", "http://localhost:9090/lib/kakaoPaySuccess.do?check_arr="+param);
        params.add("cancel_url", "http://localhost:9090/lib/kakaoPayCancel.do");
        params.add("fail_url", "http://localhost:9090/lib/kakaoPaySuccessFail.do");
 
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        System.out.println("body : " + body);
        try {
	        	
        	//String 타입으로 데이터를 받아온다 
        	String response = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, String.class);
        	System.out.println(response);
        	//gson을 사용하여 vo에 데이터값을 저장
        	Gson gson = new Gson();
        	kakaoPayReadyVO = gson.fromJson(response, KakaoPayReadyVO.class);
            //kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
	            
            return kakaoPayReadyVO;
 
        } catch (RestClientException e) {
            // TODO Auto-generated catch block
        	System.out.println("RestClientException");
            e.printStackTrace();
        } catch (URISyntaxException e) {
            // TODO Auto-generated catch block
        	System.out.println("URISyntaxException");
            e.printStackTrace();
        }
        return null;
        
    }
			
	//<4>책 정보----------------------------------------------------------------------------------------------------------------------------
	//1. 대여책 전체 검색.....................................................
	public List<RentbookVO> rendbook_search(int nowPage){
		//페이징 처리를 위한 변수 
		int start = (nowPage - 1) * Common.Book.BLOCKLIST + 1;
		int end = start + Common.Book.BLOCKLIST - 1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		List<RentbookVO> rentbook_list = rentbook_dao.rendbook_search(map);
		return rentbook_list;
	}
	//전체 대여책의 갯수
	public int rentbook_count() {
		int book_count = rentbook_dao.rentbook_count();
		return book_count;
	}
	//페이징 처리
	public String rentbook_pageMenu(int nowPage) {
		//책 전체 개시물수 구하기
		int book_count = rentbook_dao.rentbook_count();
		//페이징 처리
		String pageMenu = Paging.getPaging("rentbook_search.do", nowPage, 
				book_count, Common.Book.BLOCKLIST, Common.Book.BLOCKPAGE);
		return pageMenu;
	}
	//컬럼별 내용 검색
	public List<RentbookVO> rentbook_search_curlum(int nowPage, String curlum, String search){
		//페이징 처리를 위한 변수 
		int start = (nowPage - 1) * Common.Book.BLOCKLIST + 1;
		int end = start + Common.Book.BLOCKLIST - 1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		List<RentbookVO> rentbook_list = null;
		if(curlum.equals("rentbook_Name")) {
			//책이름
			rentbook_list = rentbook_dao.rentbook_search_name(map);
		}else if(curlum.equals("rentbook_Category")) {
			//카테고리
			rentbook_list = rentbook_dao.rentbook_search_category(map);
		}else if(curlum.equals("rentbook_Company")) {
			//출판사
			rentbook_list = rentbook_dao.rentbook_search_company(map);
		}else if(curlum.equals("rentbook_Author")) {
			//저자
			rentbook_list = rentbook_dao.rentbook_search_author(map);
		}
		return rentbook_list;
	}
	//컬럼별 내용 검색 페이징 처리
	public String rentbook_search_pageMenu(int nowPage, String curlum, String search) {
		int book_count = 0;
		if(curlum.equals("rentbook_Name")) {
			//책이름
			book_count = rentbook_dao.rentbook_search_name_count(search);
		}else if(curlum.equals("rentbook_Category")) {
			//카테고리
			book_count = rentbook_dao.rentbook_search_category_count(search);
		}else if(curlum.equals("rentbook_Company")) {
			//출판사
			book_count = rentbook_dao.rentbook_search_company_count(search);
		}else if(curlum.equals("rentbook_Author")) {
			//저자
			book_count = rentbook_dao.rentbook_search_author_count(search);
		}
		
		String pageMenu = Paging.getPaging("rentbook_search_curlum.do", nowPage, 
				book_count, Common.Book.BLOCKLIST, Common.Book.BLOCKPAGE, curlum, search);
		return pageMenu;
	}
	//선택도서 조회수 증가
	public int rentbook_hits(String rentbook_Isbn) {
		int res = rentbook_dao.rentbook_hits(rentbook_Isbn);
		return res;
	}
	//선택 대여 도서 검색
	public RentbookVO rentbook_view(String rentbook_Isbn) {
		RentbookVO rentbook_vo = rentbook_dao.rentbook_view(rentbook_Isbn);
		return rentbook_vo;
	}
	//신규도서 안내(10권)
	public List<RentbookVO> rentbook_new(){
		List<RentbookVO> rentbook_list = rentbook_dao.rentbook_new();
		return rentbook_list;
	}
	
	//2. 판매책 전체 검색.....................................................
	public List<SellbookVO> sellbook_search(String keyword, int nowPage){
		//페이징 처리를 위한 변수 
		int start = (nowPage - 1) * Common.Book.BLOCKLIST + 1;
		int display =Common.Book.BLOCKLIST;
		String clientID = "네이버 API 아이디";
		String clientSecret = "네이버 API 비밀번호";
		List<SellbookVO> list = null;
		try {
			URL url;
			url = new URL("https://openapi.naver.com/v1/search/"
							+ "book.xml?query="
							+ URLEncoder.encode(keyword, "UTF-8")
							+ (display !=0 ? "&display=" +display :"")
							+ (start !=0 ? "&start=" +start :""));
			 
			URLConnection urlConn = url.openConnection();
			urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
			urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			         
			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));
			            
			int eventType = parser.getEventType();
			SellbookVO b = null;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
					case XmlPullParser.END_DOCUMENT: // 문서의 끝
						break;
					
					case XmlPullParser.START_DOCUMENT:
						list = new ArrayList<SellbookVO>();
						break;
					
					case XmlPullParser.END_TAG: {
						String tag = parser.getName();
						if(tag.equals("item")){
								list.add(b);
								b = null;
							}
						}
					
					case XmlPullParser.START_TAG: {
						String tag = parser.getName();
						switch (tag) {
						
							case "item":
							b = new SellbookVO();
							break;
							
							case "title":
							if(b != null)
							b.setTitle(parser.nextText());
							break;
							
							case "link":
							if(b != null)
							b.setLink(parser.nextText());
							break;
							
							case "image":
							if(b != null)
							b.setImage(parser.nextText());
							break;
							
							case "author":
							if(b != null)
							b.setAuthor(parser.nextText());
							break;
							
							case "price":
							if(b != null)
							b.setPrice(parser.nextText());
							break;
							
							case "discount":
							if(b != null)
							b.setDiscount(parser.nextText());
							break;
							
							case "publisher":
							if(b != null)
							b.setPublisher(parser.nextText());
							break;
							
							case "pubdate":
							if(b != null)
							b.setPubdate(parser.nextText());
							break;
							
							case "isbn":
							if(b != null)
							b.setIsbn(parser.nextText());
							break;
							
							case "description":
							if(b != null)
							b.setDescription(parser.nextText());
							break;
						}	
					}
				}
				eventType = parser.next();	
			}
			            
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}	
	//페이징 처리
	public String sellbook_pageMenu(String keyword, int nowPage) {
		//책 전체 개시물수 구하기
		int book_count = 70;
		//페이징 처리
		String pageMenu = Paging.getPaging("sellbook_search.do", nowPage, 
				book_count, Common.Book.BLOCKLIST, Common.Book.BLOCKPAGE, keyword);
		return pageMenu;
	}
	//선택 판매책 상세보기 폼
	public List<SellbookVO> sellbook_view(String keyword, int display, int start){
		String clientID = "네이버 API 아이디";
		String clientSecret = "네이버 API 비밀번호";
		List<SellbookVO> list = null;
		try {
			URL url;
			url = new URL("https://openapi.naver.com/v1/search/"
							+ "book.xml?query="
							+ URLEncoder.encode(keyword, "UTF-8")
							+ (display !=0 ? "&display=" +display :"")
							+ (start !=0 ? "&start=" +start :""));
			 
			URLConnection urlConn = url.openConnection();
			urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
			urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			         
			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			XmlPullParser parser = factory.newPullParser();
			parser.setInput(new InputStreamReader(urlConn.getInputStream()));
			            
			int eventType = parser.getEventType();
			SellbookVO b = null;
			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
					case XmlPullParser.END_DOCUMENT: // 문서의 끝
						break;
					
					case XmlPullParser.START_DOCUMENT:
						list = new ArrayList<SellbookVO>();
						break;
					
					case XmlPullParser.END_TAG: {
						String tag = parser.getName();
						if(tag.equals("item")){
								list.add(b);
								b = null;
							}
						}
					
					case XmlPullParser.START_TAG: {
						String tag = parser.getName();
						switch (tag) {
						
							case "item":
							b = new SellbookVO();
							break;
							
							case "title":
							if(b != null)
							b.setTitle(parser.nextText());
							break;
							
							case "link":
							if(b != null)
							b.setLink(parser.nextText());
							break;
							
							case "image":
							if(b != null)
							b.setImage(parser.nextText());
							break;
							
							case "author":
							if(b != null)
							b.setAuthor(parser.nextText());
							break;
							
							case "price":
							if(b != null)
							b.setPrice(parser.nextText());
							break;
							
							case "discount":
							if(b != null)
							b.setDiscount(parser.nextText());
							break;
							
							case "publisher":
							if(b != null)
							b.setPublisher(parser.nextText());
							break;
							
							case "pubdate":
							if(b != null)
							b.setPubdate(parser.nextText());
							break;
							
							case "isbn":
							if(b != null)
							b.setIsbn(parser.nextText());
							break;
							
							case "description":
							if(b != null)
							b.setDescription(parser.nextText());
							break;
						}	
					}
				}
				eventType = parser.next();	
			}
			            
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (XmlPullParserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	//<5>열람실----------------------------------------------------------------------------------------------------------------------------
	//1번시간 선택 유저의 아이디로 검색
	public SeatsVO my_study_room_t1(String userID) {
		SeatsVO t1_seat = seats_dao.my_study_room_t1(userID);
		return t1_seat;
	}
	//2번시간 선택 유저의 아이디로 검색
	public SeatsVO my_study_room_t2(String userID) {
		SeatsVO t2_seat = seats_dao.my_study_room_t2(userID);
		return t2_seat;
	}
	//1번시간 선택 유저의 아이디로 검색
	public SeatsVO my_study_room_t3(String userID) {
		SeatsVO t3_seat = seats_dao.my_study_room_t3(userID);
		return t3_seat;
	}
	//회원의 선택 시간 예약 취소하기
	public String my_study_room_cancel(int seats_idx, UserVO user, int num) {
		System.out.println("seats_idx : " + seats_idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("seats_idx", seats_idx);
		map.put("userID", user.getUserID());
		//test
		//map.put("userID", "chounsa555");
		
		//유저의 id와 자리를 가지고 예약 취소하기
		int res = 0;
		if(num == 1) {
			res = seats_dao.my_study_room_cancel1(map);
		}else if(num == 2) {
			res = seats_dao.my_study_room_cancel2(map);
		}else if(num == 3) {
			res = seats_dao.my_study_room_cancel3(map);
		}
		
		//성공여부 확인
		String result = "fail";
		if( res == 1 ) {
			result = "success";
		}
		return result;	
	}
	//멀티미디어실 리스트 가져오기
	public List<SeatsVO> room_select_mult(){
		List<SeatsVO> seats_List = seats_dao.room_select_mult();
		return seats_List;
	}
	//멀티시간별 사용중인 좌석
	public int mult_use_count(int hour) {
		int use_count = 0;
		if(hour >= 9 && hour < 12 ) {
			use_count = seats_dao.mult_use_count1();
		}else if(hour >= 12 && hour < 15 ) {
			use_count = seats_dao.mult_use_count2();
		}else if(hour >= 15 && hour < 18 ) {
			use_count = seats_dao.mult_use_count3();
		}
		
		System.out.println("사용중인 자리  : " + use_count);
		return use_count;
	}
	//열람실 리스트 가져오기
	public List<SeatsVO> room_select_read(){
		List<SeatsVO> seats_List = seats_dao.room_select_read();
		return seats_List;
	}
	//멀티시간별 사용중인 좌석
	public int read_use_count(int hour) {
		int use_count = 0;
		if(hour >= 9 && hour < 12 ) {
			use_count = seats_dao.read_use_count1();
		}else if(hour >= 12 && hour < 15 ) {
			use_count = seats_dao.read_use_count2();
		}else if(hour >= 15 && hour < 18 ) {
			use_count = seats_dao.read_use_count3();
		}
		
		System.out.println("사용중인 자리  : " + use_count);
		return use_count;
	}
	//선택 좌석의 정보 가져오기
	public SeatsVO seat_select(int seats_idx) {
		System.out.println("seats_idx : " + seats_idx);
		SeatsVO seat = seats_dao.seat_select(seats_idx);
		return seat;
	}
	//선택좌석의 시간별로 예약하기(최대 3)
	public String room_time_book(int seats_idx, String userID, List<Integer> times) {
		String result = "fail";
		//동일 시간대의 다른 좌석 중복 예약이 됬는지 확인
		for(int i = 0; i < times.size(); i++) {
			int seat_check = 0;
			//시간대 별로 확인
			if(times.get(i) == 1) {
				//9 ~ 12시
				seat_check = seats_dao.seat_time1_check(userID);
			}else if(times.get(i) == 2) {
				//12 ~ 15시
				seat_check = seats_dao.seat_time2_check(userID);
			}else if(times.get(i) == 3) {
				//15 ~ 18시
				seat_check = seats_dao.seat_time3_check(userID);
			}//if()
			
			//중복된 값이 있는경우 동일시간대 다른 자리에 예약됨
			if(seat_check != 0) {
				return result;
			}
			
		}//for()
		
		//자리와 유저의 아이디를 Hashmap에 저장
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("seats_idx", seats_idx);
		map.put("userID", userID);
		
		//동일시간대의 중복검사 완료후 예약
		for(int i = 0; i < times.size(); i++) {
			int res = 0;
			
			//선택 시간대 별로 예약 진행
			if(times.get(i) == 1) {
				//9 ~ 12시
				res = seats_dao.room_time1_book(map);
			}else if(times.get(i) == 2) {
				//12 ~ 15시
				res = seats_dao.room_time2_book(map);
			}else if(times.get(i) == 3) {
				//15 ~ 18시
				res = seats_dao.room_time3_book(map);
			}//if()
			
			//예약실패
			if(res == 0) {
				for (int j = 0; j < i; j++) {
					//이전에 넣었던 데이터를 삭제후 실패하기 전 데이터 복구
					if(times.get(j) == 1) {
						//9 ~ 12시
						res = seats_dao.my_study_room_cancel1(map);
					}else if(times.get(j) == 2) {
						//12 ~ 15시
						res = seats_dao.my_study_room_cancel2(map);
					}else if(times.get(j) == 3) {
						//15 ~ 18시
						res = seats_dao.my_study_room_cancel3(map);
					}//if()
				}
				return result;
			}
			
		}//for()
		
		//예약완료
		result = "success";
		
		return result;
	}
	
}
