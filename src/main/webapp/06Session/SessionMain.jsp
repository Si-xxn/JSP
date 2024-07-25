<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>SessionMain.jsp : web.xml 에서 설정한 session 정보 확인</title>
</head>
<body>
	<h2>Session 설정 확인</h2>
	<%
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm:SS"); // 시.분.초
		long creatingTime = session.getCreationTime(); // 세션을 만든 시간
		String creatingTimeSTR = simpleDateFormat.format(new Date(creatingTime)); // long -> String
		// 세션 생성 시간을 변수화 함 
		
		long lastTime = session.getLastAccessedTime(); // 마지막 요청 시간
		String lastTimeSTR = simpleDateFormat.format(new Date(lastTime)); // long -> String
		// 마지막으로 요청한 시간 변수화
	%> 
	<ul>
		<li>세션 유지 시간 : <%= session.getMaxInactiveInterval() %></li>
		<li>세션 이름 : <%= session.getId() %></li>
		<li>최초 세션 생성 시간 : <%= creatingTimeSTR %></li>
		<li>마지막 요청 시간 : <%=lastTimeSTR %></li>
	</ul>
</body>
</html>