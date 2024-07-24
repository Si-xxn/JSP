<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!DOCTYPE html><html><head>
<meta charset="UTF-8"><title>CookieResult.jsp : Main 에서 만든 쿠키값 확인</title>
</head>
<body>
	<h2> 쿠키 값 확인 해보기 </h2>
	<%
		Cookie cookie = new Cookie("myCookie", "쿠키는치토스가짱입니다.");
		// 							setName,	setValue
		cookie.setPath("/"); // = http://192.168.111.101:80/Board-JSP/
		//cookie.setPath(request.getContextPath()); // 컨텍스트 루트
		cookie.setMaxAge(3600); // 60초 * 60분 = 1시간
		response.addCookie(cookie);
		System.out.println(cookie.getPath());
		out.print("쿠키생성완료");
	
		Cookie cookie2 = new Cookie("yourCookie", "쿠키는초코가짱입니다.");
		// 							setName,	setValue
		//cookie.setPath("/"); // = http://192.168.111.101:80/Board-JSP/
		cookie2.setPath(request.getContextPath()); // 컨텍스트 루트
		cookie2.setMaxAge(3600); // 60초 * 60분 = 1시간
		response.addCookie(cookie2);
		System.out.println(cookie2.getPath());
		out.print("쿠키2생성완료");
	%>
</body>
</html>