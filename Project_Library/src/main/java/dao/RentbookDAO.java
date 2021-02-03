package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.RentbookVO;

@Repository("rentbook_dao")
public class RentbookDAO {

	@Autowired
	SqlSession sqlSession;

	//1.관리자
	//<2> 도서 관리----------------------------------------------------------------------------------------------------------------------------
	//대여도서 정보 가져오기
	public List<RentbookVO> admin_rentbook_list(){
		List<RentbookVO> rentbook_List = sqlSession.selectList("rentbook.admin_rentbook_list");
		return rentbook_List;
	}
	//신규책 추가 
	public int admin_rentbook_insert(RentbookVO vo) {
		int res = sqlSession.insert("rentbook.admin_rentbook_insert", vo);
		return res;
	}
	//대여 도서 삭제
	public int admin_rentbook_del(String rentbook_Isbn) {
		int res = sqlSession.delete("rentbook.admin_rentbook_del", rentbook_Isbn);
		return res;
	}
	
	//<3> 주문 관리----------------------------------------------------------------------------------------------------------------------------
	//대여도서를 다시 대여 가능하게 변경
	public int admin_rentbook_change(String rentbook_Isbn) {
		int res = sqlSession.update("rentbook.admin_rentbook_change", rentbook_Isbn);
		return res;
	}
	
	//2.유저
	//<4>책 정보----------------------------------------------------------------------------------------------------------------------------
	//1. 대여책 전체 검색....................................................................
	public List<RentbookVO> rendbook_search(HashMap<String, Integer> map){
		List<RentbookVO> rentbook_list = sqlSession.selectList("rentbook.rentbook_search", map);
		return rentbook_list;
	}
	//전체 대여책의 갯수
	public int rentbook_count() {
		int book_count = sqlSession.selectOne("rentbook.rentbook_count");
		return book_count;
	}
	//컬럼별 내용 검색....................................................................
	//책이름
	public List<RentbookVO> rentbook_search_name(HashMap<String, Object> map){
		List<RentbookVO> rentbook_list = sqlSession.selectList("rentbook.rentbook_search_name", map);
		return rentbook_list;
	}
	//카테고리
	public List<RentbookVO> rentbook_search_category(HashMap<String, Object> map){
		List<RentbookVO> rentbook_list = sqlSession.selectList("rentbook.rentbook_search_category", map);
		return rentbook_list;
	}
	//출판사
	public List<RentbookVO> rentbook_search_company(HashMap<String, Object> map){
		List<RentbookVO> rentbook_list = sqlSession.selectList("rentbook.rentbook_search_company", map);
		return rentbook_list;
	}
	//저자
	public List<RentbookVO> rentbook_search_author(HashMap<String, Object> map){
		List<RentbookVO> rentbook_list = sqlSession.selectList("rentbook.rentbook_search_author", map);
		return rentbook_list;
	}
	//컬럼별 내용 검색의 대여책의 갯수.........................................................
	//책이름
	public int rentbook_search_name_count(String search) {
		int book_count = sqlSession.selectOne("rentbook.rentbook_search_name_count", search);
		return book_count;
	}
	//카테고리
	public int rentbook_search_category_count(String search) {
		int book_count = sqlSession.selectOne("rentbook.rentbook_search_category_count", search);
		return book_count;
	}
	//출판사
	public int rentbook_search_company_count(String search) {
		int book_count = sqlSession.selectOne("rentbook.rentbook_search_company_count", search);
		return book_count;
	}
	//저자
	public int rentbook_search_author_count(String search) {
		int book_count = sqlSession.selectOne("rentbook.rentbook_search_author_count", search);
		return book_count;
	}
	//해당 책의 예약유무 변경
	public int rentbook_reserve(String rentbook_Isbn) {
		int reserve = sqlSession.update("rentbook.rentbook_reserve", rentbook_Isbn);
		return reserve;
	}
	//선택도서 조회수 증가
	public int rentbook_hits(String rentbook_Isbn) {
		int res = sqlSession.update("rentbook.rentbook_hits", rentbook_Isbn);
		return res;
	}
	//선택 대여 도서 검색
	public RentbookVO rentbook_view(String rentbook_Isbn) {
		RentbookVO rentbook_vo = sqlSession.selectOne("rentbook.rentbook_view", rentbook_Isbn);
		return rentbook_vo;
	}
	//신규도서 안내(10권)
	public List<RentbookVO> rentbook_new(){
		List<RentbookVO> rentbook_list = sqlSession.selectList("rentbook.rentbook_new");
		return rentbook_list;
	}
	
}
