package com.sist.haebollangce.lounge.model;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.haebollangce.common.mapper.InterMapper;

@Repository
public class LoungeDAO implements InterLoungeDAO {

	// === 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
//  @Resource
//  private SqlSessionTemplate sqlsession;
	@Autowired
	private InterMapper mapper;

	// === #2. 게시판 글쓰기 완료 요청 ===
	@Override
	public int loungeAdd(LoungeBoardDTO lgboarddto) throws Exception {
		
//      int n = sqlsession.insert("user.test_insert",userid);
//      int n = mapper.test_insert(userid);
		int n = mapper.loungeAdd(lgboarddto);
		return n;
	}
	
	// === #2-1. 파일첨부가 있는 게시판 글쓰기 완료 요청 ===
	@Override
	public int loungeAdd_withFile(LoungeBoardDTO lgboarddto) {
		int n = mapper.loungeAdd_withFile(lgboarddto);
		return n;
	}

	// --- #3-1. 페이징 처리 한 검색어 있는 전체 글 목록 보기 (1)검색이 있을 때 2)없을 때 다 포함) ---
	@Override
	public List<LoungeBoardDTO> lgboardListSearch(Map<String, String> paraMap) {
		List<LoungeBoardDTO> lgboardList = mapper.lgboardListSearch(paraMap);
		return lgboardList;
	}
	
	// --- #3-2. 페이징 처리를 위해 총 게시물 건수(totalCount) 구하기 (1)검색이 있을 때 2)없을 때 다 포함) ---
	@Override
	public int lggetTotalCount(Map<String, String> paraMap) {
		int n = mapper.lggetTotalCount(paraMap);
		return n;
	}
		
	// === #11. 검색어 입력시 자동글 완성하기 (Ajax 로 처리) ===
	@Override
	public List<String> lgwordSearchShow(Map<String, String> paraMap) {
		List<String> lgwordList = mapper.lgwordSearchShow(paraMap);
		return lgwordList;
	}

	// --- #4-1.글 조회수 증가와 함께 글 1개를 조회 해주는 것 ---
	@Override
	public LoungeBoardDTO lggetView(Map<String, String> paraMap) {
		LoungeBoardDTO lgboarddto = mapper.lggetView(paraMap);
		return lgboarddto;
	}

	// --- #4-1-1. 글 조회수 1 증가 ---
	@Override
	public void lgsetAddReadCount(String seq) {
		mapper.lgsetAddReadCount(seq);
	}

	// === #6. 라운지 글 수정 페이지 요청 완료 ===
	@Override
	public int lgedit(LoungeBoardDTO lgboarddto) {
		int n = mapper.lgedit(lgboarddto);
		return n;
	}
	
	// === #6-1. 파일첨부가 있는 라운지 글 수정 페이지 요청 완료 ===
	@Override
	public int lgedit_withFile(LoungeBoardDTO lgboarddto) {
		int n = mapper.lgedit_withFile(lgboarddto);
		return n;
	}

	// === #8. 라운지 글 삭제 페이지 요청 완료 ===
	@Override
	public int lgdel(Map<String, String> paraMap) {
		int n = mapper.lgdel(paraMap);
		return n;
	}
	
	// --- #9-1. tbl_lounge_comment 댓글쓰기(insert)--- 
	@Override
	public int loungeaddComment(LoungeCommentDTO lgcommentdto) {
		int n = mapper.loungeaddComment(lgcommentdto);
		return n;
	}
	
	// --- #9-2. tbl_lounge_board 댓글수증가(update)--- 
	@Override
	public int loungeupdateCount(String parentSeq) {
		int n = mapper.loungeupdateCount(parentSeq);
		return n;
	}
	
	// --- #9-3. tbl_lounge_comment 테이블에서 groupno 컬럼의 최대값 알아오기 ---
	// -> 원댓글쓰기 : groupno 컬럼의 최대값(max)+1 로 해서 insert 해야한다
	@Override
	public int getGroupno_max() {
		int groupno = mapper.getGroupno_max();
		return groupno;
	}
	
	// --- #14-1. tbl_lounge_comment 댓글삭제(delete)--- 
	@Override
	public int lgcommentDel(LoungeCommentDTO lgcommentdto) {
		int n = mapper.lgcommentDel(lgcommentdto);
		return n;
	}
	
	// --- #14-2. tbl_lounge_board 댓글수증가(update)--- 
	@Override
	public int lgcommentDelupdateCount(String parentSeq) {
		int n = mapper.lgcommentDelupdateCount(parentSeq);
		return n;
	}

	// === #10. 원 게시물에 딸린 댓글들을 조회 ===
	@Override
	public List<LoungeCommentDTO> lggetCommentList(String parentSeq) {
		List<LoungeCommentDTO> lgcommentList = mapper.lggetCommentList(parentSeq);
		return lgcommentList;
	}

	// === #13-0. 라운지 특정글에 대한 좋아요가 눌렸는지 확인하기 ===
	@Override
	public int loungelikeCheck(LoungelikeDTO lglikedto) {
		int n = mapper.loungelikeCheck(lglikedto);
		return n;
	}
	
	// --- #13-1.tbl_lounge_like 테이블에 좋아요 추가하기(insert) ---
	@Override
	public int loungelikeAdd(LoungelikeDTO lglikedto) {
		int n = mapper.loungelikeAdd(lglikedto);
		return n;
	}
	
	// --- #13-2.tbl_lounge_board 테이블에 likeCount 컬럼이 1 증가 (update) ---
	@Override
	public int loungeupdatelikeCount(String fk_seq) {
		int n = mapper.loungeupdatelikeCount(fk_seq);
		return n;
	}

	// --- #13-3.tbl_lounge_like 테이블에 좋아요 취소하기(delete)
	@Override
	public int loungelikeCancel(LoungelikeDTO lglikedto) {
		int n = mapper.loungelikeCancel(lglikedto);
		return n;
	}

	// --- #13-4.tbl_lounge_board 테이블에 likeCount 컬럼이 1 감소 (update)
	@Override
	public int loungecancellikeCount(String fk_seq) {
		int n = mapper.loungecancellikeCount(fk_seq);
		return n;
	}
	
	
	
	
	
	
}
