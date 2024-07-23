package org.admin.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.admin.domain.EmployeeVO;
import org.apache.ibatis.session.SqlSession;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.springframework.stereotype.Repository;

@Repository
public class AdminGoodsPersistenceImpl implements AdminGoodsPersistence {
	
	@Inject
	private SqlSession sql;
	
	public String namespace = "org.sera.mappers.adminGoods";

	@Override
	public List<GoodsVO> getEmpListAll() throws Exception {
		return sql.selectList(namespace+".getGoodsListAll");
	}

	@Override
	public List<GoodsVO> getGoodsListDefault(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getGoodsListDefault", searchKey);
	}
	
	@Override
	public int getGoodsListDefaultCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".getGoodsListDefaultCnt", searchKey);
	}

	@Override
	public List<GoodsVO> getGoodsListSearch(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getGoodsListSearch", searchKey);
	}
	
	@Override
	public int getGoodsListSearchCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".getGoodsListSearchCnt", searchKey);
	}

	@Override
	public String getMaxprice(String priceRagneSelect) throws Exception {
		Map<String, String> priceRagneSelectVal = new HashMap<String, String>();
		priceRagneSelectVal.put("priceRagneSelect", priceRagneSelect);
		
		return sql.selectOne(namespace+".getMaxprice", priceRagneSelectVal);
	}

	@Override
	public List<CategoryVO> getCategoryList() throws Exception {
		return sql.selectList(namespace+".getCategoryList");
	}

	@Override
	public CategoryVO getCategoryToId(GoodsVO gvo) throws Exception {
		return sql.selectOne(namespace+".getCategoryToId", gvo);
	}
	
	@Override
	public int goodsInsert(GoodsVO gvo) throws Exception {
		return sql.insert(namespace+".goodsInsert", gvo);
	}

	@Override
	public GoodsVO selectGoodsOne(String goodsId) throws Exception {
		return sql.selectOne(namespace+".selectGoodsOne", goodsId);
	}

	@Override
	public int goodsModify(GoodsVO gvo) throws Exception {
		return sql.update(namespace+".goodsModify", gvo);
	}

	@Override
	public int goodsDelete(GoodsVO gvo) throws Exception {
		return sql.update(namespace+".goodsDelete", gvo);
	}

	@Override
	public int goodsHardDelete(GoodsVO gvo) throws Exception {
		return sql.delete(namespace+".goodsHardDelete", gvo);
	}

	@Override
	public int goodsRestore(GoodsVO gvo) throws Exception {
		return sql.update(namespace+".goodsRestore", gvo);
	}


	

}
