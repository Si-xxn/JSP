<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("pageInt", 8282); // page 영역에 값 저장(int)
	pageContext.setAttribute("pageStr", "엠비씨"); // page 영역에 값 저장(String)
	pageContext.setAttribute("PersonDTO", new Person("가나다", 10));
%>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>PageContextMain.jsp : 자바 DTO를 이용하여 객체 활용</title>
</head>
<body>
	<h2> PageContext 영역의 속성값 저장 </h2>
	
	<%
	int pageContextInt = (Integer)pageContext.getAttribute("pageInt");
	String pageContextSTR = (String)pageContext.getAttribute("pageStr");
	Person person = (Person)pageContext.getAttribute("PersonDTO");
	/* 위에서 만든 setAttribute를 가져옴 */
	%>
	<hr>
	<h2> PageContext 영역의 속성값 출력</h2>
	<ul>
		<li> 정수 객체 출력 : <%=pageContextInt %></li>
		<li> 문자열 객체 출력 : <%=pageContextSTR %> </li>
		<li> DTO 객체 출력 : <%=person.getName() %> <%=person.getAge() %></li>
	</ul>
</body>
</html>