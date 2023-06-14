package com.sist.haebollangce.challenge.dao;

import org.springframework.web.multipart.MultipartFile;

public class challengeVO {

	private String challengeCode;			// 챌린지 일련번호
	private String fkCategoryCode;		    // 카테고리 코드   
	private String challengeName;			// 챌린지이름
	private String content;            		// 챌린지 본문(내용)
	private String regDate; 				// 등록일자
	private String challengeExp;			// 경험치
	private String memberCount; 			// 참가인원
	private String thumbnail;				// 대표이미지   
	private String fkFreqType;			    // 인증빈도 일련번호
	private String fkDuringType;			// 기간 일련번호
	private String startDate;				// 시작날짜
	private String fkUserid;				// 개설자(방장)
	
	
	private String categoryName;
	private String frequency;
	private String hourStart;
	private String hourEnd;
	private String enddate;
	// join 용도
	
	private String categoryCode;
	private String setDate;
	private String duringType;
	private String freqType;
	private String example;
	private String successImg;
	private String failImg;
	
	private MultipartFile attach;
	private MultipartFile successImgAttach;
	private MultipartFile failImgAttach;
	
	private String successImgFileName;
	private String failImgFileName;
	
	private String profilePic;
	
	private String pw;

	
	public String getChallengeCode() {
		return challengeCode;
	}
	public void setChallengeCode(String challengeCode) {
		this.challengeCode = challengeCode;
	}
	
	public String getfkCategoryCode() {
		return fkCategoryCode;
	}

	public void setfkCategoryCode(String fkCategoryCode) {
		this.fkCategoryCode = fkCategoryCode;
	}

	public String getChallengeName() {
		return challengeName;
	}
	public void setChallengeName(String challengeName) {
		this.challengeName = challengeName;
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
	public String getChallengeExp() {
		return challengeExp;
	}
	public void setChallengeExp(String challengeExp) {
		this.challengeExp = challengeExp;
	}
	public String getMemberCount() {
		return memberCount;
	}
	public void setMemberCount(String memberCount) {
		this.memberCount = memberCount;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getfkFreqType() {
		return fkFreqType;
	}
	public void setfkFreqType(String fkFreqType) {
		this.fkFreqType = fkFreqType;
	}
	public String getfkDuringType() {
		return fkDuringType;
	}
	public void setfkDuringType(String fkDuringType) {
		this.fkDuringType = fkDuringType;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getfkUserid() {
		return fkUserid;
	}
	public void setfkUserid(String fkUserid) {
		this.fkUserid = fkUserid;
	}
	
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getFrequency() {
		return frequency;
	}
	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	public String getHourStart() {
		return hourStart;
	}
	public void setHourStart(String hourStart) {
		this.hourStart = hourStart;
	}
	public String getHourEnd() {
		return hourEnd;
	}
	public void setHourEnd(String hourEnd) {
		this.hourEnd = hourEnd;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
	public String getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getSetDate() {
		return setDate;
	}
	public void setSetDate(String setDate) {
		this.setDate = setDate;
	}
	public String getDuringType() {
		return duringType;
	}
	public void setDuringType(String duringType) {
		this.duringType = duringType;
	}
	public String getFreqType() {
		return freqType;
	}
	public void setFreqType(String freqType) {
		this.freqType = freqType;
	}
	public String getExample() {
		return example;
	}
	public void setExample(String example) {
		this.example = example;
	}
	public String getSuccessImg() {
		return successImg;
	}
	public void setSuccessImg(String successImg) {
		this.successImg = successImg;
	}
	public String getFailImg() {
		return failImg;
	}
	public void setFailImg(String failImg) {
		this.failImg = failImg;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	public MultipartFile getSuccessImgAttach() {
		return successImgAttach;
	}

	public void setSuccessImgAttach(MultipartFile successImgAttach) {
		this.successImgAttach = successImgAttach;
	}

	public MultipartFile getFailImgAttach() {
		return failImgAttach;
	}

	public void setFailImgAttach(MultipartFile failImgAttach) {
		this.failImgAttach = failImgAttach;
	}




	public String getSuccessImgFileName() {
		return successImgFileName;
	}

	public void setSuccessImgFileName(String successImgFileName) {
		this.successImgFileName = successImgFileName;
	}

	public String getFailImgFileName() {
		return failImgFileName;
	}

	public void setFailImgFileName(String failImgFileName) {
		this.failImgFileName = failImgFileName;
	}

	

	public String getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	
	
	
}
