package vo;

public class GongjiVO {

	private int gongji_idx;
	private String adminID;
	private int departmentNum;
	private String gongji_subject;
	private String gongji_content;
	private String gongji_regDate;
	private int gongji_readhit; 
	private int gongji_del_info;
	//부서이름
	private String department;
	
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	
	public int getGongji_idx() {
		return gongji_idx;
	}
	public void setGongji_idx(int gongji_idx) {
		this.gongji_idx = gongji_idx;
	}
	public String getAdminID() {
		return adminID;
	}
	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}
	public int getDepartmentNum() {
		return departmentNum;
	}
	public void setDepartmentNum(int departmentNum) {
		this.departmentNum = departmentNum;
	}
	public String getGongji_subject() {
		return gongji_subject;
	}
	public void setGongji_subject(String gongji_subject) {
		this.gongji_subject = gongji_subject;
	}
	public String getGongji_content() {
		return gongji_content;
	}
	public void setGongji_content(String gongji_content) {
		this.gongji_content = gongji_content;
	}
	public String getGongji_regDate() {
		return gongji_regDate;
	}
	public void setGongji_regDate(String gongji_regDate) {
		this.gongji_regDate = gongji_regDate;
	}
	public int getGongji_readhit() {
		return gongji_readhit;
	}
	public void setGongji_readhit(int gongji_readhit) {
		this.gongji_readhit = gongji_readhit;
	}
	public int getGongji_del_info() {
		return gongji_del_info;
	}
	public void setGongji_del_info(int gongji_del_info) {
		this.gongji_del_info = gongji_del_info;
	} 
	
}
