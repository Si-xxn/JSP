<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../08Board/IsLoggedIn.jsp" %> <!-- 로그인 판단 -->    
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>FileUploadMain.jsp : 파일 업로드 테스트용</title>
</head>
<script>
    function validateForm(form) { 
        if (form.name.value == "") {
            alert("작성자를 입력하세요.");
            form.name.focus(); /* 커서이동 */
            return false;
        }
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.attachedFile.value == "") {
            alert("첨부파일은 필수 입력입니다.");
            return false;
        }
    }
</script>
<body>
<jsp:include page="../Common/Link.jsp"/> <!-- 상단메뉴 -->
    <h3>파일 업로드</h3>
    <span style="color: red;">${ ErrorMsg }</span> <!-- 에러 메시지 출력 -->
    <!-- enctype="multipart/form-data" : 파일 전송용 (post)-->
    <form name="fileForm" method="post" enctype="multipart/form-data"
          action="UploadProcess.jsp" onsubmit="return validateForm(this);">
        작성자 : <input type="text" name="name" value="" /><br />
        제목 : <input type="text" name="title" /><br /> 
        카테고리(선택사항) : 
            <input type="checkbox" name="cate" value="사진" checked />사진 <!-- 기본값 --> 
            <input type="checkbox" name="cate" value="과제" />과제 
            <input type="checkbox" name="cate" value="워드" />워드 
            <input type="checkbox" name="cate" value="음원" />음원 <br /> 
        첨부파일 : <input type="file" name="attachedFile" /> <br />
        <input type="submit" value="전송하기" />
    </form>
</body>
</html>