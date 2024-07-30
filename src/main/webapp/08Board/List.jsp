<%@page import="utils.BoardPage"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1_board.BoardDAO"%>
<%@page import="model1_board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 코드 순서 중요 -->
<%
	BoardDAO boardDAO = new BoardDAO(application);

	//검색 조건에 대한 변수 선언 -> Map<String, Object>
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	if(searchWord != null) { // 검색어가 있는 조건
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	// (페이징 처리 1단계)
	int totalCount = boardDAO.selectCount(param); // 검색 조건을 파라미터로 DAO 로 감 -> 게시물 수 int 타입으로 받음	

	// 전체 페이지 수 계산
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE")); // 페이지에 출력되는 리스트 개수 10 개
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK")); // 한 화면에 보여지는 블럭 수 5 개
	//out.println(pageSize + " "+ blockPage);
	int totalPage = (int)Math.ceil((double)totalCount/pageSize); // 총 페이지 수
	// 총 페이지 수 : 11 <- Math.ceil(올림) <-  10.5 <- 105 / 10 | (페이징 처리 3단계)
	
	// 현재 페이지 코드
	int pageNum=1;
	String pageTemp = request.getParameter("pageNum"); // List.jsp?pageNum=?
	if(pageTemp != null && !pageTemp.equals("")){ // url 로 넘어온 값이 있다의 조건
		pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 적용
		
	}
	
	// 목록에 출력 할 게시글 범위 계산 (페이징처리 2단계)
	int start = (pageNum-1) * pageSize + 1; // 첫 게시물 번호
	int end = pageNum * pageSize; // 마지막 게시물 번호
	
	param.put("start", start);
	param.put("end", end); // Map 을 통해 검색 조건과 같은 타입으로 전달
	
	List<BoardDTO> boardLists = boardDAO.selectList(param); // 검색 조건을 파라미터로 DAO 로 감 -> 결과 list로 받음
	// searchField , searchWord , start , end -> map 으로 전달
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
			
			int virtualNum =0;	// 가상번호 -> 화면 출력용
			int countNum=0;		// 페이징 처리용 번호
			
			for(BoardDTO dto : boardLists){ // DAO 에서 받은 결과 리스트
//				virtualNum = totalCount--; // 게시글 총 개수

			virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
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
		<tr align="center">
			<td>
				<%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
			</td>
			<td>
				<button type="button" onclick="location.href='Write.jsp';">게시글작성</button>
			</td>
		</tr>
	</table>
	
</body>
</html>