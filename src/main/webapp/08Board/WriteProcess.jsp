<%@page import="utils.JSFunction"%>
<%@page import="model1_board.BoardDAO"%>
<%@page import="model1_board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="./IsLoggedIn.jsp" %> <!-- 로그인 여부 판단 -->

<%
	String title=request.getParameter("title");
	String content = request.getParameter("content"); // Write.jsp 에서 넘어온 값
	
	BoardDTO boardDTO = new BoardDTO(); // 빈 객체 생성
	boardDTO.setTitle(title);
	boardDTO.setContent(content);
	boardDTO.setId(session.getAttribute("UserId").toString()); // 세션 영역에 있는 값은 객체 - > to String()사용
	// 객체에 제목, 내용, 작성자 보관 완료
	
	// 3단계, 4단계
	BoardDAO boardDAO = new BoardDAO(application); // 1,2 단계
	int result = boardDAO.insertWrite(boardDTO); // 3,4 단계
//	int result=0;
//	for(int i = 1; i<100; i++){
//		boardDTO.setTitle(title+"-"+i);
//		result=boardDAO.insertWrite(boardDTO); // 글쓰기 한번에 100개 생성
//	}
	boardDAO.close();
	
	if(result == 1){
		// 성공
		response.sendRedirect("List.jsp");
	} else { // 실패
		JSFunction.alertBack("게시글 등록 실패 이전 페이지로 이동합니다.", out);
	}
	
%>