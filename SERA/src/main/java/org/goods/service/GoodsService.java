package org.goods.service;

import java.util.List;
import java.util.Map;

import org.goods.domain.CartVO;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.goods.domain.GoodsViewVO;
import org.goods.domain.OrderVO;
import org.goods.domain.ReplyVO;
import org.member.domain.MemberVO;

public interface GoodsService {

	public List<CategoryVO> getMainType() throws Exception;

	public List<CategoryVO> getSubType() throws Exception;
	
	public List<CategoryVO> getSubTypeToMainType(String main_type) throws Exception;

	public GoodsVO selectGoodsOne(String goods_id) throws Exception;

	public List<GoodsVO> selectGoodsList(String main_type, String goods_id) throws Exception;

	public List<GoodsVO> selectGoodsListToSearch(Map<String, Object> goodsSearch) throws Exception;
	
	public List<GoodsVO> relateGoodsList(String sub_type, String goods_id) throws Exception;
	
	public List<GoodsVO> getGoodsLimitByCount(int itemCnt) throws Exception;

	public int getGoodsCnt(Map<String, Object> goodsSearch) throws Exception;
	
	public List<String> getSkinTypes() throws Exception;	
	
	public List<GoodsVO> selectGoodsListBySkinType(Map<String, Object> goodsSearch) throws Exception;
	
	public int selectGoodsListBySkinTypeCnt(Map<String, Object> goodsSearch) throws Exception;

	public GoodsViewVO viewInfoChk(Map<String, String> viewInfo) throws Exception;
	
	public void viewCountUp(Map<String, String> viewInfo) throws Exception;

	public int getViewCnt(String goods_id) throws Exception;

	public void relayViewCnt(GoodsVO gvo) throws Exception;

	public void inserCart(CartVO cvo) throws Exception;

	public List<CartVO> viewCart(String user_id) throws Exception;

	public void cartDelete(Map<String, String> deleteItemInfo) throws Exception;

	public void cartOneUpdate(CartVO cvo) throws Exception;

	public int orderGoodsInsert(List<OrderVO> ovoItems) throws Exception;

	//public List<OrderVO> getOrderNumber(String user_id) throws Exception;
	public List<OrderVO> getOrderNumber(Map<String, Object> searchKey) throws Exception;
	
	public List<OrderVO> getAllOrderNumber(Map<String, Object> searchKey) throws Exception;

	public List<OrderVO> getOrdersForNumber(OrderVO ovo) throws Exception;
	
	public List<OrderVO> getAllOrderStatus(String user_id) throws Exception;

	public void mileageCountUp(OrderVO ovo) throws Exception;

	public void deductionMileage(OrderVO ovo) throws Exception;

	public GoodsVO getGoodsAmount(String goods_id) throws Exception;

	public void deductionGoodsAmount(OrderVO ovo) throws Exception;

	public List<OrderVO> getOrdersForMember(Map<String, String> viewInfo) throws Exception;

	public void goodsReply(ReplyVO rvo) throws Exception;

	public List<ReplyVO> getReplyList(GoodsVO gvo) throws Exception;

	public List<ReplyVO> getReplyOneForUserId(OrderVO ovo) throws Exception;

	public List<GoodsVO> getBestSale(int bestItemCnt) throws Exception;

	public List<GoodsVO> getGoodsBySkinType(String skinType, int bestItemCnt) throws Exception;

	public List<GoodsVO> getGoodsBySkinTypeAll(String string, int supportCnt) throws Exception;

	public int requestCancel(Map<String, String> requestValue) throws Exception;

	public int purchaseConfirm(OrderVO ovo) throws Exception;

	public int mileageDelete(MemberVO mvo) throws Exception;

	public int cartDelete(MemberVO mvo) throws Exception;

	public void cartAllDelete(String user_id) throws Exception;

	

	

}
