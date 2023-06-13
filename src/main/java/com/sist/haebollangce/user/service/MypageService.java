package com.sist.haebollangce.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.sist.haebollangce.user.dao.InterMypageDAO;
import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.util.AES256;
import com.sist.haebollangce.common.GoogleMail;

@Service
public class MypageService implements InterMypageService {

	@Autowired // DAO
	private InterMypageDAO dao;
 
	@Autowired // 암호, 이메일 복호화
	private AES256 aes;
	
	@Autowired   // type 에 따라 알아서 Bean 을 주입해준다.
	private GoogleMail mail;
	
	// 결제하기
	@Override
	public int go_purchase(Map<String, String> paraMap) {

		int n = dao.go_purchase(paraMap);
		
		return n;
	}
	
	// 사용자가 보유하고 있는 예치금 알아오기
	@Override
	public JsonObject user_deposit(String userid) {
		
		// 유저가 보유하고 있는 예치금
		int user_deposit = dao.user_deposit(userid);
		
		// 유저가 챌린지에 사용한 모든 예치금
		int user_challenge_deposit = dao.user_challenge_deposit(userid);
		
		// 유저가 현재 보유하고 있는 총 예치금
		int user_all_deposit = user_deposit - user_challenge_deposit;
		
		// 유저가 보유한 상금
		int user_reward = dao.user_reward(userid);
		
		// 유저가 전환한 상금
		int user_convert = dao.user_convert(userid);
		
		// 유저가 현재 보유하고 있는 총 상금
		int user_all_reward = user_reward - user_convert;
		
		JsonObject jsonObj = new JsonObject();
		jsonObj.addProperty("user_deposit", user_deposit);
		jsonObj.addProperty("user_challenge_deposit", user_challenge_deposit);
		jsonObj.addProperty("user_all_deposit", user_all_deposit);
		
		jsonObj.addProperty("user_reward", user_reward);
		jsonObj.addProperty("user_convert", user_convert);
		jsonObj.addProperty("user_all_reward", user_all_reward);
		
		return jsonObj;
	}

	// 상금 전환 테이블에 전환된 내용 넣기
	@Override
	public int reward_convert(Map<String, String> paraMap) {

		int n = dao.reward_convert(paraMap);

		return n;
	}

	// 결제 현황 페이지에서 내역 알아오기
	@Override
	public String search_data(Map<String, String> paraMap) {

		List<Map<String, Object>> search_list = null;
		
		String sort = paraMap.get("sort");
		
		JsonArray jsonArr = new JsonArray();

		if ("1".equals(sort)) {

			search_list = dao.deposit_data(paraMap);  // 예치금 테이블에서 예치금 충전, 취소내역 알아오기
			
			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();
					
					jsonObj.addProperty("purchase_code", (int) map.get("purchase_code"));
					jsonObj.addProperty("purchase_date", (String) map.get("purchase_date"));
					jsonObj.addProperty("purchase_price", (int) map.get("purchase_price"));
					jsonObj.addProperty("purchase_status", (int) map.get("purchase_status"));
					
					jsonArr.add(jsonObj);
				}
			}
			
		} // end of if( sort == 1 ) -----

		else if("2".equals(sort)) {
			
			search_list = dao.challenge_during_deposit(paraMap);  // 챌린지 참여에 사용된 예치금 알아오기
			
			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();
					
					jsonObj.addProperty("entry_fee", (int) map.get("entry_fee"));
					jsonObj.addProperty("challenge_name", (String) map.get("challenge_name"));
					jsonObj.addProperty("startdate", (String) map.get("startdate"));
					
					jsonArr.add(jsonObj);
				}
			}
		} // end of else if("2".equals(sort))
		
		else if ("3".equals(sort)) {
			search_list = dao.reward_data(paraMap);

			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();

					jsonObj.addProperty("reward_date", (String) map.get("reward_date"));
					jsonObj.addProperty("reward", (int) map.get("reward"));
					jsonObj.addProperty("challenge_name", (String) map.get("challenge_name"));

					jsonArr.add(jsonObj);
				}
			}
		} // end of else if( sort == 3 ) {} -----
		
		else if ("4".equals(sort)) {
			search_list = dao.convert_reward_data(paraMap);

			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();

					jsonObj.addProperty("convert_date", (String) map.get("convert_date"));
					jsonObj.addProperty("convert_reward", (int) map.get("convert_reward"));

					jsonArr.add(jsonObj);
				}
			}
		} // end of else if( sort == 4 ) {} -----
		

		return new Gson().toJson(jsonArr);
	}

	
	// 결제 더보기 페이징 처리하기
	@Override
	public String search_paging_data(Map<String, String> paraMap) {
		List<Map<String, Object>> search_list = null;
		
		String sort = paraMap.get("sort");
		
		JsonArray jsonArr = new JsonArray();

		if ("1".equals(sort)) {

			search_list = dao.deposit_paging_data(paraMap);  // 예치금 테이블에서 예치금 충전, 취소내역 알아오기
			
			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();
					
					jsonObj.addProperty("purchase_code", (int) map.get("purchase_code"));
					jsonObj.addProperty("purchase_date", (String) map.get("purchase_date"));
					jsonObj.addProperty("purchase_price", (int) map.get("purchase_price"));
					jsonObj.addProperty("purchase_status", (int) map.get("purchase_status"));
					
					jsonArr.add(jsonObj);
				}
			}
			
		} // end of if( sort == 1 ) -----

		else if("2".equals(sort)) {
			
			search_list = dao.challenge_paging_data(paraMap);  // 챌린지 참여에 사용된 예치금 알아오기
			
			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();
					
					jsonObj.addProperty("entry_fee", (int) map.get("entry_fee"));
					jsonObj.addProperty("challenge_name", (String) map.get("challenge_name"));
					jsonObj.addProperty("startdate", (String) map.get("startdate"));
					
					jsonArr.add(jsonObj);
				}
			}
		} // end of else if("2".equals(sort))
		
		else if ("3".equals(sort)) {
			search_list = dao.reward_paging_data(paraMap);

			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();

					jsonObj.addProperty("reward_date", (String) map.get("reward_date"));
					jsonObj.addProperty("reward", (int) map.get("reward"));
					jsonObj.addProperty("challenge_name", (String) map.get("challenge_name"));

					jsonArr.add(jsonObj);
				}
			}
		} // end of else if( sort == 3 ) {} -----
		
		else if ("4".equals(sort)) {
			search_list = dao.convert_paging_data(paraMap);

			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JsonObject jsonObj = new JsonObject();

					jsonObj.addProperty("convert_date", (String) map.get("convert_date"));
					jsonObj.addProperty("convert_reward", (int) map.get("convert_reward"));

					jsonArr.add(jsonObj);
				}
			}
		} // end of else if( sort == 4 ) {} -----

		return new Gson().toJson(jsonArr);
	}
	@Override
	public String get_pagebar(Map<String, String> paraMap) {
		
		String sort = paraMap.get("sort");
		
		int total_page = 0;
		
		if("1".equals(sort)) {
			total_page = dao.get_pagebar_purcahse(paraMap);
		}
		
		else if("2".equals(sort)) {
			total_page = dao.get_pagebar_challenging(paraMap);
		}
		
		else if("3".equals(sort)) {
			total_page = dao.get_pagebar_reward(paraMap);
		}
		
		else if("4".equals(sort)) {
			total_page = dao.get_pagebar_convert(paraMap);
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total_page", total_page);
		
		return jsonObj.toString();
	}

	// 취소 가능 건 알아오기
	@Override
	public String cancel_data(Map<String, String> paraMap) {
		
		List<Map<String, Object>> search_list = null;
		
		String userid = paraMap.get("userid");
		
		search_list = dao.deposit_data(paraMap);  // 예치금 테이블에서 예치금 충전, 취소내역 알아오기
		
		// 유저가 보유하고 있는 예치금
		int user_deposit = dao.user_deposit(userid);
				
		// 유저가 챌린지에 사용한 모든 예치금
		int user_challenge_deposit = dao.user_challenge_deposit(userid);
		
		// 유저가 현재 보유하고 있는 총 예치금
		int user_all_deposit = user_deposit - user_challenge_deposit;
				
		JsonArray jsonArr = new JsonArray();
		
		if (search_list != null && search_list.size() > 0) {
			for (Map<String, Object> map : search_list) {

				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("purchase_code", (int) map.get("purchase_code"));
				jsonObj.addProperty("purchase_date", (String) map.get("purchase_date"));
				jsonObj.addProperty("purchase_price", (int) map.get("purchase_price"));
				jsonObj.addProperty("purchase_status", (int) map.get("purchase_status"));
				jsonObj.addProperty("user_all_deposit", user_all_deposit);
				
				jsonArr.add(jsonObj);
			}
			
		}
		
		return new Gson().toJson(jsonArr);
	}

	
	// 결제 취소하기
	@Override
	public String purchase_cancel(Map<String, String> paraMap) {
		
		int n = dao.purchase_cancel(paraMap);
		
		JsonObject jsonObj = new JsonObject();
		
		jsonObj.addProperty("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	@Override
	public UserDTO select_info(Map<String, String> paraMap) {

		UserDTO udto = dao.select_info(paraMap);

		return udto;
	}
	
	// 모든 관심태그 가지고오기
	@Override
	public String all_interest(String userid) {
		
		List<Map<String,String>> interest_list = dao.user_interest(userid);
		
		List<Map<String,String>> all_interest_list = dao.all_interest();
		
		// System.out.println("제거 전 : " + all_interest_list.toString());
		
		for (int i = all_interest_list.size() - 1; i >= 0; i--) {
		    Map<String, String> map_all = all_interest_list.get(i);
		    String all_category_code = map_all.get("category_code");

		    for (int j = 0; j < interest_list.size(); j++) {
		        Map<String, String> map_inter = interest_list.get(j);
		        String inter_fk_category_code = map_inter.get("fk_category_code");

		        if (inter_fk_category_code.equals(all_category_code)) {
		            all_interest_list.remove(i);
		            break; // 내부 반복문 종료 후 바깥쪽 반복문으로 이동
		        }
		    }
		}
		
		JsonArray jsonArr = new JsonArray();
		
		if(all_interest_list != null && all_interest_list.size() > 0) {
			for(Map<String,String> map : all_interest_list) {
				
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("category_code", map.get("category_code"));
				jsonObj.addProperty("category_name", map.get("category_name"));
				
				jsonArr.add(jsonObj);
				
			}
		}
		

		// System.out.println("제거 후 : " + all_interest_list.toString());
		
		JsonObject resultObj = new JsonObject();
		resultObj.add("all_interest_list", jsonArr);
		resultObj.add("interest_list", new Gson().toJsonTree(interest_list));
		
		
		return resultObj.toString();
	}
	
	// 관심태그 추가하기
	@Override
	public String plus_interest(Map<String, String> paraMap) {
		
		int n = dao.plus_interest(paraMap);

		JsonObject jsonObj = new JsonObject();

		jsonObj.addProperty("n", n);
		
		return new Gson().toJson(jsonObj);
		
	}
	
	// 관심태그 삭제하기
	@Override
	public String del_interest(Map<String, String> paraMap) {
		
		int n = dao.del_interest(paraMap);

		JsonObject jsonObj = null;

		jsonObj = new JsonObject();

		jsonObj.addProperty("n", n);
		
		return new Gson().toJson(jsonObj);
		
	}

	// 이메일 중복확인 하기
	@Override
	public String select_change_email(String change_email) {

		int n = dao.select_change_email(change_email);

		JSONObject jsonObj = null;

		jsonObj = new JSONObject();

		jsonObj.put("n", n);
		

		return jsonObj.toString();
	}

	
	// 사용자 정보 수정하기
	@Override
	public String mypage_info_edit(Map<String, Object> paraMap) {

		int n = dao.mypage_info_edit(paraMap);
		  
		// System.out.println("service n " + n);
		
		JSONObject jsonObj = null;
		
		jsonObj = new JSONObject();

		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}

	// 회원 탈퇴하기
	@Override
	public int delete_user(Map<String, String> paraMap) {
		
		int n = dao.delete_user(paraMap);
		
		return n;
	}

	// 찜한 챌린지 불러오기
	@Override
	public String like_challenge(String userid) {
		
		List<Map<String, Object>>  like_challenge_list = dao.select_like_challenge(userid);
		
		JsonArray jsonArr = new JsonArray();
		
		if(like_challenge_list != null && like_challenge_list.size() > 0) {
			
			for(Map<String, Object> map : like_challenge_list) {
				
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("thumbnail", (String) map.get("thumbnail"));
				jsonObj.addProperty("challenge_code", (int) map.get("challenge_code"));
				jsonObj.addProperty("challenge_name", (String) map.get("challenge_name"));
				jsonObj.addProperty("startdate", (String) map.get("startdate"));
				jsonObj.addProperty("enddate", (String) map.get("enddate"));
				
				jsonArr.add(jsonObj);
			}
			
		}
		
		return new Gson().toJson(jsonArr);
	}
	
	// 찜한 라운지 불러오기
	@Override
	public String like_lounge(String userid) {
		
		List<Map<String, Object>>  like_lounge_list = dao.select_like_lounge(userid);
		
		JsonArray jsonArr = new JsonArray();
		
		if(like_lounge_list != null && like_lounge_list.size() > 0) {
			
			for(Map<String, Object> map : like_lounge_list) {
				
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("seq", (String) map.get("seq"));
				jsonObj.addProperty("name", (String) map.get("name"));
				jsonObj.addProperty("subject", (String) map.get("subject"));
				jsonObj.addProperty("content", (String) map.get("content"));
				jsonObj.addProperty("likeCount", (String) map.get("likeCount"));
				jsonObj.addProperty("commentCount", (String) map.get("commentCount"));
				jsonObj.addProperty("readCount", (String) map.get("readCount"));
				jsonObj.addProperty("profile_pic", (String) map.get("profile_pic"));
				jsonObj.addProperty("filename", (String) map.get("filename"));
				
				jsonArr.add(jsonObj);
			}
			
		}
		
		return new Gson().toJson(jsonArr);
	}

	
	// 진행중인 챌린지 페이지 정보 가지고오기
	@Override
	public String mypage_challenging(Map<String, String> paraMap) {
		
		// 진행중인 챌린지 알아오기
		List<Map<String, String>> mypage_challenging_list = dao.mypage_challenging(paraMap); 
		
		JsonArray jsonArr = new JsonArray();
		
		if(mypage_challenging_list != null && mypage_challenging_list.size() > 0) {
			
			for(Map<String, String> map : mypage_challenging_list ) {
				
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("fk_challenge_code", map.get("fk_challenge_code"));
				jsonObj.addProperty("thumbnail", map.get("thumbnail"));
				jsonObj.addProperty("challenge_name", map.get("challenge_name"));
				jsonObj.addProperty("set_date", map.get("set_date"));
				jsonObj.addProperty("startdate", map.get("startdate"));
				jsonObj.addProperty("fk_userid", map.get("fk_userid"));
				jsonObj.addProperty("achievement_pct", map.get("achievement_pct"));
				jsonObj.addProperty("hour_start", map.get("hour_start"));
				jsonObj.addProperty("hour_end", map.get("hour_end"));
				jsonObj.addProperty("finish_day", map.get("finish_day"));
				jsonObj.addProperty("freq_type", map.get("freq_type"));
				jsonObj.addProperty("frequency", map.get("frequency"));
				
				jsonArr.add(jsonObj);
				
			}
			
		}
		
		return new Gson().toJson(jsonArr);
	}
	
	// 챌린지 추천하기
	@Override
	public String recommend(String userid) {
		
		List<Map<String, String>> recommend_list = dao.recommend(userid);
		
		JsonArray jsonArr = new JsonArray();
		
		
		if(recommend_list != null && recommend_list.size() > 0) {
			for(Map<String,String> map : recommend_list) {
				
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("thumbnail", map.get("thumbnail"));
				jsonObj.addProperty("challenge_name", map.get("challenge_name"));
				jsonObj.addProperty("regDate", map.get("regDate"));
				jsonObj.addProperty("startdate", map.get("startdate"));
				jsonObj.addProperty("member_count", map.get("member_count"));
				jsonObj.addProperty("fk_userid", map.get("fk_userid"));
				
				jsonArr.add(jsonObj);
				
			}
		}
		
		return new Gson().toJson(jsonArr);
	}

	// 진행중인 챌린지 페이지에서 그래프 그리기
	@Override
	public String graph_challenge_during(String userid) {

		List<Map<String, Object>> search_list = null;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("sort", "0");
		
		JsonArray jsonArr = new JsonArray();
		
		search_list = dao.challenge_during_deposit(paraMap);  // 챌린지 참여에 사용된 예치금 알아오기
		
		if (search_list != null && search_list.size() > 0) {
			for (Map<String, Object> map : search_list) {

				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("category_name", (String) map.get("category_name"));
				jsonObj.addProperty("fk_category_code", (String) map.get("fk_category_code"));
				
				jsonArr.add(jsonObj);
			}
		}
		
		return new Gson().toJson(jsonArr);
	}

	// 마이페이지 홈화면 사용자 정보 불러오기
	@Override
	public String user_information(String userid) {
		
		List<Map<String, String>> information_list = dao.user_information(userid);
		
		JsonArray jsonArr = new JsonArray();
		
		JsonObject jsonObj = new JsonObject();
		
		if(information_list != null && information_list.size() > 0) {
			
			for(Map<String, String> map:information_list) {
				
				jsonObj.addProperty("userid", (String) map.get("userid"));
				jsonObj.addProperty("name", (String) map.get("name"));
				jsonObj.addProperty("fk_level", (String) map.get("fk_level"));
				jsonObj.addProperty("exp", (String) map.get("exp"));
				jsonObj.addProperty("profile_pic", (String) map.get("profile_pic"));
				
			}
			
		}
		
		// 유저가 보유하고 있는 예치금
		int user_deposit = dao.user_deposit(userid);
		
		// 유저가 챌린지에 사용한 모든 예치금
		int user_challenge_deposit = dao.user_challenge_deposit(userid);
		
		// 유저가 현재 보유하고 있는 총 예치금
		int user_all_deposit = user_deposit - user_challenge_deposit;
		
		// 유저가 보유한 상금
		int user_reward = dao.user_reward(userid);
		
		// 유저가 전환한 상금
		int user_convert = dao.user_convert(userid);
		
		// 유저가 현재 보유하고 있는 총 상금
		int user_all_reward = user_reward - user_convert;
		
		
		jsonObj.addProperty("user_all_deposit", user_all_deposit);
		
		jsonObj.addProperty("user_all_reward", user_all_reward);
				
		jsonArr.add(jsonObj);
		
		return new Gson().toJson(jsonArr);
	}

	// 마이페이지 홈에서 인증 필요한 챌린지 불러오기
	@Override
	public String mypage_certify_challenging(Map<String, String> paraMap) {
		
			// 진행중인 챌린지 알아오기
			List<Map<String, String>> mypage_challenging_list = dao.mypage_challenging(paraMap); 
			
			// 진행중인 챌린지 중 오늘 하루 인증했는지 여부, 인증한 챌린지들 번호가 반환된다.
			List<Map<String, String>> certify_list = dao.mypage_certify_challenge(paraMap);
			
			// 인증한 챌린지 번호는 mypage_challenging_list에서 삭제해준다.
			for(int i=0; i<mypage_challenging_list.size(); i++) {
				
				for(int j=0; j<certify_list.size(); j++) {
					
					Map<String, String> map_cha = mypage_challenging_list.get(i);
					
					String cha_challenge_code = map_cha.get("fk_challenge_code");
					
					Map<String, String> map_cer = certify_list.get(j);
					
					String cer_challenge_code = map_cer.get("fk_challenge_code");
					
					if(cha_challenge_code.equals(cer_challenge_code)) {
						
						// System.out.println("cha_challenge_code " + cha_challenge_code);
						
						// System.out.println("cer_challenge_code " + cer_challenge_code);
						
						mypage_challenging_list.remove(i);
						
					}
					
				}
				
			}
			
			// System.out.println("제거 후 : " + mypage_challenging_list.toString());
			
			JsonArray jsonArr = new JsonArray();
			
			if(mypage_challenging_list != null && mypage_challenging_list.size() > 0) {
				
				for(Map<String, String> map : mypage_challenging_list ) {
					
					JsonObject jsonObj = new JsonObject();
					
					jsonObj.addProperty("fk_challenge_code", map.get("fk_challenge_code"));
					jsonObj.addProperty("thumbnail", map.get("thumbnail"));
					jsonObj.addProperty("challenge_name", map.get("challenge_name"));
					jsonObj.addProperty("set_date", map.get("set_date"));
					jsonObj.addProperty("startdate", map.get("startdate"));
					jsonObj.addProperty("fk_userid", map.get("fk_userid"));
					jsonObj.addProperty("hour_start", map.get("hour_start"));
					jsonObj.addProperty("hour_end", map.get("hour_end"));
					jsonObj.addProperty("finish_day", map.get("finish_day"));
					jsonObj.addProperty("freq_type", map.get("freq_type"));
					jsonObj.addProperty("frequency", map.get("frequency"));
					
					jsonArr.add(jsonObj);
					
				}
				
			}
			
			/*
			JsonObject resultObj = new JsonObject();
			resultObj.add("mypage_challenging", jsonArr);
			resultObj.add("certify_list", new Gson().toJsonTree(certify_list));
			*/
			
			return new Gson().toJson(jsonArr);
	}

	// 마이페이지 100% 인증한 챌린지 갯수 불러오기
	@Override
	public String finish_100_count(Map<String, String> paraMap) {
		
		int all_n = dao.finish_count(paraMap);  // 완료한 챌린지
		// 챌린지 갯수만 세는 것이므로 빠르게 계산하기 위해 전에 있던 완료된 챌린지를 쓰지 않고 실행한다.
		
		int n = dao.finish_100_count(paraMap); // 100% 완료한 챌린지
		
		int result = 0;
		
		if(all_n != 0) {
			result = (n/all_n) * 100;
		}
		
		// System.out.println(result);
	
		JsonObject jsonObj = new JsonObject();
		
		jsonObj.addProperty("result", result);
		
		return jsonObj.toString();
	}

	// 마이페이지 홈 챌린지 그래프-챌린지 참여 횟수
	@Override
	public String chart_challenging(Map<String, String> paraMap) {
		
		List<Map<String, String>> chart_challenging_list = dao.chart_challenging(paraMap);
		
		// System.out.println("chart_challenging_list " + chart_challenging_list.toString());
		
		JsonArray jsonArr = new JsonArray();
		
		if(chart_challenging_list != null && chart_challenging_list.size() > 0) {
			
			for(Map<String, String> map : chart_challenging_list) {
				
				JsonObject jsonObj = new JsonObject();
				
				jsonObj.addProperty("month", map.get("month"));
				jsonObj.addProperty("count", map.get("count"));
				
				jsonArr.add(jsonObj);
				
			}
			
		}
		
		return new Gson().toJson(jsonArr);
	}
	@Override
	public String chart_category(Map<String, String> paraMap) {

		List<Map<String, String>> category_list = dao.chart_category(paraMap);
		
		// System.out.println("servicee userid : " + paraMap.get("userid"));
		// System.out.println("servicee userid : " + paraMap.get("month"));
		
		// System.out.println("category_list " + category_list.toString());
	
		JsonArray jsonArr = new JsonArray();
		
		for(Map<String, String> map : category_list) {
			
			JsonObject jsonObj = new JsonObject();
			
			jsonObj.addProperty("category_name", map.get("category_name"));
			jsonObj.addProperty("percentage", map.get("percentage"));
			
			jsonArr.add(jsonObj);
		}
		
		return new Gson().toJson(jsonArr);
	}


}
