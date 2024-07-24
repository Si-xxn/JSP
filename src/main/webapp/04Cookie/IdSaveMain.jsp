<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String loginId = CookieManager.readCookie(request, "loginId"); // 내가 만든 쿠키관리자 자바 클래스 활용
	String cookieCheck = "";
	if(!loginId.equals("")){ // loginId 값에 빈 문자열 이외의 문자열을 저장
		cookieCheck = "checked";
		// 아이디 저장하기 체크박스에 체크가 되어있는지 판단
		
	}
%>    
    <!DOCTYPE html><html><head><meta charset="UTF-8">
<title>IdSaveMain.jsp : 쿠키를 이용한 ID 저장 및 경고창 테스트</title>
</head>
<body>
	<h2>로그인 페이지</h2>
	
	<form action="IdSaveProcess.jsp" method="post" >
		아이디 :   <input type="text" name="user_id" value="<%= loginId %>"/> 
		<input type="checkbox" name="save_check" value="Y"<%= cookieCheck %> />
		<br>
		패스워드 : <input type="password" name="user_pw"/>
		<br>
		
		<input type="submit" value="로그인" />
	</form>
</body>
</html>