<%@page import="utils.JSFunction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../08Board/IsLoggedIn.jsp" %> <!-- 로그인 판단 -->
<%
	try{
		String saveDirectory = application.getRealPath("/Uploads"); // 가져올 폴더
		String saveFilename = request.getParameter("sName"); // 저장된 파일명
		String originalFilename = request.getParameter("oName"); // 원본 파일명
		
		// 하드디스크에 있는 파일을 찾아와야함
		File file = new File(saveDirectory, saveFilename); // 경로와 파일명으로 객체 생성
		InputStream inputStream = new FileInputStream(file); // byte 형식으로 객체 생성
		
		// 윈도우용(ksc5601), 리눅스용(utf-8), 유닉스용(utf-8)
		String client = request.getHeader("User-Agent");
		if(client.indexOf("WOW64") == -1){ // 웹 브라우저 판단
			originalFilename = new String(originalFilename.getBytes("UTF-8"), "iso-8859-1"); // 리눅스나 유닉스용
			// 리눅스, 유닉스(크롬 브라우저, 파이어폭스, 모질라)
		}else {
			originalFilename = new String(originalFilename.getBytes("ksc5601"), "iso-8859-1"); // 윈도우용
			// 윈도우 (ie = internet explorer)
		}
		
		// 파일 다운로드용 응답 헤더 설정
		response.reset(); // 초기화(보안)
		response.setContentType("application/octet-stream"); // 8비트씩 처리(1byte)
		response.setHeader("Content-Disposition", "attachment; filename=\""+originalFilename+"\"");
		// 응답헤더에 파일 명 보냄
		response.setHeader("Content-Length", ""+file.length());
		// 응답헤더에 파일 크기 보냄
		out.clear(); // 출력스트림 초기화
		
		
		// 출력스트림에 파일 내용 출력
		OutputStream outputStream = response.getOutputStream(); // 출력 객체 응답헤더에 생성
		
		byte b[] = new byte[(int)file.length()]; // 파일의 크기만큼 배열 생성
		int readBuffer = 0;
		while((readBuffer = inputStream.read(b)) > 0){
			outputStream.write(b, 0, readBuffer);
		}
		inputStream.close();
		outputStream.close();	
	} catch(FileNotFoundException e){
		JSFunction.alertBack("파일을 찾을 수 없습니다.", out);
	} catch(Exception e){
		JSFunction.alertBack("다운로드 중 예외발생 관리자에게 문의하세요.", out);
	}
%>         
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Download.jsp : 첨부파일 다운로드 process</title>
</head>
<body>
</body>
</html>