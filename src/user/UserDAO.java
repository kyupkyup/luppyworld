package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import registration.Registration;
import volunteer.Volunteer;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과가 존재한다면
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else 
					return 0; // 비밀번호 불일치
				
			}
			return -1; //아이디가 없음
			
		}
		
		catch(Exception e){
			e.printStackTrace();
		}
		return -2; // 데이터 베이스 오류
		
	}
	
	public int join(String userID, String userPassword, String userName, String userEmail, String userAddress, int userAddressNum, String userGender, String userJob,
			int userAge, String userBirthday, String userPhoneNumber, String fileName, String fileRealName, int firstRoute ) {
		String SQL = "INSERT INTO USER VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setString(4, userEmail);
			pstmt.setString(5, userAddress);
			pstmt.setInt(6, userAddressNum);
			pstmt.setString(7,userGender);
			pstmt.setString(8,userJob);
			pstmt.setInt(9, userAge);
			pstmt.setString(10,userBirthday);
			pstmt.setInt(11, 5);
			pstmt.setString(12, userPhoneNumber);
			pstmt.setInt(13, 0);
			pstmt.setString(14, fileName);
			pstmt.setString(15, fileRealName);
			pstmt.setInt(16, firstRoute);


			
			return pstmt.executeUpdate();
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1;  //데이터베이스 오류
	}
	
	public ArrayList<User> getList(){
		String SQL = "SELECT * FROM USER";
		
		ArrayList<User> list = new ArrayList<User>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				user.setUserAddress(rs.getString(5));
				user.setUserAddressNum(rs.getInt(6));
				user.setUserGender(rs.getString(7));
				user.setUserJob(rs.getString(8));
				user.setUserAge(rs.getInt(9));
				user.setUserBirthday(rs.getString(10));
				user.setUserMemberShip(rs.getInt(11));
				user.setUserPhoneNumber(rs.getString(12));
				user.setUserAttend(rs.getInt(13));
				user.setFileName(rs.getString(14));
				user.setFileRealName(rs.getString(15));
				user.setFirstRoute(rs.getInt(16));								 

				list.add(user);
								 
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	
		return list; //데이터 반환
		
	
	}
	public ArrayList<User> getListAdmin(){
		String SQL = "SELECT * FROM USER where userMemberShip != 5";
		
		ArrayList<User> list = new ArrayList<User>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserName(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				user.setUserAddress(rs.getString(5));
				user.setUserAddressNum(rs.getInt(6));
				user.setUserGender(rs.getString(7));
				user.setUserJob(rs.getString(8));
				user.setUserAge(rs.getInt(9));
				user.setUserBirthday(rs.getString(10));
				user.setUserMemberShip(rs.getInt(11));
				user.setUserPhoneNumber(rs.getString(12));
				user.setUserAttend(rs.getInt(13));
				user.setFileName(rs.getString(14));
				user.setFileRealName(rs.getString(15));
				user.setFirstRoute(rs.getInt(16));								 

				list.add(user);
								 
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	
		return list; //데이터 반환
		
	
	}
	public User getUser(String userID) {
		String SQL = "SELECT * FROM USER WHERE userID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			
			rs = pstmt.executeQuery();
				if(rs.next()) {
					User user = new User();
					user.setUserID(rs.getString(1));
					user.setUserName(rs.getString(3));
					user.setUserEmail(rs.getString(4));
					user.setUserAddress(rs.getString(5));
					user.setUserAddressNum(rs.getInt(6));
					user.setUserGender(rs.getString(7));
					user.setUserJob(rs.getString(8));
					user.setUserAge(rs.getInt(9));
					user.setUserBirthday(rs.getString(10));								 
					user.setUserMemberShip(rs.getInt(11));
					user.setUserPhoneNumber(rs.getString(12));								 
					user.setUserAttend(rs.getInt(13));
					user.setFileName(rs.getString(14));								 
					user.setFileRealName(rs.getString(15));								 
					user.setFirstRoute(rs.getInt(16));								 

					return user;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null; // 불러오기 실패
	}
	
	public String getUserName1 (String userID){
		String SQL = "SELECT userName FROM USER WHERE userID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
								 
			}
			else 
				{
				return null;
				}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	return null;
		
	}
	
	public int getUserMemberShip1 (String userID){
		String SQL = "SELECT userMemberShip FROM USER WHERE userID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
								 
			}
			else 
				{
				return -1;
				}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	return -2;
	}
	
	public int getUserAttend1 (String userID){
		String SQL = "SELECT userAttend FROM USER WHERE userID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
								 
			}
			else 
				{
				return -1;
				}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	return -2;
	}
	
	public int userAttend(String userID) {
		String SQL = "UPDATE USER SET userAttend=userAttend+1 WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			return pstmt.executeUpdate();
		}
		
		catch(Exception e){
			e.printStackTrace();

		}
		return -1;
	}
	
	public int cancelUserAttend(String userID) {
		String SQL = "UPDATE USER SET userAttend=userAttend-1 WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  userID);
			return pstmt.executeUpdate();
		}
		
		catch(Exception e){
			e.printStackTrace();

		}
		return -1;
	}
	
	public int userAdmin(String userID, int userMemberShip, int userAttend) {
		String SQL = "UPDATE USER SET userMemberShip = ?, userAttend = ? WHERE userID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, userMemberShip);
			pstmt.setInt(2, userAttend);
			pstmt.setString(3, userID);
			
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int userUpdate(String userPassword, String userName, String userEmail, String userAddress, int userAddressNum, String userGender, String userJob,
			int userAge, String userBirthday, String userPhoneNumber, String fileName, String fileRealName, int firstRoute, String userID) {
		 
		String SQL = null;
		if(fileName==null || fileRealName==null) {
			 SQL = "UPDATE USER SET userPassword = ?, userName = ?, userEmail = ?, userAddress=?, userAddressNum=?, userGender=?, userJob=?, userAge=?, userBirthday=?,"
						+ " userPhoneNumber=?, firstRoute=? WHERE userID = ? ";
		 }
		 else {
			 SQL = "UPDATE USER SET userPassword = ?, userName = ?, userEmail = ?, userAddress=?, userAddressNum=?, userGender=?, userJob=?, userAge=?, userBirthday=?,"
						+ " userPhoneNumber=?, fileName=?, fileRealName=?, firstRoute=? WHERE userID = ? ";
		 }
		 
		 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt = conn.prepareStatement(SQL);
			

		
				pstmt.setString(1, userPassword);
				pstmt.setString(2, userName);
				pstmt.setString(3, userEmail);
				pstmt.setString(4, userAddress);
				pstmt.setInt(5, userAddressNum);
				pstmt.setString(6, userGender);
				pstmt.setString(7, userJob);
				pstmt.setInt(8, userAge);
				pstmt.setString(9, userBirthday);
				pstmt.setString(10, userPhoneNumber);
		
			
			
			if(fileName==null || fileRealName==null) {

				pstmt.setInt(11, firstRoute);
				pstmt.setString(12, userID);
			}
			else {
				pstmt.setString(11, fileName);
				pstmt.setString(12, fileRealName);
				pstmt.setInt(13, firstRoute);
				pstmt.setString(14, userID);
			}
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int deleteUser(String userID) {
		
		String SQL = "delete from USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
		
		
	}
	
	public int passwordClear(String userID) {
		
		String SQL = "update USER set userPassword='fjvldnjfem' WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
		
		
	}
	
	public int introduceChangeState(String userID) {
		
		String SQL = "update USER set userMemberShip=4 WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
		
		
	}
	
	
}
