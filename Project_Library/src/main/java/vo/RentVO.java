package vo;

public class RentVO {

	private int rent_idx;
	private String userID; 
	private String rentbook_Isbn;
	private String rentbook_Name;
	private int rent_Check;
	private String rent_Date;
	private String rent_Redate;
	private int rent_Cancel;
	
	public int getRent_idx() {
		return rent_idx;
	}
	public void setRent_idx(int rent_idx) {
		this.rent_idx = rent_idx;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getRentbook_Isbn() {
		return rentbook_Isbn;
	}
	public void setRentbook_Isbn(String rentbook_Isbn) {
		this.rentbook_Isbn = rentbook_Isbn;
	}
	public String getRentbook_Name() {
		return rentbook_Name;
	}
	public void setRentbook_Name(String rentbook_Name) {
		this.rentbook_Name = rentbook_Name;
	}
	public int getRent_Check() {
		return rent_Check;
	}
	public void setRent_Check(int rent_Check) {
		this.rent_Check = rent_Check;
	}
	public String getRent_Date() {
		return rent_Date;
	}
	public void setRent_Date(String rent_Date) {
		this.rent_Date = rent_Date;
	}
	public String getRent_Redate() {
		return rent_Redate;
	}
	public void setRent_Redate(String rent_Redate) {
		this.rent_Redate = rent_Redate;
	}
	public int getRent_Cancel() {
		return rent_Cancel;
	}
	public void setRent_Cancel(int rent_Cancel) {
		this.rent_Cancel = rent_Cancel;
	}
	
}
