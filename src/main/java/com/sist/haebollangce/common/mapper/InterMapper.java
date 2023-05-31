package com.sist.haebollangce.common.mapper;

import com.sist.haebollangce.lounge.model.LoungeBoardDTO;
import com.sist.haebollangce.user.dto.UserDTO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InterMapper {

    int test_insert(String userid);

    int fromBoard2(String userid);

    String findById(String id);

    UserDTO getDetail(String userid);

    // === #2. 게시판 글쓰기 완료 요청 ===
	int loungeAdd(LoungeBoardDTO lgboardvo) throws Exception;

	// --- #3-1. 페이징 처리 안한 검색어 없는 전체 글 목록 보기 --- 
	List<LoungeBoardDTO> lgboardListNoSearch();
}
