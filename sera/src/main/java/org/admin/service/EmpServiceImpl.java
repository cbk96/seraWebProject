package org.admin.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.admin.domain.EmployeeVO;
import org.admin.persistence.EmpPersistence;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class EmpServiceImpl implements EmpService {
	
	@Inject
	private EmpPersistence empPersistence;

	@Override
	public EmployeeVO selectOnId(String inputId) throws Exception {
		return empPersistence.selectOnId(inputId);
	}
	
	@Override
	public EmployeeVO nickChk(String inputNickName) throws Exception {
		return empPersistence.nickChk(inputNickName);
	}

	@Override
	public void insertJoin(EmployeeVO evo) throws Exception {
		empPersistence.insertJoin(evo);
	}

	@Override
	public List<EmployeeVO> getEmpList(Map<String, Object> searchKey) throws Exception {
		return empPersistence.getEmpList(searchKey);
	}
	@Override
	public int getEmpListAllCnt(Map<String, Object> searchKey) throws Exception {
		return empPersistence.getEmpListAllCnt(searchKey);
	}

	@Override
	public List<EmployeeVO> getEmpListSearch(Map<String, Object> searchKey) throws Exception {
		return empPersistence.getEmpListSearch(searchKey);
	}
	
	@Override
	public int getEmpListSearchAllCnt(Map<String, Object> searchKey) throws Exception {
		return empPersistence.getEmpListSearchAllCnt(searchKey);
	}

	@Override
	public int adminApproval(EmployeeVO evo) throws Exception {
		return empPersistence.adminApproval(evo);
	}

	@Override
	public int empOneModify(EmployeeVO evo) throws Exception {
		return empPersistence.empOneModify(evo);
	}

	@Override
	public int empLeave(String emp_id) throws Exception {
		return empPersistence.empLeave(emp_id);
	}

	@Override
	public int empDelete(String emp_id) throws Exception {
		return empPersistence.empDelete(emp_id);
	}


}
