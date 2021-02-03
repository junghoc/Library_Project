package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.RentVO;

@Repository("rent_dao")
public class RentDAO {

	@Autowired
	SqlSession sqlSession;

	//1.관리자
	//<3>주문 관리----------------------------------------------------------------------------------------------------------------------------
	//대여 주문조회
	public List<RentVO> admin_rent_list() {
		List<RentVO> rent_List = sqlSession.selectList("rent.admin_rent_list");
		return rent_List;
	}
	//도서 대여
	public int admin_rent_rent(int rent_idx) {
		int res = sqlSession.update("rent.admin_rent_rent",rent_idx);
		return res;
	}
	//도서 취소
	public int admin_rent_cancel(int rent_idx) {
		int res = sqlSession.update("rent.admin_rent_cancel",rent_idx);
		return res;
	}
	//도서 반납
	public int admin_rent_ret(int rent_idx) {
		int res = sqlSession.update("rent.admin_rent_ret",rent_idx);
		return res;
	}
	
	//2.유저
	//<1>예약----------------------------------------------------------------------------------------------------------------------------
	//선택도서 예약
	public int rentbook_reserve( RentVO rent_vo ) {
		int res = sqlSession.insert("rent.rentbook_reserve", rent_vo);
		return res;
	}
	
	//<2>마이페이지----------------------------------------------------------------------------------------------------------------------------
	//유저별 대여한 책 정보 조회 폼
	public List<RentVO> user_rent_search(String userID){
		List<RentVO> rent_List = sqlSession.selectList("rent.user_rent_search", userID);
		return rent_List;
	}
	//선택 대여한 책 대여 취소버튼
	public int user_rent_ccl(int rent_idx) {
		int res = sqlSession.update("rent.user_rent_ccl", rent_idx);
		return res;
	}
	
	
}
