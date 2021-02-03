package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.UserVO;

@Repository("user_dao")
public class UserDAO {

	@Autowired
	SqlSession sqlSession;
	
	//<0>공통사항----------------------------------------------------------------------------------------------------------------------------
	//1.로그인================================================================
	//로그인 확인
	public UserVO login_check(String userID) {
		UserVO user = sqlSession.selectOne("user.login_check", userID);
		return user;
	}
	//아이디찾기
	public UserVO id_find(UserVO vo) {
		UserVO user = sqlSession.selectOne("user.id_find", vo);
		return user;
	}
	//비밀번호 찾기
	public UserVO pwd_find(UserVO vo) {
		UserVO user = sqlSession.selectOne("user.pwd_find", vo);
		return user;
	}
	//비밀번호 변경
	public int pwd_change(UserVO vo) {
		int res = sqlSession.update("user.pwd_change", vo);
		return res;
	}
	
	//2.회원가입================================================================
	//아이디 중복체크
	public UserVO id_check(String userID) {
		UserVO vo = sqlSession.selectOne("user.id_check", userID);
		return vo;
	}
	//회원가입
	public int regi_insert(UserVO vo) {
		int res = sqlSession.insert("user.user_insert", vo);
		return res;
	}
	//유저번호 중복확인
	public UserVO key_check(String key) {
		UserVO key_check = sqlSession.selectOne("user.key_check", key);
		return key_check;
	}
	
	//<1>관리자----------------------------------------------------------------------------------------------------------------------------
	//1.회원 관리================================================================
	//모든 유저의 정보를 가지고온다
	public List<UserVO> admin_user_list(){
		List<UserVO> user_List = sqlSession.selectList("user.admin_user_list");
		return user_List;
	}
	//회원 삭제 복구
	public int admin_user_restore(String userID) {
		int res = sqlSession.update("user.admin_user_restore", userID);
		return res;
	}
	//선택 회원의 정보 가져오기
	public UserVO admin_user_info(String userID) {
		UserVO user = sqlSession.selectOne("user.admin_user_info", userID);
		return user;
	}
	
	//<2>유저----------------------------------------------------------------------------------------------------------------------------
	//2.마이페이지================================================================
	//개인정보 변경(비밀번호 x)
	public int user_update_nopwd(UserVO vo) {
		int res = sqlSession.update("user.user_update_nopwd", vo);
		return res;
	}
	//개인정보 변경(비밀번호 o)
	public int user_update_yespwd(UserVO vo) {
		int res = sqlSession.update("user.user_update_yespwd", vo);
		return res;
	}
	//id로 해당 정보 가지고오기
	public UserVO user_search_id(String userID) {
		UserVO user_update = sqlSession.selectOne("user.user_search_id", userID);
		return user_update;
	}
	//회원탈퇴
	public int user_del(String userID) {
		int res = sqlSession.update("user.user_del", userID);
		return res;
	}
	
}
