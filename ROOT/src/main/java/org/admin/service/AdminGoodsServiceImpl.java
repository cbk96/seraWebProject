package org.admin.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.admin.domain.EmployeeVO;
import org.admin.persistence.AdminGoodsPersistence;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.springframework.stereotype.Service;

@Service
public class AdminGoodsServiceImpl implements AdminGoodsService {
	
	@Inject
	private AdminGoodsPersistence adminGoodsPersistence;

	@Override
	public List<GoodsVO> getGoodsListAll() throws Exception {
		return adminGoodsPersistence.getEmpListAll();
	}

	@Override
	public List<GoodsVO> getGoodsListDefault(Map<String, Object> searchKey) throws Exception {
		return adminGoodsPersistence.getGoodsListDefault(searchKey);
	}
	
	@Override
	public int getGoodsListDefaultCnt(Map<String, Object> searchKey) throws Exception {
		return adminGoodsPersistence.getGoodsListDefaultCnt(searchKey);
	}

	@Override
	public List<GoodsVO> getGoodsListSearch(Map<String, Object> searchKey) throws Exception {
		return adminGoodsPersistence.getGoodsListSearch(searchKey);
	}
	
	@Override
	public int getGoodsListSearchCnt(Map<String, Object> searchKey) throws Exception {
		return adminGoodsPersistence.getGoodsListSearchCnt(searchKey);
	}

	@Override
	public String getMaxprice(String priceRagneSelect) throws Exception {
		return adminGoodsPersistence.getMaxprice(priceRagneSelect);
	}

	@Override
	public List<CategoryVO> getCategoryList() throws Exception {
		return adminGoodsPersistence.getCategoryList();
	}

	@Override
	public CategoryVO getCategoryToId(GoodsVO gvo) throws Exception {
		return adminGoodsPersistence.getCategoryToId(gvo);
	}
	
	@Override
	public int goodsInsert(GoodsVO gvo) throws Exception {
		return adminGoodsPersistence.goodsInsert(gvo);
	}

	@Override
	public GoodsVO selectGoodsOne(String goodsId) throws Exception {
		return adminGoodsPersistence.selectGoodsOne(goodsId);
	}

	@Override
	public int goodsModify(GoodsVO gvo) throws Exception {
		return adminGoodsPersistence.goodsModify(gvo);
	}

	@Override
	public int goodsDelete(GoodsVO gvo) throws Exception {
		return adminGoodsPersistence.goodsDelete(gvo);
	}

	@Override
	public int goodsHardDelete(GoodsVO gvo) throws Exception {
		return adminGoodsPersistence.goodsHardDelete(gvo);
	}

	@Override
	public int goodsRestore(GoodsVO gvo) throws Exception {
		return adminGoodsPersistence.goodsRestore(gvo);
	}

}
