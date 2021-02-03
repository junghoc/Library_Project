package vo;

import org.springframework.web.multipart.MultipartFile;

public class RentbookVO {

	private String rentbook_Isbn;
	private String rentbook_Name;
	private String rentbook_Category;
	private String rentbook_Company;
	private String rentbook_Content;
	private String rentbook_Author;
	private String rentbook_Year;
	private String rentbook_Receiving;
	private int rentbook_Hits;
	private int rentbook_Reserve;
	//파일
	private MultipartFile photo;
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
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
	public String getRentbook_Category() {
		return rentbook_Category;
	}
	public void setRentbook_Category(String rentbook_Category) {
		this.rentbook_Category = rentbook_Category;
	}
	public String getRentbook_Company() {
		return rentbook_Company;
	}
	public void setRentbook_Company(String rentbook_Company) {
		this.rentbook_Company = rentbook_Company;
	}
	public String getRentbook_Content() {
		return rentbook_Content;
	}
	public void setRentbook_Content(String rentbook_Content) {
		this.rentbook_Content = rentbook_Content;
	}
	public String getRentbook_Author() {
		return rentbook_Author;
	}
	public void setRentbook_Author(String rentbook_Author) {
		this.rentbook_Author = rentbook_Author;
	}
	public String getRentbook_Year() {
		return rentbook_Year;
	}
	public void setRentbook_Year(String rentbook_Year) {
		this.rentbook_Year = rentbook_Year;
	}
	public String getRentbook_Receiving() {
		return rentbook_Receiving;
	}
	public void setRentbook_Receiving(String rentbook_Receiving) {
		this.rentbook_Receiving = rentbook_Receiving;
	}
	public int getRentbook_Hits() {
		return rentbook_Hits;
	}
	public void setRentbook_Hits(int rentbook_Hits) {
		this.rentbook_Hits = rentbook_Hits;
	}
	public int getRentbook_Reserve() {
		return rentbook_Reserve;
	}
	public void setRentbook_Reserve(int rentbook_Reserve) {
		this.rentbook_Reserve = rentbook_Reserve;
	}
	
}
