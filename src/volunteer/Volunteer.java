package volunteer;

import java.sql.Date;
import java.sql.Time;

public class Volunteer {

	int volunteerID;
	/* 1. ���������ҰԿ�.
	 * 2. īǮŸ��� ������, ������ �����ϴٸ� ���� �����ҰԿ�.
	 * 3. �� īǮ Ÿ�� �;��.
	 * 4. �ƴϿ�. ���� ���Կ�.
	 * 5. ���� ����� ������, ������ �����ϴٸ� ���� �����ҰԿ�.
	 * 
	 * */
	int volunteerAvailable;
	int eatWhether;
	String foodName;
	int foodPrice;
	String volunteerDate;
	String volunteerTitle;
	String volunteerContent;
	String volunteerPlace;
	String volunteerAnnounceDate;
	String userID;
	String dueDate;
	String dueHour;
	String dueMinute;
	String surveyURL;
	
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getVolunteerID() {
		return volunteerID;
	}
	public void setVolunteerID(int volunteerID) {
		this.volunteerID = volunteerID;
	}

	public int getVolunteerAvailable() {
		return volunteerAvailable;
	}
	public void setVolunteerAvailable(int volunteerAvailable) {
		this.volunteerAvailable = volunteerAvailable;
	}

	public int getEatWhether() {
		return eatWhether;
	}
	public void setEatWhether(int eatWhether) {
		this.eatWhether = eatWhether;
	}
	public String getFoodName() {
		return foodName;
	}
	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}
	public int getFoodPrice() {
		return foodPrice;
	}
	public void setFoodPrice(int foodPrice) {
		this.foodPrice = foodPrice;
	}
	public String getVolunteerDate() {
		return volunteerDate;
	}
	public void setVolunteerDate(String volunteerDate) {
		this.volunteerDate = volunteerDate;
	}
	public String getVolunteerTitle() {
		return volunteerTitle;
	}
	public void setVolunteerTitle(String volunteerTitle) {
		this.volunteerTitle = volunteerTitle;
	}
	public String getVolunteerContent() {
		return volunteerContent;
	}
	public void setVolunteerContent(String volunteerContent) {
		this.volunteerContent = volunteerContent;
	}
	public String getVolunteerPlace() {
		return volunteerPlace;
	}
	public void setVolunteerPlace(String volunteerPlace) {
		this.volunteerPlace = volunteerPlace;
	}
	public String getVolunteerAnnounceDate() {
		return volunteerAnnounceDate;
	}
	public void setVolunteerAnnounceDate(String volunteerAnnounceDate) {
		this.volunteerAnnounceDate = volunteerAnnounceDate;
	}
	public String getDueDate() {
		return dueDate;
	}
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}
	public String getDueHour() {
		return dueHour;
	}
	public void setDueHour(String dueHour) {
		this.dueHour = dueHour;
	}
	public String getDueMinute() {
		return dueMinute;
	}
	public void setDueMinute(String dueMinute) {
		this.dueMinute = dueMinute;
	}

	public String getSurveyURL() {
		return surveyURL;
	}
	public void setSurveyURL(String surveyURL) {
		this.surveyURL = surveyURL;
	}
	
	
	
	
	
	
}
