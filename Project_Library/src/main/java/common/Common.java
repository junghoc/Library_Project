package common;

public class Common {
	//공지사항 페이징 처리를 위한 클래스
	public static class Gongji{

		//한 페이지에 보여줄 게시물 수
		public final static int BLOCKLIST = 5;
				
		//한 화면에 보여지는 페이지 메뉴 수
		//◀ 1 2 3 4 5 ▶
		public final static int BLOCKPAGE = 3;
		
	}
	
	//자유게시판 페이징 처리를 위한 클래스
	public static class Board{
		
		//한 페이지에 보여줄 게시물 수
		public final static int BLOCKLIST = 5;
		
		//한 화면에 보여지는 페이지 메뉴 수
		//<1 2 3 4 5>
		public final static int BLOCKPAGE = 3;
	}
	
	//자유게시판 댓글 페이징 처리를 위한 클래스
	public static class Board_Com{
		
		//한 페이지에 보여줄 게시물 수
		public final static int BLOCKLIST = 3;

	}
	
	//대여책 페이징 처리를 위한 클래스
	public static class Book{
		
		public final static int BLOCKLIST = 10;
		
		public final static int BLOCKPAGE = 5;
		
	}
	
}
