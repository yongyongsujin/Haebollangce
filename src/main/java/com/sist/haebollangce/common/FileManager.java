package com.sist.haebollangce.common;



import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Calendar;



import org.springframework.stereotype.Component;

// === #154. FileManager 클래스 생성하기 === 
@Component 
public class FileManager {

	// == 파일 업로드 하기 첫번째 방법 ==
	// byte[] bytes : 파일의 내용물
    // String originalFilename : 첨부된 파일의 원래이름
	// String path : 업로드 할 파일의 저장경로
	// 리턴값 : 서버에 저장된 새로운 파일명(예: 2023051909271535243254235235234.png)
	public String doFileUpload(byte[] bytes, String originalFilename, String path) throws Exception {
		
		String newFilename = null;
		
		if(bytes == null) {
			return null;
		}
		
		// 클라이언트가 업로드한 파일의 이름
		if("".equals(originalFilename) || originalFilename == null) {
			return null;
		}
		
		// 확장자(예:  강아지   또는   강아지.  또는   강아지.png   또는   강.아.지.png)
		// 강아지.       ==>  originalFilename.lastIndexOf(".")  ==> 3
		// 강아지.png   ==> originalFilename.lastIndexOf(".") ==> 3
		// 강.아.지.png ==> originalFilename.lastIndexOf(".") ==> 5
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf(".")); 
		if(fileExt == null || "".equals(fileExt) || ".".equals(fileExt)) {
			return null;
		}
		
		// 서버에 저장할 새로운 파일명을 만든다.
		// 서버에 저장할 새로운 파일명이 동일한 파일명이 되지 않고 고유한 파일명이 되도록 하기 위해
		// 현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		// newFilename 은 예를 들면, 2023051909271535243254235235234.png 와 같이 된다.   
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성한다.
		File dir = new File(path);
		// 파라미터로 입력받은 문자열인 path(파일을 저장할 경로)를 실제 폴더로 만든다.
		// 자바에서는 File 클래스를 사용하여 폴더 또는 파일을 생성 및 관리를 하게 된다. 
		
		if(!dir.exists()) {
			// 만약에 파일을 저장할 경로인 폴더가 실제로 존재하지 않는다면 
			
			dir.mkdirs(); // 파일을 저장할 경로인 폴더를 생성한다.
		}
		
		String pathname = path + File.separator + newFilename;
		                      // File.separator 은 운영체제에서 사용하는 파일경로의 구분자 이다.
                              // 운영체제가 Windows 이라면 File.separator 은 "\" 이고,
                              // 운영체제가 UNIX 또는 Linux 이라면 File.separator 은 "/" 이다.
        // 해당경로에 \ 를 더하고 파일명을 더한 경로까지 나타내어준 파일명(문자열)을 만든다. 
		// pathname 은 예를 들면, C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files\2023051909271535243254235235234.png 이다.      
		
		FileOutputStream fos = new FileOutputStream(pathname);
		// FileOutputStream 는 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 클래스 이다.
		// 이러한 일을 하는 FileOutputStream 객체 fos 를 생성한다.
		
		fos.write(bytes);
		// write(byte[] bytes) 메소드가 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 일을 하는 것이다. 
		
		fos.close();
		// 생성된 FileOutputStream 객체 fos 가 더이상 사용되지 않도록 소멸 시킨다.
		
		return newFilename;
		// 파일을 업로드 한 이후에 
		// 업로드 되어진 파일명(현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든것)을 알아온다.
	}
	
	
	// == 파일 업로드 하기 두번째 방법(네이버 스마트 에디터를 사용한 사진첨부에 해당하는 것임) ==
	public String doFileUpload(InputStream is, String originalFilename, String path) throws Exception {
		
		String newFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null || originalFilename.equals(""))
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists())
			dir.mkdirs();
		
		String pathname = path + File.separator + newFilename;
		
		byte[] byteArr = new byte[1024];
		int size = 0;
		FileOutputStream fos = new FileOutputStream(pathname);
		
		while((size = is.read(byteArr)) != -1) {
			fos.write(byteArr, 0, size);
		}
		fos.flush();
		
		fos.close();
		is.close();
		
		return newFilename;
	}
	
}






