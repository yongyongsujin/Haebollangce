package com.sist.haebollangce.challenge.dto;

public class CertifyDTO {

	private String certifyNo;			// 인증일련번호
	private String fkUserid;			// 회원 아이디
	private String fkChallengeCode;	// 챌린지 일련번호
	private String certifyTime; 		// 인증시각
	private String certifyImg; 		// 인증사진 파일명
	
	
	
	public String getcertifyNo() {
		return certifyNo;
	}
	public void setcertifyNo(String certifyNo) {
		this.certifyNo = certifyNo;
	}
	public String getfkUserid() {
		return fkUserid;
	}
	public void setfkUserid(String fkUserid) {
		this.fkUserid = fkUserid;
	}
	public String getfkChallengeCode() {
		return fkChallengeCode;
	}
	public void setfkChallengeCode(String fkChallengeCode) {
		this.fkChallengeCode = fkChallengeCode;
	}
	public String getcertifyTime() {
		return certifyTime;
	}
	public void setcertifyTime(String certifyTime) {
		this.certifyTime = certifyTime;
	}
	public String getcertifyImg() {
		return certifyImg;
	}
	public void setcertifyImg(String certifyImg) {
		this.certifyImg = certifyImg;
	}
	
	
	
	
}
