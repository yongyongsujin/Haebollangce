package com.sist.haebollangce.challenge.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.challenge.dao.challengeVO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.service.InterChallengeService;
import com.sist.haebollangce.common.FileManager;
import com.sist.haebollangce.config.token.CookieUtil;
import com.sist.haebollangce.config.token.JwtTokenizer;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;

@Controller
@RequestMapping("/challenge")
public class ChallengeController {

    @Autowired
    private InterChallengeService service;
    
    @Autowired // 파일 업로드
	private FileManager fileManager;

    @Autowired
    private JwtTokenizer jwtTokenizer;

    @Autowired   // 비밀번호 복호화
    private PasswordEncoder passwordEncoder;
    
    // =====================================================================================================
    
    
    @RequestMapping(value="/add_challenge")
    public ModelAndView add_challenge(ModelAndView mav, HttpServletRequest request) {
    	
	    	// 쿠키에서 accessToken (jWT 형식)을 가져옵니다. 
	    	String accessToken = CookieUtil.getToken(request,"accessToken");
	
	    	String userid = "";
	    	
	    	// 로그인 되어있다면 정상적으로 토큰에 접근 가능하며 아래와 같이 userid를 얻을  수 있습니다.
	    	// (로그아웃을 한 경우 null)
	    	if(accessToken != null) {
	    	   userid = jwtTokenizer.getUseridFromToken(accessToken);
	    	}
    	
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
    		mav.addObject("userid", userid);
    		
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
  //		System.out.println(root);

  		
  		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.
  		String path = root + "resources" + File.separator + "static" + File.separator +"photo_upload";
  		
  //		System.out.println("~~~~ 확인용 스마트 에디터 path => " + path);
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
  			
  	//		System.out.println(">>> 스마트에디터 확인용 filename ==> " + filename);
  			// >>> 스마트에디터 확인용 filename ==> 
  			
  			InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
  			
  			String newFilename = fileManager.doFileUpload(is, filename, path);
  			
  			String ctxPath = request.getContextPath(); // 
  	//		System.out.println("확인용 ctxPath" + ctxPath);
  			
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
			
	//	    System.out.println("~~~~~~ 썸네일 확인용 webapp 의 절대경로=> " + root);
		 //  ~~~~~~ 확인용 webapp 의 절대경로=> C:/Users/user/git/Haebollangce/src/main/
			
		    String path = root + "resources" + File.separator + "static" + File.separator + "images";
			/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		                운영체제가 Windows 이라면 File.separator 는  "\" 이고,
		                운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
		    */
			
			// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	//		System.out.println("~~~~~~ 확인용 썸네일  path => " + path);
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
    			mav.setViewName("redirect:/challenge/join");
    		}
    		else {
    			mav.setViewName("lounge/error/add_arror.tiles1");
    		}
    		
    		return mav;
    }
    
    
    
    // 챌린지 게시글 1개 보기 
    @RequestMapping(value="/challengeView")
    public ModelAndView challengeView(ModelAndView mav, HttpServletRequest request) {
    		
	    	// 쿠키에서 accessToken (jWT 형식)을 가져옵니다. 
	    	String accessToken = CookieUtil.getToken(request,"accessToken");
	
	    	String userid = "";
	    	
	    	// 로그인 되어있다면 정상적으로 토큰에 접근 가능하며 아래와 같이 userid를 얻을  수 있습니다.
	    	// (로그아웃을 한 경우 null)
	    	if(accessToken != null) {
	    	   userid = jwtTokenizer.getUseridFromToken(accessToken);
	    	}
    	
    		// 조회하고자 하는 카테고리 코드 
    		String challengeCode = request.getParameter("challengeCode");
    		
    		ChallengeDTO challengedto = null;
    		
    		try {
    			Integer.parseInt(challengeCode);
    			
    			Map<String, String> paraMap = new HashMap<>();
    			paraMap.put("challengeCode", challengeCode);
    			paraMap.put("userid", userid);
    			
    			challengedto = service.getview(paraMap);
    			
    		} catch (NumberFormatException e) {
    			
    		}
    		
    		
    		int n = 0;
    		
    		if(userid != "" ) {
    			
    			Map<String, String> paraMap = new HashMap<>();
    			paraMap.put("userid", userid);
    			paraMap.put("challengeCode", challengeCode);
    			
    			n = service.checkLike(paraMap);
    			
    			
    		}
    		
    		// System.out.println("likecount : "+ n);
    		
    		
    		mav.addObject("userid", userid);
    		mav.addObject("challengedto", challengedto);
    		mav.addObject("likecount", n);
    		
    		mav.setViewName("challenge/challengeView.tiles1");
    		return mav;
    }
    
    // 챌린지 게시글 북마크 추가 
    @ResponseBody
    @RequestMapping(value="/challengelikeadd")
    public int challengelikeadd(ChallengeDTO challengedto) {
    		
    		int n = 0;
    		
    		// 챌린지 북마크(관심)등록
    		n = service.challengelikeadd(challengedto);
    		
    	//	System.out.println("controller 확인용 : "+ n);
    	
    		return n;
    }
    
    
    // 챌린지 게시글 북마크 해제
    @ResponseBody
    @RequestMapping(value="/likedelete")
    public int likedelete(ChallengeDTO challengedto) {
    		
    		int n = 0;
    		
    		// 챌린지 북마크(관심)해제
    		n = service.likedelete(challengedto);
    		
    //	System.out.println("controller 확인용 : "+ n);
    	
    		return n;
    }
  
    
    
    
 // 메인페이지
    @RequestMapping(value="/main")
   public String mainpage(HttpServletRequest request) {

       return "main_page.tiles1";
       // /WEB-INF/views/tiles1/main_page.jsp 페이지를 만들어야 한다.
    }
    
    
    // 메인페이지 챌린지(Ajax)
    @ResponseBody
    @RequestMapping(value="/main_a", method=RequestMethod.GET)
    public String mainpage_a() {
       
        List<challengeVO> challengeList = service.challengeList();
      
      JSONArray jsonArr = new JSONArray(); 
      
      if(challengeList != null) {
         for(challengeVO vo : challengeList) {
            
            JSONObject jsonObj = new JSONObject(); 
            jsonObj.put("challengeName", vo.getChallengeName()); 
            jsonObj.put("categoryName", vo.getCategoryName()); 
            jsonObj.put("startDate", vo.getStartDate()); 
            jsonObj.put("setDate", vo.getSetDate());
            jsonObj.put("fkDuringType", vo.getfkDuringType());
            jsonObj.put("memberCount", vo.getMemberCount());
            jsonObj.put("thumbnail", vo.getThumbnail());
            jsonObj.put("fkUserid", vo.getfkUserid());
            jsonObj.put("challengeCode", vo.getChallengeCode());
            jsonObj.put("frequency", vo.getFrequency());
            
            jsonArr.put(jsonObj); 
         }
      }
      
      return jsonArr.toString();

    }

    // 메인페이지 라운지(Ajax)
    @ResponseBody
    @RequestMapping(value="/main_b", method=RequestMethod.GET)
    public String mainpage_b() {
       
        List<LoungeBoardDTO> loungeList = service.index_loungeList();
      
      JSONArray jsonArr = new JSONArray(); 
      
      if(loungeList != null) {
         for(LoungeBoardDTO dto : loungeList) {
            
            JSONObject jsonObj = new JSONObject(); 
            jsonObj.put("name", dto.getName()); 
            jsonObj.put("subject", dto.getSubject()); 
            jsonObj.put("content", dto.getContent()); 
            jsonObj.put("readCount", dto.getReadCount());
            jsonObj.put("thumbnail", dto.getThumbnail());
            jsonObj.put("likeCount", dto.getLikeCount());
            jsonObj.put("commentCount", dto.getCommentCount());
            jsonObj.put("seq", dto.getSeq());
            
            
            jsonArr.put(jsonObj); 
         }
      }
      
      return jsonArr.toString();

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
    
    // 챌린지 삭제하기
    @RequestMapping(value="/challengedel")
    public String challengedel(HttpServletRequest request) {
       
       String challengeCode = request.getParameter("challengeCode");

        request.setAttribute("challengeCode", challengeCode);
        
       return "/challenge/del_challenge.tiles1";
       
    }   

    // 챌린지 삭제하기 ajax
    @ResponseBody
    @RequestMapping(value = "/challengedel_ajax", method = { RequestMethod.GET }, produces = "text/plain;charset=UTF-8")
    public String pw_identify_ajax(HttpServletRequest request) {
       
       String challengeCode = request.getParameter("challengeCode");
       String pw = request.getParameter("pw");
       String fkUserid = request.getParameter("fkUserid");
       
       Map<String, String> paraMap = new HashMap<>();
       paraMap.put("fkUserid", fkUserid);
       paraMap.put("challengeCode", challengeCode);
       
       challengeVO challenge = service.challViewWithNoAddCount(paraMap);
       
         if( passwordEncoder.matches(pw, challenge.getPw() )) {
            // 비번이 같을 때
            return "success";
         }
         else {
            // 비번이 다를 때
            return "false";
         }
       
    }
    
    // 챌린지 삭제 페이지 요청 완료
    @PostMapping(value = "/challengedelend")
    public ModelAndView challengedelend(ModelAndView mav, HttpServletRequest request) {
       
       // 삭제하고자 하는 글번호 받아오기 
       String challengeCode = request.getParameter("challengeCode");

       // 삭제하고자 하는 글내용 가져오기 (이 안에 작성자 정보도 포함되어있음 - 남이 쓴 글 삭제를 막기위해 필요)
       Map<String,String> paraMap = new HashMap<>();
       paraMap.put("challengeCode", challengeCode);
             
       int n = service.challengedel(paraMap);

       if(n==1) {
          mav.addObject("message", "챌린지 삭제 완료");
          mav.addObject("loc", request.getContextPath()+"/challenge/challenge_all");
       }
       else {
          mav.addObject("message", "챌린지 삭제 실패");
          mav.addObject("loc", "javascript:history.back()"); 
       }
       
       mav.setViewName("msg");
       
       return mav;
       
    }
    
}