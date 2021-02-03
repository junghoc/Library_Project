package service;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import common.Common;
import dao.BoardDAO;
import dao.UserDAO;
import util.Paging;
import vo.BoardVO;
import vo.Board_ComVO;
import vo.GongjiVO;
import vo.UserVO;

@Service("com_Service")
public class ComService {
	
	@Autowired
	UserDAO user_dao;
	
	@Autowired
	BoardDAO board_dao;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//<0>공통사항
	//1.로그인----------------------------------------------------------------------------------------------------------------------------
	public UserVO login_check(UserVO vo) { 
		//이름과 메일이 일치하는 유저의 정보 가져오기
		UserVO user	= user_dao.login_check(vo.getUserID()); 
		if( user == null ) { 
			//아이디 존재 x
			return null; 
		} //아이디 존재 -> 비밀번호 확인 
		if(!bcryptPasswordEncoder.matches(vo.getUserPWD(), user.getUserPWD()) ) { 
			//비밀번호	일치하지 x 
			return null; 
			} //아이디 비밀번호 일치 
		return user; 
	}
	
	//1)아이디 찾기........................................................
	public String id_find(UserVO vo) {
		//유저 정보 가져오기
		UserVO user = user_dao.id_find(vo);
		String res = "no";
		String result = "";
		//id 체크
		if(user != null) {
			//아이디 존재(회원탈퇴 제외)
			res = "yes";
			result = String.format(
					"[{'res':'%s'}, {'userName':'%s'}, {'email1':'%s'}, {'email2':'%s'}]",
					res, user.getUserName(), user.getEmail1(), user.getEmail2());
			return result;
		}
		//아이디 존재x(회원탈퇴 제외)
		result = String.format("[{'res':'%s'}]", res);
		return result;
	}
	//id찾기 인증완료 후 아이디 확인
	public UserVO id_find_check(UserVO vo) {
		//이름과 메일이 일치하는 유저의 정보 가져오기
		UserVO user = user_dao.id_find(vo);
		return user;
	}
	//2)비멀번호 찾기...............................................................
	public String pwd_find(UserVO vo) {
		//유저 정보가져오기
		UserVO user = user_dao.pwd_find(vo);
		String res = "no";//체크를 위한 변수
		String result = "";//리턴할 변수
		//id 체크
		if(user != null) {
			res = "yes";
			result = String.format(
					"[{'res':'%s'}, {'userID':'%s'}, {'email1':'%s'}, {'email2':'%s'}]",
					res, user.getUserID(), user.getEmail1(), user.getEmail2());
			return result;
		}
		//아이디 존재할시
		result = String.format("[{'res':'%s'}]", res);
		return result;
	}
	//비밀번호 변경
	public String pwd_find_change(UserVO vo) {
		//비밀번호 암호화
		System.out.println("기존 pwd : " + vo.getUserPWD());
		String userPWD = bcryptPasswordEncoder.encode(vo.getUserPWD());
		vo.setUserPWD(userPWD);
		System.out.println("인코딩 pwd : " + userPWD);
		
		//비밀번호 변경
		int res = user_dao.pwd_change(vo);
		String result = "no";
		if(res == 1) {
			//변경 성공시
			result = "yes";
		}
		return result;
	}
	
	//2.회원가입----------------------------------------------------------------------------------------------------------------------------
	//아이디 중복체크======================================================================
	public String id_check(String userID) {
		//중복되는 아이디가 있는지 확인
		UserVO vo = user_dao.id_check(userID);
		String res = "no";
		//vo의 값이 null인경우 중복되는 아이디 없음.
		if( vo == null ) {
			//회원가입이 가능한 경우
			res = "yes";
		}
		String resultStr = String.format(
						"[{'result':'%s'}, {'userID':'%s'}]", res, userID);
		return resultStr;
	}
	
	//이메일 보내기======================================================================
	private int size;
	//인증키 생성
	public String getKey(int size) {
		this.size = size;
	    return getAuthCode();
	}
	//인증코드 난수 발생
	public String getAuthCode() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;
		
		while(buffer.length() < size) {
			num = random.nextInt(10);
			buffer.append(num);
		}
		
		return buffer.toString();
	    }
	//이메일 보내기
	public String sendAuthMail(String email) {
		//6자리 난수 인증번호 생성
		String authKey = getKey(6);
		//인증메일 보내기
		//메일 제목, 내용
		String subject = "[도서관] 이메일 인증 번호입니다. ";
		String content = "이메일 인증을 완료해 주세요."
						+ "\n"
						+ "도서관의 회원이 되시는 걸 진심으로 환영합니다."
						+ "\n"
						+ "이메일 인증을 완료하셔야 정상적으로 진행이 가능합니다.\n"
						+ "앞으로 도서관 서비스에 많은 관심과 사랑 부탁 드립니다.\n"
						+ "\n"
						+ "인증번호 :" + authKey
						+ "\n감사합니다.";
		// 보내는 사람
		String from = "보내는사람 이메일 주소";
		try {
			// 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");
			// 메일 내용을 채워줌
			mailHelper.setFrom(from);	// 보내는 사람 셋팅
			mailHelper.setTo(email);		// 받는 사람 셋팅
			mailHelper.setSubject(subject);	// 제목 셋팅
			mailHelper.setText(content);	// 내용 셋팅
			// 메일 전송
			mailSender.send(mail);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return authKey;
	}
	
	//회원가입======================================================================
	public int regi_insert(UserVO vo) {
		while(true) {
			//7자리 난수로 유저번호 등록
			String key = "user" + getKey(7);
			//유저번호 중복확인
			UserVO key_check = user_dao.key_check(key);
			if(key_check ==  null) {
				System.out.println("key 중복안됨 : " + key);
				vo.setKey(key);
				break;
			}
		}
		//비밀번호 암호화
		System.out.println("기존 pwd : " + vo.getUserPWD());
		String userPWD = bcryptPasswordEncoder.encode(vo.getUserPWD());
		vo.setUserPWD(userPWD);
		System.out.println("인코딩 pwd : " + userPWD);
		//회원가입
		int res = user_dao.regi_insert(vo);
		return res;
	}
	
	//3.게시판-----------------------------------------------------------------------------------------------------
	//1) 공지게시판==========================================================================
	//공지 게시판 리스트
	public List<GongjiVO> board_gongji_list(int nowPage) {
		//페이징 처리를 위한 변수 
		int start = (nowPage - 1) * Common.Gongji.BLOCKLIST + 1;
		int end = start + Common.Gongji.BLOCKLIST - 1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		//페이지별 게시물 조회
		List<GongjiVO> gongji_List = board_dao.board_gongji_list(map);
		return gongji_List;
	}
	//공지게시판 페이징처리
	public String gongji_pageMenu(int nowPage) {
		//전체 게시물수 구하기
		int gongji_total = board_dao.gongji_row_total();
		//페이징 처리
		String pageMenu = Paging.getPaging("board_gongji_list.do", nowPage, 
				gongji_total, Common.Gongji.BLOCKLIST, Common.Gongji.BLOCKPAGE);
		return pageMenu;
	}
	//공지게시판 선택 게시물 한건 조회
	public GongjiVO gongji_view(int gongji_idx) {
		GongjiVO gongji_vo = board_dao.gongji_view(gongji_idx);
		return gongji_vo;
	}
	//공지게시판 조회수 증가
	public int gongji_readhit(int gongji_idx) {
		int res = board_dao.gongji_readhit(gongji_idx);
		return res;
	}
	
	//2) 자유게시판==========================================================================
	//자유 게시판 리스트
	public List<BoardVO> board_list(int nowPage){
		//페이징 처리를 위한 변수
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		//페지이별 게시물 조회
		List<BoardVO> board_List = board_dao.board_list(map);
		return board_List;
	}
	//자유게시판 페이징 처리
	public String board_pageMenu(int nowPage) {
		//전체 게시물수 구하기
		int board_total = board_dao.board_row_total();
		//페이징 처리
		String pageMenu = Paging.getPaging("board_gongji_list.do", nowPage, 
				board_total, Common.Gongji.BLOCKLIST, Common.Gongji.BLOCKPAGE);
		return pageMenu;
	}
	//자유게시판 선택 게시물 한건 조회
	public BoardVO board_view(int board_idx) {
		BoardVO board_vo = board_dao.board_view(board_idx);
		return board_vo;
	}
	//자유게시판 조회수 증가
	public int board_readhit(int board_idx) {
		int res = board_dao.board_readhit(board_idx);
		return res;
	}
	//자유게시판 새글 작성하기
	public int board_write(BoardVO board_vo) {
		int res = board_dao.board_write(board_vo);
		return res;
	}
	//자유게시판 선택글 삭제
	public String board_delete(int board_idx) {
		//삭제의 성공 유무를 확인할 변수
		String result = "no";
		//삭제가 된 것 처럼 업데이트를 수행 
		int res = board_dao.board_delete(board_idx);
		if( res == 1 ) {
			result = "yes"; 
		}
		return result;
	}
	//자유게시판 선택글 수정
	public String board_modify(BoardVO board_vo) {
		String result = "no";
		int res = board_dao.board_modify(board_vo);
		if(res == 1) {
			//수정완료
			result = "yes";
		}
		return result;
	}

	//3) 자유게시판 댓글==========================================================================
	//자유 게시판 댓글 리스트
	public List<Board_ComVO> board_com_list(int board_idx){
		//댓글 리스트 가져오기
		List<Board_ComVO> board_com_List = board_dao.board_com_list(board_idx);
		return board_com_List;
	}
	//자유 게시판 총 페이지
	public int board_com_count(int board_idx) {
		//총 갯수가져오기
		int board_com_count = board_dao.board_com_count(board_idx);
		return board_com_count;
	}
	//자유 게시판 댓글 작성
	public int board_com_write(Board_ComVO board_com_vo) {
		//댓글 작성
		int res = board_dao.board_com_write(board_com_vo);
		return res;
	}
	//자유 게시판 댓글 삭제
	public String board_com_del(int board_com_idx) {
		String result = "no";
		//선택 댓글이 삭제가 된것 처럼 업데이트
		int res = board_dao.board_com_del(board_com_idx);
		if( res == 1 ) {
			result = "yes"; 
		}
		return result;
	}
}
