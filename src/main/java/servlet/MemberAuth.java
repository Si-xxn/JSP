package servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memberShip.MemberDAO;
import memberShip.MemberDTO;

// @WebServlet("/login.mbc") // http://localhost/Board-JSP/login.mbc
// web.xml 에 정보 작성
public class MemberAuth extends HttpServlet {
	// 서블릿을 사용한 로그인 처리 방법
	// DB에 있는 회원이면 방가방가 처리 
	// DB에 회원이 없으면 귀하는 회원이 아님 처리 
	// DB에 없지만 xml에 admin ID 가 있으면 최고 관리자 임을 출력 
	
	// 필드
	MemberDAO dao; // 회원용 JDBC
	@Override
	public void init() throws ServletException {
		// JDBC 1, 2단계 처리
		ServletContext application = this.getServletContext(); // 톰캣 web.xml 활용
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleURL");
		String id = application.getInitParameter("OracleId");
		String pw = application.getInitParameter("OraclePwd");
		
		dao = new MemberDAO(driver, url, id, pw);
	}
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		dao.close();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// JSP 에서 넘어온 id/pw 처리한다.
		String admin_id = this.getInitParameter("admin_id");
		// web.xml 에 있는 id 가져옴			 	kkk
		
		String id = req.getParameter("id");		// JSP 폼에서 넘어온 값	
		String pass = req.getParameter("pass"); 
		
		MemberDTO dto = dao.getMemberDTO(id, pass); // DAO 메서드 결과를 DTO 로 받음
		
		String memberId = dto.getId(); // 찾아온 객체의 아이디를 넣음
		
		if(memberId != null) {
			req.setAttribute("authMessage", dto.getName()+"님 방가방가");
		} else { // DB 에 정보가 없으면
			if(admin_id.equals(id)) {
				req.setAttribute("authMessage", admin_id + "관리자님 로그인 하셨습니다.");
			} else {
				req.setAttribute("authMessage", "귀하는 회원이 아닙니다. 가입 후 이용해주세요.");
			}
			
		}
		
		req.getRequestDispatcher("/13Servlet/MemberAuth.jsp").forward(req, resp);
		// 처리 후 응답을 보낼 주소와 객체를 전달한다.
		
		
		
	}
}
