<%@page import="model1_board.BoardDAO"%>
<%@page import="model1_board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>

<%
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content"); // 폼 값 변수에 저장
	
	BoardDTO boardDTO = new BoardDTO();
	
	boardDTO.setNum(num);
	boardDTO.setTitle(title);
	boardDTO.setContent(content); // 빈객체 생성 후 값 저장
	
	BoardDAO boardDAO = new BoardDAO(application); // 1,2 단계
	int affected = boardDAO.updateEdit(boardDTO); // 3,4 단계
	
	boardDAO.close(); // 5단계
	
	// 성공 여부 결정
	
	if(affected == 1){
		// 성공
		response.sendRedirect("View.jsp?num="+boardDTO.getNum()); // View.jsp?num=4
	} else {
		// 실패
		JSFunction.alertBack("수정 실패", out); // 경고 출력 후 이전페이지로 이동
	}
%>    
<title>EditProcess.jsp : DTO를 받아 update 쿼리 처리</title>
