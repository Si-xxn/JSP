<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>ExeQuery.jsp</title>
</head>
<body>
	<h2>회원 목록 조회 테스트</h2>
	<%
		JDBConnect jdbc = new JDBConnect();
		
		String sql = "select * from member";
		PreparedStatement prst = jdbc.connection.prepareStatement(sql);
		
		ResultSet rs = prst.executeQuery();
		
		while(rs.next()){
			String id = rs.getString(1);
			String pw = rs.getString(2);
			String name = rs.getString(3);
			Date regidate = rs.getDate(4);
			out.println(String.format("이름 : %s  | ID : %s  | PW : %s  | Date : %s <br>", name, id, pw, regidate));
		}
		
		jdbc.close();
	%>
</body>
</html>