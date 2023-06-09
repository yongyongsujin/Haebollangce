package com.sist.haebollangce.common;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Map;

public class MyUtil {
	
	// 챌린저의 시작날짜를 가져와 인증빈도와 기간에 맞게 총 인증횟수를 리턴하는 메소드
	public static int getTotalCertify(Map<String, String> paraMap) {
		
		String startDate = paraMap.get("startDate"); 		   // 시작날짜 가져오기 - 형식은 'yyyy-mm-dd' 키값 매칭 해야함
		String fk_freq_type = paraMap.get("fk_freq_type"); 	   // 인증빈도 가져오기 - 100, 101, 102
		String fk_during_type = paraMap.get("fk_during_type"); // 인증기간 가져오기 - 1, 2 .. 8
		
		int s_year = Integer.parseInt(startDate.substring(0, 4));
		int s_month = Integer.parseInt(startDate.substring(5, 7));
		int s_date = Integer.parseInt(startDate.substring(8));
		
		LocalDate date = LocalDate.of(s_year, s_month, s_date);
		DayOfWeek dayOfWeek = date.getDayOfWeek();
		int getDay = dayOfWeek.getValue();
		// 월요일 = 1 ~ 일요일  = 7 값을 리턴 
		
		int totalCertify = 0; // 총 인증횟수
		
		if (getDay == 1 || getDay == 2 || getDay == 3 || getDay == 4 || getDay == 5) {
			// 시작날 요일이 평일부터 시작했을 경우 / 평일에 시작했으니 평일과 매일만 시작날짜를 더해줌
			
			switch (fk_freq_type) {
				case "100": // 매일인 경우
					totalCertify += 7;
					break;
				case "101": // 평일인 경우
					totalCertify += 5;
					break;
				case "102":	// 주말인 경우
					totalCertify += 2;
					break;
				default:
					break;
			}
	    	
			totalCertify = totalCertify * Integer.parseInt(fk_during_type);
			
	    	if ( "100".equals(fk_freq_type) || "101".equals(fk_freq_type) ) {
	    		// 평일과 매일만 시작날짜를 더해줌
	    		totalCertify += 1;
	    	}
	    	
		}
		else {
			// 시작날 요일이 주말부터 시작했을 경우
			
			switch (fk_freq_type) {
				case "100": // 매일인 경우
					totalCertify += 7;
					break;
				case "101": // 평일인 경우
					totalCertify += 5;
					break;
				case "102":	// 주말인 경우
					totalCertify += 2;
					break;
				default:
					break;
			}
			
			totalCertify = totalCertify * Integer.parseInt(fk_during_type);
			
			if ( "100".equals(fk_freq_type) || "102".equals(fk_freq_type) ) {
	    		// 주말만 시작날짜를 더해줌
	    		totalCertify += 1;
	    	}
			
		}
		
		return totalCertify;
	}
	
}
