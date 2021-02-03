package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.AdminVO;

@Repository("admin_dao")
public class AdminDAO {

	@Autowired
	SqlSession sqlSession;
	
	//<0>공통사항----------------------------------------------------------------------------------------------------------------------------
	//아이디 중복체크
	public AdminVO id_check(String adminID) {
		AdminVO vo = sqlSession.selectOne("admin.id_check", adminID);
		return vo;
	}
	//회원가입
	public int regi_insert(AdminVO vo) {
		int res = sqlSession.insert("admin.admin_insert", vo);
		return res;
	}
	//로그인(id찾기)
	public AdminVO login_id_check(String adminID) {
		AdminVO admin = sqlSession.selectOne("admin.login_id_check", adminID);
		return admin;
	}
	
	//<1> 관리자
	//6. 직원 관리----------------------------------------------------------------------------------------------------------------------------
	//직원 리스트 가지고 오기
	public List<AdminVO> admin_empl_list() {
		List<AdminVO> admin_List = sqlSession.selectList("admin.admin_empl_list");
		return admin_List;
	}
	//직원 관리 승인
	public int admin_employee_approval(String adminID) {
		int res = sqlSession.update("admin.admin_employee_approval", adminID);
		return res;
	}
	
	
}
