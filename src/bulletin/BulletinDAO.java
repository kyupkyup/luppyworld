
package bulletin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class BulletinDAO {

	private Connection conn;
	private ResultSet rs;
	
	public BulletinDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/luppyworld?serverTimezone=UTC";	//서버 선언
			String dbID = "luppyworld";
			String dbPassword = "a1870523!!";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);	//연결시켜서 conn에 저장
			
		}
		
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
				
			}
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류

	}
	
	public int getNext() {
		String SQL = "SELECT bulletinID FROM bulletin ORDER BY bulletinID DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) + 1;
				 
			}
			return 1; // 첫번째 게시글인 경우
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류

	}
	
	public int write(String bulletinTitle, String userID, String bulletinContent, String userName, String fileName, String fileRealName) {
	String SQL = "INSERT INTO bulletin VALUES(?,?,?,?,?,?,?,?,?)";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bulletinTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, bulletinContent);
			pstmt.setString(5, userName);
			pstmt.setInt(6, 1);
			pstmt.setString(7, getDate());
			pstmt.setString(8, fileName);
			pstmt.setString(9, fileRealName);

				
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	
	}
	
	public int writeNotice(String bulletinTitle, String userID, String bulletinContent, String userName , String fileName, String fileRealName) {
	String SQL = "INSERT INTO bulletin VALUES(?,?,?,?,?,?,?,?,?)";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bulletinTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, bulletinContent);
			pstmt.setString(5, userName);
			pstmt.setInt(6, 2); // bulletin available 2면 공지사항
			pstmt.setString(7, getDate());
			pstmt.setString(8, fileName);
			pstmt.setString(9, fileRealName);
				
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	
	}
	
	public int writeIntroduction(String bulletinTitle, String userID, String bulletinContent, String userName, String fileName, String fileRealName) {
	String SQL = "INSERT INTO bulletin VALUES(?,?,?,?,?,?,?,?,?)";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bulletinTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, bulletinContent);
			pstmt.setString(5, userName);
			pstmt.setInt(6, 3); // bulletinAvailable 3이면 가입인사
			pstmt.setString(7, getDate());
			pstmt.setString(8, fileName);
			pstmt.setString(9, fileRealName);
				
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	
	}
	// 게시판 글 목록 불러오기
	public ArrayList<Bulletin> getList(int pageNumber){
		String SQL = "SELECT * FROM bulletin WHERE bulletinID < ? AND bulletinAvailable =1 ORDER BY bulletinID DESC LIMIT 10 ";
		
		ArrayList<Bulletin> list = new ArrayList<Bulletin>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Bulletin bulletin = new Bulletin();
				bulletin.setBulletinID(rs.getInt(1));
				bulletin.setBulletinTitle(rs.getString(2));
				bulletin.setUserID(rs.getString(3));
				bulletin.setBulletinContent(rs.getString(4));
				bulletin.setUserName(rs.getString(5));
				bulletin.setBulletinAvailable(rs.getInt(6));
				bulletin.setBulletinDate(rs.getString(7));
				list.add(bulletin);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터 반환
	}
	
	public ArrayList<Bulletin> getNoticeList(int pageNumber){
		String SQL = "SELECT * FROM bulletin WHERE bulletinID < ? AND bulletinAvailable =2 ORDER BY bulletinID DESC LIMIT 10 ";
		
		ArrayList<Bulletin> list = new ArrayList<Bulletin>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Bulletin bulletin = new Bulletin();
				bulletin.setBulletinID(rs.getInt(1));
				bulletin.setBulletinTitle(rs.getString(2));
				bulletin.setUserID(rs.getString(3));
				bulletin.setBulletinContent(rs.getString(4));
				bulletin.setUserName(rs.getString(5));
				bulletin.setBulletinAvailable(rs.getInt(6));
				bulletin.setBulletinDate(rs.getString(7));
				list.add(bulletin);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터 반환
	}
	
	public ArrayList<Bulletin> getIntroductionList(int pageNumber){
		String SQL = "SELECT * FROM bulletin WHERE bulletinID < ? AND bulletinAvailable =3 ORDER BY bulletinID DESC LIMIT 10 ";
		
		ArrayList<Bulletin> list = new ArrayList<Bulletin>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Bulletin bulletin = new Bulletin();
				bulletin.setBulletinID(rs.getInt(1));
				bulletin.setBulletinTitle(rs.getString(2));
				bulletin.setUserID(rs.getString(3));
				bulletin.setBulletinContent(rs.getString(4));
				bulletin.setUserName(rs.getString(5));
				bulletin.setBulletinAvailable(rs.getInt(6));
				bulletin.setBulletinDate(rs.getString(7));
				list.add(bulletin);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터 반환
	}
	
	public boolean nextPage(int pageNumber, int bulletinAvailable) {
		String SQL = "SELECT * FROM bulletin WHERE bulletinID < ? AND bulletinAvailable =?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			pstmt.setInt(2, bulletinAvailable);

			rs = pstmt.executeQuery();
		
			
				if(rs.next()) {
					
					return true;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false; //데이터 반환
	}
	
	public Bulletin getBulletin(int bulletinID) {
		String SQL = "SELECT * FROM bulletin WHERE bulletinID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bulletinID);
			rs = pstmt.executeQuery();
				if(rs.next()) {
					Bulletin bulletin = new Bulletin();
					bulletin.setBulletinID(rs.getInt(1));
					bulletin.setBulletinTitle(rs.getString(2));
					bulletin.setUserID(rs.getString(3));
					bulletin.setBulletinContent(rs.getString(4));
					bulletin.setUserName(rs.getString(5));
					bulletin.setBulletinAvailable(rs.getInt(6));
					bulletin.setBulletinDate(rs.getString(7));	
					bulletin.setFileName(rs.getString(8));
					bulletin.setFileRealName(rs.getString(9));

					return bulletin;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null; // 불러오기 실패
	}
		
	
	public int update(int bulletinID, String bulletinTitle, String bulletinContent, int bulletinAvailable, String fileName, String fileRealName) {
		String SQL =null;
		if(fileName!=null && fileRealName!=null) {
			SQL = "UPDATE bulletin SET bulletinTitle = ?, bulletinContent = ?, bulletinAvailable = ?, fileName=?, fileRealName=? WHERE bulletinID = ? ";
		}
		else {
			SQL = "UPDATE bulletin SET bulletinTitle = ?, bulletinContent = ?, bulletinAvailable = ? WHERE bulletinID = ? ";

		}
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bulletinTitle);
			pstmt.setString(2, bulletinContent);
			pstmt.setInt(3, bulletinAvailable);
			
			if(fileName!=null && fileRealName!=null) {
			pstmt.setString(4, fileName);
			pstmt.setString(5, fileRealName);
			pstmt.setInt(6, bulletinID);

			}
			else {
			pstmt.setInt(4, bulletinID);
			}
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int bulletinID) {
		
		String SQL = "UPDATE bulletin SET bulletinAvailable = 0 WHERE bulletinID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bulletinID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
		
		
	}
	
}
