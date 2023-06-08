package com.sist.haebollangce.challenge.controller;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.service.InterChallengeService;
import com.sist.haebollangce.common.FileManager;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
    	
    	// 로그인 유저인지 확인
    	
    	int ing_count = 0;  // 초기값 설정
    	int before_count = 0;  // 초기값 설정
    	
    	List<ChallengeDTO> chaList = service.getJoinedChaList();
    	
    	
    	for (ChallengeDTO chaDTO : chaList) {
    	    
    	    String str_startDate = chaDTO.getStartDate(); // chaDTO에서 시작 날짜를 가져옴
    	    String str_endDate = chaDTO.getEnddate();
            String pattern = "yyyy-MM-dd"; // 시작 날짜의 형식에 맞는 패턴을 지정
            Date startDate = null;
            Date endDate = null;
            
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            try {
                startDate = sdf.parse(str_startDate);
                endDate = sdf.parse(str_endDate);
            } catch (Exception e) {
                e.printStackTrace();
            }
    	    Date today = new Date();  // 현재 날짜

    	    // 현재 날짜와 챌린지의 시작일, 종료일을 비교하여 증가시킬 변수 값을 계산
    	    if (startDate.compareTo(today) <= 0 && endDate.compareTo(today) >= 0) {
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
    public ModelAndView challenge_join(ModelAndView mav) {
    	
    	mav.setViewName("certify/join.tiles1");
    	// /WEB-INF/views/tiles1/certify/join.jsp
    	return mav;
    }
    
    // 참가하기 완료버튼 클릭시 팝업창 연결
    @RequestMapping(value="/joinEnd")
    public ModelAndView joinEnd(ModelAndView mav) {
    	
    	// 로그인 검사
    	// tbl_challenge_info 에 insert 
    	mav.setViewName("tiles1/certify/joinEnd");
    	return mav;
    }
 
    // 인증하기 버튼 클릭시
    @RequestMapping(value="/certify")
    public ModelAndView certify(ModelAndView mav) {

    	mav.setViewName("certify/certify.tiles1");
    	return mav;
    }
    
    // 참가중인 챌린지 클릭시 내 인증정보 페이지 이동
    @RequestMapping(value="/certifyMyInfo")
    public ModelAndView certifyMyInfo(ModelAndView mav) {

    	mav.setViewName("certify/certifyMyInfo.tiles1");
    	return mav;
    }
    
    
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
    		
    		mav.setViewName("redirect:/challengeView?challengeCode="+challengeCode);
    		
    		return mav;
    }
    
}
