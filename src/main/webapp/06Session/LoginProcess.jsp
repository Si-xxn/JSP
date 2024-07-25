<%@page import="memberShip.MemberDTO"%>
<%@page import="memberShip.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>LoginProcess.jsp : Form 으로 받은 request 값 처리</title>
</head>
<body>
<!-- DTO 와 DAO 이용하여 로그인 처리 -->
	<%
		String userId=request.getParameter("user_id");
		String userPwd=request.getParameter("user_pw");
		// Form 에서 넘어온 데이터를 변수에 넣음
		
		// DAO 는 web.xml 2번째 생성자로 적용
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleURL");
		String id = application.getInitParameter("OracleId");
		String pwd = application.getInitParameter("OraclePwd");
		
		MemberDAO memberDAO = new MemberDAO(driver, url, id, pwd); // 1단계 2단계
		MemberDTO memberDTO = memberDAO.getMemberDTO(userId, userPwd); // 3단계 4단계
		
		memberDAO.close(); // 5단계
		// ID, PW 넣고 객체 받음 -> 성공 DTO | 실패 null
		
		// 성공 -> session | 실패 -> back(돌아감)
		
		if(memberDTO.getId() != null){
			// null X : DB에 정보가 있음
			session.setAttribute("UserId", memberDTO.getId());		// 세션에 id 넣음
			session.setAttribute("UserName", memberDTO.getName()); 	// 세션에 name 넣음
			/* session.setAttribute("lastLogin", session.getLastAccessedTime()); */
			response.sendRedirect("LoginForm.jsp");
		} else {
			// DB에 정보가 없음 
			request.setAttribute("LoginErrMsg", "ID 또는 PW 를 확인해주세요.");
			request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
		}
	%>
</body>
</html>