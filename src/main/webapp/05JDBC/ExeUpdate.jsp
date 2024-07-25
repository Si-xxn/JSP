<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>ExeUpdate.jsp</title>
</head>
<body>
	<h2>회원 추가 테스트</h2>
	<%
		JDBConnect jdbc = new JDBConnect();
		
		String id = "test1";
		String pw = "0000";
		String name = "테스트";
		
		String sql = "insert into member values (?, ?, ?, sysdate )";
		PreparedStatement prst = jdbc.connection.prepareStatement(sql);
		prst.setString(1, id);
		prst.setString(2, pw);
		prst.setString(3, name);
		int result = prst.executeUpdate();
		
		if(result > 0 ){
			out.println(result+"행이 입력되었습니다.");
		}
		
		jdbc.close();
	%>

</body>
</html>