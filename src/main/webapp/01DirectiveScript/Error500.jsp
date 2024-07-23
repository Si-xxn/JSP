<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage = "IsErrorPage.jsp" trimDirectiveWhitespaces="true" %>
    <!-- errorPage = "isErrorPage.jsp" 로 지시한다. -->
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<title>Error500.JSP -> 예외발생</title>
</head>
<body>
<%
//	try{
	int myAge = Integer.parseInt(request.getParameter("age")) + 10; // 현재나이 +10
	// request.getParameter("age") -> url 을 통한 매개값을 받는다.
	out.println("10년 후 당신의 나이는 "+myAge + " 입니다.");
//	} catch(Exception e) {
//		out.println("예외발생 : url 매개값을 확인하세요!");
//		out.println(" ?age = ??? ");
//	}
%>
</body>
</html>