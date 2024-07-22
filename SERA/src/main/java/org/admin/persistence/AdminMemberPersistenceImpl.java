package org.admin.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.goods.domain.GoodsVO;
import org.member.domain.MemberVO;
import org.springframework.stereotype.Repository;

@Repository
public class AdminMemberPersistenceImpl implements AdminMemberPersistence {
	
	@Inject
	private SqlSession sql;
	
	public String namespace = "org.sera.mappers.adminMember";

	@Override
	public List<MemberVO> getMemberListDefault(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getMemberListDefault", searchKey);
	}
	
	@Override
	public int getMemberListDefaultCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".getMemberListDefaultCnt", searchKey);
	}

	@Override
	public List<MemberVO> memberListSearch(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".memberListSearch", searchKey);
	}
	
	@Override
	public int memberListSearchCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".memberListSearchCnt", searchKey);
	}

	@Override
	public int memberOneModify(MemberVO mvo) throws Exception {
		return sql.update(namespace+".memberOneModify", mvo);
	}

	@Override
	public int sleeperConver(String user_id) throws Exception {
		return sql.update(namespace+".sleeperConver", user_id);
	}

	@Override
	public int blacklistConver(String user_id) throws Exception {
		return sql.update(namespace+".blacklistConver", user_id);
	}

}
