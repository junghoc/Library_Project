package vo;

public class AdminVO {

	private String adminID;
	private String adminPWD;
	private String email;
	private String adminName;
	private String tell;
	private int departmentNum; 
	private int enabled; 
	private String authority;
	
	public String getAdminID() {
		return adminID;
	}
	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}
	public String getAdminPWD() {
		return adminPWD;
	}
	public void setAdminPWD(String adminPWD) {
		this.adminPWD = adminPWD;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getTell() {
		return tell;
	}
	public void setTell(String tell) {
		this.tell = tell;
	}
	public int getDepartmentNum() {
		return departmentNum;
	}
	public void setDepartmentNum(int departmentNum) {
		this.departmentNum = departmentNum;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
}
