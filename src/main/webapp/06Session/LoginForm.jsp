<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>LoginForm.jsp</title> <!-- 로그인 성공 -> 세션에 저장 / 로그인 실패 -> 돌아가기 -->
</head>
<body>
	<%-- <jsp:include page="../Common/Link.jsp" /> --%>
    <h2>로그인 페이지</h2>
    <span style="color: red; font-size: 1.2em;"> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg") %>
                <!-- 조건 : request 영역에 "loginErrMsg"가 있으면 ? true : false (삼항연산자)-->
    </span> <!-- span 태그 : 1 줄 글자 태그 -->
    <%
    if (session.getAttribute("UserId") == null) {  // 로그인 상태 확인 ~ 36행까지 true
        // 로그아웃 상태
    %> <!-- 로그인 스크립트 실행 -->
    <script>
    function validateForm(form) { // validateForm 호출 시 form 정보 받음(29~34행)
        if (!form.user_id.value) { // form 안에 user_id 값이 없으면(!) 
            alert("아이디를 입력하세요."); // 경고창 띄움
            return false; // false return | true 다음 조건 실행
        }
        if (form.user_pw.value == "") { // form 안에 user_pw 값이 비어있으면
            alert("패스워드를 입력하세요."); // 경고창 띄움
            return false; // false return | true action 실행
        }
    }
    </script> <!-- 1순위 : onsubmit 2순위 : action --> 
    <form action="LoginProcess.jsp" method="post" name="loginFrm"
        onsubmit="return validateForm(this);"> 
        <!-- onsubmit -> return true -> action -->
        아이디 : <input type="text" name="user_id" /><br />
        패스워드 : <input type="password" name="user_pw" /><br />
        <input type="submit" value="로그인하기" />
    </form>
    <%
    // 로그인 처리
    } else { // 로그인된 상태
    %>
        <%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br />
        <a href="Logout.jsp">[로그아웃]</a> <!-- session 제거 -->
    <%
    }
    %>
</body>
</html>