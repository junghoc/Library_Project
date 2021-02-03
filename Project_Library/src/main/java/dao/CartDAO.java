package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.CartVO;

@Repository("cart_dao")
public class CartDAO {

	@Autowired
	SqlSession sqlSession;
	
	//2)유저
	//<1>예약----------------------------------------------------------------------------------------------------------------------------
	//2.장바구니(책 구매 예정).....................................................
	//해당아이디의 cart정보 모두 가져오기
	public List<CartVO> user_sellbook_cart(String userID){
		List<CartVO> cart_list = sqlSession.selectList("cart.user_sellbook_cart", userID);
		return cart_list;
	}
	//해당아이디 cart의 총합구하기
	public int user_sellbook_cart_total(String userID){
		int total = sqlSession.selectOne("cart.user_sellbook_cart_total", userID);
		return total;
	}
	//선택 판매책 장바구니에 담기
	public int sellbook_cart(CartVO cart_vo) {
		int res = sqlSession.insert("cart.sellbook_cart", cart_vo);
		return res;
	}
	//선택 판매책 수량 변경
	public int sellbook_cart_cnt(CartVO cart_vo) {
		//선택 판매책 장바구니에서 수량 변경
		int res = sqlSession.update("cart.sellbook_cart_cnt", cart_vo);
		return res;
	}
	//선택 판매책 삭제(1개)
	public int sellbook_del(int cart_idx) {
		//선택 판매책 장바구니에서 수량 변경
		int res = sqlSession.update("cart.sellbook_del", cart_idx);
		return res;
	}
	//다중삭제에서 실패한경우 다시 값 되돌리기
	public int sellbook_re(int cart_idx) {
		//선택 판매책 장바구니에서 수량 변경
		int res = sqlSession.update("cart.sellbook_re", cart_idx);
		return res;
	}
	//선택 판매책 정보 모두 가져오기
	public CartVO sellbook_orders(int cart_idx){
		CartVO cart_vo = sqlSession.selectOne("cart.sellbook_orders", cart_idx);
		return cart_vo;
	}
	//장바구니에서 구매완료한 제품 변경
	public int sellbook_order_end(int cart_idx){
		int res = sqlSession.update("cart.sellbook_order_end", cart_idx);
		return res;
	}
	
	//<2>마이페이지----------------------------------------------------------------------------------------------------------------------------
	//선택 주문 정보의 디테일(카트의정보)을 orders_idx를 통해 가져오기
	public List<CartVO> cart_list_idx(int orders_idx) {
		List<CartVO> cart_list = sqlSession.selectList("cart.cart_list_idx", orders_idx);
		return cart_list;
	}

}
