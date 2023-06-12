package com.sist.haebollangce.messenger.model;

// === 쪽지 기능을 위해 DTO 생성 === //
public class MessengerDTO {

	private String seq;          		//쪽지번호
	private String title;          		//쪽지제목
	private String content;          	//쪽지내용
	private String regDate;          	//쪽지보낸일자
	private String sender;          	//쪽지 보낸사람
	private String receiver;          	//쪽지 받은사람
	private String isdeletedBySender;   //보낸이 쪽지삭제여부   1:삭제x,  0:삭제o
	private String isdeletedByReceiver;	//받는이 쪽지삭제여부   1:삭제x,  0:삭제o
	
	
	// getter & setter
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getIsdeletedBySender() {
		return isdeletedBySender;
	}
	public void setIsdeletedBySender(String isdeletedBySender) {
		this.isdeletedBySender = isdeletedBySender;
	}
	public String getIsdeletedByReceiver() {
		return isdeletedByReceiver;
	}
	public void setIsdeletedByReceiver(String isdeletedByReceiver) {
		this.isdeletedByReceiver = isdeletedByReceiver;
	}
	
	
}
