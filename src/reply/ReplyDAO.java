package reply;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import bulletin.Bulletin;
import bulletin.BulletinDAO;

public class ReplyDAO {


	private Connection conn;
	private ResultSet rs;
	
	public ReplyDAO() {
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
		String SQL = "SELECT replyID FROM reply ORDER BY replyID DESC";
		
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
	
	public int reply(int bulletinID, String userID, String replyContent) {
	String SQL = "INSERT INTO reply VALUES(?,?,?,?,?,?)" ;
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, bulletinID);
			pstmt.setString(3, userID);
			pstmt.setString(4, replyContent);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);
	
			//rs = pstmt.executeQuery();
			
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
 
		return -1; //�����ͺ��̽� ����
	
	}
	// �Խ��� �� ��� �ҷ�����
	public ArrayList<Reply> getList(int bulletinID){
		String SQL = "SELECT * FROM reply WHERE bulletinID = ? ";
		
		ArrayList<Reply> list = new ArrayList<Reply>();
		
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bulletinID);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Reply reply = new Reply();
				reply.setReplyID(rs.getInt(1));
				reply.setBulletinID(rs.getInt(2));
				reply.setUserID(rs.getString(3));
				reply.setReplyContent(rs.getString(4));
				reply.setReplyDate(rs.getString(5));
				reply.setReplyAvailable(rs.getInt(6));

				list.add(reply);
								 
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
	
		return list; //������ ��ȯ
		
	
	}

	
	public Reply getReply(int bulletinID) {
		String SQL = "SELECT * FROM reply WHERE bulletinID = ? ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bulletinID);
			
			rs = pstmt.executeQuery();
		
			
				if(rs.next()) {
					
					Reply reply = new Reply();
					reply.setReplyID(rs.getInt(1));
					reply.setBulletinID(rs.getInt(2));
					reply.setUserID(rs.getString(3));
					reply.setReplyContent(rs.getString(4));
					reply.setReplyDate(rs.getString(5));
					reply.setReplyAvailable(rs.getInt(6));
					return reply;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null; // �ҷ����� ����
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
		return -1; //�����ͺ��̽� ����
	}
	
	public int delete(int replyID) {
		
		String SQL = "UPDATE reply SET replyAvailable = 0 WHERE replyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyID);
		
			return pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ���� 
		
		
	}
}
