package com.sist.haebollangce.common;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.stereotype.Component;

//=== #185. Spring Scheduler(스프링스케줄러5) === //
//=== Spring Scheduler(스프링스케줄러)를 사용한 email 발송하기 === 
//=== email 을 보내주는 클래스 생성하기 ===
@Component  // bean 으로 올리는 것임
public class GoogleMail {

    // ==== Spring Scheduler(스프링 스케줄러)를 사용한 email 발송하기 예제 ==== //
    public void sendmail_Reservation(String recipient, String emailContents) throws Exception {
           
       // 1. 정보를 담기 위한 객체
       Properties prop = new Properties(); 
       
       // 2. SMTP 서버의 계정 설정
          //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
       prop.put("mail.smtp.user", ""); // 자기꺼 넣기
           
       
       // 3. SMTP 서버 정보 설정
       //    Google Gmail 인 경우  smtp.gmail.com
       prop.put("mail.smtp.host", "smtp.gmail.com");
       
       prop.put("mail.smtp.port", "465");
       prop.put("mail.smtp.starttls.enable", "true");
       prop.put("mail.smtp.auth", "true");
       prop.put("mail.smtp.debug", "true");
       prop.put("mail.smtp.socketFactory.port", "465");
       prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
       prop.put("mail.smtp.socketFactory.fallback", "false");
       
       prop.put("mail.smtp.ssl.enable", "true");
       prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
         
       
       Authenticator smtpAuth = new MySMTPAuthenticator();
       Session ses = Session.getInstance(prop, smtpAuth);
          
       // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
       ses.setDebug(true);
               
       // 메일의 내용을 담기 위한 객체생성
       MimeMessage msg = new MimeMessage(ses);

       // 제목 설정
       String subject = "localhost:9090/board/ 방문 예약일자를 알려드립니다.";
       msg.setSubject(subject);
               
       // 보내는 사람의 메일주소
       String sender = "";  // 자기꺼 넣기
       Address fromAddr = new InternetAddress(sender);
       msg.setFrom(fromAddr);
               
       // 받는 사람의 메일주소
       Address toAddr = new InternetAddress(recipient);
       msg.addRecipient(Message.RecipientType.TO, toAddr);
               
       // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
       msg.setContent("<div style='font-size:14pt;'>"+emailContents+"</div>", "text/html; charset=UTF-8");
               
       // 메일 발송하기
       Transport.send(msg);
       
    }// end of sendmail_Reservation(String recipient, String emailContents)------------------- 

    
    
   public void sendmail(String recipient, String certificationCode) throws Exception {
      
        // 1. 정보를 담기 위한 객체
        Properties prop = new Properties(); 
        
        
        // 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
        //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
        prop.put("mail.smtp.user", "");  // 자기꺼 넣기
        
        
        // 3. SMTP 서버 정보 설정
        //    Google Gmail 인 경우  smtp.gmail.com
        prop.put("mail.smtp.host", "smtp.gmail.com");
        
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.debug", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("mail.smtp.socketFactory.fallback", "false");
        
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
          
        
        Authenticator smtpAuth = new MySMTPAuthenticator();
        Session ses = Session.getInstance(prop, smtpAuth);
           
        // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
        ses.setDebug(true);
                
        // 메일의 내용을 담기 위한 객체생성
        MimeMessage msg = new MimeMessage(ses);

        // 제목 설정
        String subject = "localhost:9090/MyMVC/index.up 회원님의 비밀번호를 찾기위한 인증코드 발송";
        msg.setSubject(subject);
                
        // 보내는 사람의 메일주소
        String sender = ""; // 자기꺼 넣기
        Address fromAddr = new InternetAddress(sender);
        msg.setFrom(fromAddr);
                
        // 받는 사람의 메일주소
        Address toAddr = new InternetAddress(recipient);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
                
        // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
        msg.setContent("발송된 인증코드 : <span style='font-size:14pt; color:red;'>"+certificationCode+"</span>", "text/html;charset=UTF-8"); 
                
        // 메일 발송하기
        Transport.send(msg);
      
   }// end of public void sendmail(String recipient, String certificationCode)------
	
   // 결제 성공 후 메일 보내주기
	public void sendmail_OrderFinish(String recipient, String subject, String emailContent) throws Exception {
		// 1. 정보를 담기 위한 객체
	    Properties prop = new Properties(); 
	    
	    
	    // 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
	    //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
	    prop.put("mail.smtp.user", "sjsig23672367@gmail.com");  // 자기꺼 넣기
	    
	    
	    // 3. SMTP 서버 정보 설정
	    //    Google Gmail 인 경우  smtp.gmail.com
	    prop.put("mail.smtp.host", "smtp.gmail.com");
	    
	    prop.put("mail.smtp.port", "465");
	    prop.put("mail.smtp.starttls.enable", "true");
	    prop.put("mail.smtp.auth", "true");
	    prop.put("mail.smtp.debug", "true");
	    prop.put("mail.smtp.socketFactory.port", "465");
	    prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	    prop.put("mail.smtp.socketFactory.fallback", "false");
	    
	    prop.put("mail.smtp.ssl.enable", "true");
	    prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	      
	    
	    Authenticator smtpAuth = new MySMTPAuthenticator();
	    Session ses = Session.getInstance(prop, smtpAuth);
	       
	    // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
	    ses.setDebug(true);
	            
	    // 메일의 내용을 담기 위한 객체생성
	    MimeMessage msg = new MimeMessage(ses);
	
	    // 제목 설정
	    msg.setSubject(subject);
	            
	    // 보내는 사람의 메일주소
	    String sender = "sjsig23672367@gmail.com"; // 자기꺼 넣기
	    Address fromAddr = new InternetAddress(sender);
	    msg.setFrom(fromAddr);
	            
	    // 받는 사람의 메일주소
	    Address toAddr = new InternetAddress(recipient);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	            
	    // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
	    msg.setContent(emailContent, "text/html;charset=UTF-8"); 
	            
	    // 메일 발송하기
	    Transport.send(msg);
		
	}

	public void sendmail_challengeResult(String recipient, String content) throws Exception {
	      
        // 1. 정보를 담기 위한 객체
        Properties prop = new Properties(); 
        
        
        // 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
        //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
        prop.put("mail.smtp.user", "sjsig23672367@gmail.com");  // 자기꺼 넣기
        
        
        // 3. SMTP 서버 정보 설정
        //    Google Gmail 인 경우  smtp.gmail.com
        prop.put("mail.smtp.host", "smtp.gmail.com");
        
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.debug", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        prop.put("mail.smtp.socketFactory.fallback", "false");
        
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
          
        
        Authenticator smtpAuth = new MySMTPAuthenticator();
        Session ses = Session.getInstance(prop, smtpAuth);
           
        // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
        // ses.setDebug(true);
                
        // 메일의 내용을 담기 위한 객체생성
        MimeMessage msg = new MimeMessage(ses);

        // 제목 설정
        String subject = "[HAEBOLLANGCE] 금일의 종료된 챌린지 결과";
        msg.setSubject(subject);
                
        // 보내는 사람의 메일주소
        String sender = "sjsig23672367@gmail.com"; // 자기꺼 넣기
        Address fromAddr = new InternetAddress(sender);
        msg.setFrom(fromAddr);
                
        // 받는 사람의 메일주소
        Address toAddr = new InternetAddress(recipient);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
                
        // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
        msg.setContent(content, "text/html;charset=UTF-8"); 
                
        // 메일 발송하기
        Transport.send(msg);
      
   }
	

}