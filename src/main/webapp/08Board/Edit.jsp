<%@page import="model1_board.BoardDTO"%>
<%@page import="model1_board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %> <!-- 로그인 판단 -->   
<%
	String num = request.getParameter("num");
	BoardDAO boardDAO = new BoardDAO(application);	
	BoardDTO boardDTO = boardDAO.selectView(num); // 객체로 내용 가져옴
	
	String sessionId = session.getAttribute("UserId").toString(); // 로그인 아이디 가져옴
	
	if(!sessionId.equals(boardDTO.getId())) { // 로그인 정보 불일치
		JSFunction.alertBack("작성자 본인만 수정 가능합니다.", out); // 경고창 + 이전페이지로 이동
		return;
	}
	boardDAO.close();
%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Edit.jsp : View.jsp 에 있는 객체 수정 폼</title>
<script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>
</head>
<body>
<jsp:include page="../Common/Link.jsp" />
<h2>회원제 게시판 - 글수정(Edit)</h2>
<form name="EditFrm" method="post" action="EditProcess.jsp"
      onsubmit="return validateForm(this);">
    <input type="hidden" name="num" value="<%=boardDTO.getNum() %>" /> <!-- 요청 값 히든처리 -->  
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" value="<%=boardDTO.getTitle() %>" /></td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;" ><%=boardDTO.getContent() %></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='List.jsp';">목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>