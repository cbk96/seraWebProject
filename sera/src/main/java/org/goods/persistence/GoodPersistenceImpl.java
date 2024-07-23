package org.goods.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.goods.domain.CartVO;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.goods.domain.GoodsViewVO;
import org.goods.domain.OrderVO;
import org.goods.domain.ReplyVO;
import org.member.domain.MemberVO;
import org.springframework.stereotype.Repository;

@Repository
public class GoodPersistenceImpl implements GoodPersistence {
	
	@Inject
	private SqlSession sql;
	
	public String namespace ="org.sera.mappers.goods";

	@Override
	public List<CategoryVO> getMainType() {
		return sql.selectList(namespace+".getMainType");
	}

	@Override
	public List<CategoryVO> getSubType() {
		return sql.selectList(namespace+".getSubType");
	}
	@Override
	public List<CategoryVO> getSubTypeToMainType(String main_type) throws Exception {
		return sql.selectList(namespace+".getSubTypeToMainType", main_type);
	}

	@Override
	public GoodsVO selectGoodsOne(String goods_id) throws Exception {
		return sql.selectOne(namespace+".selectGoodsOne", goods_id);
	}

	@Override
	public List<GoodsVO> selectGoodsList(String main_type, String goods_id) throws Exception {
		Map<String, String> goods = new HashMap<String, String>();
		goods.put("main_type", main_type);
		goods.put("goods_id", goods_id);
		
		return sql.selectList(namespace+".selectGoodsList", goods);
	}

	@Override
	public List<GoodsVO> selectGoodsListToSearch(Map<String, Object> goodsSearch) throws Exception {
		return sql.selectList(namespace+".selectGoodsListToSearch", goodsSearch);
	}

	@Override
	public int getGoodsCnt(Map<String, Object> goodsSearch) throws Exception {
		return sql.selectOne(namespace+".getGoodsCnt", goodsSearch);
	}

	@Override
	public GoodsViewVO viewInfoChk(Map<String, String> viewInfo) throws Exception {
		return sql.selectOne(namespace+".viewInfoChk", viewInfo);
	}
	
	@Override
	public List<GoodsVO> relateGoodsList(String sub_type, String goods_id) throws Exception {
		Map<String, String> relateGoodInfo = new HashMap<String, String>();
		relateGoodInfo.put("sub_type", sub_type);
		relateGoodInfo.put("goods_id", goods_id);
		
		return sql.selectList(namespace+".relateGoodsList", relateGoodInfo);
	}
	
	@Override
	public List<GoodsVO> getGoodsLimitByCount(int itemCnt) {
		return sql.selectList(namespace+".getGoodsLimitByCount", itemCnt);
	}
	
	@Override
	public List<String> getSkinTypes() throws Exception {
		return sql.selectList(namespace+".getSkinTypes");
	}
	
	@Override
	public List<GoodsVO> selectGoodsListBySkinType(Map<String, Object> goodsSearch) throws Exception {
		return sql.selectList(namespace+".selectGoodsListBySkinType", goodsSearch);
	}
	
	@Override
	public int selectGoodsListBySkinTypeCnt(Map<String, Object> goodsSearch) throws Exception {
		return sql.selectOne(namespace+".selectGoodsListBySkinTypeCnt", goodsSearch);
	}
	
	@Override
	public void viewCountUp(Map<String, String> viewInfo) throws Exception {
		sql.insert(namespace+".viewCountUp", viewInfo);
	}

	@Override
	public int getViewCnt(String goods_id) throws Exception {
		return sql.selectOne(namespace+".getViewCnt", goods_id);
	}

	@Override
	public void relayViewCnt(GoodsVO gvo) throws Exception {
		sql.update(namespace+".relayViewCnt", gvo);
	}

	@Override
	public CartVO dupliCartChk(CartVO cvo) throws Exception {
		return sql.selectOne(namespace+".dupliCartChk", cvo);
	}
	
	@Override
	public void inserCart(CartVO cvo) throws Exception {
		sql.insert(namespace+".inserCart", cvo);
	}

	@Override
	public void updateCartCountUp(CartVO cvo) throws Exception {
		sql.update(namespace+".updateCartCountUp", cvo);
	}

	@Override
	public List<CartVO> viewCart(String user_id) throws Exception {
		return sql.selectList(namespace+".viewCart", user_id);
	}

	@Override
	public void cartDelete(Map<String, String> deleteItemInfo) throws Exception {
		sql.delete(namespace+".cartDelete", deleteItemInfo);
	}

	@Override
	public int orderGoodsInsert(List<OrderVO> ovoItems) throws Exception {
		return sql.insert(namespace+".orderGoodsInsert", ovoItems);
	}

	/*@Override
	public List<OrderVO> getOrderNumber(String user_id) throws Exception {
		return sql.selectList(namespace+".getOrderNumber", user_id);
	}*/
	@Override
	public List<OrderVO> getOrderNumber(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getOrderNumber", searchKey);
	}
	
	@Override
	public List<OrderVO> getAllOrderNumber(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getAllOrderNumber", searchKey);
	}
	

	@Override
	public List<OrderVO> getOrdersForNumber(OrderVO ovo) throws Exception {
		return sql.selectList(namespace+".getOrdersForNumber", ovo);
	}
	
	@Override
	public List<OrderVO> getAllOrderStatus(String user_id) throws Exception {
		return sql.selectList(namespace+".getAllOrderStatus", user_id);
	}

	@Override
	public void mileageCountUp(OrderVO ovo) throws Exception {
		sql.insert(namespace+".mileageCountUp", ovo);
	}

	@Override
	public void deductionMileage(OrderVO ovo) throws Exception{
		sql.insert(namespace+".deductionMileage", ovo);
	}

	@Override
	public GoodsVO getGoodsAmount(String goods_id) throws Exception {
		return sql.selectOne(namespace+".getGoodsAmount", goods_id);
	}

	@Override
	public void deductionGoodsAmount(OrderVO ovo) throws Exception {
		sql.update(namespace+".deductionGoodsAmount", ovo);
	}

	@Override
	public List<OrderVO> getOrdersForMember(Map<String, String> viewInfo) throws Exception {
		return sql.selectList(namespace+".getOrdersForMember", viewInfo);
	}

	@Override
	public void goodsReply(ReplyVO rvo) throws Exception {
		sql.insert(namespace+".goodsReply", rvo);
	}

	@Override
	public List<ReplyVO> getReplyList(GoodsVO gvo) throws Exception {
		return sql.selectList(namespace+".getReplyList", gvo);
	}

	@Override
	public List<ReplyVO> getReplyOneForUserId(OrderVO ovo) throws Exception{
		return sql.selectList(namespace+".getReplyOneForUserId", ovo);
	}

	@Override
	public List<GoodsVO> getBestSale(int bestItemCnt) throws Exception {
		return sql.selectList(namespace+".getBestSale",bestItemCnt);
	}

	@Override
	public List<GoodsVO> getGoodsBySkinType(String skinType, int bestItemCnt) throws Exception {
		Map<String, Object> goodsBySkinType = new HashMap<String, Object>();
		goodsBySkinType.put("skinType", skinType);
		goodsBySkinType.put("bestItemCnt", bestItemCnt);
		
		return sql.selectList(namespace+".getGoodsBySkinType", goodsBySkinType);
	}

	@Override
	public List<GoodsVO> getGoodsBySkinTypeAll(String skinType, int supportCnt) throws Exception {
		Map<String, Object> goodsBySkinType = new HashMap<String, Object>();
		goodsBySkinType.put("skinType", skinType);
		goodsBySkinType.put("supportCnt", supportCnt);
		
		return sql.selectList(namespace+".getGoodsBySkinTypeAll", goodsBySkinType);
	}

	@Override
	public int requestCancel(Map<String, String> requestValue) throws Exception {
		return sql.update(namespace+".requestCancel", requestValue);
	}

	@Override
	public int purchaseConfirm(OrderVO ovo) throws Exception {
		return sql.update(namespace+".purchaseConfirm", ovo);
	}

	@Override
	public int mileageDelete(MemberVO mvo) throws Exception {
		return sql.delete(namespace+".mileageDelete", mvo);
	}

	@Override
	public int cartDelete(MemberVO mvo) throws Exception {
		return sql.delete(namespace+".cartDeleteById", mvo);
	}

	@Override
	public void cartAllDelete(String user_id) throws Exception {
		sql.delete(namespace+".cartAllDelete", user_id);
	}	

}
