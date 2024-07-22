package org.admin.persistence;

import java.util.List;
import java.util.Map;

import org.admin.domain.EmployeeVO;
import org.springframework.web.multipart.MultipartFile;

public interface EmpPersistence {

	EmployeeVO selectOnId(String inputId) throws Exception;
	
	EmployeeVO nickChk(String inputNickName) throws Exception;

	void insertJoin(EmployeeVO evo) throws Exception;

	List<EmployeeVO> getEmpList(Map<String, Object> searchKey) throws Exception;
	
	int getEmpListAllCnt(Map<String, Object> searchKey) throws Exception;

	List<EmployeeVO> getEmpListSearch(Map<String, Object> searchKey) throws Exception;
	
	int getEmpListSearchAllCnt(Map<String, Object> searchKey) throws Exception;

	int adminApproval(EmployeeVO evo) throws Exception;

	int empOneModify(EmployeeVO evo) throws Exception;

	int empLeave(String emp_id) throws Exception;

	int empDelete(String emp_id) throws Exception;

}
