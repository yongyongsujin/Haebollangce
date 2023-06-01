package com.sist.haebollangce.lounge.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.haebollangce.lounge.model.InterLoungeDAO;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;

@Service
public class LoungeService implements InterLoungeService {

	// === 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired
	private InterLoungeDAO  dao;

	// === #2. 게시판 글쓰기 완료 요청 ===
	@Override
	public int loungeAdd(LoungeBoardDTO lgboarddto) throws Exception {
		int n = dao.loungeAdd(lgboarddto);
		return n;
	}

	// --- #3-1. 페이징 처리 안한 검색어 없는 전체 글 목록 보기 ---
	@Override
	public List<LoungeBoardDTO> lgboardListNoSearch() {
		List<LoungeBoardDTO> lgboardList = dao.lgboardListNoSearch();
		return lgboardList;
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

	// === #8. 라운지 글 삭제 페이지 요청 완료 ===
	@Override
	public int lgdel(Map<String, String> paraMap) {
		int n = dao.lgdel(paraMap);
		return n;
	}
	
}
