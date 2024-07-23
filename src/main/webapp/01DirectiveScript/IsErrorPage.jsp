<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %> <!-- isErrorPage = "true" : 예외처리용 페이지임을 지시 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IsErrorPage.jsp : 예외 통합 처리</title>
</head>
<body>
	<h2>서비스 중 일시적인 예외가 발생하였습니다.</h2>
	<p>
	오류명 : <%= exception.getClass().getName() %> <br>
	오류메시지 : <%= exception.getMessage() %> <br>
	관리자 쳔락처 : 010-1111-1111 <br>
	오류 발생 제보시 사례 제공합니다. 감사합니다.
	</p>
	<!-- 페이지 예외 발생시 통합 처리용 -->
</body>
</html>