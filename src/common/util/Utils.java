package common.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class Utils {

	/*
	 * MessageDigest : 단방향 암호화 지원함
	 * - 암호화된 문자열에서 원문을 추출할 수 없는 알고리즘
	 * 
	 * md5(사용불가)
	 * sha1(사용불가)
	 * 
	 * 뒤에 숫자가 클수록 좋다.
	 * sha256
	 * sha512
	 * 
	 * 문자열 -> byte배열 -> messageDigest 암호화 -> Base64로 인코딩(암호화된 문자열)
	 * 
	 * 
	 */
	public static String getEncryptedPassword(String password) {
		String encryptedPassword = null;
		
//		1. byte[]로 변환
		byte[] bytes = null; 
		try {
			bytes = password.getBytes("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
//		2. MessageDigest객체 생성
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("sha-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
//		3. MessageDigest객체를 통한 암호화
		md.update(bytes);
		byte[] encryptedBytes = md.digest(); //암호화
		
//		4.Base64인코더를 통한 인코딩
		Base64.Encoder encoder = Base64.getEncoder();
		encryptedPassword = encoder.encodeToString(encryptedBytes);
		
//		System.out.println("암호화/인코딩전:"+ new String(encryptedBytes));
//		System.out.println("암호화/인코딩처리후 :"+encryptedPassword);
		
		
		return encryptedPassword;
	}
	public static String getPageBarHtml0(int cPage, int numPerPage, int totalContents, String url) {
		String pageBar = "";
		int pageBarSize = 5;//페이지바에 표시될 페이지번호수를 가리킨다.
//		(공식2)
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
//		(공식3) pageStart 시작페이지번호 구하기
//		1 2 3 4 5 => pageStart =1
//		6 7 8 9 10 => pageStart =6
//		...
		int pageStart =((cPage-1)/pageBarSize) * pageBarSize+1;
		int pageEnd = pageStart + pageBarSize-1;
		
//		증감변수
		int pageNo = pageStart;
		
//		[이전] 영역
		if (pageNo==1) {
			
		}else {
			pageBar += "<a href='"+url+"cPage="+(pageNo-1)+"'>[이전]</a>";
		}
		
//		페이지번호 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
//			현재페이지인 경우
			if (pageNo == cPage) {
				pageBar += "<span class='cPage'>"+pageNo+"</span>";
			}else {
				pageBar += "<a href='"+url+"cPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
//		[다음] 영역
		if (pageNo > totalPage) {
			
		}else {
			pageBar += "<a href='"+url+"cPage="+pageNo+"'>[다음]</a>";
		}
		
		
		
		return pageBar;
	}
	
	public static String getPageBarHtml(int cPage, int numPerPage, int totalContents, String url, String hospId) {
		String pageBar = "";
		int pageBarSize = 5;//페이지바에 표시될 페이지번호수를 가리킨다.
//		(공식2)
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
//		(공식3) pageStart 시작페이지번호 구하기
//		1 2 3 4 5 => pageStart =1
//		6 7 8 9 10 => pageStart =6
//		...
		int pageStart =((cPage-1)/pageBarSize) * pageBarSize+1;
		int pageEnd = pageStart + pageBarSize-1;
		
//		증감변수
		int pageNo = pageStart;
		
//		[이전] 영역
		if (pageNo==1) {
			
		}else {
			pageBar += "<a href='"+url+"cPage="+(pageNo-1)+"&&hospId=" + hospId +"'>[이전]</a>";
		}
		
//		페이지번호 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
//			현재페이지인 경우
			if (pageNo == cPage) {
				pageBar += "<span class='cPage'>"+pageNo+"</span>";
			}else {
				pageBar += "<a href='"+url+"cPage="+pageNo+"&&hospId=" + hospId +"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
//		[다음] 영역
		if (pageNo > totalPage) {
			
		}else {
			pageBar += "<a href='"+url+"cPage="+pageNo+"&&hospId=" + hospId +"'>[다음]</a>";
		}
		
		
		
		return pageBar;
	}
	public static String getPageBarHtml2(int cPage, int numPerPage, int totalContents, String url) {
		String pageBar = "";
		int pageBarSize = 2;//페이지바에 표시될 페이지번호수를 가리킨다.
//		(공식2)
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
//		(공식3) pageStart 시작페이지번호 구하기
//		1 2 3 4 5 => pageStart =1
//		6 7 8 9 10 => pageStart =6
//		...
		int pageStart =((cPage-1)/pageBarSize) * pageBarSize+1;
		int pageEnd = pageStart + pageBarSize-1;
		
//		증감변수
		int pageNo = pageStart;
		
//		[이전] 영역
		if (pageNo==1) {
			
		}else {
			pageBar += "<a href='"+url+"cPage="+(pageNo-1)+"'><svg xmlns=\"http://www.w3.org/2000/svg\"\r\n" + 
					"				xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"7px\" height=\"11px\">\r\n" + 
					"                    <path fill-rule=\"evenodd\" fill=\"rgb(55, 59, 68)\"\r\n" + 
					"					d=\"M0.818,4.634 C1.177,4.275 1.758,4.275 2.117,4.634 L6.014,8.531 C6.372,8.889 6.372,9.471 6.014,9.830 C5.655,10.188 5.074,10.188 4.715,9.830 L0.818,5.933 C0.459,5.574 0.459,4.993 0.818,4.634 Z\" />\r\n" + 
					"                    <path fill-rule=\"evenodd\" fill=\"rgb(55, 59, 68)\"\r\n" + 
					"					d=\"M0.818,5.067 L4.715,1.170 C5.074,0.812 5.655,0.812 6.014,1.170 C6.372,1.529 6.372,2.110 6.014,2.469 L2.117,6.366 C1.758,6.725 1.177,6.725 0.818,6.366 C0.459,6.007 0.459,5.426 0.818,5.067 Z\" />\r\n" + 
					"                </svg>&nbspPrev</a>";
		}
		
//		페이지번호 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
//			현재페이지인 경우
			if (pageNo == cPage) {
				pageBar += "<span class='cPage' style='font-weight:bold; color:#9090b9; font-size:30px;'>"+pageNo+"</span>";
			}else {
				pageBar += "<a href='"+url+"cPage="+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
//		[다음] 영역
		if (pageNo > totalPage) {
			
		}else {
			pageBar += "<a href='"+url+"cPage="+pageNo+"'>Next<svg\r\n" + 
					"				xmlns=\"http://www.w3.org/2000/svg\"\r\n" + 
					"				xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"7px\" height=\"11px\">\r\n" + 
					"                    <path fill-rule=\"evenodd\" fill=\"rgb(55, 59, 68)\"\r\n" + 
					"					d=\"M6.026,6.397 C5.667,6.756 5.085,6.756 4.727,6.397 L0.830,2.500 C0.471,2.142 0.471,1.560 0.830,1.201 C1.189,0.843 1.770,0.843 2.129,1.201 L6.026,5.098 C6.384,5.457 6.384,6.038 6.026,6.397 Z\" />\r\n" + 
					"                    <path fill-rule=\"evenodd\" fill=\"rgb(55, 59, 68)\"\r\n" + 
					"					d=\"M6.026,5.964 L2.129,9.861 C1.770,10.220 1.189,10.220 0.830,9.861 C0.471,9.502 0.471,8.920 0.830,8.562 L4.727,4.665 C5.085,4.306 5.667,4.306 6.026,4.665 C6.384,5.024 6.384,5.605 6.026,5.964 Z\" />\r\n" + 
					"                </svg></a>";
		}
		
		return pageBar;
	}
	
}
