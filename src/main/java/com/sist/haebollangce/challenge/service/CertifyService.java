package com.sist.haebollangce.challenge.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.challenge.dao.InterCertifyDAO;
import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.dto.ChallengeInfoDTO;
import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.common.GoogleMail;
import com.sist.haebollangce.common.MyUtil;
import com.sist.haebollangce.config.token.CookieUtil;
import com.sist.haebollangce.config.token.JwtTokenizer;

@Service
public class CertifyService implements InterCertifyService {

    @Autowired
    private InterCertifyDAO dao;
    
    @Autowired // 파일 업로드
	private FileManager fileManager;

    @Autowired
    private GoogleMail mail;
    
    @Autowired
    private JwtTokenizer jwtTokenizer;
    
	// 이미 참가한 챌린지인지 확인
 	@Override
 	public String checkJoinedChall(HttpServletRequest request) {
 		
 		// 쿠키에서 accessToken (jWT 형식)을 가져옵니다. 
 		String accessToken = CookieUtil.getToken(request,"accessToken");

 		// 로그인 되어있다면 정상적으로 토큰에 접근 가능하며 아래와 같이 userid를 얻을  수 있습니다.
 		// (로그아웃을 한 경우 null)
 		
 		String userid = "";
 		
 		if(accessToken != null) {
 		   userid = jwtTokenizer.getUseridFromToken(accessToken);
 		}
 		
     	String challenge_code = request.getParameter("challenge_code");
     	
     	Map<String, String> paraMap = new HashMap<>();
     	paraMap.put("fk_userid", userid);
     	paraMap.put("fk_challenge_code", challenge_code);
 		
 		Map<String, String> resultMap = dao.checkJoinedChall(paraMap);
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

     		String userDeposit = dao.getUserDeposit(userid);
     		// 로그인한 유저의 보유 예치금 알아오기
     		ChallengeDTO chaDTO = dao.getOneChallengeInfo(challenge_code);
     		// 챌린지 코드를 받아  그 챌린지의 정보 가져오기
     		
     		request.setAttribute("userid", userid);
     		request.setAttribute("userDeposit", userDeposit);
     		request.setAttribute("chaDTO", chaDTO);
     		
     		return "certify/join.tiles1";
     		// /WEB-INF/views/tiles1/certify/join.jsp
     	}
 		
 	}
    
 	
 // 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert
 	@Override
 	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
 	public int joinChallenge(HttpServletRequest request) throws Throwable{

 		String fk_userid = request.getParameter("fk_userid");
     	String entry_fee = request.getParameter("entry_fee");
     	String fk_challenge_code = request.getParameter("fk_challenge_code");
     	String after_deposit = request.getParameter("after_deposit");
     	// form에서 받아오는 것들
     	
     	Map<String, String> paraMap = new HashMap<>();
     	paraMap.put("fk_userid", fk_userid);
     	paraMap.put("entry_fee", entry_fee);
     	paraMap.put("fk_challenge_code", fk_challenge_code);
     	paraMap.put("after_deposit", after_deposit);
 		
 		int n = 0, m = 0, k = 0; 
 		
 		m = dao.joinChallenge(paraMap);
 		// 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert (참가인원수 update 트랜잭션 처리)
 		// 맵퍼 userid 변경해야함
 		
 		if (m == 1) {
 			n = dao.updateMemberCount(paraMap);
 			// 챌린지 테이블에 참가인원수 update
 		
 			if (n==1) {
 				ChallengeDTO chaDTO = dao.getOneChallengeInfo(fk_challenge_code);
 		    	// 챌린지 코드를 받아  그 챌린지의 정보 가져오기
 		    	
 		    	request.setAttribute("chaDTO", chaDTO);
 		    	request.setAttribute("paraMap", paraMap);
 		    	k = 1;
 			}
 		}
 		
 		return k;
 	}
 	
    
	// 참가중인 챌린지 리스트 가져오기
	@Override
	public ModelAndView getJoinedChaList(ModelAndView mav, HttpServletRequest request) {
		
		// 쿠키에서 accessToken (jWT 형식)을 가져옵니다. 
 		String accessToken = CookieUtil.getToken(request,"accessToken");

 		// 로그인 되어있다면 정상적으로 토큰에 접근 가능하며 아래와 같이 userid를 얻을  수 있습니다.
 		// (로그아웃을 한 경우 null)
 		
 		String fk_userid = "";
 		
 		if(accessToken != null) {
 			fk_userid = jwtTokenizer.getUseridFromToken(accessToken);
 			// 아이디 받아오기
 		}
		
		List<ChallengeDTO> chaList = dao.getJoinedChaList(fk_userid);
		// 참가중인 챌린지 리스트 가져오기
		
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
    	
		return mav;
	}

	

	// 인증 기록 테이블에 insert
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int doCertify(ModelAndView mav, MultipartHttpServletRequest mrequest) throws Throwable {

		String fk_userid = mrequest.getParameter("fk_userid");
    	String fk_challenge_code = mrequest.getParameter("fk_challenge_code");
    	MultipartFile certify_img = mrequest.getFile("certify_img");
    	// form에서 받아오는 것들
    	
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
		
		int n = 0, m = 0, k = 0;
		// 인증테이블 insert, 유저 달성률 update, 경험치 update 트랜잭션 처리
		
		m = dao.doCertify(paraMap);
		// 인증 기록 테이블에 insert
		
		if (m==1) {
			Map<String, String> userAchievePct = dao.getUserAchievePct(paraMap);
			// 인증이 완료되었으면 해당 유저의 달성률을 계산하여 가져오기
			paraMap.put("achievement_pct", userAchievePct.get("achievement_pct"));
			paraMap.put("challenge_exp", userAchievePct.get("challenge_exp")); 
			
			k = dao.updateAchievePct(paraMap);
			// 참여중인 챌린지 정보에서 유저의 달성률 update
			
			if (k==1) {
				n = dao.addUserExp(paraMap);
				// 인증할때마다 유저 경험치 증가시키기
			}
		}
		
		return n;
	}

	
	// 오늘 인증하였는지 체크 / return 1이면 오늘 인증 한 것
	@Override
	public ModelAndView checkTodayCertify(ModelAndView mav, HttpServletRequest request) {
		
		String accessToken = CookieUtil.getToken(request,"accessToken");
 		String fk_userid = "";
 		
 		if(accessToken != null) {
 			fk_userid = jwtTokenizer.getUseridFromToken(accessToken);
 			// 아이디 받아오기
 		}
    	String challenge_code = request.getParameter("challenge_code");
    	
    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("challenge_code", challenge_code);
		
		int checkCertify = dao.checkTodayCertify(paraMap);
		// 오늘 인증하였는지 체크 / return 1이면 오늘 인증 한 것

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
    	
    	Map<String, String> oneExample = dao.getCertifyInfo(paraMap);
    	// 인증하려는 챌린지의 인증예시 데이터 가져오기
    	
    	mav.addObject("oneExample", oneExample);
    	mav.addObject("paraMap", paraMap);
    	
    	mav.setViewName("certify/certify.tiles1");
    	
		return mav;
	}

	
	@Override
	public void userReport(HttpServletRequest request) {
		
		String fk_userid = request.getParameter("userid");
    	String challenge_code = request.getParameter("challenge_code");
    	String certifyNo = request.getParameter("certifyNo");
    	String report_content = request.getParameter("report_content");
    	// form 태그 받아오기
    	
    	Map <String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("challenge_code", challenge_code);
    	paraMap.put("certifyNo", certifyNo);
    	paraMap.put("report_content", report_content);
    	
    	Map <String, String> resultMap = dao.checkReport(paraMap);
    	// 로그인한 유저가 신고했던 인증사진인지 체크하는 메소드
		
    	if (resultMap != null) {
    		// 이미 신고했던 인증사진일 경우
    		
    		String message = "이미 신고한 유저입니다.";
    		String loc = request.getContextPath()+"/challenge/certifyMyInfo?challenge_code="+challenge_code;
    		String icon = "info";
    		
    		request.setAttribute("message", message);
    		request.setAttribute("loc", loc);
    		request.setAttribute("icon", icon);
    	}
    	else {
    		
    		int n = dao.userReport(paraMap);
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
    		
    	}
    	

	}

	
	// 매일 챌린지 정산하는 스케줄러
	@Scheduled(cron="0 30 12 * * *") // 매일 00시 30분에 정산시작 cron="0 30 00 * * *"
	public void rewardCalculate() {
		// 스케줄러로 사용되어지는 메소드는 반드시 파라미터는 없어야 한다.
	      
		System.out.println("금일의 챌린지 정산 시작 !");
	    
		List<ChallengeDTO> endChallengeList = dao.getAllChallengeList();
		// 전체 챌린지 리스트 가져오기 
		// where 절 기간 수정해야함
		
		if (endChallengeList.size() > 0) {
			// 종료된 챌린지가 있을 때
			
			StringBuilder sb = new StringBuilder ();
			
			for (ChallengeDTO chaDTO : endChallengeList) {
				// 한 챌린지 마다의 정산 (상금을 계산한다)
				
				String challenge_code = chaDTO.getChallengeCode();
				List<ChallengeInfoDTO> chaInfoList = dao.getParticipantList(challenge_code);
				// 챌린지 코드를 받아 해당 챌린지의 참가하고 있는 참가자의 정보 리스트를 가져온다.
				
				System.out.println(challenge_code+"번 챌린지 정산 결과");
				sb.append("["+challenge_code+"번 챌린지 정산 결과]<br>");
				
				if (chaInfoList.size() > 0) {
					// 참가자가 있을 경우 - 참가자들의 정보를 가져와 정산
					
					int perfectUserTotalDeposit = 0;
					int totalPenalty = 0;
					int totalEntryFee = 0;
					
					for (ChallengeInfoDTO chaInfoDTO : chaInfoList) {
						// 총 벌금 계산과 100% 달성한 유저들의 예치금 알아오기 
						
						int userEntryFee = Integer.parseInt(chaInfoDTO.getEntryFee());
						int userAchievePct = Integer.parseInt(chaInfoDTO.getAchievementPct());
						
						if ( userAchievePct == 0 ) {
							// 달성률 0퍼인 사람은 참가비 = 벌금
							totalPenalty += userEntryFee;
						}
						else if (userAchievePct != 0 && userAchievePct < 80) {
							// 달성률 80미만인 사람들의 벌금 수급
							totalPenalty += (userEntryFee * (100 - userAchievePct)) / 100;
						}
						else if ( userAchievePct == 100 ) {
							// 달성률 100%인 사람들의 총 예치금 구하기
							perfectUserTotalDeposit += userEntryFee;
						}
						
						totalEntryFee += userEntryFee;
					} // end chaInfoList - 총 벌금 구하기
					
					System.out.println("이 챌린지의 벌금 합계 : "+totalPenalty);
					System.out.println("이 챌린지의 100% 달성률 유저들의 총 합계 예치금 : "+perfectUserTotalDeposit);
					sb.append("<h3>이 챌린지의 유저들의 예치금 합계 : "+totalEntryFee+" 원<br>");
					sb.append("이 챌린지의 벌금 합계 : "+totalPenalty+" 원<br>");
					sb.append("이 챌린지의 100% 달성률 유저들의 총 합계 예치금 : "+perfectUserTotalDeposit+"<br>");
					
					
					// 상금 분배 시작
					for (ChallengeInfoDTO chaInfoDTO : chaInfoList) {
						
						int userEntryFee = Integer.parseInt(chaInfoDTO.getEntryFee());
						int userAchievePct = Integer.parseInt(chaInfoDTO.getAchievementPct());
						
						int userReward = 0;
						
						if (userAchievePct != 0 && userAchievePct < 80) {
							// 달성률 80미만인 사람들의 상금
							userReward = userEntryFee * userAchievePct / 100;
						}
						else if ( 80 <= userAchievePct && userAchievePct < 100 ) {
							// 달성률 80% 이상 100% 미만인 사람들의 상금
							userReward = userEntryFee;
						}
						else if ( userAchievePct == 100 ) {
							// 달성률 100%인 사람들의 상금
							if (totalPenalty == 0) {
								// 벌금이 안모여졌을 경우 즉, 참가자 모두가 100% 달성률 일 경우
								userReward = userEntryFee;
							}
							else {
								userReward = (int)Math.floor( (totalPenalty * userEntryFee / perfectUserTotalDeposit) / 100) * 100 ;
							}
						}
						
						if (totalPenalty != 0) {
							totalPenalty -= userReward;
						}
						chaInfoDTO.setUserReward(userReward);
						
						try {
							dao.userRewardAdd(chaInfoDTO);
							// 분배된 상금 insert 하기
						} catch (Exception e) {
							e.printStackTrace();
						}
						
						System.out.println("'"+chaInfoDTO.getFkUserid()+"' 유저의 상금 : "+userReward+" 원");
						sb.append("'"+chaInfoDTO.getFkUserid()+"' 유저의 예치금 : "+userEntryFee+" 원, 유저의 달성률 : "+userAchievePct+"%, 유저의 총 상금 : "+userReward+" 원<br>");
						 
					} // 상금 분배 끝
					
					System.out.println("이 챌린지의 회사가 가지는 수수료 (벌금 정산 후 남는 돈) : "+totalPenalty);
					sb.append("이 챌린지의 회사가 가지는 수수료 (벌금 정산 후 남는 돈) : "+totalPenalty+" 원</h3><br>");
					sb.append("<hr style='border: solid 2px black;'>");
					
				} // end if 참가자가 존재할경우
				
			} // end for endChallengeList 한 챌린지의 정산
			
			try {
				String content ="<h1>[HAEBOLLANGCE] 금일의 종료된 챌린지 결과</h1>"+ 
								"<h2>"+sb.toString()+"</h2>";
				// mail.sendmail_challengeResult("sdvilzty@naver.com", content);
				// 챌린지 결과 이메일로 전송
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} // end if 종료된 챌린지가 있을 경우
		
		return ;
	}


	// 내 인증정보 가져오기
	@Override
	public void certifyMyInfo(HttpServletRequest request) {

		String accessToken = CookieUtil.getToken(request,"accessToken");
 		String fk_userid = "";
 		
 		if(accessToken != null) {
 			fk_userid = jwtTokenizer.getUseridFromToken(accessToken);
 			// 아이디 받아오기
 		}
    	String challenge_code = request.getParameter("challenge_code");

    	Map<String, String> paraMap = new HashMap<>();
    	paraMap.put("fk_userid", fk_userid);
    	paraMap.put("challenge_code", challenge_code);
    	
    	Map<String, String> joinedChallInfo = dao.getJoinedChallengeInfo(paraMap);
    	// 유저아이디와 챌린지 코드를 받아  그 챌린지의 참가중인 정보 가져오기 (챌린지 정보 view용)

    	Map<String, String> oneExample = dao.getCertifyInfo(paraMap);
    	// 인증하려는 챌린지의 인증예시 데이터 가져오기
    	
    	List<CertifyDTO> myCertifyHistory = dao.getMyCertifyHistory(paraMap);
    	// 내 인증기록 가져오기 (인증샷)
    	
    	paraMap.put("fk_userid", "");
    	List<CertifyDTO> allCertifyHistory = dao.getMyCertifyHistory(paraMap);
    	// 모든유저의 인증기록 가져오기 (인증샷)

    	Map<String, String> userAchieveCharts = dao.getUserAchieveCharts(challenge_code);
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
    	
	}
}
