package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.ComService;
import service.UserService;
import util.View_Path;
import vo.BoardVO;
import vo.Board_ComVO;
import vo.GongjiVO;
import vo.RentbookVO;
import vo.UserVO;

@Controller
public class ComController {

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	ComService com_Service;
	
	@Autowired
	UserService user_Service;
	
	//<0>공통사항
	//0.메인 화면 선택----------------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value={"/","/select.do"})
	public String select_View() {
		return View_Path.Main_View.VIEW_PATH + "Library_Select.jsp";
	}
	//유저 페이지
	@RequestMapping("/main.do")
	public String main_View(Model model) {
		int nowPage = 1;
		
		//페이지별 게시물 조회
		List<GongjiVO> gongji_List = com_Service.board_gongji_list(nowPage);
		
		//전체 책정보
		List<RentbookVO> rentbook_list = user_Service.rentbook_new();
		
		model.addAttribute("rentbook_list", rentbook_list);
		model.addAttribute("gongji_List", gongji_List);
		return View_Path.Main_View.VIEW_PATH + "Library_Main.jsp";
	}
	
	//1.로그인----------------------------------------------------------------------------------------------------------------------------
	//로그인 폼화면===============================================================================================================
	@RequestMapping("/login_form.do")
	public String login_form(){
		return View_Path.Log_View.VIEW_PATH + "Library_Login.jsp"; 
	}
	//로그아웃 폼
	@RequestMapping("/logout_form.do")
	public String logout_form() {
		return View_Path.Log_View.VIEW_PATH + "Library_Logout.jsp"; 
	}
	//로그인
	
	 @RequestMapping("/login_check.do") 
	 public String login_check(UserVO vo) { 
		 UserVO user = com_Service.login_check(vo); 
		 //아이디 or 비밀번호가 일치하지 않는경우session 저장을 안해준다. 
		 if(user == null) { 
			 return View_Path.Log_View.VIEW_PATH + "Library_Login_Check.jsp"; } //session에 정보 저장 session = request.getSession();
		 session.setAttribute("user", user); //세션 유지시간
		 session.setMaxInactiveInterval(60 * 60);//1시간 
		 return View_Path.Log_View.VIEW_PATH + "Library_Login_Check.jsp"; 
	 }
	 
	//로그아웃
	@RequestMapping("/logout.do")
	public String logout() {
		//세션에 등록되어 있는 데이터 삭제
		session.removeAttribute("user");
		return "main.do";
	}
	//아이디&비밀번호 찾기 폼화면===============================================================================================================
	@RequestMapping("/idpwd_find_form.do")
	public String idpwd_find_form() {
		return View_Path.Idpwd_View.VIEW_PATH + "Library_Idpwd_Find.jsp";
	}
	//아이디 비밀번호 찾기 창
	@RequestMapping("/idpwd_find_window.do")
	public String idpwd_find_window() {
		return View_Path.Idpwd_View.VIEW_PATH + "Library_Idpwd_Find_Window.jsp";
	}
	//1)아이디 찾기..................................................................
	@RequestMapping("/id_find.do")
	@ResponseBody
	public String id_find(UserVO vo) {
		String result = com_Service.id_find(vo);
		return result;
	}
	//id찾기 이메일 인증 폼
	@RequestMapping("/id_find_check_form.do")
	public String id_find_check_form(Model model, UserVO user) {
		model.addAttribute("user", user);
		return View_Path.Idpwd_View.VIEW_PATH + "Library_Idsearch_Check.jsp";
	}
	//id찾기 인증완료 후 아이디 확인
	@RequestMapping("id_find_check.do")
	public String id_find_check(UserVO vo, Model model) {
		UserVO user = com_Service.id_find_check(vo);
		model.addAttribute("user", user);
		return View_Path.Idpwd_View.VIEW_PATH + "Library_Idsearch_Find.jsp";
	}
	
	//2)비밀번호 찾기...............................................................
	@RequestMapping("/pwd_find.do")
	@ResponseBody
	public String pwd_find(UserVO vo) {
		String result = com_Service.pwd_find(vo);
		return result;
	}
	//pwd 찾기 이메일 인증 폼
	@RequestMapping("/pwd_find_check_form.do")
	public String pwd_find_check_form(UserVO vo, Model model) {
		model.addAttribute("user", vo);
		return View_Path.Idpwd_View.VIEW_PATH + "Library_Pwdsearch_Check.jsp";
	}
	//pwd변경 폼(userID,email1,email2)
	@RequestMapping("/pwd_find_change_form.do")
	public String id_find_change_form(UserVO vo, Model model) {
		model.addAttribute("user", vo);
		return View_Path.Idpwd_View.VIEW_PATH + "Library_Pwdsearch_Change.jsp";
	}
	//비밀번호 변경(userID,userPWD,email1,email2)
	@RequestMapping("/pwd_find_change.do")
	@ResponseBody
	public String pwd_find_change(UserVO vo) {
		String result = com_Service.pwd_find_change(vo);
		return result;
	}
	
	//2.회원가입----------------------------------------------------------------------------------------------------------------------------
	//회원가입 조인
	@RequestMapping("/register_join.do")
	public String register_join(){
		return View_Path.Regi_View.VIEW_PATH + "Library_Regi_Join.jsp"; 
	}
	//회원가입 폼
	@RequestMapping("/register_form.do")
	public String register_from() {
		return View_Path.Regi_View.VIEW_PATH + "Library_Regi.jsp";
	}
	//아이디 중복체크
	@RequestMapping("/id_check.do")
	@ResponseBody
	public String id_check(String userID) {
		//중복되는 아이디 확인 후 회원가입이 가능한지 확인
		String resultStr = com_Service.id_check(userID);
		return resultStr;
	}
	//이메일 인증메일 보내기
	@RequestMapping("/sendmail.do")
	@ResponseBody
	public String cer_Email( String email ) {
		/* email = "chounsa5555@naver.com"; */
		System.out.println(email);
		//임의의 authKey 생성 & 이메일 발송
		String authKey = com_Service.sendAuthMail(email);
		System.out.println(authKey);
		return authKey;
	}
	//회원가입
	@RequestMapping("/register.do")
	public String register(UserVO vo) {
		int res = com_Service.regi_insert(vo);
		return "register_check.do";
	}
	//회원가입 확인 폼
	@RequestMapping("/register_check.do")
	public String register_check(){
		return View_Path.Regi_View.VIEW_PATH + "Library_Regi_Check.jsp";
	}
	
	//3.게시판----------------------------------------------------------------------------------------------------------------------------
	//1) 공지게시판...............................................................................................
	@RequestMapping("/board_gongji_list.do")
	public String board_gongji_list( Model model, Integer page ) {
		int nowPage = 1;
		//페지이가  null값인경우
		if( page != null ) {
			nowPage = page;
		}
		//페이지별 게시물 조회
		List<GongjiVO> gongji_List = com_Service.board_gongji_list(nowPage);
		//페이징 처리
		String pageMenu = com_Service.gongji_pageMenu(nowPage);
		//포워딩
		model.addAttribute("gongji_List", gongji_List);
		model.addAttribute("pageMenu", pageMenu);
		//선택 게시물에서 메인메뉴로 나온경우
		request.getSession().removeAttribute("gongji");
		return View_Path.Board_View.VIEW_PATH + "Board_Gongji_List.jsp?page=" + nowPage;
	}
	//공지 게시판 선택 게시글 보기
	@RequestMapping("/board_gongji_view.do")
	public String board_gongji_view(Model model, int gongji_idx, int page) {
		//선택 게시물 한건 조회
		GongjiVO gongji_vo = com_Service.gongji_view(gongji_idx);
		//다중 새로고침 방지 위한 세션 생성
		session = request.getSession();
		String gongji = (String)session.getAttribute("gongji");
		if( gongji == null ) {
			//처음으로  게시물 들어올경우 조회수 증가
			com_Service.gongji_readhit(gongji_idx);
			session.setAttribute("gongji", "readhit");
		}
		model.addAttribute("gongji_vo", gongji_vo);
		return View_Path.Board_View.VIEW_PATH + "Board_Gongji_View.jsp?page=" + page;
	}
	
	//2) 자유게시판...............................................................................................
	@RequestMapping("/board_list.do")
	public String list( Model model, Integer page ) {
		int nowPage = 1;
		if( page != null ) {
			nowPage = page;
		}
		//페이지별 게시물 조회
		List<BoardVO> board_List = com_Service.board_list(nowPage);
		//페이징 처리
		String pageMenu = com_Service.board_pageMenu(nowPage); 
		//포워딩
		model.addAttribute("board_List", board_List);
		model.addAttribute("pageMenu", pageMenu);
		//선택 게시물에서 메인메뉴로 나온경우
		request.getSession().removeAttribute("board");
		return View_Path.Board_View.VIEW_PATH + "Board_List.jsp";
	}
	//자유 게시판 새글 작성 폼
	@RequestMapping("/user_board_write_form.do") 
	public String board_write_form() { 
		return	View_Path.Board_View.VIEW_PATH + "Board_Write.jsp"; 
	}
	//자유 게시판 새글 작성
	@RequestMapping("/user_board_write.do") 
	public String board_write(BoardVO board_vo) {
		//세션에 저장된 user의 정보가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		//userID 및 userName를 board_vo저장
		board_vo.setUserID(user.getUserID());
		board_vo.setUserName(user.getUserName());
		//IP board_vo에 저장하기
		String board_IP = request.getRemoteAddr();
		board_vo.setBoard_IP(board_IP);
		System.out.println("자유게시판 작성자 IP : " + board_IP);
		
		//새글 작성
		com_Service.board_write(board_vo); 
		return "redirect:board_list.do";
	}
	//자유 게시판 선택 게시글 보기
	@RequestMapping("/board_view.do") 
	public String board_view(Model model, int board_idx) {
		//해당 글 가져오기
		BoardVO board_vo = com_Service.board_view(board_idx);
		
		//해당 글 댓글 가져오기......................................................................................3) 자유게시판 댓글
		List<Board_ComVO> board_com_List = com_Service.board_com_list(board_idx);
		//해당 글 총 댓글 갯수
		int board_com_count = com_Service.board_com_count(board_idx);
		
		//조회수 중복 방지
		if(session.getAttribute("board") == null) {
			session.setAttribute("board", "readhit");
			//조회수 증가
			com_Service.board_readhit(board_idx);
		}
		model.addAttribute("board_vo", board_vo);
		model.addAttribute("board_com_List", board_com_List);
		model.addAttribute("board_com_count", board_com_count);
		return View_Path.Board_View.VIEW_PATH + "Board_View.jsp";
	}
	//자유 게시판 선택글 삭제
	@RequestMapping("/user_board_delete.do")
	@ResponseBody 
	public String board_delete(int board_idx) {
		//선택글 삭제의 결과값을 result에 담아준다
		String result = com_Service.board_delete(board_idx);
		return result;
	}
	//자유 게시판 선택글 수정 폼
	@RequestMapping("/user_board_modify_form.do")
	public String board_modify_form(int board_idx, Model model) {
		//선택글 수정을 위해 선택한 게시글 가져오기
		BoardVO board_vo = com_Service.board_view(board_idx);
		model.addAttribute("board_vo", board_vo);
		return View_Path.Board_View.VIEW_PATH + "Board_Modify.jsp"; 
	}
	//자유게시판 선택글 수정
	@RequestMapping("/user_board_modify.do")
	@ResponseBody
	public String board_modify(BoardVO board_vo) {
		//선택한 게시글에 아이피 저장
		board_vo.setBoard_IP(request.getRemoteAddr());
		//수정
		String result = com_Service.board_modify(board_vo);
		return result;
	}
	
	//3) 자유게시판 댓글...............................................................................................
	//자유 게시판 댓글 달기
	@RequestMapping("/user_board_com_write.do")
	public String board_com_write(Board_ComVO board_com_vo, int page) {
		System.out.println(board_com_vo.getBoard_idx());
		//세션에 저장된 user의 정보가져오기
		UserVO user = (UserVO)session.getAttribute("user");
		//IP,userID 및 userName를  board_com_vo저장
		board_com_vo.setUserID(user.getUserID());
		board_com_vo.setUserName(user.getUserName());
		board_com_vo.setBoard_com_IP(request.getRemoteAddr());
		//댓글 작성
		int res = com_Service.board_com_write(board_com_vo);
		return "redirect:board_view.do?page="+page+"&board_idx="+board_com_vo.getBoard_idx(); 
	}
	//자유 게시판 댓글 삭제
	@RequestMapping("/user_board_com_del.do")
	@ResponseBody
	public String board_com_del(int board_com_idx) {
		String result = com_Service.board_com_del(board_com_idx);
		return result;
	}
	
	//4.도서관 안내----------------------------------------------------------------------------------------------------------------------------
	//인사말 폼
	@RequestMapping("/about_pre.do")
	public String about_pre() {
		return View_Path.About_View.VIEW_PATH + "About_Pre.jsp";
	}
	//오시는길 폼
	@RequestMapping("/about_come.do")
	public String about_come() {
		return View_Path.About_View.VIEW_PATH + "About_Come.jsp";
	}
	//조직도 폼
	@RequestMapping("/about_organization.do")
	public String about_organization() {
		return View_Path.About_View.VIEW_PATH + "About_Organization.jsp";
	}
	
}
