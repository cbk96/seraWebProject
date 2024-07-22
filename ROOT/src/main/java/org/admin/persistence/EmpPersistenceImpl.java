package org.admin.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.admin.domain.EmployeeVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public class EmpPersistenceImpl implements EmpPersistence {
	
	@Inject
	private SqlSession sql;
	
	private String namespace = "org.sera.mappers.emp";

	@Override
	public EmployeeVO selectOnId(String inputId) throws Exception{
		return sql.selectOne(namespace+".selectOnId", inputId);
	}
	
	@Override
	public EmployeeVO nickChk(String inputNickName) throws Exception {
		return sql.selectOne(namespace+".nickChk", inputNickName);
	}

	@Override
	public void insertJoin(EmployeeVO evo) throws Exception {
		sql.insert(namespace+".insertJoin", evo);
	}
	
	@Override
	public List<EmployeeVO> getEmpList(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getEmpList", searchKey);
	}
	
	@Override
	public int getEmpListAllCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".getEmpListAllCnt", searchKey);
	}

	@Override
	public List<EmployeeVO> getEmpListSearch(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getEmpListSearch", searchKey);
	}
	
	@Override
	public int getEmpListSearchAllCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".getEmpListSearchAllCnt", searchKey);
	}

	@Override
	public int adminApproval(EmployeeVO evo) throws Exception {
		return sql.update(namespace+".adminApproval", evo);
	}

	@Override
	public int empOneModify(EmployeeVO evo) throws Exception {
		return sql.update(namespace+".empOneModify", evo);
	}

	@Override
	public int empLeave(String emp_id) throws Exception {
		return sql.update(namespace+".empLeave", emp_id);
	}

	@Override
	public int empDelete(String emp_id) throws Exception {
		return sql.delete(namespace+".empDelete", emp_id);
	}


}
