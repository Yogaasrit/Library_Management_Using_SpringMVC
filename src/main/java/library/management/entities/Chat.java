package library.management.entities;

public class Chat {
private int chatId;
private int userId;
private String userName;
private String message;
private String replyMessage;

public Chat() {
	super();
	// TODO Auto-generated constructor stub
}

public String getReplyMessage() {
	return replyMessage;
}

public void setReplyMessage(String replyMessage) {
	this.replyMessage = replyMessage;
}

public int getChatId() {
	return chatId;
}
public void setChatId(int chatId) {
	this.chatId = chatId;
}
public int getUserId() {
	return userId;
}
public void setUserId(int userId) {
	this.userId = userId;
}
public String getUserName() {
	return userName;
}
public void setUserName(String userName) {
	this.userName = userName;
}
public String getMessage() {
	return message;
}
public void setMessage(String message) {
	this.message = message;
}
}