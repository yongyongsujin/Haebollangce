package com.sist.haebollangce.lounge.model;

// === #82. 댓글용 DTO 생성
public class LoungeCommentDTO {
	
	private String seq;          // 댓글번호
	private String fkUserid;     // 사용자ID fk_userid
	private String name;         // 성명
	private String content;      // 댓글내용
	private String regDate;      // 작성일자
	private String parentSeq;    // 원게시물 글번호
	private String status;       // 글삭제여부
	
	private String groupno;		// === 답변글쓰기 게시판을 위한 필드
	private String fk_seq;
	private String depthno;
	
	private String lgcprofile;	// 라운지 1개글 볼때 필요한 댓글이미지

	// getter & setter
	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getFkUserid() {
		return fkUserid;
	}

	public void setFkUserid(String fkUserid) {
		this.fkUserid = fkUserid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(String parentSeq) {
		this.parentSeq = parentSeq;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	///////// getter & setter 추가 /////////
	public String getGroupno() {
		return groupno;
	}
	
	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}
	
	public String getFk_seq() {
		return fk_seq;
	}
	
	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}
	
	public String getDepthno() {
		return depthno;
	}
	
	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}

	public String getLgcprofile() {
		return lgcprofile;
	}

	public void setLgcprofile(String lgcprofile) {
		this.lgcprofile = lgcprofile;
	}

	/////////////////////////////////////////
	
	
}
