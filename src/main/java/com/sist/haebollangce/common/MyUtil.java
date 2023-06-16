package com.sist.haebollangce.common;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
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
	
	
	// 시작시간과 종료시간을 받아와 현재시간과 비교하여 boolean을 리턴하는 함수
	public static boolean getTimeCompare(String hour_start, String hour_end) {
		
		boolean bool = false;
		
		String startHour = hour_start.substring(0,2);
		String startMin = hour_start.substring(3,5);
		
		String endHour = hour_end.substring(0,2);
		String endMin = hour_end.substring(3,5);
		
		LocalTime startTime = LocalTime.of(Integer.parseInt(startHour) , Integer.parseInt(startMin));
		LocalTime nowTime = LocalTime.now();
		LocalTime endTime = LocalTime.of(Integer.parseInt(endHour) , Integer.parseInt(endMin));
		
		if (startTime.isBefore(nowTime)) {
			
			if (endTime.isAfter(nowTime)) {
				bool = true;
			}
		}
		
		return bool;
	}
	
	
	// frequency 타입(평일, 주말)을 받아와 현재시간과 비교하여 boolean을 리턴하는 함수
	public static boolean getDateCompare(String fk_freq_type) {
		
		DayOfWeek currentDayOfWeek = LocalDate.now().getDayOfWeek();

		switch (fk_freq_type) {
			case "100":
				// 매일
				return true;
			case "101":
				// 평일 (월요일부터 금요일)
				return currentDayOfWeek != DayOfWeek.SATURDAY && currentDayOfWeek != DayOfWeek.SUNDAY;
			case "102":
				// 주말 (토요일 또는 일요일)
				return currentDayOfWeek == DayOfWeek.SATURDAY || currentDayOfWeek == DayOfWeek.SUNDAY;
			default:
				return false;
		}
		
	}
	
	
	// 시작기간과 챌린지 기간을 알아와 현재 진행중이면 boolean을 리턴하는 함수
	public static boolean DateChecker (String startDate, String fk_during_type) {
		LocalDate currentDate = LocalDate.now();
        LocalDate parsedStartDate = LocalDate.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        int fkDuringType = Integer.parseInt(fk_during_type);
        LocalDate calculatedEndDate = parsedStartDate.plusWeeks(fkDuringType);

        return (currentDate.isEqual(parsedStartDate) || currentDate.isEqual(calculatedEndDate) ||
                (currentDate.isAfter(parsedStartDate) && currentDate.isBefore(calculatedEndDate.plusDays(1))));
	}
	
}
