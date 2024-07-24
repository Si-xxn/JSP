<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String popupMode="on"; // 쿠키 제어용
	
	Cookie[]cookies = request.getCookies(); // 쿠키의 모든 정보를 배열로 가져옴
	if(cookies != null){
		for(Cookie c : cookies){ // 쿠키 배열에서 한개씩 가져옴
			String name = c.getName();	 // 배열에서 이름 가져옴
			String value = c.getValue(); // 배열에서 값 가져옴
			if(name.equals("popupClose")){
				popupMode = value; // on, off 
			}
		}
	}
%>    
    <!DOCTYPE html><html><head>
<meta charset="UTF-8"><title>PopupMain_v0.1.jsp : 쿠키를 활용한 팝업 제어 테스트</title>
</head>
<body>
	<!-- HTML(문서태그), CSS3, JavaScript -->
<style>
	div#popup{
		position: absolute; top:100px; left:50px; color:yellow;
		width:270px; height:100px; background-color:gray;
	}
	
	div#popup>div{ /* div 안쪽에 div style */
		position:relative; background-color: #ffffff;
		border:1px solid gray; padding: 10px; color: black;
	}
</style> <!-- CSS3 를 적용하는 블럭 : 색, 크키, 도형 -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<!-- 외부에서 제공하는 jquery 라이브러리 CDN -->
<!-- jquery : 자바스크립트를 조금 더 편하게 개선한 코드 -->
<script >
	$(function(){ /* jquery 기본 프레임 */
		$('#closeBtn').click(function(){ /* id가 closeBtn 객체를 클릭하면 -> 실행할 행동 작성 */
			$('#popup').hide(); /* id가 popup 객체를 숨김 */
				var chkval = $("input:checkbox[id=inactiveToday]:checked").val();
				/* input 태그에 checkbox 타입에 아이디가 inactiveToday가 체크 값을 확인 후 chkval 에 넣음 */
				
				$.ajax({ /* 비동기 코드로 현재 창을 유지하면서 데이터를 전달한다. */
					url : './PopupCookie.jsp',
					type : 'get',
					data : {inactiveToday : chkval},
					dataType : "text",
					success : function(resData){
						if(resData != ''){ // '' <- 비어있지않으면 
							location.reload();
						}
					}
				});
		});
	});
</script> <!-- JavaScript를 적용하는 블럭 : 동적문서 -->

	<h2> 팝업 메인 페이지 (V0.1)</h2>
	
	<%
		out.print("현재 팝업창은 "+popupMode + " 상태입니다.");
		if(popupMode.equals("on")){
	%>
	
	<div id="popup">
		<h2 align="center"> 공지사항 </h2>
		<div align="right">
			<form name="popFrm">
				<input type="checkbox" id="inactiveToday" value="1" />
				하루동안 열지 않음
				<input type="button" value="닫기" id="closeBtn" />
			</form>
		</div>
	</div><!-- 사각형 메모지 -->
	<%
		} 
	%>
</body>
</html>