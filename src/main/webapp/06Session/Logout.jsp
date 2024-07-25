<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Logout.jsp : 로그인 세션 삭제</title>
</head>
<body>
	<%
		// 회원인증 정보 삭제(세션에 저장된 아이디와 이름을 제거)
		session.removeAttribute("UserId");
		session.removeAttribute("UserName");
		
		// 2. 모든 속성을 한번에 삭제(세션 자체 무효화)
		session.invalidate();
		
		response.sendRedirect("LoginForm.jsp");
	%>
</body>
</html>