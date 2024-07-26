<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("UserId") == null){ // 로그인 안함
		JSFunction.alertLocation("로그인 후 이용 가능한 기능입니다.", "../06Session/LoginForm.jsp", out);
		return ;
	}
%>
