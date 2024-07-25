<%@page import="common.DBConnPool"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>ConnPool.jsp : 커넥션 풀 접속 테스트</title>
</head>
<body>
	<h2> 커넥션 풀 테스트 </h2>
	<p>커넥션 풀은 톰캣 서버가 관리한다. (context.xml, server.xml 을 이용한다.)</p>
	<%
		DBConnPool pool = new DBConnPool(); // 1단계, 2단계
		
		pool.close(); // 5단계
	%>
</body>
</html>