package org.goods.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.goods.domain.CartVO;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.goods.domain.GoodsViewVO;
import org.goods.domain.OrderVO;
import org.goods.domain.ReplyVO;
import org.goods.persistence.GoodPersistence;
import org.member.domain.MemberVO;
import org.springframework.stereotype.Service;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Inject
	private GoodPersistence goodPersistence;

	@Override
	public List<CategoryVO> getMainType() throws Exception {
		return goodPersistence.getMainType();
	}

	@Override
	public List<CategoryVO> getSubType() throws Exception {
		return goodPersistence.getSubType();
	}
	
	@Override
	public List<CategoryVO> getSubTypeToMainType(String main_type) throws Exception {
		return goodPersistence.getSubTypeToMainType(main_type);
	}

	@Override
	public GoodsVO selectGoodsOne(String goods_id) throws Exception {
		return goodPersistence.selectGoodsOne(goods_id);
	}

	@Override
	public List<GoodsVO> selectGoodsList(String main_type, String goods_id) throws Exception {
		return goodPersistence.selectGoodsList(main_type, goods_id);
	}

	@Override
	public List<GoodsVO> selectGoodsListToSearch(Map<String, Object> goodsSearch) throws Exception {
		return goodPersistence.selectGoodsListToSearch(goodsSearch);
	}
	
	@Override
	public List<GoodsVO> relateGoodsList(String sub_type, String goods_id) throws Exception {
		return goodPersistence.relateGoodsList(sub_type, goods_id);
	}
	
	@Override
	public List<GoodsVO> getGoodsLimitByCount(int itemCnt) throws Exception {
		return goodPersistence.getGoodsLimitByCount(itemCnt);
	}

	@Override
	public int getGoodsCnt(Map<String, Object> goodsSearch) throws Exception {
		return goodPersistence.getGoodsCnt(goodsSearch);
	}
	
	@Override
	public List<String> getSkinTypes() throws Exception {
		return goodPersistence.getSkinTypes();
	}
	
	@Override
	public List<GoodsVO> selectGoodsListBySkinType(Map<String, Object> goodsSearch) throws Exception {
		return goodPersistence.selectGoodsListBySkinType(goodsSearch);
	}
	
	@Override
	public int selectGoodsListBySkinTypeCnt(Map<String, Object> goodsSearch) throws Exception {
		return goodPersistence.selectGoodsListBySkinTypeCnt(goodsSearch);
	}

	@Override
	public GoodsViewVO viewInfoChk(Map<String, String> viewInfo) throws Exception {
		return goodPersistence.viewInfoChk(viewInfo);
	}
	
	@Override
	public void viewCountUp(Map<String, String> viewInfo) throws Exception {
		goodPersistence.viewCountUp(viewInfo);
	}

	@Override
	public int getViewCnt(String goods_id) throws Exception {
		return goodPersistence.getViewCnt(goods_id);
	}

	@Override
	public void relayViewCnt(GoodsVO gvo) throws Exception {
		goodPersistence.relayViewCnt(gvo);
	}
	
	@Override
	public void inserCart(CartVO cvo) throws Exception {
		CartVO dupliCvo = goodPersistence.dupliCartChk(cvo);
		
		if(dupliCvo==null) {//기존에 동일한 상품이 등록되어 있지 않는 경우에만 상품을 장바구니에 등록한다.
			goodPersistence.inserCart(cvo);
		}else {//기존에 장바구니에 동일한 상품이 등록 되어 있는 상태라면 추가적으로 상품을 등록하지 않고 기존에 등록된 상품의 구매수를 늘린다.
			int existAmount = dupliCvo.getAmount();
			int existQuantity =  dupliCvo.getQuantity();
			
			System.out.println("existAmount : "+existAmount);
			System.out.println("existQuantity : "+existQuantity);
			System.out.println("cvo.getQuantity : "+cvo.getQuantity());
			
			if(cvo.getQuantity() + existQuantity > existAmount) {
				cvo.setQuantity(existAmount);
			}else {
				cvo.setQuantity(cvo.getQuantity() + existQuantity);
			}
			
			goodPersistence.updateCartCountUp(cvo);
		}
	}

	@Override
	public List<CartVO> viewCart(String user_id) throws Exception {
		return goodPersistence.viewCart(user_id);
	}

	@Override
	public void cartDelete(Map<String, String> deleteItemInfo) throws Exception {
		goodPersistence.cartDelete(deleteItemInfo);
	}

	@Override
	public void cartOneUpdate(CartVO cvo) throws Exception {
		goodPersistence.updateCartCountUp(cvo);
	}

	@Override
	public int orderGoodsInsert(List<OrderVO> ovoItems) throws Exception {
		return goodPersistence.orderGoodsInsert(ovoItems);
	}

	/*@Override
	public List<OrderVO> getOrderNumber(String user_id) throws Exception {
		return goodPersistence.getOrderNumber(user_id);
	}*/
	@Override
	public List<OrderVO> getOrderNumber(Map<String, Object> searchKey) throws Exception {
		return goodPersistence.getOrderNumber(searchKey);
	}
	
	@Override
	public List<OrderVO> getAllOrderNumber(Map<String, Object> searchKey) throws Exception {
		return goodPersistence.getAllOrderNumber(searchKey);
	}

	@Override
	public List<OrderVO> getOrdersForNumber(OrderVO ovo) throws Exception {
		return goodPersistence.getOrdersForNumber(ovo);
	}
	
	@Override
	public List<OrderVO> getAllOrderStatus(String user_id) throws Exception {
		return goodPersistence.getAllOrderStatus(user_id);
	}

	@Override
	public void mileageCountUp(OrderVO ovo) throws Exception {
		goodPersistence.mileageCountUp(ovo);
	}

	@Override
	public void deductionMileage(OrderVO ovo) throws Exception {
		goodPersistence.deductionMileage(ovo);
	}

	@Override
	public GoodsVO getGoodsAmount(String goods_id) throws Exception {
		return goodPersistence.getGoodsAmount(goods_id);
	}

	@Override
	public void deductionGoodsAmount(OrderVO ovo) throws Exception {
		goodPersistence.deductionGoodsAmount(ovo);
	}

	@Override
	public List<OrderVO> getOrdersForMember(Map<String, String> viewInfo) throws Exception {
		return goodPersistence.getOrdersForMember(viewInfo);
	}

	@Override
	public void goodsReply(ReplyVO rvo) throws Exception {
		goodPersistence.goodsReply(rvo);
	}

	@Override
	public List<ReplyVO> getReplyList(GoodsVO gvo) throws Exception {
		return goodPersistence.getReplyList(gvo);
	}

	@Override
	public List<ReplyVO> getReplyOneForUserId(OrderVO ovo) throws Exception {
		return goodPersistence.getReplyOneForUserId(ovo);
	}

	@Override
	public List<GoodsVO> getBestSale(int bestItemCnt) throws Exception {
		return goodPersistence.getBestSale(bestItemCnt);
	}

	@Override
	public List<GoodsVO> getGoodsBySkinType(String skinType, int bestItemCnt) throws Exception {
		return goodPersistence.getGoodsBySkinType(skinType, bestItemCnt);
	}

	@Override
	public List<GoodsVO> getGoodsBySkinTypeAll(String skinType, int supportCnt) throws Exception {
		return goodPersistence.getGoodsBySkinTypeAll(skinType, supportCnt);
	}

	@Override
	public int requestCancel(Map<String, String> requestValue) throws Exception {
		return goodPersistence.requestCancel(requestValue);
	}

	@Override
	public int purchaseConfirm(OrderVO ovo) throws Exception {
		return goodPersistence.purchaseConfirm(ovo);
	}

	@Override
	public int mileageDelete(MemberVO mvo) throws Exception {
		return goodPersistence.mileageDelete(mvo);
		
	}

	@Override
	public int cartDelete(MemberVO mvo) throws Exception {
		return goodPersistence.cartDelete(mvo);
	}

	@Override
	public void cartAllDelete(String user_id) throws Exception {
		goodPersistence.cartAllDelete(user_id);
	}

	


}
