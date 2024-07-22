package org.sera.service;

import java.util.List;

import org.goods.domain.OrderVO;
import org.member.domain.MemberVO;
import org.member.domain.MileageVO;
import org.sera.domain.PostCodeVO;

public interface MemberService {
	
	public void insertJoin(MemberVO mvo) throws Exception;
	
	public MemberVO nickChk(String inputNickName) throws Exception;

	public MemberVO selectOnId(String user_id) throws Exception;

	public List<PostCodeVO> searchPostCode(PostCodeVO pvo) throws Exception;

	public MemberVO idSearch(MemberVO mvo) throws Exception;

	public MemberVO pwdSearch(MemberVO mvo) throws Exception;

	public void pwdChange(MemberVO mvo) throws Exception;

	public int memberModify(MemberVO mvo) throws Exception;

	public MemberVO loadAccount(String user_id) throws Exception;

	public MemberVO searchingAccount(String user_id) throws Exception;

	public int memberDelete(MemberVO mvo) throws Exception;

	public List<MileageVO> getMileage(String user_id) throws Exception;

}
