package com.sist.haebollangce.challenge.controller;

import com.sist.haebollangce.challenge.dao.challengeVO;
import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.service.InterChallengeService;
import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.common.MyUtil;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/challenge")
public class ChallengeController {

    @Autowired
    private InterChallengeService service;
    
    @Autowired // 파일 업로드
	private FileManager fileManager;

 // 헤더의 챌린지 인증 페이지 클릭시 (참여중인 챌린지 목록)
    @RequestMapping(value="/certifyList")
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
    
    // 챌린지 참가하는 페이지
    @RequestMapping(value="/join")
    public String challenge_join(HttpServletRequest request) {
    	
    	// 로그인 확인
    	
    	String fk_userid = "qwer1234"; // request.getParameter("fk_userid"); 로그인한 회원의 아이디
    	String challenge_code = "7";
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("fk_challenge_code", challenge_code);

    	Map<String, String> resultMap = service.checkJoinedChall(paraMap);
    	// 이미 참가한 챌린지인지 확인
    	
    	if (resultMap != null) {
    		// 이미 참가한 챌린지인 경우
    		
    		String message = "이미 참가중인 챌린지입니다.";
    		String loc = request.getContextPath()+"/challenge/certifyList";
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
    @RequestMapping(value="/joinEnd")
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
 
    // 인증하기 버튼 클릭시
    @GetMapping(value="/certify")
    public ModelAndView certify(ModelAndView mav, HttpServletRequest request) {

    	// 로그인 확인
    	
    	String fk_userid = "qwer1234";
    	String challenge_code = "8";
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("challenge_code", challenge_code);
    	
    	int checkCertify = service.checkTodayCertify(paraMap);
    	// 오늘 인증하였는지 체크 / return 1 이상이면 오늘 인증 한 것
    	
    	if ( checkCertify >= 1) {
    		// 오늘 인증횟수가 1 이상일 경우
    		
    		String message = "오늘 인증을 이미 완료한<br>챌린지입니다.";
    		String loc = request.getContextPath()+"/challenge/certifyList";
    		String icon = "info";
    		
    		mav.addObject("message", message);
    		mav.addObject("loc", loc);
    		mav.addObject("icon", icon);
    		
    		mav.setViewName("tiles1/certify/swal_msg");
    		
    		return mav;
    	}
    	
    	Map<String, String> oneExample = service.getCertifyInfo(paraMap);
    	// 인증하려는 챌린지의 인증예시 데이터 가져오기
    	
    	mav.addObject("oneExample", oneExample);
    	mav.addObject("paraMap", paraMap);
    	
    	mav.setViewName("certify/certify.tiles1");
    	return mav;
    }
    
    // 인증하기 버튼 클릭시
    @PostMapping(value="/certify")
    public ModelAndView certify(ModelAndView mav, ChallengeDTO chadto, MultipartHttpServletRequest mrequest) {

    	// 로그인 확인
    	
    	String fk_userid = mrequest.getParameter("fk_userid");
    	String fk_challenge_code = mrequest.getParameter("fk_challenge_code");
    	String certify_img = "https://file.mk.co.kr/meet/neds/2020/06/image_readtop_2020_588132_15916615634233012.jpg";
    	
    	// MultipartFile attach = mrequest.getfi
    	
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("fk_challenge_code", fk_challenge_code);
    	paraMap.put("certify_img", certify_img);
    	
//    /*
//        1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
//        >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
//                   우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
//                   조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
//    */
//		// WAS의 webapp 의 절대경로를 알아온다
//		HttpSession session = mrequest.getSession();
//		String root = session.getServletContext().getRealPath("/");
//		System.out.println("webappp의 절대경로 : "+root);
//
//		String path = root+"resources"+File.separator+"files";
//	/*  File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
//		운영체제가 Windows 이라면 File.separator 는  "\" 이고,
//		운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
//		path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
//	*/
//		System.out.println("path : "+path);
//		
//		// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화 한 후 파일 올리기
//		String newFileName = "";
//		// WAS(톰캣)의 디스크에 저장될 파일명 
//		byte[] bytes = null;
//		// 첨부파일의 내용물을 담는 것
//		
//		long fileSize = 0;
//		// 첨부파일의 크기 
//		
//		try {
//			bytes = attach.getBytes();
//			// 첨부 파일의 내용물을 읽어오는 것
//			
//			String originalFilename = attach.getOriginalFilename();
//			// attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
//			System.out.println("originalFilename : "+originalFilename);
//			
//			newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
//			// 첨부되어진 파일을 업로드 하는 것
//			System.out.println("newFileName : "+newFileName);
//			
//			// 3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 fileSize 값을 넣어주기 
//			boardvo.setFileName(newFileName);
//			// WAS(톰캣)에 저장된 파일명
//			
//			boardvo.setOrgFilename(originalFilename);
//			// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
//            // 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
//			
//			fileSize = attach.getSize();
//			boardvo.setFileSize(String.valueOf(fileSize));
//			// 첨부 파일의 크기 (단위는 byte)
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		int n = 0;
		
		try {
			n = service.doCertify(paraMap);
			// 인증 기록 테이블에 insert (파일명 추가해야함)
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
    @RequestMapping(value="/certifyMyInfo")
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
    
    // =====================================================================================================
    
    
    
    @RequestMapping(value="/add_challenge")
    public ModelAndView add_challenge(ModelAndView mav) {
    	
    		List<ChallengeDTO> categoryList = null;
    		
    		categoryList = service.getcategoryList();
    		
    		List<ChallengeDTO> freqList = null;
    		
    		freqList = service.getfreq();
    		
    		// System.out.println("확인용 categoryList : " + categoryList);
    		
    		List<ChallengeDTO> duringList = null;
    		
    		duringList = service.getduring();
    		
    		mav.addObject("categoryList", categoryList);
    		mav.addObject("freqList", freqList);
    		mav.addObject("duringList" ,duringList);
    		
    		mav.setViewName("challenge/add_challenge.tiles1");
    	
    		return mav;
    }
    
    // 스마트 에디터. 그래그앤 드롭을 사용한 다중사진파일업로드 === // 
  	@RequestMapping(value="/image/multiplePhotoUpload.action", method= {RequestMethod.POST} )
  	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
  		
  		/*
  		   1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
  		   >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
  		        우리는 WAS 의 webapp/resources/static/photo_upload 라는 폴더로 지정해준다.
  		*/
  		
  		// WAS 의 webapp 의 절대경로를 알아와야 한다.
  		HttpSession session = request.getSession();
  		String root = session.getServletContext().getRealPath("/").substring(0, 40);
  		System.out.println(root);

  		
  		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.
  		String path = root + "resources" + File.separator + "static" + File.separator +"photo_upload";
  		
  		System.out.println("~~~~ 확인용 스마트 에디터 path => " + path);
  		// ~~~~ 확인용  스마트 에디터  path => 
  		
  		File dir = new File(path);
  		if(!dir.exists()) {
  			dir.mkdirs();
  		}
  		
  		try {
  			String filename = request.getHeader("file-name"); // 파일명(문자열)을 받는다 - 일반 원본파일명
  			// 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
  			
  			/*
  			    [참고]
  			    HttpServletRequest의 getHeader() 메소드를 통해 클라이언트 사용자의 정보를 알아올 수 있다. 
  	
  				request.getHeader("referer");           // 접속 경로(이전 URL)
  				request.getHeader("user-agent");        // 클라이언트 사용자의 시스템 정보
  				request.getHeader("User-Agent");        // 클라이언트 브라우저 정보 
  				request.getHeader("X-Forwarded-For");   // 클라이언트 ip 주소 
  				request.getHeader("host");              // Host 네임  예: 로컬 환경일 경우 ==> localhost:9090    
  			*/
  			
  			System.out.println(">>> 스마트에디터 확인용 filename ==> " + filename);
  			// >>> 스마트에디터 확인용 filename ==> 
  			
  			InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
  			
  			String newFilename = fileManager.doFileUpload(is, filename, path);
  			
  			String ctxPath = request.getContextPath(); // 
  			System.out.println("확인용 ctxPath" + ctxPath);
  			
  			String strURL = "";
  			strURL += "&bNewLine=true&sFileName="+newFilename; 
  			strURL += "&sFileURL="+ctxPath+"/photo_upload/"+newFilename;
  			
  			
  			// === 웹브라우저 상에 사진 이미지를 쓰기 === //
  			PrintWriter out = response.getWriter();
  			out.print(strURL);
  			
  		} catch(Exception e) {
  			e.printStackTrace();
  		}
  		
  	}
    
    // 챌린지 등록 완료 
    @RequestMapping(value="/addEnd", method= {RequestMethod.POST})
    public ModelAndView addEnd(ModelAndView mav, ChallengeDTO challengedto, MultipartHttpServletRequest mrequest) {
    	
	    	

    		// 대표사진 등록 파일 처리 로직
    		MultipartFile attach = challengedto.getAttach();
		
		if( !attach.isEmpty() ) {
			 
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/").substring(0, 40); 
			
		    System.out.println("~~~~~~ 썸네일 확인용 webapp 의 절대경로=> " + root);
		 //  ~~~~~~ 확인용 webapp 의 절대경로=> C:/Users/user/git/Haebollangce/src/main/
			
		    String path = root + "resources" + File.separator + "static" + File.separator + "images";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		                운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		                운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
			System.out.println("~~~~~~ 확인용 썸네일  path => " + path);
			//  ~~~~~~ 확인용 path => C:/Users/user/git/Haebollangce/src/main/webapp/resources/files
			
			
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
			
			try {
				bytes = attach.getBytes();
				// 첨부파일의 내용물을 읽어오는 것 
				
				String originalFilename = attach.getOriginalFilename();
				
				
		//		System.out.println("~~~ 확인용 originalFilename => " + originalFilename);
				// ~~~ 확인용 originalFilename => IMG_6949.JPG
				
				newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
				
				
		//		System.out.println(">>> 확인용 newFileName => " + newFileName);
				// >>> 확인용 newFileName => 20230522103648816893054943800.JPG
				// >>> 확인용 newFileName => 20230522103856817021097001000.JPG
				
			
				challengedto.setThumbnail(newFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
        
        // 인증성공 예시첨부 파일 처리 로직
        MultipartFile successImgAttach = challengedto.getSuccessImgAttach();
        if (successImgAttach != null && !successImgAttach.isEmpty()) {
            
            HttpSession session = mrequest.getSession();
            String root = session.getServletContext().getRealPath("/").substring(0, 40);
		//	System.out.println("~~~~~~ 확인용 successImgAttach webapp 의 절대경로=> " + root);
			
			String path = root + "resources" + File.separator + "static" + File.separator + "images";
			
		//	System.out.println("~~~~~~ 확인용 successImgAttach path => " + path);
			//  ~~~~~~ 확인용 path => C:\\Users\\user\\git\\Haebollangce\\src\\main\\webapp\\resources\\files
        		
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
            
            try {
            		
	            	bytes = successImgAttach.getBytes();
	            	
	            	String originalFilename = successImgAttach.getOriginalFilename();
	            
	            	newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
                
                challengedto.setSuccessImg(newFileName);
                challengedto.setSuccessImgFileName(originalFilename);
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 인증실패 예시첨부 파일 처리 로직
        MultipartFile failImgAttach = challengedto.getFailImgAttach();
        if (failImgAttach != null && !failImgAttach.isEmpty()) {
        	
        		HttpSession session = mrequest.getSession();
        		String root = session.getServletContext().getRealPath("/").substring(0, 40);
		//	System.out.println("~~~~~~ 확인용 failImgAttach webapp 의 절대경로=> " + root);
			
        		String path = root + "resources" + File.separator + "static" + File.separator + "images";
			
		//	System.out.println("~~~~~~ 확인용 failImgAttach path => " + path);
			//  ~~~~~~ 확인용 path => C:\\Users\\user\\git\\Haebollangce\\src\\main\\webapp\\resources\\files
        		
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			// 첨부파일의 내용물을 담는 것
            
            try {
            		
	            	bytes = failImgAttach.getBytes();
	            	
	            	String originalFilename = failImgAttach.getOriginalFilename();
	            
	            	newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
                
                challengedto.setFailImg(newFileName);
                challengedto.setFailImgFileName(originalFilename);
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        
    		int n = 0;
    	
    		n = service.addChallenge(challengedto);
    		
   // 	System.out.println("확인용 n : "  + n);
    		
    		if(n == 3) {
    			mav.setViewName("redirect:/lounge/loungeList");
    		}
    		else {
    			mav.setViewName("lounge/error/add_arror.tiles1");
    		}
    		
    		return mav;
    }
    
    
    
    // 챌린지 게시글 1개 보기 
    @RequestMapping(value="/challengeView")
    public ModelAndView challengeView(ModelAndView mav, HttpServletRequest request) {
    		
    		// 조회하고자 하는 카테고리 코드 
    		String challengeCode = request.getParameter("challengeCode");
    		
    		ChallengeDTO challengedto = null;
    		
    		try {
    			Integer.parseInt(challengeCode);
    			
    			Map<String, String> paraMap = new HashMap<>();
    			paraMap.put("challengeCode", challengeCode);
    			
    			challengedto = service.getview(paraMap);
    			
    		} catch (NumberFormatException e) {
    			
    		}
    		
    		mav.addObject("challengedto", challengedto);
    		
    		mav.setViewName("challenge/challengeView.tiles1");
    		return mav;
    }
    
    @RequestMapping(value="/challengeView_2")
    public ModelAndView challengeView_2(ModelAndView mav, HttpServletRequest request) {
    		String challengeCode = request.getParameter("challengeCode");
    		
    		Integer.parseInt(challengeCode);
			
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("challengeCode", challengeCode);
    		
    		mav.setViewName("redirect:/challengeView?challengeCode="+challengeCode);
    		
    		return mav;
    }
    
    
    
 // 메인페이지
    @RequestMapping(value="/main")
   public String mainpage(HttpServletRequest request) {
       
       
       
       return "main_page.tiles1";
       // /WEB-INF/views/tiles1/main_page.jsp 페이지를 만들어야 한다.
    }

    
    // 챌린지 불러오기
    @RequestMapping(value="/challenge_all")
    public ModelAndView challenge_all(ModelAndView mav, HttpServletRequest request) {

       List<challengeVO> challengeList = null;
       List<challengeVO> categoryList = null;
       
       challengeList = service.challengeList();
       categoryList = service.categoryList();
       
       mav.addObject("challengeList", challengeList);
       mav.addObject("categoryList", categoryList);
       
      mav.setViewName("board/challenge_all.tiles1");
      
       return mav;
       
    }
    
    
 
    // 카테고리별 챌린지 불러오기
    @ResponseBody
    @RequestMapping(value="/challengelist", method=RequestMethod.GET)
    public Map<String, List<challengeVO>> challengelist(@RequestParam(value = "categoryCode", required = false) String categoryCode) {
        List<challengeVO> challengelist = service.challengelist();
        Map<String, List<challengeVO>> categoryMap = new HashMap<>();
        
        // 카테고리 별로 데이터 그룹화
        for (challengeVO cvo : challengelist) {
            String category = cvo.getfkCategoryCode();
            
            // 전체 카테고리인 경우 모든 데이터 추가
            if (categoryCode == null) {
                if (!categoryMap.containsKey(category)) {
                    categoryMap.put(category, new ArrayList<>());
                }
                categoryMap.get(category).add(cvo);
            }
            // 특정 카테고리인 경우 해당 카테고리에 속하는 데이터만 추가
            else if (category.equals(categoryCode)) {
                if (!categoryMap.containsKey(category)) {
                    categoryMap.put(category, new ArrayList<>());
                }
                categoryMap.get(category).add(cvo);
            }
        }

        return categoryMap;
    }
    
}