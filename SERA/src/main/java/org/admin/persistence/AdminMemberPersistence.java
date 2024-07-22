package org.admin.persistence;

import java.util.List;
import java.util.Map;

import org.goods.domain.GoodsVO;
import org.member.domain.MemberVO;

public interface AdminMemberPersistence {

	public List<MemberVO> getMemberListDefault(Map<String, Object> searchKey) throws Exception;
	
	public int getMemberListDefaultCnt(Map<String, Object> searchKey) throws Exception;

	public List<MemberVO> memberListSearch(Map<String, Object> searchKey) throws Exception;
	
	public int memberListSearchCnt(Map<String, Object> searchKey) throws Exception;

	public int memberOneModify(MemberVO mvo) throws Exception;

	public int sleeperConver(String user_id) throws Exception;

	public int blacklistConver(String user_id) throws Exception;

}
