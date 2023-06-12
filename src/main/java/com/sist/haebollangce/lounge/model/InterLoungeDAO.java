package com.sist.haebollangce.lounge.model;

import java.util.List;
import java.util.Map;

public interface InterLoungeDAO {

	// === #2. 게시판 글쓰기 완료 요청 ===
	int loungeAdd(LoungeBoardDTO lgboarddto) throws Exception;

	// === #2-1. 파일첨부가 있는 게시판 글쓰기 완료 요청 ===
	int loungeAdd_withFile(LoungeBoardDTO lgboarddto);

	// --- #3-1. 페이징 처리 한 검색어 있는 전체 글 목록 보기 (1)검색이 있을 때 2)없을 때 다 포함) ---
	List<LoungeBoardDTO> lgboardListSearch(Map<String, String> paraMap);

	// --- #3-2. 페이징 처리를 위해 총 게시물 건수(totalCount) 구하기 (1)검색이 있을 때 2)없을 때 다 포함) ---
	int lggetTotalCount(Map<String, String> paraMap);
	
	// === #11. 검색어 입력시 자동글 완성하기 (Ajax 로 처리) ===
	List<String> lgwordSearchShow(Map<String, String> paraMap);

	// --- #4-1.글 조회수 증가와 함께 글 1개를 조회 해주는 것 ---
	LoungeBoardDTO lggetView(Map<String, String> paraMap);

	// --- #4-1-1. 글 조회수 1 증가 ---
	void lgsetAddReadCount(String seq);

	// === #6. 라운지 글 수정 페이지 요청 완료 ===
	int lgedit(LoungeBoardDTO lgboarddto);
	
	// === #6-1. 파일첨부가 있는 라운지 글 수정 페이지 요청 완료 ===
	int lgedit_withFile(LoungeBoardDTO lgboarddto);

	// === #8. 라운지 글 삭제 페이지 요청 완료 ===
	int lgdel(Map<String, String> paraMap);

	// --- #9-1. tbl_lounge_comment 댓글쓰기(insert)--- 
	int loungeaddComment(LoungeCommentDTO lgcommentdto);

	// --- #9-2. tbl_lounge_board 댓글수증가(update)--- 
	int loungeupdateCount(String parentSeq);

	// --- #9-3. tbl_lounge_comment 테이블에서 groupno 컬럼의 최대값 알아오기 ---
	// -> 원댓글쓰기 : groupno 컬럼의 최대값(max)+1 로 해서 insert 해야한다
	int getGroupno_max();

	// --- #14-1. tbl_lounge_comment 댓글삭제(delete)--- 
	int lgcommentDel(LoungeCommentDTO lgcommentdto);
	
	// --- #14-2. tbl_lounge_board 댓글수증가(update)--- 
	int lgcommentDelupdateCount(String parentSeq);	

	// === #10. 원 게시물에 딸린 댓글들을 조회 ===
	List<LoungeCommentDTO> lggetCommentList(String parentSeq);

	// === #13-0. 라운지 특정글에 대한 좋아요가 눌렸는지 확인하기 ===
	int loungelikeCheck(LoungelikeDTO lglikedto);
	
	// --- #13-1.tbl_lounge_like 테이블에 좋아요 추가하기(insert) ---
	int loungelikeAdd(LoungelikeDTO lglikedto);

	// --- #13-2.tbl_lounge_board 테이블에 likeCount 컬럼이 1 증가 (update) ---
	int loungeupdatelikeCount(String fk_seq);

	// --- #13-3.tbl_lounge_like 테이블에 좋아요 취소하기(delete) 
	int loungelikeCancel(LoungelikeDTO lglikedto);

	// --- #13-4.tbl_lounge_board 테이블에 likeCount 컬럼이 1 감소 (update)
	int loungecancellikeCount(String fk_seq);
	
	
	
	
}
