package org.sera.service;

import java.util.List;

import javax.inject.Inject;

import org.goods.domain.OrderVO;
import org.member.domain.MemberVO;
import org.member.domain.MileageVO;
import org.sera.domain.PostCodeVO;
import org.sera.persistence.MemberPersistence;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberPersistence memberPersistence;
	
	@Override
	public void insertJoin(MemberVO mvo) throws Exception {
		memberPersistence.insertJoin(mvo);
	}
	
	@Override
	public MemberVO nickChk(String inputNickName) throws Exception {
		return memberPersistence.nickChk(inputNickName);
	}
	
	@Override
	public MemberVO selectOnId(String user_id) throws Exception {
		return memberPersistence.selectOnId(user_id);
	}

	@Override
	public List<PostCodeVO> searchPostCode(PostCodeVO pvo) throws Exception {
		return memberPersistence.searchPostCode(pvo);
	}

	@Override
	public MemberVO idSearch(MemberVO mvo) throws Exception {
		
		return memberPersistence.idSearch(mvo);
	}

	@Override
	public MemberVO pwdSearch(MemberVO mvo) throws Exception {
		
		return memberPersistence.pwdSearch(mvo);
	}

	@Override
	public void pwdChange(MemberVO mvo) throws Exception {
		memberPersistence.pwdChange(mvo);
	}

	@Override
	public int memberModify(MemberVO mvo) throws Exception {
		return memberPersistence.memberModify(mvo);
	}

	@Override
	public MemberVO loadAccount(String user_id) throws Exception {
		return memberPersistence.loadAccount(user_id);
	}

	@Override
	public MemberVO searchingAccount(String user_id) throws Exception {
		return memberPersistence.searchingAccount(user_id);
	}

	@Override
	public int memberDelete(MemberVO mvo) throws Exception {
		return memberPersistence.memberDelete(mvo);
	}

	@Override
	public List<MileageVO> getMileage(String user_id) throws Exception {
		return memberPersistence.getMileage(user_id);
	}

}
