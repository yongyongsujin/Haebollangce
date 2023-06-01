package com.sist.haebollangce.common.mapper;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;
import com.sist.haebollangce.user.dto.UserDTO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InterMapper {

    int test_insert(String userid);

    int fromBoard2(String userid);

    String findById(String id);

    UserDTO getDetail(String userid);

    // === #2. 게시판 글쓰기 완료 요청 ===
	int loungeAdd(LoungeBoardDTO lgboarddto) throws Exception;

	// --- #3-1. 페이징 처리 안한 검색어 없는 전체 글 목록 보기 --- 
	List<LoungeBoardDTO> lgboardListNoSearch();

	// --- #4-1. 글 조회수 증가와 함께 글 1개를 조회 해주는 것 ---
	LoungeBoardDTO lggetView(Map<String, String> paraMap);
	
	// --- #4-1-1. 글 조회수 1 증가 ---
	void lgsetAddReadCount(String seq);

	// === #6. 라운지 글 수정 페이지 요청 완료 ===
	int lgedit(LoungeBoardDTO lgboarddto);

	// === #8. 라운지 글 삭제 페이지 요청 완료 ===
	int lgdel(Map<String, String> paraMap);
	
	List<ChallengeDTO> getJoinedChaList();
	// 참가중인 챌린지 리스트 가져오기
}
