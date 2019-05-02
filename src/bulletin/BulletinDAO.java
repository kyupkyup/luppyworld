
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
			String dbURL = "jdbc:mysql://localhost/luppyworld?serverTimezone=UTC";	//���� ����
			String dbID = "luppyworld";
			String dbPassword = "a1870523!!";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);	//������Ѽ� conn�� ����
			
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
		return ""; //�����ͺ��̽� ����

	}
	
	public int getNext() {
		String SQL = "SELECT bulletinID FROM bulletin ORDER BY bulletinID DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) + 1;
				 
			}
			return 1; // ù��° �Խñ��� ���
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����

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
		return -1; //�����ͺ��̽� ����
	
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
			pstmt.setInt(6, 2); // bulletin available 2�� ��������
			pstmt.setString(7, getDate());
			pstmt.setString(8, fileName);
			pstmt.setString(9, fileRealName);
				
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	
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
			pstmt.setInt(6, 3); // bulletinAvailable 3�̸� �����λ�
			pstmt.setString(7, getDate());
			pstmt.setString(8, fileName);
			pstmt.setString(9, fileRealName);
				
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	
	}
	// �Խ��� �� ��� �ҷ�����
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
		return list; //������ ��ȯ
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
		return list; //������ ��ȯ
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
		return list; //������ ��ȯ
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
		return false; //������ ��ȯ
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
		return null; // �ҷ����� ����
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
		return -1; //�����ͺ��̽� ����
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
		return -1; //�����ͺ��̽� ���� 
		
		
	}
	
}
