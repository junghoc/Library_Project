package vo;

public class BoardVO {

	private int board_idx;
	private String userName;
	private String userID;
	private String board_subject;
	private String board_content;
	private String board_regDate;
	private int board_readhit;
	private int board_del_info;
	private String board_IP;
	
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBoard_subject() {
		return board_subject;
	}
	public void setBoard_subject(String board_subject) {
		this.board_subject = board_subject;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_regDate() {
		return board_regDate;
	}
	public void setBoard_regDate(String board_regDate) {
		this.board_regDate = board_regDate;
	}
	public int getBoard_readhit() {
		return board_readhit;
	}
	public void setBoard_readhit(int board_readhit) {
		this.board_readhit = board_readhit;
	}
	public int getBoard_del_info() {
		return board_del_info;
	}
	public void setBoard_del_info(int board_del_info) {
		this.board_del_info = board_del_info;
	}
	public String getBoard_IP() {
		return board_IP;
	}
	public void setBoard_IP(String board_IP) {
		this.board_IP = board_IP;
	}
	
}
