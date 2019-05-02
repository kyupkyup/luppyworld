package bulletin;

/**
 * @author lky
 *
 */
/**
 * @author lky
 *
 */
public class Bulletin {

	private int bulletinID;
	private String bulletinTitle;
	private String userID;
	private String bulletinContent;
	private String userName;
	private int bulletinAvailable;
	private String bulletinDate;
	private String fileName;
	private String fileRealName;

	public Bulletin() {
		
		
	}
	
	public int getBulletinID() {
		return bulletinID;
	}
	public void setBulletinID(int bulletinID) {
		this.bulletinID = bulletinID;
	}
	public String getBulletinTitle() {
		return bulletinTitle;
	}
	public void setBulletinTitle(String bulletinTitle) {
		this.bulletinTitle = bulletinTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBulletinContent() {
		return bulletinContent;
	}
	public void setBulletinContent(String bulletinContent) {
		this.bulletinContent = bulletinContent;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getBulletinAvailable() {
		return bulletinAvailable;
	}
	public void setBulletinAvailable(int bulletinAvailable) {
		this.bulletinAvailable = bulletinAvailable;
	}

	public String getBulletinDate() {
		return bulletinDate;
	}
	public void setBulletinDate(String bulletinDate) {
		this.bulletinDate = bulletinDate;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileRealName() {
		return fileRealName;
	}

	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	
	
}
