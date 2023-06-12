package com.sist.haebollangce.challenge.dto;

public class ChallengeInfoDTO {
	
	private String challengeInfo;
	private String fkUserid;
	private String fkChallengeCode;
	private String entryFee;
	private String achievementPct;
	private int userReward;
	
	
	public String getChallengeInfo() {
		return challengeInfo;
	}
	public void setChallengeInfo(String challengeInfo) {
		this.challengeInfo = challengeInfo;
	}
	public String getFkUserid() {
		return fkUserid;
	}
	public void setFkUserid(String fkUserid) {
		this.fkUserid = fkUserid;
	}
	public String getFkChallengeCode() {
		return fkChallengeCode;
	}
	public void setFkChallengeCode(String fkChallengeCode) {
		this.fkChallengeCode = fkChallengeCode;
	}
	public String getEntryFee() {
		return entryFee;
	}
	public void setEntryFee(String entryFee) {
		this.entryFee = entryFee;
	}
	public String getAchievementPct() {
		return achievementPct;
	}
	public void setAchievementPct(String achievementPct) {
		this.achievementPct = achievementPct;
	}
	public int getUserReward() {
		return userReward;
	}
	public void setUserReward(int userReward) {
		this.userReward = userReward;
	}
	
	

}
