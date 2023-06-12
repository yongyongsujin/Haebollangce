package com.sist.haebollangce.lounge.service;

import java.util.List;
import java.util.Map;

import com.sist.haebollangce.lounge.model.LoungeBoardDTO;
import com.sist.haebollangce.lounge.model.LoungeCommentDTO;
import com.sist.haebollangce.lounge.model.LoungelikeDTO;

public interface InterLoungeService {

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

	// --- #4-1. 글 조회수 증가와 함께 글 1개를 조회 해주는 것 ---
	LoungeBoardDTO lggetView(Map<String, String> paraMap);

	// --- #4-2. 글 조회수 증가는 없고, 단순히 글 1개만 조회해주는 것 ---
	LoungeBoardDTO lggetViewWithNoAddCount(Map<String, String> paraMap);

	// === #6. 라운지 글 수정 페이지 요청 완료 ===
	int lgedit(LoungeBoardDTO lgboarddto);
	
	// === #6-1. 파일첨부가 있는 라운지 글 수정 페이지 요청 완료 ===
	int lgedit_withFile(LoungeBoardDTO lgboarddto);

	// === #6-2. 라운지 글 편집 중 파일첨부 있으면 삭제 요청 === 첨부파일 편집 기능 만들다 보류
	/* void deletelgOrgFilename(Map<String, String> paraMap); */

	// === #8. 라운지 글 삭제 페이지 요청 완료 ===
	int lgdel(Map<String, String> paraMap);

	// === #9. 댓글쓰기(transaction 처리) ===
	// --- 댓글쓰기(insert) / 원게시물에 댓글수 증가(update)
	int loungeaddComment(LoungeCommentDTO lgcommentdto) throws Throwable;
	
	// === #14. 라운지 특정 글에서 댓글  삭제하기(Ajax 처리) ===
	// --- 댓글삭제(delete) / 원게시물에 댓글수 감소(update1)
	int lgcommentDel(LoungeCommentDTO lgcommentdto);

	// === #10. 원 게시물에 딸린 댓글들을 조회 ===
	List<LoungeCommentDTO> lggetCommentList(String parentSeq);

	// === #13-0. 라운지 특정글에 대한 좋아요가 눌렸는지 확인하기 (select) ===
	int loungelikeCheck(LoungelikeDTO lglikedto);
	
	// --- #13-1.tbl_lounge_like 테이블에 좋아요 추가하기(insert)
	int loungelikeAdd(LoungelikeDTO lglikedto);

	// --- #13-3.tbl_lounge_like 테이블에 좋아요 취소하기(delete)
	int loungelikeCancel(LoungelikeDTO lglikedto);

	
	
	
	
	
	
}
