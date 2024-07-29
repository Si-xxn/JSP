<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1_board.BoardDAO"%>
<%@page import="model1_board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDAO boardDAO = new BoardDAO(application);
	
	// 검색 조건에 대한 변수 선언 -> Map<String, Object>
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	if(searchWord != null) { // 검색어가 있는 조건
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	
	List<BoardDTO> boardLists = boardDAO.selectList(param); // 검색 조건을 파라미터로 DAO 로 감 -> 결과 list로 받음
	int totalCount = boardDAO.selectCount(param); // 검색 조건을 파라미터로 DAO 로 감 -> 게시물 수 int 타입으로 받음
	boardDAO.close();
%>    
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>List.jsp : BoardDTO - BoardDAO 활용한 리스트 출력, 검색</title>
</head>
<body>
	<jsp:include page="../Common/Link.jsp"/> <!-- 상단메뉴 -->
	<!-- 검색 폼 -->
	<h2 align="center">회원제 게시판 - 목록보기(list.jsp)</h2>
	<form method="get">
		<table border="1" width="90%">
			<tr> <!-- 1 줄 -->
				<td align="center"> <!-- 1 칸 : 가운데 정렬 -->
					<select name="searchField"> <!-- 내림 목록 상자 -->
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="id"> ID </option>
					</select> <!-- 검색 필드 설정 -->
					
					<input type="text" name="searchWord" /> <!-- 검색 단어 -->
					<input type="submit" value="검색" /> <!-- 버튼 -->
					
				</td>
			</tr>
		</table>
	</form>
	<!-- boardList 메서드 활용 -->
	<table border="1" width="90%">
		<tr> <!-- 제목 한 줄 -->
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
		</tr> <!-- 제목행 끝 -->
	<!-- 목록 -->	
	<%
		if(boardLists.isEmpty()){ // DAO 에서 리스트로 나온 값이 비었을 때
	%>	
		<tr>
			<td colspan="5" align="center"> 등록된 게시글이 없습니다.</td>
		</tr>
	<%
		} else { // 등록된 게시물 있다의 조건
			
			int virtualNum =0; // 가상번호 -> 화면 출력용
			for(BoardDTO dto : boardLists){ // DAO 에서 받은 결과 리스트
				virtualNum = totalCount--; // 게시글 총 개수
	%>
		<tr>
			<td><%=virtualNum %></td>
			<td align="left">
			<a href="View.jsp?num=<%=dto.getNum() %>"> <!-- ?num=2 request.getParameter(num) -->
			<%=dto.getTitle() %></a></td>
			<td><%=dto.getId() %></td>
			<td><%=dto.getVisitcount() %></td>
			<td><%=dto.getPostdate() %></td>
		</tr>
	<%	
			} // for
		}// if
	%>		
	</table> <!-- 리스트 테이블 종료 -->
	<!-- 글쓰기 테이블 -->
	<table border="1" width="90%">
		<tr align="right">
			<td>
				<button type="button" onclick="location.href='Write.jsp';">게시글작성</button>
			</td>
		</tr>
	</table>
</body>
</html>