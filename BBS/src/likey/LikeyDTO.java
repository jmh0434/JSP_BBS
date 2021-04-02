package likey;

public class LikeyDTO {
	String userID;
	int bbsID;
	String userIP;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	public LikeyDTO(String userID, int bbsID, String userIP) {
		super();
		this.userID = userID;
		this.bbsID = bbsID;
		this.userIP = userIP;
	}
}
