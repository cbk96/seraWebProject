package org.admin.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.admin.persistence.AdminMemberPersistence;
import org.member.domain.MemberVO;
import org.springframework.stereotype.Service;

@Service
public class AdminMemberServiceImpl implements AdminMemberService{
	
	@Inject
	private AdminMemberPersistence adminMemberPersistence;

	@Override
	public List<MemberVO> getMemberListDefault(Map<String, Object> searchKey) throws Exception {
		return adminMemberPersistence.getMemberListDefault(searchKey);
	}
	
	@Override
	public int getMemberListDefaultCnt(Map<String, Object> searchKey) throws Exception {
		return adminMemberPersistence.getMemberListDefaultCnt(searchKey);
	}

	@Override
	public List<MemberVO> memberListSearch(Map<String, Object> searchKey) throws Exception {
		return adminMemberPersistence.memberListSearch(searchKey);
	}
	
	@Override
	public int memberListSearchCnt(Map<String, Object> searchKey) throws Exception {
		return adminMemberPersistence.memberListSearchCnt(searchKey);
	}

	@Override
	public int memberOneModify(MemberVO mvo) throws Exception {
		return adminMemberPersistence.memberOneModify(mvo);
	}

	@Override
	public int sleeperConver(String user_id) throws Exception {
		return adminMemberPersistence.sleeperConver(user_id);
	}

	@Override
	public int blacklistConver(String user_id) throws Exception {
		return adminMemberPersistence.blacklistConver(user_id);
	}

}
