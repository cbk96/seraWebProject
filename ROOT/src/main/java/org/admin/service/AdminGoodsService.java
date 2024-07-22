package org.admin.service;

import java.util.List;
import java.util.Map;

import org.admin.domain.EmployeeVO;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;

public interface AdminGoodsService {
	
	public List<GoodsVO> getGoodsListAll() throws Exception;
	
	public List<GoodsVO> getGoodsListDefault(Map<String, Object> searchKey) throws Exception;
	
	public int getGoodsListDefaultCnt(Map<String, Object> searchKey) throws Exception;

	public List<GoodsVO> getGoodsListSearch(Map<String, Object> searchKey) throws Exception;
	
	public int getGoodsListSearchCnt(Map<String, Object> searchKey) throws Exception;

	public String getMaxprice(String priceRagneSelect) throws Exception;

	public List<CategoryVO> getCategoryList() throws Exception;

	public CategoryVO getCategoryToId(GoodsVO gvo) throws Exception;
	
	public int goodsInsert(GoodsVO gvo) throws Exception;

	public GoodsVO selectGoodsOne(String goodsId) throws Exception;

	public int goodsModify(GoodsVO gvo) throws Exception;

	public int goodsDelete(GoodsVO gvo) throws Exception;

	public int goodsHardDelete(GoodsVO gvo) throws Exception;

	public int goodsRestore(GoodsVO gvo) throws Exception;

}
