<%@page import="model1_board.BoardDAO"%>
<%@page import="model1_board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
	String num = request.getParameter("num"); // 삭제 번호

	BoardDTO boardDTO = new BoardDTO(); // 빈객체
	BoardDAO boardDAO = new BoardDAO(application);
	boardDTO = boardDAO.selectView(num); // 번호로 객체 가져와 DTO 에 삽입
	
	String sessionId = session.getAttribute("UserId").toString(); // 로그인 이름
	
	int delResult = 0; // 삭제 성공 여부 판단 1 = 성공 | 0 = 실패
	
	if(sessionId.equals(boardDTO.getId())) { // 사용자 일치 확인
		// 일치 O
		boardDTO.setNum(num);
		delResult = boardDAO.deletePost(boardDTO); // 결과 받음
		boardDAO.close();
		if(delResult == 1){
			// 삭제 성공
			JSFunction.alertLocation("삭제 완료", "List.jsp", out);
		}else {
			JSFunction.alertBack("삭제 실패", out);
			return;
		}
	} else {
		// 일치X
		JSFunction.alertBack("본인만 사용 가능한 기능입니다.", out);
		return;
	}
%>    
<title>DeleteProcess.jsp : 삭제 처리(form X)</title>
