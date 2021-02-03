package vo;

public class SeatsVO {

	private int seats_idx;//1-24pc실 25-66열람실
	private String t1_user_id;//9 ~ 12시
	private String t2_user_id;//12 ~ 15시
	private String t3_user_id;//15 ~ 18시
	
	public int getSeats_idx() {
		return seats_idx;
	}
	public void setSeats_idx(int seats_idx) {
		this.seats_idx = seats_idx;
	}
	public String getT1_user_id() {
		return t1_user_id;
	}
	public void setT1_user_id(String t1_user_id) {
		this.t1_user_id = t1_user_id;
	}
	public String getT2_user_id() {
		return t2_user_id;
	}
	public void setT2_user_id(String t2_user_id) {
		this.t2_user_id = t2_user_id;
	}
	public String getT3_user_id() {
		return t3_user_id;
	}
	public void setT3_user_id(String t3_user_id) {
		this.t3_user_id = t3_user_id;
	}
	
}
