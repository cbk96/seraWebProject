package org.sera.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.member.domain.MemberVO;
import org.member.domain.MileageVO;
import org.sera.domain.PostCodeVO;
import org.springframework.stereotype.Repository;

@Repository
public class MemberPersistenceImpl implements MemberPersistence {
	
	@Inject
	private SqlSession sql;
	
	private String namespace="org.sera.mappers.sera";

	@Override
	public void insertJoin(MemberVO mvo) throws Exception {
		sql.insert(namespace+".insertJoin", mvo);
		System.out.println("per test");
	}
	
	@Override
	public MemberVO nickChk(String inputNickName) {
		return sql.selectOne(namespace+".nickChk", inputNickName);
	}
	
	@Override
	public MemberVO selectOnId(String user_id) throws Exception {
		return sql.selectOne(namespace+".selectOnId", user_id);
	}

	@Override
	public List<PostCodeVO> searchPostCode(PostCodeVO pvo) throws Exception {
		System.out.println("pvo : "+pvo);
		System.out.println("pvo.getArea3 : "+pvo.getArea3());
		return sql.selectList(namespace+".searchPostCode",pvo);
	}

	@Override
	public MemberVO idSearch(MemberVO mvo) throws Exception {
		
		return sql.selectOne(namespace+".idSearch", mvo);
	}

	@Override
	public MemberVO pwdSearch(MemberVO mvo) throws Exception {
		
		return sql.selectOne(namespace+".pwdSearch", mvo);
	}

	@Override
	public void pwdChange(MemberVO mvo) throws Exception {
		sql.update(namespace+".pwdChange",mvo);
	}

	@Override
	public int memberModify(MemberVO mvo) throws Exception {
		return sql.update(namespace+".memberModify", mvo);
	}

	@Override
	public MemberVO loadAccount(String user_id) throws Exception {
		return sql.selectOne(namespace+".loadAccount",user_id);
	}

	@Override
	public MemberVO searchingAccount(String user_id) throws Exception {
		return sql.selectOne(namespace+".searchingAccount", user_id);
	}

	@Override
	public int memberDelete(MemberVO mvo) throws Exception {
		sql.delete(namespace+".memberCartDelete", mvo);
		sql.delete(namespace+".memberMileageDelete", mvo);
		return sql.delete(namespace+".memberDelete", mvo);
	}

	@Override
	public List<MileageVO> getMileage(String user_id) throws Exception {
		return sql.selectList(namespace+".getMileage",user_id);
	}

}
