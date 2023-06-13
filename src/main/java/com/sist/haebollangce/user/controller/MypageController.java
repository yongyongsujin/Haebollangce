package com.sist.haebollangce.user.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.service.InterMypageService;

import com.sist.haebollangce.common.GoogleMail;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
@RequestMapping("mypage")
public class MypageController {

	@Autowired
	private InterMypageService service;

	@Autowired   // 메일 보내기
	private GoogleMail mail;
	
	@Autowired // 파일 업로드
	private FileManager fileManager;
	
	@GetMapping(value = "/purchaseMail")
	public ModelAndView purchaseMail(ModelAndView mav) {
		// 임시 홈화면
		mav.setViewName("mypage/purchaseMail.tiles5");

		return mav;
	}
	
	@PostMapping(value = "/mypageHome")
	public String mypageHome(HttpServletRequest request) {

		String userid = request.getParameter("userid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		
		UserDTO udto = service.select_info(paraMap);
		
		request.setAttribute("udto", udto);
		
		return "mypage/mypageHome.tiles5";
	}

	
	/* 결제 페이지로 가기 시작 */
	@GetMapping(value = "/depositPurchase")
	public ModelAndView depositPurchase(ModelAndView mav) {

		mav.setViewName("mypage/depositPurchase.tiles5");

		return mav;
	}
	/* 결제 페이지로 가기 끝 */

	
	/* 결제하기 시작 */
	@PostMapping(value = "/purchase_success")
	public ModelAndView purchase_success(ModelAndView mav, HttpServletRequest request) {

		String userid = request.getParameter("userid");
		String deposit = request.getParameter("deposit");

		// System.out.println(userid);
		// System.out.println(deposit);

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("deposit", deposit);

		// 예치금 결제하기
		int n = service.go_purchase(paraMap);

		if (n == 1) {
			mav.setViewName("mypage/mypageHome.tiles5");
		}

		return mav;
	}
	/* 결제하기 끝 */

	
	/* 결제 후 문자보내기 시작 */
	@ResponseBody
	@RequestMapping(value = "/sms_ajax", method = { RequestMethod.POST }, produces = "text/plain;charset=UTF-8") // 오로지
	public ModelAndView sms_ajax(ModelAndView mav, HttpServletRequest request) {

		String api_key = ""; // 자기꺼 넣기

		// String api_secret = "발급받은 본인의 API Secret"; // 발급받은 본인 API Secret
		String api_secret = ""; // 자기꺼 넣기

		Message coolsms = new Message(api_key, api_secret);

		String mobile = request.getParameter("mobile");
		String smsContent = request.getParameter("smsContent");

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("to", mobile); // 수신번호
		paraMap.put("from", ""); // 발신번호
		paraMap.put("type", "SMS"); // SMS(단문), LMS(장문), MMS, AT
		paraMap.put("text", smsContent); // 문자내용
		paraMap.put("app_version", "JAVA SDK v2.2"); // application name and version
		paraMap.put("mode", "test");

		JSONObject jsonObj;

		try {
			jsonObj = (JSONObject) coolsms.send(paraMap);

			String json = jsonObj.toString();

			mav.addObject("json", json);
		} catch (CoolsmsException e) {
			e.printStackTrace();
		}

		return mav;

	}
	/* 결제 후 문자보내기 끝 */

	
	/* 결제 후 메일보내기 시작 */
	@ResponseBody
	@RequestMapping(value = "/email_ajax", method = { RequestMethod.POST }, produces = "text/plain;charset=UTF-8") // 오로지
	public ModelAndView email_ajax(ModelAndView mav, HttpServletRequest request) {

		String userid = request.getParameter("userid");
		
		String recipient = request.getParameter("email");
		
		String deposit = request.getParameter("deposit");
		
		String merchant = request.getParameter("merchant");
		
		String subject = "[해볼랑스] " + userid + "님의 결제내역을 보내드립니다.";
		
		JsonObject jsonObj = service.user_deposit(userid);  // 보유중인 예치금 알아오기
		
		String user_all_deposit = jsonObj.get("user_all_deposit").toString();
		
		LocalDate now = LocalDate.now();
		
		String emailContent = "<div style='padding:25px;width:35%;border:5px dashed #aaaaaa;'>"
					   + "	<h1 style='font-family: 'Pretendard-Regular';'>Haebollangce</h1>"
					   + "		<div style='margin-top:50px;'>"
					   + "			모두 함께 도전하는 즐거움! 해볼랑스 입니다."
					   + "		</div>"
					   + "		<div style='margin:20px 0;'>"
					   + "			'" + userid + "' 님의 예치금 결제 내역을 보내드립니다."
					   + "		</div>"
					   + "		<div style='border: 1px solid black;'>"
					   + "			<div style='padding: 20px 30px;'>결제 일시<span style='float:right;'>" + now + "</span></div>" 
					   + "			<div style='padding: 20px 30px;border-top: 1px solid #aaaaaa;border-bottom: 1px solid #aaaaaa;'>주문번호<span style='float:right;'>" + merchant + "</span></div>"
					   + "			<div style='padding: 20px 30px;border-bottom: 1px solid #aaaaaa;'>보유한 예치금<span style='float:right;'>" + user_all_deposit + "</span></div>" 
					   + "			<div style='padding: 20px 30px;'>결제한 금액 및 충전된 예치금<span style='color:red; font-weight:bold; float:right;'>" + deposit + "</span></div>"
					   + "		</div>" 
					   + "		<div style='margin-top: 34px;background-color: #f2f2f2;height: 120px;padding: 38px 30px;'>" 
					   + "			<div>본 메일은 발신전용 메일 이므로 회신이 불가합니다.</div>" 
					   + "			<div>결제하지 않은 사항이거나 문의사항이 있으실 경우 <a href=''>고객센터</a>로 문의바랍니다.</div>" 
					   + "		</div>" 
					   + "	</div>";
		
		Map<String, Object> paraMap = new HashMap<>();
		
		jsonObj = new JsonObject();
		
		try {
			
			mail.sendmail_OrderFinish(recipient, subject, emailContent);
			jsonObj.addProperty("result", "1");
			
		} catch (Exception e) {
			
			e.printStackTrace();
			jsonObj.addProperty("result", "0");
			
		}
		
		String json = jsonObj.toString();
		
		mav.addObject("json", json);
		
		return mav;

	}
	/* 결제 후 메일보내기 끝  */
	
	
	/* 상금 전환 페이지 이동 시작 */
	@GetMapping(value = "/change_reward")
	public String change_reward() {

		return "mypage/changeReward.tiles5";
	}
	/* 상금 전환 페이지 이동 끝 */

	
	/* 상금 전환 요청하기 시작 */
	@PostMapping(value = "/reward_convert")
	public ModelAndView reward_convert(ModelAndView mav, HttpServletRequest request) {

		String userid = request.getParameter("userid");
		String reward = request.getParameter("reward");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("reward", reward);

		int n = service.reward_convert(paraMap); // 상금 테이블에 전환된 내용 넣기

		String message = "";

		String loc = "";

		if (n == 1) {
			message = "상금전환이 성공했습니다.\\n영업일 기준 7일 이내 입금될 예정입니다.";
			loc = "mypageHome";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		} else {
			message = "상금전환이 실패했습니다.\\n고객센터에 문의바랍니다.";
			loc = "javascript:history.back()";

			mav.addObject("message", message);
			mav.addObject("loc", loc);

			mav.setViewName("msg");
		}

		return mav;
	}
	/* 상금 전환 요청하기 끝 */

	
	/* 결제 현황 페이지 가기 시작 */
	@GetMapping(value = "/mypageUsing")
	public String mypageDepositUsing(HttpServletRequest request) {
		// request.setAttribute("userid", );
		return "mypage/mypageUsing.tiles5";
	}
	/* 결제 현황 페이지 가기 끝 */

	
	/* 사용자의 보유 예치금 알아오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/user_deposit_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String user_deposit_ajax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		JsonObject jsonObj = service.user_deposit(userid);  // 보유중인 예치금 알아오기
		
		return jsonObj.toString();
	}
	
	/* 사용자의 보유 예치금 알아오기 끝 */
	
	
	/* 예치금 그래프 보여주기 시작 */
	@ResponseBody
	@RequestMapping(value = "/deposit_chart_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String deposit_chart_ajax(HttpServletRequest request) {

		String userid = request.getParameter("userid");
		/*
		System.out.println(userid); 
		*/
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);

		String json = service.deposit_chart(paraMap);

		return json;
	}
	/* 예치금 그래프 보여주기 끝 */
	
	
	/* 취소가능한 결제건 알아오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/cancel_data_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String cancel_data_ajax(HttpServletRequest request, HttpServletResponse response) {

		String userid = request.getParameter("userid");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String sort = request.getParameter("sort");
		/*
		System.out.println(userid); 
		System.out.println(start);
		System.out.println(end);
		*/
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("start", start);
		paraMap.put("end", end);
		paraMap.put("sort", sort);

		String json = service.cancel_data(paraMap);

		return json;
	}
	/* 취소가능한 결제건 알아오기 끝 */
	
	/* 결제 취소하기 시작 */
	@ResponseBody
	@RequestMapping(value = "/purchase_cancel_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String purchase_cancel_ajax(HttpServletRequest request) {

		String userid = request.getParameter("userid");
		String purchase_code = request.getParameter("purchase_code");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("purchase_code", purchase_code);

		String json = service.purchase_cancel(paraMap);

		return json;
	}
	/* 결제 취소하기 끝 */
	
	/* 결제 현황 페이지에서 내역 알아오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/search_data_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String search_data(HttpServletRequest request, HttpServletResponse response) {

		String userid = request.getParameter("userid");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String sort = request.getParameter("sort");
		
		/*
	 	System.out.println(userid); 
	 	System.out.println(start);
		System.out.println(end);
		System.out.println(sort);
		*/
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("start", start);
		paraMap.put("end", end);
		paraMap.put("sort", sort);

		String json = service.search_data(paraMap);

		return json;
	}
	/* 결제 현황 페이지에서 내역 알아오기 끝 */

	/* 결제 더보기 가기 시작 */
	@PostMapping(value="/mypageDetailUsing")
	public String mypageDetailUsing(HttpServletRequest request) {
		
		String sort = request.getParameter("sort");
		
		String userid = request.getParameter("userid");
		
		request.setAttribute("sort", sort);
		request.setAttribute("userid", userid);
		
		return "mypage/mypageDetailUsing.tiles5";
	}
	/* 결제 더보기 가기 끝*/
	
	
	/* 결제 더보기 페이징 처리하기 시작 */
	@ResponseBody
	@RequestMapping(value = "/search_paging_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String search_paging_ajax(HttpServletRequest request) {

		String userid = request.getParameter("userid");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String sort = request.getParameter("sort");
		String current_pageno = request.getParameter("current_pageno");
		
		if(current_pageno == null) {
			current_pageno = "1";
		}
		
		/*
		 * System.out.println("userid " + userid); System.out.println("start " + start);
		 * System.out.println("end " + end); System.out.println("sort " + sort);
		 * System.out.println("current_pageno " + current_pageno);
		 */
		
		int page_size = 10;
		
		int start_rno = (( Integer.parseInt(current_pageno) - 1) * page_size) + 1;
	    int end_rno = start_rno + page_size - 1;
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("start", start);
		paraMap.put("end", end);
		paraMap.put("sort", sort);
		paraMap.put("start_rno", String.valueOf(start_rno) );
		paraMap.put("end_rno", String.valueOf(end_rno) );

		String json = service.search_paging_data(paraMap);

		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/get_pagebar_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String get_pagebar_ajax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String page_size = request.getParameter("page_size");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String sort = request.getParameter("sort");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("page_size", page_size);
		paraMap.put("start", start);
		paraMap.put("end", end);
		paraMap.put("sort", sort);
		
		// totalPage 알아오기
		String total_page = service.get_pagebar(paraMap);
		
		return total_page;
	}
	/* 결제 더보기 페이징 처리하기 끝 */
	
	
	/* 회원 정보수정 및 회원탈퇴 들어가기 전 비밀번호 확인 가기 시작 */
	@PostMapping(value = "/mypagePwdIdentify")
	public String mypagePwdIdentify(HttpServletRequest request) {

		String result = request.getParameter("result");
		
		request.setAttribute("result", result);
		
		return "mypage/mypagePwdIdentify.tiles5";
	}
	/* 회원 정보수정 및 회원탈퇴 들어가기 전 비밀번호 확인 가기 끝 */

	
	/* 비밀번호 확인 후 회원 정보수정 페이지 가기 시작 */
	@PostMapping(value = "/mypageInfoEdit")
	public String mypageInfoEdit(HttpServletRequest request) {

		String result = request.getParameter("result");
		
		String userid = request.getParameter("userid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		
		if("0".equals(result)) {
			// 회원정보 수정하기 페이지 가기
			UserDTO udto = service.select_info(paraMap);
	
			String hp1 = udto.getMobile().substring(3, 7);
	
			String hp2 = udto.getMobile().substring(7);
			
			request.setAttribute("udto", udto);
	
			request.setAttribute("hp1", hp1);
	
			request.setAttribute("hp2", hp2);
	
			return "mypage/mypageInfoEdit.tiles5";
		}
		else {
			// 회원탈퇴하기
			int n = service.delete_user(paraMap);
			
			if(n==1) {
				request.setAttribute("message", "회원탈퇴에 성공했습니다.\\n지금까지 이용해주셔서 감사합니다.");
				request.setAttribute("loc", "mypageHome");
			}
			else {
				request.setAttribute("message", "회원탈퇴에 실패했습니다.\\n고객센터에 문의해주세요.");
				request.setAttribute("loc", "mypageHome");
			}
			
			return "msg";
		}
	}
	/* 비밀번호 확인 후 회원 정보수정 페이지 가기 끝 */
	
	
	/* 모든 관심태그 가지고오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/all_interest_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String all_interest_ajax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		String json = service.all_interest(userid);
		
		return json;
		
	}
	/* 모든 관심태그 가지고오기 끝 */
	
	
	/* 관심태그 추가하기 시작 */
	@ResponseBody
	@RequestMapping(value = "/plus_interest_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String plus_interest_ajax(HttpServletRequest request) {
		
		String userid= request.getParameter("userid");
		String category_code = request.getParameter("category_code");
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("category_code", category_code);
		
		String json = service.plus_interest(paraMap);

		return json;
	}
	/* 관심태그 추가하기 끝 */
	
	
	/* 관심태그 삭제하기 시작 */
	@ResponseBody
	@RequestMapping(value = "/del_interest_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String del_interest_ajax(HttpServletRequest request) {
		
		String userid= request.getParameter("userid");
		String category_code = request.getParameter("category_code");
		
		// System.out.println(userid);
		// System.out.println(category_code);
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("category_code", category_code);
		
		String json = service.del_interest(paraMap);

		return json;
	}
	/* 관심태그 삭제하기 끝 */
	
	
	/* 이메일 중복확인 시작 */
	@ResponseBody
	@RequestMapping(value = "/email_change_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String email_change_ajax(HttpServletRequest request) {

		String change_email = request.getParameter("change_email");

		String json = service.select_change_email(change_email);

		return json;
	}
	/* 이메일 중복확인 끝 */

	
	/* 회원정보 수정하기 시작 */
	@ResponseBody
	@RequestMapping(value = "/mypage_info_edit_ajax", method = {RequestMethod.POST}, produces = "text/plain;charset=UTF-8")
	public String mypage_info_edit(MultipartFile uploadFile, MultipartHttpServletRequest mtp_request){
		
		String userid = mtp_request.getParameter("userid");
		String pw = mtp_request.getParameter("pw");
		String mobile = mtp_request.getParameter("mobile");
		String email = mtp_request.getParameter("email");
		String acct = mtp_request.getParameter("acct");
		String originalFilename = mtp_request.getParameter("profilePic");
		
		HttpSession session = mtp_request.getSession();
		String root = session.getServletContext().getRealPath("/").substring(0, 40);  
		// 메타데이터 폴더 경로입니다. 경로를 수정할 경우 밑에 root 를 출력한 후 substring 조절하기.
		//System.out.println(root);
		
		String path = root + "resources" + File.separator + "static" + File.separator + "images";
		// System.out.println(path);
		
		/*
			System.out.println("~~~~ 확인용 path => " + path);
			
			System.out.println(userid);
			System.out.println(pw);
			System.out.println(mobile);
			System.out.println(email);
			System.out.println(acct);
			System.out.println(originalFilename);
		*/
		File dir = new File(path);
		
		if(!dir.exists()) {
			// 경로가 존재하지 않는다면 경로(폴더)를 만들어라
			dir.mkdir();
		}
		
		String newFileName = "";
		
		try {
			MultipartFile mtfile = mtp_request.getFile("profile_pic_file");
		
			// System.out.println(mtfile);
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
			
			long fileSize = 0;
			// 첨부파일의 크기
			
			// 첨부파일의 내용물을 읽어오는 것
			bytes = mtfile.getBytes();
			
			originalFilename = mtfile.getOriginalFilename();
			
			// System.out.println("originalFilename : " + originalFilename);
			
			newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
			
			// System.out.println("newFileName : " + newFileName);
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pw", pw);
		paraMap.put("mobile", mobile);
		paraMap.put("email", email);
		paraMap.put("acct", acct);
		paraMap.put("profilePic", newFileName);
		
		String json = service.mypage_info_edit(paraMap);
		
		// System.out.println(json);
		
		return json;
	}
	/* 회원정보 수정하기 끝 */
	
	
	/* 진행중인 챌린지 페이지로 가기 시작 */
	@GetMapping(value = "/mypageChallenging")
	public String mypageChallenging(HttpServletRequest request) {

		return "mypage/mypageChallenging.tiles5";
	}
	/* 진행중인 챌린지 페이지로 가기 끝 */
	
	
	/* 진행중인 챌린지 정보 가져오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/mypage_challenging_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String mypage_challenging_ajax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		String fk_category_code = request.getParameter("fk_category_code");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("fk_category_code", fk_category_code);
		
		String json = service.mypage_challenging(paraMap);

		return json;
	}
	/* 진행중인 챌린지 정보 가져오기 끝 */
	
	
	/* 챌린지 추천하기 시작 */
	@ResponseBody
	@RequestMapping(value = "/mypage_recommend_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String mypage_recommend_1_ajax(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		
		String json = service.recommend(userid);

		return json;
	}
	/* 챌린지 추천하기 끝 */
	
	
	/* 진행중인 챌린지 페이지에서 그래프 그리기 시작 */
	@ResponseBody
	@RequestMapping(value = "/mypage_challenge_during_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String mypage_challenge_during_ajax(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		 
		String json = service.graph_challenge_during(userid);
		
		return json;
	}
	/* 진행중인 챌린지 페이지에서 그래프 그리기 끝 */
	

	/* 완료된 챌린지 페이지로 가기 시작 */
	@GetMapping(value = "/mypageFinish")
	public String mypageFinish(HttpServletRequest request) {

		return "mypage/mypageFinish.tiles5";
	}
	/* 완료된 챌린지 페이지로 가기 끝 */

	
	/* 개설한 챌린지 페이지로 가기 시작 */
	@GetMapping(value = "/mypageCreate")
	public String mypageCreate(HttpServletRequest request) {

		return "mypage/mypageCreate.tiles5";
	}
	/* 개설한 챌린지 페이지로 가기 끝 */
	
	
	/* 찜한 챌린지 페이지 가기 시작 */
	@GetMapping(value = "/mypageChallengeLike")
	public String mypageLike() {

		return "mypage/mypageChallengeLike.tiles5";
	}
	/* 찜한 챌린지 페이지 가기 끝 */
	
	
	/* 찜한 챌린지 불러오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/like_challenge_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String like_challenge_ajax(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		 
		String json = service.like_challenge(userid);
		
		return json;
	}
	/* 찜한 챌린지 불러오기 끝 */
	
	
	/* 찜한 라운지 페이지 가기 시작 */
	@GetMapping(value = "/mypageLoungeLike")
	public String mypageLoungeLike() {

		return "mypage/mypageLoungeLike.tiles5";
	}
	/* 찜한 라운지 페이지 가기 끝 */
	
	
	/* 찜한 라운지 불러오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/like_lounge_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String like_lounge_ajax(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		 
		String json = service.like_lounge(userid);
		
		return json;
	}
	/* 찜한 라운지 불러오기 끝 */
	
	
	/* 마이페이지 홈화면 사용자 정보 불러오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/user_information_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String user_information_ajax(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		 
		String json = service.user_information(userid);
		
		return json;
	}
	/* 마이페이지 홈화면 사용자 정보 불러오기 끝 */
	
	
	/* 마이페이지 인증 필요한 챌린지 불러오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/home_user_challenging_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String home_user_challenging_ajax(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("fk_category_code", "0");
		
		String json = service.mypage_certify_challenging(paraMap);
		
		return json;
	}
	/* 마이페이지 인증 필요한 챌린지 불러오기 끝 */

	
	/* 마이페이지 100% 인증한 챌린지들 불러오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/finish_100_ajax", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String finish_100_ajax(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		
		String json = service.finish_100_count(paraMap);
		
		return json;
	}
	/* 마이페이지 100% 인증한 챌린지들 불러오기 끝 */

	
	/* 마이페이지 홈 챌린지 그래프 시작*/
	@ResponseBody
	@RequestMapping(value = "/chart_challenging", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String chart_challenging(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		
		String json = service.chart_challenging(paraMap);
		
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/chart_category", method = {RequestMethod.GET}, produces = "text/plain;charset=UTF-8")
	public String chart_category(HttpServletRequest request){
		
		String userid = request.getParameter("userid");
		String month = request.getParameter("month");
		
		// System.out.println(userid);
		// System.out.println(month);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("month", month);
		
		String json = service.chart_category(paraMap);
		
		return json;
	}
	/* 마이페이지 홈 챌린지 그래프 끝*/
	
	
}
