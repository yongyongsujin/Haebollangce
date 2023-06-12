package com.sist.haebollangce.lounge.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.lounge.model.InterLoungeDAO;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;
import com.sist.haebollangce.lounge.model.LoungeCommentDTO;
import com.sist.haebollangce.lounge.model.LoungelikeDTO;

@Service
public class LoungeService implements InterLoungeService {

	// === 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired
	private InterLoungeDAO  dao;

	// === #2. 게시판 글쓰기 완료 요청 ===
	@Override
	public int loungeAdd(LoungeBoardDTO lgboarddto) throws Exception{
		int n = dao.loungeAdd(lgboarddto);
		return n;
	}
	
	// === #2-1. 파일첨부가 있는 게시판 글쓰기 완료 요청 ===
	@Override
	public int loungeAdd_withFile(LoungeBoardDTO lgboarddto) {
		int n = dao.loungeAdd_withFile(lgboarddto);
		return n;
	}
	
	// --- #3-1. 페이징 처리 한 검색어 있는 전체 글 목록 보기 (1)검색이 있을 때 2)없을 때 다 포함)---
	@Override
	public List<LoungeBoardDTO> lgboardListSearch(Map<String, String> paraMap) {
		List<LoungeBoardDTO> lgboardList = dao.lgboardListSearch(paraMap);
		return lgboardList;
	}

	// --- #3-2. 페이징 처리를 위해 총 게시물 건수(totalCount) 구하기 (1)검색이 있을 때 2)없을 때 다 포함)---
	@Override
	public int lggetTotalCount(Map<String, String> paraMap) {
		int n = dao.lggetTotalCount(paraMap);
		return n;
	}
	
	// === #11. 검색어 입력시 자동글 완성하기 (Ajax 로 처리) ===
	@Override
	public List<String> lgwordSearchShow(Map<String, String> paraMap) {
		List<String> lgwordList = dao.lgwordSearchShow(paraMap);
		return lgwordList;
	}


	// --- #4-1.글 조회수 증가와 함께 글 1개를 조회 해주는 것 ---
	@Override
	public LoungeBoardDTO lggetView(Map<String, String> paraMap) {
		LoungeBoardDTO lgboarddto = dao.lggetView(paraMap); // 글 1개 조회하기
		
		// --- #4-1-1. 글 조회수 1 증가 --- 
		dao.lgsetAddReadCount(lgboarddto.getSeq()); // 조회수 1 증가하고,
		lgboarddto = dao.lggetView(paraMap); 		  // 조회수가 업데이트 된 글을 읽어온다.
		
		return lgboarddto;
	}

	// --- #4-2. 글 조회수 증가는 없고, 단순히 글 1개만 조회해주는 것 ---
	@Override
	public LoungeBoardDTO lggetViewWithNoAddCount(Map<String, String> paraMap) {
		LoungeBoardDTO lgboarddto = dao.lggetView(paraMap); // 글 1개 조회하기
		return lgboarddto;
	}

	// === #6. 라운지 글 수정 페이지 요청 완료 ===
	@Override
	public int lgedit(LoungeBoardDTO lgboarddto) {
		int n = dao.lgedit(lgboarddto);
		return n;
	}
	
	// === #6-1. 파일첨부가 있는 라운지 글 수정 페이지 요청 완료 ===
	@Override
	public int lgedit_withFile(LoungeBoardDTO lgboarddto) {
		int n = dao.lgedit_withFile(lgboarddto);
		return n;
	}
	
	// === #6-2. 라운지 글 편집 중 파일첨부 있으면 삭제 요청 === 첨부파일 편집 기능 만들다 보류
	/*
	 * @Override public void deletelgOrgFilename(Map<String, String> paraMap) {
	 * String path = paraMap.get("path"); String fileName = paraMap.get("fileName");
	 * 
	 * if(fileName != null && !"".equals(fileName)) { try {
	 * FileManager.doFileDelete(fileName, path); } catch (Exception e) {
	 * e.printStackTrace(); } } }
	 */
			
	// === #8. 라운지 글 삭제 페이지 요청 완료 ===
	@Override
	public int lgdel(Map<String, String> paraMap) {
		int n = dao.lgdel(paraMap);
		
		// --- 파일첨부가 된 글이라면 글 삭제시 paraMap 에 담아온 파일정보로 DB 에서 파일을 삭제하고 글을 지운다  ---
		if(n==1) {
			String path = paraMap.get("path");
			String fileName = paraMap.get("fileName");
			
			if(fileName != null && !"".equals(fileName)) {
				try {
					FileManager.doFileDelete(fileName, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return n;
	}

	// === #9. 댓글쓰기(transaction 처리) ===
	// --- 댓글쓰기(insert) / 원게시물에 댓글수 증가(update)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int loungeaddComment(LoungeCommentDTO lgcommentdto) throws Throwable {
		
		// 댓글쓰기가 원댓글쓰기인지 아니면 답변댓글쓰기인지를 구분하여  tbl_lounge_comment 테이블에 insert 를 해주어야 한다.
	    // 원댓글쓰기 이라면 tbl_lounge_comment 테이블의 groupno 컬럼의 값은 groupno 컬럼의 최대값(max)+1 로 해서 insert 해야하고,
	    // 답변댓글쓰기 이라면 넘겨받은 값(lgcommentdto)을 그대로 insert 해주어야 한다. 
	    
	    // --- #9-3. tbl_lounge_comment 테이블에서 groupno 컬럼의 최대값 알아오기 --- (#144.)
		// -> 원댓글쓰기 : groupno 컬럼의 최대값(max)+1 로 해서 insert 해야한다
		if("".equals(lgcommentdto.getFk_seq())) { 
			int groupno = dao.getGroupno_max() + 1;
			lgcommentdto.setGroupno(String.valueOf(groupno));
		}
		
		int n=0, m=0;
		
		// --- #9-1. tbl_lounge_comment 댓글쓰기(insert)--- 
		n = dao.loungeaddComment(lgcommentdto); 
		
		if(n==1) {
			// --- #9-2. tbl_lounge_board 댓글수증가(update)--- 
			m = dao.loungeupdateCount(lgcommentdto.getParentSeq()); 
		}
		
		return m;
	}

	// === #14. 라운지 특정 글에서 댓글  삭제하기(Ajax 처리) ===
	// --- 댓글삭제(delete) / 원게시물에 댓글수 감소(update1)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int lgcommentDel(LoungeCommentDTO lgcommentdto) {
		
		int n=0, m=0;
		
		// --- #14-1. tbl_lounge_comment 댓글삭제(delete)--- 
		n = dao.lgcommentDel(lgcommentdto); 
		//System.out.println("~~~댓글삭제 n : " + n);
		
		if(n > 0) {
			// --- #14-2. tbl_lounge_board 댓글수감소(update)--- 
			for(int i=0; i<n; i++) {
				m = dao.lgcommentDelupdateCount(lgcommentdto.getParentSeq()); 
				//System.out.println("~~~댓글삭제 m : " + m);
			}
		}
		
		return m;
	}
		
	
	// === #10. 원 게시물에 딸린 댓글들을 조회 ===
	@Override
	public List<LoungeCommentDTO> lggetCommentList(String parentSeq) {
		List<LoungeCommentDTO> lgcommentList = dao.lggetCommentList(parentSeq);
		return lgcommentList;
	}

	// === #13. 라운지 특정글에 대한 좋아요 등록하고 취소하기 === 
	
	// === #13-0. 라운지 특정글에 대한 좋아요가 눌렸는지 확인하기 ===
	@Override
	public int loungelikeCheck(LoungelikeDTO lglikedto) {
		int n = dao.loungelikeCheck(lglikedto);
		return n;
	}

	// --- 좋아요 등록(transaction 처리) ---
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int loungelikeAdd(LoungelikeDTO lglikedto) {
		
		int n=0, result=0;
		
		n = dao.loungelikeAdd(lglikedto); // --- #13-1.tbl_lounge_like 테이블에 좋아요 추가하기(insert)
		// System.out.println("~~~ 확인용 n : " + n);
		// ~~~ 확인용 n : 1
		
		if(n==1) {
			result = dao.loungeupdatelikeCount(lglikedto.getFk_seq()); // --- #13-2.tbl_lounge_board 테이블에 likeCount 컬럼이 1 증가 (update)
			// System.out.println("~~~ 확인용 result : " + result);
			// ~~~ 확인용 result : 1
		}
		return result;
	}

	// --- 좋아요 취소(transaction 처리) ---
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int loungelikeCancel(LoungelikeDTO lglikedto) {
		
		int n=0, result=0;
		
		n = dao.loungelikeCancel(lglikedto); // --- #13-3.tbl_lounge_like 테이블에 좋아요 취소하기(delete)
		// System.out.println("~~~ 확인용 n : " + n);
		// ~~~ 확인용 n : 1
		
		if(n==1) {
			result = dao.loungecancellikeCount(lglikedto.getFk_seq()); // --- #13-4.tbl_lounge_board 테이블에 likeCount 컬럼이 1 감소 (update)
			// System.out.println("~~~ 확인용 result : " + result);
			// ~~~ 확인용 result : 1
		}
		return result;
	}
	

	
}
