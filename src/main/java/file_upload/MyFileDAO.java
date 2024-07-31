package file_upload;

import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import common.DBConnPool;

public class MyFileDAO extends DBConnPool { // 1, 2, 5단계 상속받음
	// JDBC 1 ~ 5단계 
	
	
	// 입력 메서드
		public int insertFile(MyFileDTO myFileDTO) {
			int result=0;
			
			String query="insert into myfile (idx, name, title, category, ofile, sfile) values(seq_board_num.nextval, ?, ?, ?, ?, ?)";
			
			try {
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, myFileDTO.getName());
				pstmt.setString(2, myFileDTO.getTitle());
				pstmt.setString(3, myFileDTO.getCate());
				pstmt.setString(4, myFileDTO.getOfile());
				pstmt.setString(5, myFileDTO.getSfile());
				
				result = pstmt.executeUpdate(); // 4단계 -> 정수리턴
			} catch (SQLException e) {
				System.out.println("MyFileDAO.insertFile 에러발생");
				e.printStackTrace();
			}
			
			
			return result;
		}
	
	// 출력 메서드
	public List<MyFileDTO> myFileLists (){
		List<MyFileDTO> fileList = new Vector<MyFileDTO>(); // 멀티 스레드
		
		String query = "select * from myfile order by idx desc"; // 모든 데이터 찾아옴(내림차순 정렬)
		try {
			pstmt = con.prepareStatement(query);
			
			rs = pstmt.executeQuery(); // 쿼리문 실행 -> 결과 출력 : 표
			
			while(rs.next()) {
				MyFileDTO dto = new MyFileDTO(); // 빈 객체 생성
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCate(rs.getString("category"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setPostdate(rs.getString("postdate")); // 빈객에체 삽입
				
				fileList.add(dto); // list 객체에 dto 삽입
				
			}
		} catch (SQLException e) {
			System.out.println("MyFileDAO.myFileLists(select) 예외 발생");
			e.printStackTrace();
		}
		
		return fileList; // 테이블에 있는 모든 값이 리스트 객체로 리턴
	}
	
	// 수정 메서드
	
	
	// 삭제 메서드
	
}
