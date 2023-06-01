package com.sist.haebollangce.challenge.dto;

public class ChallengeDTO {
	
	private String challenge_code;			// 챌린지 일련번호
	private String fk_category_code;		// 카테고리 코드   
	private String challenge_name;			// 챌린지이름
	private String content;            		// 챌린지 본문(내용)
	private String regDate; 				// 등록일자
	private String challenge_exp;			// 경험치
	private String member_count; 			// 참가인원
	private String thumbnail;				// 대표이미지   
	private String fk_freq_type;			// 인증빈도 일련번호
	private String fk_during_type;			// 기간 일련번호
	private String startDate;				// 시작날짜
	private String fk_userid;				// 개설자(방장)
	
	
	private String category_name;
	private String frequency;
	private String hour_start;
	private String hour_end;
	private String enddate;
	// join 용도
	
	
	public String getChallenge_code() {
		return challenge_code;
	}
	public void setChallenge_code(String challenge_code) {
		this.challenge_code = challenge_code;
	}
	public String getFk_category_code() {
		return fk_category_code;
	}
	public void setFk_category_code(String fk_category_code) {
		this.fk_category_code = fk_category_code;
	}
	public String getChallenge_name() {
		return challenge_name;
	}
	public void setChallenge_name(String challenge_name) {
		this.challenge_name = challenge_name;
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
	public String getChallenge_exp() {
		return challenge_exp;
	}
	public void setChallenge_exp(String challenge_exp) {
		this.challenge_exp = challenge_exp;
	}
	public String getMember_count() {
		return member_count;
	}
	public void setMember_count(String member_count) {
		this.member_count = member_count;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getFk_freq_type() {
		return fk_freq_type;
	}
	public void setFk_freq_type(String fk_freq_type) {
		this.fk_freq_type = fk_freq_type;
	}
	public String getFk_during_type() {
		return fk_during_type;
	}
	public void setFk_during_type(String fk_during_type) {
		this.fk_during_type = fk_during_type;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	
	
	
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getFrequency() {
		return frequency;
	}
	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	public String getHour_start() {
		return hour_start;
	}
	public void setHour_start(String hour_start) {
		this.hour_start = hour_start;
	}
	public String getHour_end() {
		return hour_end;
	}
	public void setHour_end(String hour_end) {
		this.hour_end = hour_end;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
	
	
	
}
