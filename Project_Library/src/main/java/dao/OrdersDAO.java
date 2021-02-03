package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.OrdersVO;
import vo.Orders_DetailVO;

@Repository("orders_dao")
public class OrdersDAO {

	@Autowired
	SqlSession sqlSession;
	
	//1)관리자
	//<3>주문관리----------------------------------------------------------------------------------------------------------------------------
	//판매 도서 주문 리스트
	public List<OrdersVO> admin_orders_list(){
		List<OrdersVO> orders_List = sqlSession.selectList("orders.admin_orders_list");
		return orders_List;
	}
	//선택 판매 도서 배송 완료
	public int admin_orders_finish(int orders_idx) {
		int res = sqlSession.update("orders.admin_orders_finish", orders_idx);
		return res;
	}
	
	//2)유저
	//<1>예약----------------------------------------------------------------------------------------------------------------------------
	//3.판매도서 구매.....................................................
	//주문도서책 정보 저장
	public int orders_books(OrdersVO orders_vo) {
		int res = sqlSession.insert("orders.orders_books", orders_vo);
		return res;
	}
	//송장번호 확인 및 주문도서 정보가지고오기
	public OrdersVO orders_invoice_check(String orders_Invoice) {
		//송장번호 중복확인
		OrdersVO vo_check = sqlSession.selectOne("orders.orders_invoice_check", orders_Invoice);
		return vo_check;
	}
	
	//주문 상세보기========================================================================
	//주문 상세보기에 정보넣기
	public int orders_detail(Orders_DetailVO detail_vo) {
		int res = sqlSession.insert("orders.orders_detail", detail_vo);
		return res;
	}
	
	//<2>마이페이지----------------------------------------------------------------------------------------------------------------------------
	//유저별 구매책의 정보 가져오기
	public List<OrdersVO> user_sellbook_search(String userID){
		List<OrdersVO> orders_List = sqlSession.selectList("orders.user_sellbook_search", userID);
		return orders_List;
	}
	//선택 주문정보 가져오기
	public OrdersVO orders_select_idx(int orders_idx) {
		OrdersVO orders_vo = sqlSession.selectOne("orders.orders_select_idx", orders_idx);
		return orders_vo;
	}
	
}
