package org.closet.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import org.junit.Test;

public class JDBCDriverTest {
	
	private Connection conn;
	
	@Test
	public void testJDBCDriver() {
		
		String sql1 = 
				"insert into member"+
				"value(?,?,?,?,?,?,?,?,?,?)";
		
		String sql2 = 
				"insert into testTable"+
				"value(?,?,?)";
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/closet","clothes","clothespwd");
//			PreparedStatement pstmt = conn.prepareStatement(sql2);
//			
//			pstmt.setString(1, "testId"); //고객 아이디
//			pstmt.setString(2, "nameless"); //고객명
//			pstmt.setString(3, "testPwd"); //비밀번호
//			pstmt.setInt(4, 29); //연령
//			pstmt.setString(5, "남자"); //성별
//			pstmt.setString(6, "homeless"); //주소
//			pstmt.setInt(7, 97); //선호 사이즈
//			pstmt.setString(8, "black"); //선호 색상
//			pstmt.setString(9, "면"); //선호 옷감
//			pstmt.setString(10, "don't know"); //선호 브랜드
//			
//			pstmt.setString(1, "testid");
//			pstmt.setString(2, "testpwd");
//			pstmt.setString(3, "sdfsdfsdfsdfsdf");
//			
//			boolean result = pstmt.execute();
//			
//			if(result) {
//				System.out.println("데이터 베이스 연결 테스트 완료");
//			}else {
//				System.out.println("데이터 베이스 연결 실패");
//			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
