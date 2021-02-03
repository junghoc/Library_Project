package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.SeatsVO;

@Repository("seats_dao")
public class SeatsDAO {

	@Autowired
	SqlSession sqlSession;
	
	//1.관리자
	//<5>열람실----------------------------------------------------------------------------------------------------------------------------
	//열람실 리스트 전부 가져오기
	public List<SeatsVO> admin_seats_list(){
		List<SeatsVO> seats_List = sqlSession.selectList("seats.admin_seats_list");
		return seats_List;
	}
	//열람실 초기화(전부다 빈자리로 만들기)
	public int admin_study_room_reset() {
		int res = sqlSession.update("seats.admin_study_room_reset");
		return res;
	}
	
	//2.유저
	//<5>열람실----------------------------------------------------------------------------------------------------------------------------
	//1번시간 선택 유저의 아이디로 검색
	public SeatsVO my_study_room_t1(String userID) {
		SeatsVO t1_seat = sqlSession.selectOne("seats.my_study_room_t1", userID);
		return t1_seat;
	}
	//2번시간 선택 유저의 아이디로 검색
	public SeatsVO my_study_room_t2(String userID) {
		SeatsVO t2_seat = sqlSession.selectOne("seats.my_study_room_t2", userID);
		return t2_seat;
	}
	//3번시간 선택 유저의 아이디로 검색
	public SeatsVO my_study_room_t3(String userID) {
		SeatsVO t3_seat = sqlSession.selectOne("seats.my_study_room_t3", userID);
		return t3_seat;
	}
	//회원의 1번 시간 예약 취소하기
	public int my_study_room_cancel1(HashMap<String, Object> map) {
		int res = sqlSession.update("seats.my_study_room_cancel1",map);
		return res;
	}
	//회원의 2번 시간 예약 취소하기
	public int my_study_room_cancel2(HashMap<String, Object> map) {
		int res = sqlSession.update("seats.my_study_room_cancel2",map);
		return res;
	}
	//회원의 3번 시간 예약 취소하기
	public int my_study_room_cancel3(HashMap<String, Object> map) {
		int res = sqlSession.update("seats.my_study_room_cancel3",map);
		return res;
	}
	//멀티미디어실 리스트 가져오기
	public List<SeatsVO> room_select_mult(){
		List<SeatsVO> seats_List = sqlSession.selectList("seats.room_select_mult");
		return seats_List;
	}
	//멀티미디어실 사용중인 좌석 (9 - 12)
	public int mult_use_count1() {
		int use_count = sqlSession.selectOne("seats.mult_use_count1");
		return use_count;
	}
	//멀티미디어실 사용중인 좌석 (12 - 15)
	public int mult_use_count2() {
		int use_count = sqlSession.selectOne("seats.mult_use_count2");
		return use_count;
	}
	//멀티미디어실 사용중인 좌석 (15 - 18)
	public int mult_use_count3() {
		int use_count = sqlSession.selectOne("seats.mult_use_count3");
		return use_count;
	}
	//열람실 리스트 가져오기
	public List<SeatsVO> room_select_read(){
		List<SeatsVO> seats_List = sqlSession.selectList("seats.room_select_read");
		return seats_List;
	}
	//멀티미디어실 사용중인 좌석 (9 - 12)
	public int read_use_count1() {
		int use_count = sqlSession.selectOne("seats.read_use_count1");
		return use_count;
	}
	//멀티미디어실 사용중인 좌석 (12 - 15)
	public int read_use_count2() {
		int use_count = sqlSession.selectOne("seats.read_use_count2");
		return use_count;
	}
	//멀티미디어실 사용중인 좌석 (15 - 18)
	public int read_use_count3() {
		int use_count = sqlSession.selectOne("seats.read_use_count3");
		return use_count;
	}	
	//선택 좌석의 정보 가져오기
	public SeatsVO seat_select(int seats_idx) {
		SeatsVO seat = sqlSession.selectOne("seats.seat_select", seats_idx);
		return seat;
	}
	//동일 시간대의 다른좌석 중복예약 확인(9 - 12)
	public int seat_time1_check(String userID) {
		int seat_check = sqlSession.selectOne("seats.seat_time1_check", userID);
		return seat_check;
	}
	//동일 시간대의 다른좌석 중복예약 확인(12 - 15)
	public int seat_time2_check(String userID) {
		int seat_check = sqlSession.selectOne("seats.seat_time2_check", userID);
		return seat_check;
	}
	//동일 시간대의 다른좌석 중복예약 확인(15 - 18)
	public int seat_time3_check(String userID) {
		int seat_check = sqlSession.selectOne("seats.seat_time3_check", userID);
		return seat_check;
	}
	//선택 시간대별로 예약 진행(9 - 12)
	public int room_time1_book(HashMap<String, Object> map) {
		int res = sqlSession.update("seats.room_time1_book", map);
		return res;
	}
	//선택 시간대별로 예약 진행(12 - 15)
	public int room_time2_book(HashMap<String, Object> map) {
		int res = sqlSession.update("seats.room_time2_book", map);
		return res;
	}
	//선택 시간대별로 예약 진행(15 - 18)
	public int room_time3_book(HashMap<String, Object> map) {
		int res = sqlSession.update("seats.room_time3_book", map);
		return res;
	}
	
}
