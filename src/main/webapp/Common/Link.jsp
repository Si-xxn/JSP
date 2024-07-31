<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Link.jsp : 페이지 위쪽에 자리를 잡는 메뉴 -->
<!-- includ용 파일은 기본 태그가 필요없다. -->

<table border="1" width="90%"> <!-- 테이블 시작 : 표의 두께 1, 가로 크기 90% 차지 -->
  <tr>	 <!-- 가로 1줄 시작 -->	
  	<!-- <th>제목 1칸 </th> -->
  	<!-- <td>내용 1칸 </td> -->
  	<td align="center"> <!-- 1칸 설정 : 가운데 정렬 -->
  		<!-- 로그인 상태 보고 로그인 | 로그아웃 글자 출력 -->
  		<%
  			if(session.getAttribute("UserId")==null) { /* 세션에 UserId 이름이 없다 -> 로그인 메뉴 */ %>
  				<a href="../06Session/LoginForm.jsp"> 로그인 </a>
  				
  				
  			<% } else { /* 세션에 UserId 이름이 있다 -> 로그아웃메뉴 */%>
  				<a href="../06Session/Logout.jsp"> 로그아웃 </a>
  				
  		 <% } %> <!-- 세션을 보고 로그인 | 로그아웃 처리 종료 -->
  		 
  		 <!-- 게시판 링크 추가 -->
  		 &nbsp;&nbsp;&nbsp;&nbsp; 
  		 <a href="../08Board/List.jsp"> 회원용게시판 </a>
  		 &nbsp;&nbsp;&nbsp;&nbsp;
  		 <a href="../12FileUpload/FileList.jsp"> 자료게시판 </a>
  		 &nbsp;&nbsp;&nbsp;&nbsp;
  		 <a href="../10Mvc/List.jsp"> 서블릿게시판 </a>
  		 &nbsp;&nbsp;&nbsp;&nbsp;
  		 <a href="../11Item/List.jsp"> 상품게시판 </a>
  		 &nbsp;&nbsp;&nbsp;&nbsp;
  	</td> 
  </tr>  <!-- 가로 1줄 종료 --> 	
</table> <!-- 테이블 끝 -->


