<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>web.xml JDBCTest.jsp : Application 영역을 활용한 접속테스트</title>
</head>
<body>
	<h2>JDBC 연결 테스트 (Application + JSP)</h2>
	<!-- 단점 : 매번 페이지마다 필수 코드가 있다.  -->
	<%
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleURL");
		String id = application.getInitParameter("OracleId");
		String pwd = application.getInitParameter("OraclePwd");
		
		
		JDBConnect jdbc = new JDBConnect(driver, url, id, pwd);
		/* 1단계 2단계 완성 */
		// 3(쿼리문 생성), 4(쿼리문 실행) 단계 진행
		// 5단계 (닫기) 진행

		jdbc.close();
	%>
</body>
</html>