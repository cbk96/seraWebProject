package org.closet.persistence;

import java.sql.Connection;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class DataSourceTest {
	
	@Inject
	private DataSource dataSource;
	
	@Test
	public void testDataSource() {
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			
			System.out.println("root-context.xml으로 DataSource 객체 생성하여 스프링 빈 등록 완료");
			conn.close();
		}catch(Exception e) {
			
		}
	}

}
