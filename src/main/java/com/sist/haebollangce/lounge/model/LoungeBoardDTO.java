package com.sist.haebollangce.lounge.model;

import org.springframework.web.multipart.MultipartFile;

// === #52. DTO 생성하기 ===
// 먼저 Oracle 에서 tbl_board 테이블을 먼저 생성해야한다.

public class LoungeBoardDTO {
	
	// insert 용 필드
	private String seq;          // 글번호 
	private String fk_userid;    // 사용자ID fk_userid
	private String name;         // 글쓴이 
	private String subject;      // 글제목
	private String content;      // 글내용 
	private String pw;           // 글암호
	private String readCount;    // 글조회수
	private String regDate;      // 글쓴시간
	private String status;       // 글삭제여부   1:사용가능한 글,  0:삭제된글 
   
	private String commentCount;	// === 댓글형 게시판을 위한 댓글수  필드 추가
	
    private MultipartFile attach;	// === 첨부파일
	/* 
		form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 
       	진짜파일 ==> WAS(톰캣) 디스크에 저장됨.
       	조심할것은 MultipartFile attach 는 오라클 데이터베이스 tbl_lounge_board 테이블의 컬럼이 아니다.
       	/Haebollangce/src/main/webapp/WEB-INF/views/tiles1/lounge/loungeAdd.jsp 파일에서 input type="file" 인 name 의 이름(attach)과  
		동일해야만 파일첨부가 가능해진다.!!!!
	*/
	private String fileName;    // WAS(톰캣)에 저장될 파일명(2023052211123035243254235235234.png) 
	private String orgFilename; // 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize;    // 파일크기 
	
	private MultipartFile attachThumbnail; 	// === 썸네일 첨부파일
	
	private String thumbnail;	// 게시물 썸네일
	private String regDateAgo;	// 게시물 작성일로부터 경과한 일 수를 구하는데 사용 regDate_ago
	private String likeCount;	// 게시물의 좋아요 갯수
	private String lgbprofile; 	// 라운지 1개글 볼때 필요한 프로필이미지
	
	//////////////////////////////////////////////////
	// getter & setter
	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getReadCount() {
		return readCount;
	}

	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}

	
	///////// getter & setter 추가 /////////
	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	
	///////// getter & setter 추가 /////////
	
	public MultipartFile getAttachThumbnail() {
		return attachThumbnail;
	}

	public void setAttachThumbnail(MultipartFile attachThumbnail) {
		this.attachThumbnail = attachThumbnail;
	}


	public String getThumbnail() {
	return thumbnail;
	}
	
	public void setThumbnail(String thumbnail) {
	this.thumbnail = thumbnail;
	}
	
	public String getRegDateAgo() {
		return regDateAgo;
	}

	public void setRegDateAgo(String regDateAgo) {
		this.regDateAgo = regDateAgo;
	}
	
	public String getLikeCount() {
		return likeCount;
	}
	
	public void setLikeCount(String likeCount) {
		this.likeCount = likeCount;
	}
	
	public String getLgbprofile() {
		return lgbprofile;
	}

	public void setLgbprofile(String lgbprofile) {
		this.lgbprofile = lgbprofile;
	}

	
}










