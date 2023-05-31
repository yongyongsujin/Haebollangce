package com.sist.haebollangce.lounge.model;

import java.util.List;

public interface InterLoungeDAO {

	// === #2. 게시판 글쓰기 완료 요청 ===
	int loungeAdd(LoungeBoardDTO lgboardvo) throws Exception ;

	// --- #3-1. 페이징 처리 안한 검색어 없는 전체 글 목록 보기 ---
	List<LoungeBoardDTO> lgboardListNoSearch();

}
