package vo;

public class CartVO {
	
	private int cart_idx;
	private int cart_Cnt;
	private String sellbook_Isbn;
	private String sellbook_Name;
	private int sellbook_Price;
	private String userID;
	private int cart_Check;
	
	public int getCart_idx() {
		return cart_idx;
	}
	public void setCart_idx(int cart_idx) {
		this.cart_idx = cart_idx;
	}
	public int getCart_Cnt() {
		return cart_Cnt;
	}
	public void setCart_Cnt(int cart_Cnt) {
		this.cart_Cnt = cart_Cnt;
	}
	public String getSellbook_Isbn() {
		return sellbook_Isbn;
	}
	public void setSellbook_Isbn(String sellbook_Isbn) {
		this.sellbook_Isbn = sellbook_Isbn;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getCart_Check() {
		return cart_Check;
	}
	public void setCart_Check(int cart_Check) {
		this.cart_Check = cart_Check;
	}
	public String getSellbook_Name() {
		return sellbook_Name;
	}
	public void setSellbook_Name(String sellbook_Name) {
		this.sellbook_Name = sellbook_Name;
	}
	public int getSellbook_Price() {
		return sellbook_Price;
	}
	public void setSellbook_Price(int sellbook_Price) {
		this.sellbook_Price = sellbook_Price;
	}
	
}
