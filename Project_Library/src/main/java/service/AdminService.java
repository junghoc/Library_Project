package service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import common.Common;
import dao.AdminDAO;
import dao.BoardDAO;
import dao.CartDAO;
import dao.OrdersDAO;
import dao.RentDAO;
import dao.RentbookDAO;
import dao.SeatsDAO;
import dao.UserDAO;
import util.Paging;
import vo.AdminVO;
import vo.BoardVO;
import vo.Board_ComVO;
import vo.GongjiVO;
import vo.OrdersVO;
import vo.RentVO;
import vo.RentbookVO;
import vo.SeatsVO;
import vo.UserVO;

@Service("admin_Service")
public class AdminService {
	
	@Autowired
	AdminDAO admin_dao;
	
	@Autowired
	UserDAO user_dao;
	
	@Autowired
	BoardDAO board_dao;
	
	@Autowired
	SeatsDAO seats_dao;
	
	@Autowired
	RentDAO rent_dao;
	
	@Autowired
	CartDAO cart_dao;
	
	@Autowired
	OrdersDAO orders_dao;
	
	@Autowired
	RentbookDAO rentbook_dao;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	ServletContext application;
	
	//0)공통사항
	//<1>로그인----------------------------------------------------------------------------------------------------------------------------
	public AdminVO login_check(AdminVO vo) {
		//id가 일치하는 관리자 정보 가져오기
		AdminVO admin = admin_dao.login_id_check(vo.getAdminID());
		if( admin == null ) {
			//아이디존재 x
			 return null;
		}
		//아이디 존재 -> 비밀번호확인
		if( !bcryptPasswordEncoder.matches(vo.getAdminPWD(), admin.getAdminPWD()) ) {
			//비밀번호 일치하지 x
			return null;
		}
		//아이디 비밀번호 일치
		return admin;
	}

	
	//<2>회원가입----------------------------------------------------------------------------------------------------------------------------
	//아이디 중복체크======================================================================
	public String id_check(String adminID) {
		//중복되는 아이디가 있는지 확인
		AdminVO vo = admin_dao.id_check(adminID);
		String res = "no";
		//vo의 값이 null인경우 중복되는 아이디 없음.
		if( vo == null ) {
			//회원가입이 가능한 경우
			res = "yes";
		}
		String resultStr = String.format(
						"[{'result':'%s'}, {'adminID':'%s'}]", res, adminID);
		return resultStr;
	}
	//회원가입======================================================================
	public int regi_insert(AdminVO vo) {
		//비밀번호 암호화
		System.out.println("기존 pwd : " + vo.getAdminPWD());
		String adminPWD = bcryptPasswordEncoder.encode(vo.getAdminPWD());
		vo.setAdminPWD(adminPWD);
		System.out.println("인코딩 pwd : " + adminPWD);
		//회원가입
		int res = admin_dao.regi_insert(vo);
		return res;
	}
	
	//1) 관리자
	//<1> 회원 관리----------------------------------------------------------------------------------------------------------------------------
	//모든 유저의 정보를 가지고 온다
	public List<UserVO> admin_user_list(){
		List<UserVO> user_List = user_dao.admin_user_list();
		return user_List;
	}
	//회원 삭제
	public int admin_user_del(String userID) {
		int res = user_dao.user_del(userID);
		return res;
	}
	//회원 삭제 복구
	public int admin_user_restore(String userID) {
		int res = user_dao.admin_user_restore(userID);
		return res;
	}
	//선택 회원의 정보 가져오기
	public UserVO admin_user_info(String userID) {
		UserVO user = user_dao.admin_user_info(userID);
		return user;
	}
	//회원정보 수정(성공여부확인)
	public String admin_user_update(UserVO user) {
		String result = "fail";
		
		//비밀번호 암호화
		System.out.println("기존 pwd : " + user.getUserPWD());
		String userPWD = bcryptPasswordEncoder.encode(user.getUserPWD());
		user.setUserPWD(userPWD);
		System.out.println("인코딩 pwd : " + userPWD);
		//비밀번호 변경
		int res = user_dao.user_update_yespwd(user);
		if(res == 1) {
			//비밀번호 변경 성공
			result = "success";
		}
		
		return result;
	}
	
	//<2> 도서 관리----------------------------------------------------------------------------------------------------------------------------
	//대여도서 정보 가져오기
	public List<RentbookVO> admin_rentbook_list(){
		List<RentbookVO> rentbook_List = rentbook_dao.admin_rentbook_list();
		return rentbook_List;
	}
	//신규책 추가 
	public String admin_rentbook_insert(RentbookVO vo) throws IllegalStateException, IOException {
		String result = "fail";
		
		//신규책 추가
		int res = rentbook_dao.admin_rentbook_insert(vo);
		
		if(res == 1) {
			result = "success";
			//이미지 업로드
			String webPath = "/resources/images/book_img/";
			String savePath = application.getRealPath(webPath);
			System.out.println(savePath);
			
			//업로드 될 파일의 정보
			MultipartFile photo = vo.getPhoto();
			System.out.println("photo : " + photo);
			String filename = "no_file";
			//파일이 정상적으로 업로드 되었다면..
			if( !photo.isEmpty() ) {
				//업로드 된파일에 실제 파일명
				filename = vo.getRentbook_Isbn() + ".PNG";
				//저장할 파일경로 생성하기
				File saveFile = new File(savePath, filename);
				if( !saveFile.exists() ) {
					saveFile.mkdirs();
				}else {
					//동일한 파일명이 존재할경우 현재 업로드 시간을 파일명 뒤에 붙여서
					//중복을 방지해준다.
					saveFile.mkdirs();
				}
				//업로드 된 파일은 MultipartResolver클래스가 지정해놓은 임시 저장소에 자동으로 들어간다
				//임시저장소에 있는 파일은 일정기간이 지나면 자동으로 삭제되기 떄문에 개발자가지정해준 경로로 파일을 복사해둬야 한다.
				photo.transferTo(saveFile);
			}
		}
		
		return result;
	}
	//대여 도서 삭제
	public int admin_rentbook_del(String rentbook_Isbn) {
		int res = rentbook_dao.admin_rentbook_del(rentbook_Isbn);
		return res;
	}
	
	//<3> 주문 관리----------------------------------------------------------------------------------------------------------------------------
	//대여 주문조회
	public List<RentVO> admin_rent_list() {
		List<RentVO> rent_List = rent_dao.admin_rent_list();
		return rent_List;
	}
	//도서 대여
	public int admin_rent_rent(int rent_idx) {
		int res = rent_dao.admin_rent_rent(rent_idx);
		return res;
	}
	//도서 취소
	public int admin_rent_cancel(int rent_idx) {
		int res = rent_dao.admin_rent_cancel(rent_idx);
		return res;
	}
	//도서 반납
	public int admin_rent_ret(int rent_idx) {
		int res = rent_dao.admin_rent_ret(rent_idx);
		return res;
	}
	//대여도서를 다시 대여 가능하게 변경
	public int admin_rentbook_change(String rentbook_Isbn) {
		int res = rentbook_dao.admin_rentbook_change(rentbook_Isbn);
		return res;
	}
	//판매 도서 주문 리스트
	public List<OrdersVO> admin_orders_list(){
		List<OrdersVO> orders_List = orders_dao.admin_orders_list();
		return orders_List;
	}
	//선택 판매 도서 배송 완료
	public int admin_orders_finish(int orders_idx) {
		int res = orders_dao.admin_orders_finish(orders_idx);
		return res;
	}
	
	//<4> 열람실 관리----------------------------------------------------------------------------------------------------------------------------
	//열람실 리스트 전부 가져오기
	public List<SeatsVO> admin_seats_list(){
		List<SeatsVO> seats_List = seats_dao.admin_seats_list();
		return seats_List;
	}
	//열람실 초기화(전부다 빈자리로 만들기)
	public int admin_study_room_reset() {
		int res = seats_dao.admin_study_room_reset();
		return res;
	}

	//<5> 게시판 관리----------------------------------------------------------------------------------------------------------------------------
	//(1) 공지 게시판..........................................
	//공지사항 정보 가져오기
	public List<GongjiVO> admin_gongji_list() {
		List<GongjiVO> gongji_List = board_dao.admin_gongji_list();
		return gongji_List;
	}
	//선택 공지글 삭제
	public int admin_board_gongji_del(int gongji_idx) {
		int res = board_dao.admin_board_gongji_del(gongji_idx);
		return res;
	}
	//선택 일반글 복구
	public int admin_board_gongji_restore(int gongji_idx) {
		int res = board_dao.admin_board_gongji_restore(gongji_idx);
		return res;
	}
	//선택 공지글 공지글로 변경
	public int admin_board_gongji_main(int gongji_idx) {
		int res = board_dao.admin_board_gongji_main(gongji_idx);
		return res;
	}
	//선택 공지사항 정보 가져오기
	public GongjiVO admin_gongji_idx(int gongji_idx) {
		GongjiVO gongji = board_dao.gongji_view(gongji_idx);
		return gongji;
	}
	//선택 공지사항 글 수정(성공여부확인)
	public String admin_board_gongji_update(GongjiVO gongji) {
		//성공여부를 확인할 변수
		String result = "fail";
		
		int res = board_dao.admin_board_gongji_update(gongji);
		if(res == 1) {
			//비밀번호 변경 성공
			result = "success";
		}
		
		return result;
	}
	//새로운 공지글 작성
	public String dmin_board_gongji_insert(GongjiVO gongji) {
		//성공여부를 확인할 변수
		String result = "fail";
		
		int res = board_dao.admin_board_gongji_insert(gongji);
		if(res == 1) {
			//비밀번호 변경 성공
			result = "success";
		}
		
		return result;
	}
	
	//(2) 자유 게시판..........................................
	//자유게시판 정보 가져오기
	public List<BoardVO> admin_board_list() {
		List<BoardVO> board_List = board_dao.admin_board_list();
		return board_List;
	}
	//선택 자유게시판글 삭제
	public int admin_board_del(int board_idx) {
		int res = board_dao.board_delete(board_idx);
		return res;
	}
	//선택 자유게시판글 복구
	public int admin_board_restore(int board_idx) {
		int res = board_dao.admin_board_restore(board_idx);
		return res;
	}
	//선택 자유게시판글 정보 가져오기
	public BoardVO admin_board_info(int board_idx) {
		BoardVO board = board_dao.board_view(board_idx);
		return board;
	}
	//선택 자유게시판의 댓글 가져오기
	public List<Board_ComVO> admin_board_com_list(int nowPage, int board_idx){
		//페이징처리 시작, 끝, 페이지를 가져오기
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		//페이징 처리를 위한 맵퍼에 시작과 끝 저장 그리고 ref저장
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		map.put("board_idx", board_idx);
		//선택 자유게시판의 댓글 가져오기
		List<Board_ComVO> com_List = board_dao.admin_board_com_list(map);
		return com_List;
	}
	//선택 자유게시판의 페이징 처리
	public String admin_board_com_pageMenu(int nowPage, int board_idx) {
		//해당 게시글 댓글의 총 갯수 구하기
		int com_total = board_dao.admin_board_com_list_total(board_idx);
		//페이징 처리
		String pageMenu = Paging.getPaging("admin_board_update_window_form.do", nowPage, 
				com_total, Common.Board.BLOCKLIST, Common.Board.BLOCKPAGE, board_idx);
		
		return pageMenu;	
	}

	//(2-1) 자유 게시판 댓글..........................................
	//선택 댓글 삭제
	public int admin_board_com_del(int board_com_idx) {
		int res = board_dao.board_com_del(board_com_idx);
		return res;
	}
	//선택 댓글 삭제
	public int admin_board_com_restore(int board_com_idx) {
		int res = board_dao.admin_board_com_restore(board_com_idx);
		return res;
	}
	
	//<6> 직원 관리----------------------------------------------------------------------------------------------------------------------------
	//직원 리스트 가지고 오기
	public List<AdminVO> admin_empl_list() {
		List<AdminVO> admin_List = admin_dao.admin_empl_list();
		return admin_List;
	}
	//직원 관리 승인
	public int admin_employee_approval(String adminID) {
		int res = admin_dao.admin_employee_approval(adminID);
		return res;
	}
	
}
