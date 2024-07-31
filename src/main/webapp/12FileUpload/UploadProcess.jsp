<%@page import="file_upload.MyFileDAO"%>
<%@page import="file_upload.MyFileDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<!-- cos.jar -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* method="post" enctype="multipart/form-data" 처리 */
	/* cos.jar 필요요소 4가지 : request, 저장경로, 단일파일크기, 인코딩  */
	
	// 1단계 : cos.jar 연결
	try {
		String saveDirectory = application.getRealPath("/Uploads");
		// 저장 디렉토리 -> http://192.168.111.101:80/Board-JSP/Uploads
		int maxPostSize = 1024 * 1024 * 100; // 파일 최대크기(100메가바이트 | kb * mb * gb)
		String encoding = "UTF-8";
	
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		System.out.println("saveDirectory : " + saveDirectory);
		System.out.println("maxPostSize : " + maxPostSize);
	
		// 2단계 : ofile, sfile 결정
		String fileName = mr.getFilesystemName("attachedFile"); // 현재 파일 이름
		System.out.println("fileName : " + fileName);
		String ext = fileName.substring(fileName.lastIndexOf(".")); // 파일 확장자
		System.out.println("ext : " + ext);
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		System.out.println("now : " + now);
		String newFileName = now + ext; // 새로운 파일 이름("업로드일시.확장자")
		System.out.println("newFileName : " + newFileName);
	
		// 3. 파일명 변경
		File oldFile = new File(saveDirectory + File.separator + fileName);
		System.out.println("oldFile : " + oldFile);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		System.out.println("newFile : " + newFile);
		oldFile.renameTo(newFile);
		System.out.println("oldFile : " + oldFile);
	
		// 4. 파일 업로드 메인에서 넘어온 폼 값 처리
		String name = mr.getParameter("name"); // 작성자
		String title = mr.getParameter("title"); // 제목
		String[] cateArray = mr.getParameterValues("cate");
	
		StringBuffer cateBuf = new StringBuffer();
		if (cateArray == null) {
			cateBuf.append("선택 없음");
		} else {
			for (String s : cateArray) {
		cateBuf.append(s + ", ");
			} // 사진, 과제 <- 이런 형태로 출력(StringBuffer)
		}
	
		// 5 단계 -> DTO 에 4번 값 넣기
		MyFileDTO dto = new MyFileDTO();
		dto.setName(name);
		dto.setTitle(title);
		dto.setCate(cateBuf.toString());
		dto.setOfile(fileName);
		dto.setSfile(newFileName);
	
		// 6. DAO 통해서 데이터베이스에 반영
		MyFileDAO dao = new MyFileDAO();
		dao.insertFile(dto);
		dao.close();
	
		// 7. 파일 목록 JSP로 리디렉션
		response.sendRedirect("FileList.jsp");
	} catch (Exception e) {
		System.out.println("UploadProcess.jsp 예외발생");
		e.printStackTrace();
		request.setAttribute("ErrorMsg", "파일 업로드 오류");
		request.getRequestDispatcher("FileUploadMain.jsp").forward(request, response);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UploadProcess.jsp : cos.jar 활용하여 파일 처리 및 DAO 연결</title>
</head>
<body>

</body>
</html>