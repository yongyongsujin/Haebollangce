package com.sist.haebollangce.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.service.InterMypageService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
@RequestMapping("mypage")
public class MypageController {

	@Autowired
	private InterMypageService service;

	@Autowired // 파일 업로드
	private FileManager fileManager;
	
	@GetMapping(value = "/mypageHome")
	public ModelAndView mypageHome(ModelAndView mav) {

		mav.setViewName("mypage/mypageHome.tiles5");

		return mav;
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

		int minus = service.reward_minus(paraMap); // 전환한 상금 감소시키기

		int n = service.reward_convert(paraMap); // 상금 테이블에 전환된 내용 넣기

		String message = "";

		String loc = "";

		if (minus == 1 && n == 1) {
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
	@GetMapping(value = "/mypageDepositUsing")
	public String mypageDepositUsing(HttpServletRequest request) {

		return "mypage/mypageDepositUsing.tiles5";
	}
	/* 결제 현황 페이지 가기 끝 */

	
	/* 결제 현황 페이지에서 내역 알아오기 시작 */
	@ResponseBody
	@RequestMapping(value = "/search_data_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String search_data(HttpServletRequest request, HttpServletResponse response) {

		String userid = request.getParameter("userid");
		String start_date = request.getParameter("start_date");
		String end_date = request.getParameter("end_date");
		String sort = request.getParameter("sort");
		/*
		 * System.out.println(userid); System.out.println(start_date);
		 * System.out.println(end_date);
		 */
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("start_date", start_date);
		paraMap.put("end_date", end_date);
		paraMap.put("sort", sort);

		String json = service.search_data(paraMap);

		return json;
	}
	/* 결제 현황 페이지에서 내역 알아오기 끝 */

	
	/* 회원 정보수정 및 회원탈퇴 들어가기 전 비밀번호 확인 가기 시작 */
	@GetMapping(value = "/mypagePwdIdentify")
	public String mypagePwdIdentify(HttpServletRequest request) {

		return "mypage/mypagePwdIdentify.tiles5";
	}
	/* 회원 정보수정 및 회원탈퇴 들어가기 전 비밀번호 확인 가기 끝 */

	
	/* 비밀번호 확인 후 회원 정보수정 페이지 가기 시작 */
	@PostMapping(value = "/mypageInfoEdit")
	public String mypageInfoEdit(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);

		UserDTO udto = service.select_info(paraMap);

		String hp1 = udto.getMobile().substring(3, 7);

		String hp2 = udto.getMobile().substring(7);

		request.setAttribute("udto", udto);

		request.setAttribute("hp1", hp1);

		request.setAttribute("hp2", hp2);

		return "mypage/mypageInfoEdit.tiles5";
	}
	/* 비밀번호 확인 후 회원 정보수정 페이지 가기 끝 */

	
	/* 이메일 중복확인 시작 */
	@ResponseBody
	@RequestMapping(value = "/email_change_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
	public String email_change_ajax(HttpServletRequest request, HttpServletResponse response) {

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
		String originalFilename = mtp_request.getParameter("profile_pic");
		
		HttpSession session = mtp_request.getSession();
		String root = session.getServletContext().getRealPath("/").substring(0, 40);  
		// 메타데이터 폴더 경로입니다. 경로를 수정할 경우 밑에 root 를 출력한 후 substring 조절하기.
		// System.out.println(root);
		
		String path = root + "resources"+File.separator+"static"+File.separator+"images";
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
		
		try {
			MultipartFile mtfile = mtp_request.getFile("profile_pic_file");
		
			// System.out.println(mtfile);
			
			String newFileName = "";
			
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
		paraMap.put("profile_pic", originalFilename);
		
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
	
}
