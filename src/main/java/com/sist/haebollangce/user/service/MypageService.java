package com.sist.haebollangce.user.service;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.user.dao.InterMypageDAO;
import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.util.AES256;

@Service
public class MypageService implements InterMypageService {

	@Autowired // DAO
	private InterMypageDAO dao;
 
	@Autowired // 암호, 이메일 복호화
	private AES256 aes;
	 
	@Autowired // 파일 업로드
	private FileManager fileManager;
 
	// 결제하기
	@Override
	public int go_purchase(Map<String, String> paraMap) {

		int n = dao.go_purchase(paraMap);

		return n;
	}

	// 결제한 예치금을 보유예치금에 추가하기
	@Override
	public int plus_deposit(Map<String, String> paraMap) {

		int plus = dao.plus_deposit(paraMap);

		return plus;
	}

	// 전환한 상금 감소시키기
	@Override
	public int reward_minus(Map<String, String> paraMap) {

		int n = dao.reward_minus(paraMap);

		return n;
	}

	// 상금 전환 테이블에 전환된 내용 넣기
	@Override
	public int reward_convert(Map<String, String> paraMap) {

		int n = dao.reward_convert(paraMap);

		return n;
	}

	// 결제 현황 페이지에서 내역 알아오기
	@Override
	public String search_data(Map<String, Object> paraMap) {

		List<Map<String, Object>> search_list = null;

		int sort = Integer.parseInt(((String) paraMap.get("sort")));

		JSONArray jsonArr = new JSONArray();

		if (sort == 2) {

			search_list = dao.search_data(paraMap);

			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JSONObject jsonObj = new JSONObject();

					jsonObj.put("purchase_date", map.get("purchase_date"));
					jsonObj.put("purchase_price", map.get("purchase_price"));
					jsonObj.put("purchase_status", map.get("purchase_status"));
					jsonObj.put("deposit", map.get("deposit"));

					jsonArr.put(jsonObj);
				}
			}

		} // end of if( sort == 2 ) -----

		else if (sort == 5) {
			search_list = dao.search_reward(paraMap);

			if (search_list != null && search_list.size() > 0) {
				for (Map<String, Object> map : search_list) {

					JSONObject jsonObj = new JSONObject();

					jsonObj.put("reward_date", map.get("reward_date"));
					jsonObj.put("reward", map.get("reward"));
					jsonObj.put("challenge_name", map.get("challenge_name"));
					jsonObj.put("reward_balance", map.get("reward_balance"));
					jsonObj.put("convert_reward", map.get("convert_reward"));

					jsonArr.put(jsonObj);
				}
			}

		} // end of else if( sort == 5 ) {} -----

		return jsonArr.toString();
	}

	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	@Override
	public UserDTO select_info(Map<String, String> paraMap) {

		UserDTO udto = dao.select_info(paraMap);

		return udto;
	}

	// 이메일 중복확인 하기
	@Override
	public String select_change_email(String change_email) {

		int n = dao.select_change_email(change_email);

		JSONObject jsonObj = null;

		if (n == 1) {
			jsonObj = new JSONObject();

			jsonObj.put("n", n);
		} else {
			jsonObj = new JSONObject();

			jsonObj.put("n", n);
		}

		return jsonObj.toString();
	}

	
	// 사용자 정보 수정하기
	@Override
	public String mypage_info_edit(Map<String, Object> paraMap) {

		int n = dao.mypage_info_edit(paraMap);
		  
		// System.out.println("service n " + n);
		
		JSONObject jsonObj = null;
		
		if (n == 1) {
			jsonObj = new JSONObject();

			jsonObj.put("n", n);
		} else {
			jsonObj = new JSONObject();

			jsonObj.put("n", n);
		}
		
		return jsonObj.toString();
	}
	/*
	 * @Override public String profile_upload_ajax(UserDTO udto,
	 * MultipartHttpServletRequest mrequest, MultipartFile profile_pic_file) {
	 * 
	 * JSONObject jsonObj = null;
	 * 
	 * int n = 0;
	 * 
	 * MultipartFile attach = udto.getAttach();
	 * 
	 * if( !attach.isEmpty()) {
	 * 
	 * HttpSession session = mrequest.getSession(); String root =
	 * session.getServletContext().getRealPath("/");
	 * 
	 * String path = root + "resourse" + File.separator + "static" + File.separator
	 * + "images";
	 * 
	 * System.out.println(path);
	 * 
	 * File dir = new File(path); if(!dir.exists()) { dir.mkdirs(); }
	 * 
	 * String newFileName = "";
	 * 
	 * byte[] bytes = null; // 첨부파일의 내용물을 담는 것
	 * 
	 * long fileSize = 0; // 첨부파일의 크기
	 * 
	 * try { bytes = attach.getBytes(); // 첨부파일의 내용물을 읽어오는 것
	 * 
	 * String originalFilename = attach.getOriginalFilename();
	 * 
	 * newFileName = fileManager.doFileUpload(bytes, originalFilename, path); // 파일
	 * 업로드
	 * 
	 * System.out.println(">>> 확인용 newFileName => " + newFileName);
	 * 
	 * udto.setFileName(newFileName);
	 * 
	 * udto.setOrgFilename(originalFilename); // 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때
	 * 사용. // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
	 * 
	 * fileSize = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
	 * udto.setFileSize(String.valueOf(fileSize));
	 * 
	 * n = 1;
	 * 
	 * jsonObj.put("n", n); } catch (Exception e) { e.printStackTrace(); n = 0;
	 * 
	 * jsonObj.put("n", n); }
	 * 
	 * }
	 * 
	 * return jsonObj.toString(); }
	 */

}
