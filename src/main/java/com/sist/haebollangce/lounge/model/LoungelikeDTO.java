package com.sist.haebollangce.lounge.model;

// 게시물 좋아요 DTO 생성
public class LoungelikeDTO {

	private String fk_userid; 	// 좋아요 누른 사용자
	private String fk_seq;		// 좋아요 누른 게시물 (DB에서는 number임)
	
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getFk_seq() {
		return fk_seq;
	}
	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}
	
	
}
