package org.admin.service;

import java.util.List;
import java.util.Map;

import org.goods.domain.GoodsVO;
import org.goods.domain.OrderVO;

public interface AdminOrderService {

	List<OrderVO> getOrderListDefault(Map<String, Object> searchKey) throws Exception;

	int getOrderListDefaultCnt(Map<String, Object> searchKey) throws Exception;

	List<OrderVO> getOrderListSearch(Map<String, Object> searchKey) throws Exception;

	int getOrderListSearchCnt(Map<String, Object> searchKey) throws Exception;

	int getMaxSellPrice() throws Exception;

	List<OrderVO> getOrderListByOrderNumber(String order_number) throws Exception;

	int customerInfoModify(OrderVO ovo) throws Exception;
	
	int shipInfoModify(OrderVO ovo) throws Exception;

	int orderRequest(Map<String, String> requestValue) throws Exception;

	int deductionMileage(Map<String, String> requestValue) throws Exception;

	int restoreMileage(String order_number) throws Exception;


}
