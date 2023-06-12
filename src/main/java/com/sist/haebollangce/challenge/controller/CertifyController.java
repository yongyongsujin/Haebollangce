package com.sist.haebollangce.challenge.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.service.InterCertifyService;
import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.common.MyUtil;

@Controller
public class CertifyController {

    @Autowired
    private InterCertifyService service;

    @Autowired // 파일 업로드
	private FileManager fileManager;
    
    
    // 챌린지 참가하는 페이지
    @RequestMapping(value="/challenge/join")
    public String challenge_join(HttpServletRequest request) {
    	
    	// 로그인 확인
    	
    	String fk_userid = "qwer1234"; // request.getParameter("fk_userid"); 로그인한 회원의 아이디
    	String challenge_code = "24";
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("fk_challenge_code", challenge_code);

    	Map<String, String> resultMap = service.checkJoinedChall(paraMap);
    	// 이미 참가한 챌린지인지 확인
    	
    	if (resultMap != null) {
    		// 이미 참가한 챌린지인 경우
    		
    		String message = "이미 참가중인 챌린지입니다.";
    		String loc = request.getContextPath()+"/challenge/certifyList"; // 챌린지 목록으로 변경해야함
    		String icon = "warning";
    		
    		request.setAttribute("message", message);
    		request.setAttribute("loc", loc);
    		request.setAttribute("icon", icon);
    		
    		return "tiles1/certify/swal_msg";
    	}
    	else {
    		// 참가한 챌린지가 아닐 경우

    		String userDeposit = service.getUserDeposit(fk_userid);
    		// 로그인한 유저의 보유 예치금 알아오기
    		ChallengeDTO chaDTO = service.getOneChallengeInfo(challenge_code);
    		// 챌린지 코드를 받아  그 챌린지의 정보 가져오기
    		
    		request.setAttribute("userDeposit", userDeposit);
    		request.setAttribute("chaDTO", chaDTO);
    		
    		return "certify/join.tiles1";
    		// /WEB-INF/views/tiles1/certify/join.jsp
    	}
    	
    }
    
    // 참가하기 완료버튼 클릭시 팝업창 연결
    @RequestMapping(value="/challenge/joinEnd")
    public String joinEnd(HttpServletRequest request) {
    	
    	// 로그인 확인
    	
    	String fk_userid = request.getParameter("fk_userid");
    	String entry_fee = request.getParameter("entry_fee");
    	String fk_challenge_code = request.getParameter("fk_challenge_code");
    	String after_deposit = request.getParameter("after_deposit");
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("entry_fee", entry_fee);
    	paraMap.put("fk_challenge_code", fk_challenge_code);
    	paraMap.put("after_deposit", after_deposit);
    	
    	try {
			service.joinChallenge(paraMap);
			// 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert (참가인원수 update 트랜잭션 처리)
			// 맵퍼 userid 변경해야함
		} catch (Throwable e) {
			e.printStackTrace();
		}
    	
    	ChallengeDTO chaDTO = service.getOneChallengeInfo(fk_challenge_code);
    	// 챌린지 코드를 받아  그 챌린지의 정보 가져오기
    	
    	request.setAttribute("chaDTO", chaDTO);
    	request.setAttribute("paraMap", paraMap);
    	
    	return "tiles1/certify/joinEnd";
    }
    
    
    // 헤더의 챌린지 인증 페이지 클릭시 (참여중인 챌린지 목록)
    @RequestMapping(value="/challenge/certifyList")
    public ModelAndView challenge_certify(ModelAndView mav, HttpServletRequest request) {
    	
    	// 로그인 확인
    	
    	String fk_userid = "qwer1234"; // 아이디 받아오기

    	List<ChallengeDTO> chaList = service.getJoinedChaList(fk_userid);

    	int ing_count = 0;  // 초기값 설정
    	int before_count = 0;  // 초기값 설정
    	
    	
    	for (ChallengeDTO chaDTO : chaList) {
    	    
    	    String str_startDate = chaDTO.getStartDate(); // chaDTO에서 시작 날짜를 가져옴
    	    String str_endDate = chaDTO.getEnddate();
            String pattern = "yyyy-MM-dd"; // 시작 날짜의 형식에 맞는 패턴을 지정
            
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            Date startDate = null;
            Date endDate = null;
            Date today = null;

            try {
                startDate = sdf.parse(sdf.format(sdf.parse(str_startDate)));
                endDate = sdf.parse(sdf.format(sdf.parse(str_endDate)));
                today = sdf.parse(sdf.format(new Date()));
            } catch (Exception e) {
                e.printStackTrace();
            }

    	    // 현재 날짜와 챌린지의 시작일, 종료일을 비교하여 증가시킬 변수 값을 계산
    	    if (startDate.compareTo(today) <= 0 && endDate.compareTo(today) >= 0 ) {
    	    	ing_count++;
    	    } else if (startDate.compareTo(today) > 0) {
    	    	before_count++;
    	    }
    	    
    	}
    	
    	mav.addObject("ing_count", ing_count);
    	mav.addObject("before_count", before_count);
    	mav.addObject("chaList", chaList);
    	
    	mav.setViewName("certify/certifyList.tiles1");
    	// /WEB-INF/views/tiles1/certify/certifyList.jsp
    	return mav;
    }
    
 
    // 인증하기 버튼 클릭시
    @GetMapping(value="/challenge/certify")
    public ModelAndView certify(ModelAndView mav, HttpServletRequest request) {

    	// 로그인 확인
    	
    	String fk_userid = "qwer1234";
    	String challenge_code = "25";
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("challenge_code", challenge_code);
    	
    	int checkCertify = service.checkTodayCertify(paraMap);
    	// 오늘 인증하였는지 체크 / return 1 이상이면 오늘 인증 한 것
    	
//    	if ( checkCertify >= 1) {
//    		// 오늘 인증횟수가 1 이상일 경우
//    		
//    		String message = "오늘 인증을 이미 완료한<br>챌린지입니다.";
//    		String loc = request.getContextPath()+"/challenge/certifyList";
//    		String icon = "info";
//    		
//    		mav.addObject("message", message);
//    		mav.addObject("loc", loc);
//    		mav.addObject("icon", icon);
//    		
//    		mav.setViewName("tiles1/certify/swal_msg");
//    		
//    		return mav;
//    	}
    	
    	Map<String, String> oneExample = service.getCertifyInfo(paraMap);
    	// 인증하려는 챌린지의 인증예시 데이터 가져오기
    	
    	mav.addObject("oneExample", oneExample);
    	mav.addObject("paraMap", paraMap);
    	
    	mav.setViewName("certify/certify.tiles1");
    	return mav;
    }
    
    // 인증하기 버튼 클릭시
    @PostMapping(value="/challenge/certify")
    public ModelAndView certify(ModelAndView mav, MultipartHttpServletRequest mrequest) {

    	// 로그인 확인
    	
    	String fk_userid = mrequest.getParameter("fk_userid");
    	String fk_challenge_code = mrequest.getParameter("fk_challenge_code");
    	MultipartFile certify_img = mrequest.getFile("certify_img");
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("fk_challenge_code", fk_challenge_code);
    	
    /*
        1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
        >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
                   우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
                   조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
    */
		// WAS의 webapp 의 절대경로를 알아온다
		HttpSession session = mrequest.getSession();
		String root = session.getServletContext().getRealPath("/").substring(0, 40);
		// System.out.println("webappp의 절대경로 : "+root);
		// C:/Users/user\git\Haebollangce\src\main\webapp\

		String path = root+"resources"+File.separator+"static"+File.separator+"images"+File.separator+"certify";
	/*  File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
		path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	*/
		// System.out.println("path : "+path);
		
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
		String newFileName = "";
		// WAS(톰캣)의 디스크에 저장될 파일명 
		byte[] bytes = null;
		// 첨부파일의 내용물을 담는 것
		
		try {
			bytes = certify_img.getBytes();
			// 첨부 파일의 내용물을 읽어오는 것
			
			String originalFilename = certify_img.getOriginalFilename();
			// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
			// System.out.println("originalFilename : "+originalFilename);
			
			newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
			// 첨부되어진 파일을 업로드 하는 것
			// System.out.println("newFileName : "+newFileName);
			
			paraMap.put("certify_img", newFileName);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int n = 0;
		
		try {
			n = service.doCertify(paraMap);
			// 인증 기록 테이블에 insert
		} catch (Throwable e) {
			e.printStackTrace();
			// 인증이 실패되었을 경우 - challenge_info 테이블에 달성률의 체크제약 조건 0 ~ 100 안의 숫자만 가능 
			// 100%가 넘는 인증일 경우 종료된 챌린지이어야함
			
			String message = "종료된 챌린지입니다.";
    		String loc = mrequest.getContextPath()+"/challenge/certifyList";
    		String icon = "info";
    		
    		mav.addObject("message", message);
    		mav.addObject("loc", loc);
    		mav.addObject("icon", icon);
    		
    		mav.setViewName("tiles1/certify/swal_msg");
    		
    		return mav;
		}
		
		if (n==1) {
			// 인증이 완료되었을 경우

			String message = "인증이 완료되었습니다 !";
    		String loc = mrequest.getContextPath()+"/challenge/certifyList";
    		String icon = "success";
    		
    		mav.addObject("message", message);
    		mav.addObject("loc", loc);
    		mav.addObject("icon", icon);
    		
    		mav.setViewName("tiles1/certify/swal_msg");
    		
		} else {
			// 인증이 실패되었을 경우

			String message = "인증 실패.<br>관리자에게 문의하세요.";
    		String loc = mrequest.getContextPath()+"/challenge/certifyList";
    		String icon = "error";
    		
    		mav.addObject("message", message);
    		mav.addObject("loc", loc);
    		mav.addObject("icon", icon);
    		
    		mav.setViewName("tiles1/certify/swal_msg");
		}
		
		return mav;
    }
    
    // 참가중인 챌린지 클릭시 내 인증정보 페이지 이동
    @RequestMapping(value="/challenge/certifyMyInfo")
    public String certifyMyInfo(HttpServletRequest request) {
    	
    	// 참가중인 유저가 아닐시 잘못된 경로
    	
    	String fk_userid = "qwer1234";
    	String challenge_code = request.getParameter("challenge_code");

    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("challenge_code", challenge_code);
    	
    	Map<String, String> joinedChallInfo = service.getJoinedChallengeInfo(paraMap);
    	// 유저아이디와 챌린지 코드를 받아  그 챌린지의 참가중인 정보 가져오기 (챌린지 정보 view용)

    	Map<String, String> oneExample = service.getCertifyInfo(paraMap);
    	// 인증하려는 챌린지의 인증예시 데이터 가져오기
    	
    	List<CertifyDTO> myCertifyHistory = service.getMyCertifyHistory(paraMap);
    	// 내 인증기록 가져오기 (인증샷)
    	
    	paraMap.put("fk_userid", "");
    	List<CertifyDTO> allCertifyHistory = service.getMyCertifyHistory(paraMap);
    	// 모든유저의 인증기록 가져오기 (인증샷)

    	Map<String, String> userAchieveCharts = service.getUserAchieveCharts(challenge_code);
    	// 해당 챌린지의 유저들의 달성률 통계 가져오기
    			
    	String startDate = joinedChallInfo.get("startDate"); // 종료날짜
    	String fk_freq_type = joinedChallInfo.get("fk_freq_type"); // 인증빈도 종류 100, 101, 102
    	String fk_during_type = joinedChallInfo.get("fk_during_type"); // 기간종류 1주간, 2주간
    	
    	paraMap.put("startDate", startDate);
    	paraMap.put("fk_freq_type", fk_freq_type);
    	paraMap.put("fk_during_type", fk_during_type);
    	
    	int totalCertify = MyUtil.getTotalCertify(paraMap);
    	// 챌린저의 총 인증횟수를 리턴해주는 메소드
    	
    	request.setAttribute("certifyCnt", myCertifyHistory.size());
    	request.setAttribute("totalCertify", totalCertify);
    	request.setAttribute("myCertifyHistory", myCertifyHistory);
    	request.setAttribute("userAchieveCharts", userAchieveCharts);
    	request.setAttribute("allCertifyHistory", allCertifyHistory);
    	// 인증통계용 데이터
    	
    	request.setAttribute("joinedChallInfo", joinedChallInfo);
    	request.setAttribute("oneExample", oneExample);
    	
    	return "certify/certifyMyInfo.tiles1";
    }
    
    
    // 유저가 신고했을 때
    @PostMapping(value="/challenge/userReport")
    public String userReport(HttpServletRequest request) {
    	
    	String fk_userid = "qwer1234";
    	// 신고한 사람은 로그인한 유저이기 때문에  로그인한 유저의 아이디 알아오기
    	
    	String challenge_code = request.getParameter("challenge_code");
    	String certifyNo = request.getParameter("certifyNo");
    	String report_content = request.getParameter("report_content");
    	
    	Map <String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("certifyNo", certifyNo);
    	paraMap.put("report_content", report_content);
    	
    	int n = service.userReport(paraMap);
    	// 유저를 신고했을때 신고테이블에 insert
    	
    	if (n==1) {
    		// 신고가 완료되었을시
    		
    		String message = "해당유저의 신고가<br>접수되었습니다.";
    		String loc = request.getContextPath()+"/challenge/certifyMyInfo?challenge_code="+challenge_code;
    		String icon = "success";
    		
    		request.setAttribute("message", message);
    		request.setAttribute("loc", loc);
    		request.setAttribute("icon", icon);
    	}
    	else {
    		
    		String message = "알 수없는 에러가 발생하였습니다. 관리자에게 문의하세요";
    		String loc = request.getContextPath()+"/challenge/certifyMyInfo?challenge_code="+challenge_code;
    		String icon = "error";
    		
    		request.setAttribute("message", message);
    		request.setAttribute("loc", loc);
    		request.setAttribute("icon", icon);
    	}

    	return "tiles1/certify/swal_msg";
    }
    
    
}
