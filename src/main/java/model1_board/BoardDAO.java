package model1_board;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class BoardDAO extends JDBConnect {
	// 생성자를 이용해서 1단계 2단계 처리
	
	public BoardDAO(ServletContext application) {
		super(application); // 3번째 방법 JDBC 연결
	}
	
	// board 테이블의 게시물 개수를 알아야함
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 리턴 값
		
		// 3단계 쿼리문 작성
		String query = "select count(*) from board ";
		if(map.get("searchWord")!= null) {
			// 검색어 O
			query += "where " + map.get("searchField") + " like '%"+map.get("searchWord")+"%'";
			// searchField : 제목, 내용, 작성자(Object)
			// searchWord : input="text" 로 넘어온 글자.
			// select count(*) from board where 제목 like '%딸기%';
		} // 검색어 조건 추가
		
		// 4단계 : 실행
		try {
			statement = connection.createStatement(); // 쿼리문 연결
			
			resultSet = statement.executeQuery(query); // 쿼리문 실행 후 결과 표로 받음
			resultSet.next(); // 
			totalCount=resultSet.getInt(1); // 첫번째 컬럼 값 totalCount 삽입
			System.out.println(totalCount);
		} catch (SQLException e) {
			System.out.println("BoardDAO.selectCount 메서드 오류");
			System.out.println("게시물 개수를 구하는 오류 발생");
//			e.printStackTrace();
		}
		
		
		return totalCount;
	}
	
	// 게시물의 리스트
	public List<BoardDTO> selectList(Map<String, Object> map){
		List<BoardDTO> listBoardDTO = new Vector<BoardDTO>();
		// 3단계
		String query = "select * from board ";
		if(map.get("searchWord")!= null) {
			// 검색어 O
			query += "where " + map.get("searchField") + " like '%"+map.get("searchWord")+"%'";
			// searchField : 제목, 내용, 작성자(Object)
			// searchWord : input="text" 로 넘어온 글자.
			// select count(*) from board where 제목 like '%딸기%';
		} // 검색어 조건 추가
		query += "order by num desc"; // 내림차순 정렬
		// 3단계 쿼리문 완성
		
		// 4단계 : 실행
		try {
			statement = connection.createStatement(); // 쿼리문 연결
			
			resultSet = statement.executeQuery(query); // 쿼리문 실행 후 결과 표로 받음
			while(resultSet.next()) {
				BoardDTO boardDTO = new BoardDTO();
				boardDTO.setNum(resultSet.getString("num"));
				boardDTO.setId(resultSet.getString("id"));
				boardDTO.setTitle(resultSet.getString("title"));
				boardDTO.setContent(resultSet.getString("content"));
				boardDTO.setPostdate(resultSet.getDate("postdate"));
				boardDTO.setVisitcount(resultSet.getString("visitcount")); // 객체에 값 삽입 완료
				// name 필드 null
				
				listBoardDTO.add(boardDTO); // boardDTO 객체 list 객체에 추가
			} // while 종료
			
			
			
		} catch (SQLException e) {
			System.out.println("BoardDAO.selectList 메서드 오류");
			System.out.println("board 테이블 모든 리스트 출력 오류");
//			e.printStackTrace();
		}
			
		
		
		return listBoardDTO;
	}
	// 게시글 등록용 메서드
	public int insertWrite(BoardDTO dto) {
		int result=0;
		// 3단계
		try {
			String query = "insert into board (num, title, content, id, visitcount) values(seq_board_num.nextval, ?, ?, ?, 0)";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, dto.getTitle());
			preparedStatement.setString(2, dto.getContent());
			preparedStatement.setString(3, dto.getId());
			result = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO.insertWrite 메서드 예외발생");
			System.out.println("쿼리문 확인하세요");
			e.printStackTrace();
		}
		if(result > 0) {
			
		}
		return result;
	}
	
	// 게시글에 제목을 클릭했을 때 상세보기 페이지
	public BoardDTO selectView(String num) {
		// 메서드 호출 시 입력 num (boardk_pk) 받고 가져온 데이터를 BoardDTO 객체에 넣어 리턴
		BoardDTO viewDTO = new BoardDTO();
		
		// 쿼리문 생성 / member PK -> board FK
//		String query = "select * from board where num=? "; // 작성자 판단 불가능
//		member 에 있는 작성자를 가져올 수 있도록 join 처리
		String query = "select B.*, M.name from member M inner join board B on M.id = B.id where num=? ";
		// member 테이블의 별칭 : M / board 테이블의 별칭 : B 선언
		// 부모 테이블 M inner join 으로 B를 이용 -> ID가 같은 자료를 찾는다.(M.id = B.id) 
		// 조건 : 파라미터로 받은 BNO 이용 / 찾아온 값은 board 테이블의 모든 것과 member 테이블의 name 필드 가져옴 -> DTO에 name 필드 추가
		
		try {
			preparedStatement = connection.prepareStatement(query); // 객체 생성
			
			preparedStatement.setString(1, num); 
			
			resultSet = preparedStatement.executeQuery(); // 쿼리 실행 후 표로 결과 받음
			
			if(resultSet.next()) {
				viewDTO.setNum(resultSet.getString("num"));
				viewDTO.setTitle(resultSet.getString("title"));
				viewDTO.setContent(resultSet.getString("content"));
				viewDTO.setPostdate(resultSet.getDate("postdate"));
				viewDTO.setId(resultSet.getString("id"));
				viewDTO.setVisitcount(resultSet.getString("visitcount"));
				viewDTO.setName(resultSet.getString("name"));
				System.out.println(viewDTO.toString()); 
			}
		} catch (SQLException e) {
			System.out.println("BoardDAO.selectView 메서드 예외발생");
			System.out.println("쿼리문 확인하세요.");
			e.printStackTrace();
		}
		
		return viewDTO;
	}
	
	public void updateVisitCount(String num) {
		// 리스트에서 제목을 클릭 했을 때 조회수 증가 코드
		// void 리턴은 resultSet 안씀.
		String query = "update board set visitcount = visitcount+1 where num=?";
		// 조건에 대한 visitCount 1씩 증가
		
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, num);
			
			preparedStatement.executeQuery(); // 실행만 하고 결과는 안 봄.
		} catch (SQLException e) {
			System.out.println("BoardDAO.updateVisitCount 예외발생 \n쿼리문 확인하세요.");
			e.printStackTrace();
		}
	}
	// 수정할 객체 받아서 성공시 1개의 값을 수정했다의 결과 리턴
	public int updateEdit(BoardDTO boardDTO) {
		int result=0;
		
		String query = "update board set title=?, content=? where num=?";
		
		try {
			preparedStatement = connection.prepareStatement(query);
			
			preparedStatement.setString(1, boardDTO.getTitle());
			preparedStatement.setString(2, boardDTO.getContent());
			preparedStatement.setString(3, boardDTO.getNum());
			
			result=preparedStatement.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO.updateEdit 예외 발생 \n쿼리문 확인");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 삭제 메서드 DTO 받아 삭제 후 int 로 리턴
	public int deletePost(BoardDTO boardDTO) {
		int result=0;
		
		String query = "delete from board where num=?";
		try {
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, boardDTO.getNum());
			
			result = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO.deletePost 예외 발생 \n쿼리문 확인");
			e.printStackTrace();
		}
		
		
		return result;
	}

}
