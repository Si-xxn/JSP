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

}
