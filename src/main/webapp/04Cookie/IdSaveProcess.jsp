<%@page import="utils.CookieManager"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	String save_check = request.getParameter("save_check");
	
	if("kkk".equals(user_id) && "1234".equals(user_pw)){
		// 아이디와 패스워드가 같은지 비교
		if(save_check != null && save_check.equals("Y")){
			// 아이디 저장하기 체크 확인
			CookieManager.makeCookie(response, "loginId", user_id, 86400);
			// 쿠키생성
		} else { // 체크 안되어있는 상태
			CookieManager.deleteCookie(response, "loginId");
		}
		JSFunction.alertLocation("로그인 성공", "IdSaveMain.jsp", out); // 로그인 성공 경고창 
		
	} else {
		// 아이디와 패스워드가 다르면
		JSFunction.alertBack("로그인 실패 - id / pw 확인해주세요.", out);
	}
%>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>IdSaveProcess.jsp : 로그인 처리(성공, 실패(판단) + 쿠키 + 경고창 처리)</title></head>
<body>

</body>
</html>