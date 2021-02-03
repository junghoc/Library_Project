package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.BoardVO;
import vo.Board_ComVO;
import vo.GongjiVO;

@Repository("board_dao")
public class BoardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	//유저......................................................................................................
	//<5>게시판----------------------------------------------------------------------------------------------------------------------------
	//1. 공지 게시판===================================================================================
	//공지 게시판 리스트
	public List<GongjiVO> board_gongji_list(HashMap<String, Integer> map){
		//페이지별 게시물 조회
		List<GongjiVO> gongji_List = sqlSession.selectList("board.gongji_list", map);
		return gongji_List;
	}
	//공지게시판 전체 게시물수 구하기
	public int gongji_row_total() {
		int gongji_total = sqlSession.selectOne("board.gongji_row_total");
		return gongji_total;
	}
	//공지게시판 선택 게시물 한건 조회
	public GongjiVO gongji_view(int gongji_idx) {
		GongjiVO gongji_vo = sqlSession.selectOne("board.gongji_view", gongji_idx);
		return gongji_vo;
	}
	//공지게시판 조회수 증가
	public int gongji_readhit(int gongji_idx) {
		int res = sqlSession.update("board.gongji_readhit", gongji_idx);
		return res;
	}
	
	//2. 자유 게시판===================================================================================
	//자유 게시판 리스트
	public List<BoardVO> board_list(HashMap<String, Integer> map){
		//페이지별 게시물 조회
		List<BoardVO> board_List = sqlSession.selectList("board.board_list", map);
		return board_List;
	}
	//자유게시판 전체 게시물수 구하기
	public int board_row_total() {
		int board_total = sqlSession.selectOne("board.board_row_total");
		return board_total;
	}
	//자유게시판 선택 게시물 한건 조회
	public BoardVO board_view(int board_idx) {
		BoardVO board_vo = sqlSession.selectOne("board.board_view", board_idx);
		return board_vo;
	}
	//자유게시판 조회수 증가
	public int board_readhit(int board_idx) {
		int res = sqlSession.update("board.board_readhit", board_idx);
		return res;
	}
	//자유게시판 새글 작성하기
	public int board_write(BoardVO board_vo) {
		int res = sqlSession.insert("board.board_write", board_vo);
		return res;
	}
	//자유게시판 선택글 삭제
	public int board_delete(int board_idx) {
		int res = sqlSession.update("board.board_delete", board_idx);
		return res;
	}
	//자유게시판 선택글 수정
	public int board_modify(BoardVO board_vo) {
		int res = sqlSession.update("board.board_modify", board_vo);
		return res;
	}
	
	//3. 자유 게시판 댓글 ===================================================================================
	//자유 게시판 댓글 리스트
	public List<Board_ComVO> board_com_list(int board_idx){
		List<Board_ComVO> board_com_List = sqlSession.selectList("board.board_com_list", board_idx);
		return board_com_List;
	}
	//자유 게시판 총 댓글 갯수
	public int board_com_count(int board_idx) {
		int count = sqlSession.selectOne("board.board_com_count", board_idx);
		return count;
	}
	//자유 게시판 댓글 작성
	public int board_com_write(Board_ComVO board_com_vo) {
		int res = sqlSession.insert("board.board_com_write", board_com_vo);
		return res;
	}
	//자유 게시판 댓글 삭제
	public int board_com_del(int board_com_idx) {
		int res = sqlSession.update("board.board_com_del", board_com_idx);
		return res;
	}
	
	//1)관리자......................................................................................................
	//<5>게시판----------------------------------------------------------------------------------------------------------------------------
	//1. 공지 게시판===================================================================================
	//공지 게시판 리스트
	public List<GongjiVO> admin_gongji_list() {
		List<GongjiVO> gongji_List = sqlSession.selectList("board.admin_gongji_list");
		return gongji_List;
	}
	//선택 공지글 삭제
	public int admin_board_gongji_del(int gongji_idx) {
		int res = sqlSession.update("board.admin_board_gongji_del", gongji_idx);
		return res;
	}
	//선택 일반글 복구
	public int admin_board_gongji_restore(int gongji_idx) {
		int res = sqlSession.update("board.admin_board_gongji_restore", gongji_idx);
		return res;
	}
	//선택 공지글 공지글로 변경
	public int admin_board_gongji_main(int gongji_idx) {
		int res = sqlSession.update("board.admin_board_gongji_main", gongji_idx);
		return res;
	}
	//선택 공지사항 글 수정
	public int admin_board_gongji_update(GongjiVO gongji) {
		int res = sqlSession.update("board.admin_board_gongji_update", gongji);
		return res;
	}
	//새로운 공지글 작성
	public int admin_board_gongji_insert(GongjiVO gongji) {
		int res = sqlSession.insert("board.admin_board_gongji_insert", gongji);
		return res;
	}
	
	//2. 자유 게시판===================================================================================
	//자유 게시판 리스트
	public List<BoardVO> admin_board_list() {
		List<BoardVO> board_List = sqlSession.selectList("board.admin_board_list");
		return board_List;
	}
	//선택 자유게시판글 복구
	public int admin_board_restore(int board_idx) {
		int res = sqlSession.update("board.admin_board_restore", board_idx);
		return res;
	}
	//선택 자유게시판의 댓글 가져오기
	public List<Board_ComVO> admin_board_com_list(HashMap<String, Integer> map){
		List<Board_ComVO> com_List = sqlSession.selectList("board.admin_board_com_list", map);
		return com_List;
	}
	//해당 게시글 댓글의 총 갯수 구하기
	public int admin_board_com_list_total(int board_idx) {
		int com_total = sqlSession.selectOne("board.admin_board_com_list_total",board_idx);
		return com_total;
	}
	
	//2-1. 자유 게시판 댓글..........................................
	//선택 댓글 삭제
	public int admin_board_com_restore(int board_com_idx) {
		int res = sqlSession.update("board.admin_board_com_restore", board_com_idx);
		return res;
	}
	
		
		
}
