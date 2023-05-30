package com.sist.haebollangce.lounge.model;

import java.util.List;

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
	public int loungeAdd(LoungeBoardVO lgboardvo) {
		
//      int n = sqlsession.insert("user.test_insert",userid);
//      int n = mapper.test_insert(userid);
		int n = mapper.loungeAdd(lgboardvo);
		return n;
	}

	// --- #3-1. 페이징 처리 안한 검색어 없는 전체 글 목록 보기 ---
	@Override
	public List<LoungeBoardVO> lgboardListNoSearch() {
		List<LoungeBoardVO> lgboardList = mapper.lgboardListNoSearch();
		return lgboardList;
	}
	
}
