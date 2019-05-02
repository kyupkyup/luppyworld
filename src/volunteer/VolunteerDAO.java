package volunteer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.sql.Date;

import volunteer.Volunteer;
import volunteer.VolunteerDAO;

public class VolunteerDAO {
	private Connection conn;
	private ResultSet rs;
	
	public VolunteerDAO() {
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
		String SQL = "SELECT volunteerID FROM volunteer ORDER BY volunteerID DESC";
		
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
	
	public int volunteerWrite(String volunteerTitle, String volunteerContent, String volunteerPlace, String volunteerDate, int volunteerAvailable, String foodName, int foodPrice, String userID, String dueDate, 
			String dueHour, String dueMinute, String surveyURL) {
	String SQL = "INSERT INTO volunteer VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, volunteerTitle);
			pstmt.setString(3, volunteerContent);
			pstmt.setString(4, volunteerPlace);
			pstmt.setString(5, volunteerDate);
			pstmt.setInt(6, 1);
			pstmt.setString(7, foodName);
			pstmt.setInt(8, foodPrice);
			pstmt.setString(9, getDate());
			pstmt.setString(10, userID);
			pstmt.setString(11, dueDate);
			pstmt.setString(12, dueHour);
			pstmt.setString(13, dueMinute);
			pstmt.setString(14, surveyURL);

			

			
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	
	}
	// 봉사공지 목록 불러오기
	public ArrayList<Volunteer> getList(int pageNumber){
		String SQL = "SELECT * FROM volunteer WHERE volunteerID < ? AND volunteerAvailable =1 ORDER BY volunteerID DESC LIMIT 10 ";
		
		ArrayList<Volunteer> list = new ArrayList<Volunteer>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			
			rs = pstmt.executeQuery();
			// 날짜 에서 인티져로 가는게 문제라는데 해결할 것
			while(rs.next()) {
				Volunteer volunteer = new Volunteer();
				volunteer.setVolunteerID(rs.getInt(1));
				volunteer.setVolunteerTitle(rs.getString(2));
				volunteer.setVolunteerContent(rs.getString(3));
				volunteer.setVolunteerPlace(rs.getString(4));
				volunteer.setVolunteerDate(rs.getString(5));
				volunteer.setVolunteerAvailable(rs.getInt(6));
				volunteer.setFoodName(rs.getString(7));
				volunteer.setFoodPrice(rs.getInt(8));
				volunteer.setVolunteerAnnounceDate(rs.getString(9));
				volunteer.setUserID(rs.getString(10));									 
				volunteer.setDueDate(rs.getString(11));									 
				volunteer.setDueHour(rs.getString(12));									 
				volunteer.setDueMinute(rs.getString(13));	
				volunteer.setSurveyURL(rs.getString(14));									 


				list.add(volunteer);
								 
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	
		return list; //데이터 반환
		
	
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM volunteer WHERE volunteerID < ? AND volunteerAvailable =1 ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			
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
	
	public Volunteer getVolunteer(int volunteerID) {
		String SQL = "SELECT * FROM volunteer WHERE VolunteerID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  volunteerID);
			
			rs = pstmt.executeQuery();
				if(rs.next()) {
					Volunteer volunteer = new Volunteer();
					volunteer.setVolunteerID(rs.getInt(1));
					volunteer.setVolunteerTitle(rs.getString(2));
					volunteer.setVolunteerContent(rs.getString(3));
					volunteer.setVolunteerPlace(rs.getString(4));
					volunteer.setVolunteerDate(rs.getString(5));
					volunteer.setVolunteerAvailable(rs.getInt(6));
					volunteer.setFoodName(rs.getString(7));
					volunteer.setFoodPrice(rs.getInt(8));
					volunteer.setVolunteerAnnounceDate(rs.getString(9));								 
					volunteer.setUserID(rs.getString(10));	
					volunteer.setDueDate(rs.getString(11));									 
					volunteer.setDueHour(rs.getString(12));									 
					volunteer.setDueMinute(rs.getString(13));										 
					volunteer.setSurveyURL(rs.getString(14));									 

					return volunteer;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null; // 불러오기 실패
	}
		
	
	public int updateVolunteer(int volunteerID, String volunteerTitle, String volunteerContent, String volunteerPlace, String volunteerDate,  String foodName, int foodPrice,
			String userID, String dueDate, String dueHour, String dueMinute, String surveyURL) {
		String SQL = "UPDATE volunteer SET volunteerTitle = ?, volunteerContent = ?, volunteerPlace = ?, volunteerDate =?, foodName = ?, foodPrice = ?, "
				+" volunteerAnnounceDate=?, userID=?, dueDate =?, dueHour=?, dueMinute=?, surveyURL=?  WHERE volunteerID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, volunteerTitle);
			pstmt.setString(2, volunteerContent);
			pstmt.setString(3, volunteerPlace);
			pstmt.setString(4, volunteerDate);
			pstmt.setString(5, foodName);
			pstmt.setInt(6, foodPrice);
			pstmt.setString(7, getDate());
			pstmt.setString(8, userID);
			pstmt.setString(9, dueDate);
			pstmt.setString(10, dueHour);
			pstmt.setString(11, dueMinute);
			pstmt.setString(12, surveyURL);
			
			pstmt.setInt(7, volunteerID);

			
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int volunteerID) {
		
		String SQL = "UPDATE volunteer SET volunteerAvailable = 0 WHERE volunteerID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, volunteerID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
		
		
	}
}
