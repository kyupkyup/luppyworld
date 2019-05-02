package registration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import bulletin.Bulletin;
import bulletin.BulletinDAO;

public class RegistrationDAO {


	private Connection conn;
	private ResultSet rs;
	
	public RegistrationDAO() {
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
	
	public int register(int volunteerID, String userID, String region, int carfool, int eatWhether, int carfoolee, int workPlace, int scary, int paid,String oneSay) {
	String SQL = "INSERT INTO registration VALUES(?,?,?,?,?,?,?,?,?,?,?)" ;
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, volunteerID);
			pstmt.setString(2, userID);
			pstmt.setString(3, region);
			pstmt.setInt(4, carfool);
			pstmt.setInt(5, eatWhether);
			pstmt.setInt(6, carfoolee);
			pstmt.setInt(7, workPlace);
			pstmt.setInt(8, scary);
			pstmt.setInt(9, 0);
			pstmt.setString(10, volunteerID+userID);
			pstmt.setString(11, oneSay);

	
			//rs = pstmt.executeQuery();
			
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
 
		return -1; //데이터베이스 오류
	
	}
	// 게시판 글 목록 불러오기
	public ArrayList<Registration> getList(int volunteerID){
		String SQL = "SELECT * FROM registration WHERE volunteerID = ? ";
		
		ArrayList<Registration> list = new ArrayList<Registration>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  volunteerID);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Registration registration = new Registration();
				registration.setUserID(rs.getString(2));
				registration.setRegion(rs.getString(3));
				registration.setCarfool(rs.getInt(4));
				registration.setEatWhether(rs.getInt(5));
				registration.setCarfoolee(rs.getInt(6));
				registration.setWorkPlace(rs.getInt(7));
				registration.setScary(rs.getInt(8));
				registration.setPaid(rs.getInt(9));
				registration.setPrimaryUserID(rs.getString(10));
				registration.setOneSay(rs.getString(11));

				list.add(registration);
								 
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	
		return list; //데이터 반환
		
	
	}

	
	public Registration getRegistration(String userID, int volunteerID) {
		String SQL = "SELECT * FROM registration WHERE userID = ? and volunteerID=? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			pstmt.setInt(2,  volunteerID);

			rs = pstmt.executeQuery();
		
				if(rs.next()) {
					Registration registration = new Registration();
					registration.setUserID(rs.getString(2));
					registration.setRegion(rs.getString(3));
					registration.setCarfool(rs.getInt(4));
					registration.setEatWhether(rs.getInt(5));
					registration.setCarfoolee(rs.getInt(6));
					registration.setWorkPlace(rs.getInt(7));
					registration.setScary(rs.getInt(8));
					registration.setPaid(rs.getInt(9));
					registration.setPrimaryUserID(rs.getString(10));
					registration.setOneSay(rs.getString(11));

					return registration;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null; // 불러오기 실패
	}
		
	
	public int update(int bulletinID, String bulletinTitle, String bulletinContent) {
		String SQL = "UPDATE bulletin SET bulletinTitle = ?, bulletinContent = ? WHERE bulletinID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bulletinTitle);
			pstmt.setString(2, bulletinContent);
			pstmt.setInt(3, bulletinID);
			
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int deleteRegister(String primaryUserID) {
		
		String SQL = "delete from registration WHERE primaryID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, primaryUserID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
		
		
	}
	
	public int paid(String primaryUserID) {
		
		String SQL = "UPDATE registration SET paid = 1 WHERE primaryID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, primaryUserID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
	
	public int cancelPaid(String primaryUserID) {
		
		String SQL = "UPDATE registration SET paid = 0 WHERE primaryID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, primaryUserID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
}
