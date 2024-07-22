package org.admin.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.admin.persistence.AdminOrderPersistence;
import org.goods.domain.GoodsVO;
import org.goods.domain.OrderVO;
import org.springframework.stereotype.Service;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {
	
	@Inject 
	public AdminOrderPersistence adminOrderPersistence;

	@Override
	public List<OrderVO> getOrderListDefault(Map<String, Object> searchKey) throws Exception {
		return adminOrderPersistence.getOrderListDefault(searchKey);
	}

	@Override
	public int getOrderListDefaultCnt(Map<String, Object> searchKey) throws Exception {
		return adminOrderPersistence.getOrderListDefaultCnt(searchKey);
	}

	@Override
	public List<OrderVO> getOrderListSearch(Map<String, Object> searchKey) throws Exception {
		return adminOrderPersistence.getOrderListSearch(searchKey);
	}

	@Override
	public int getOrderListSearchCnt(Map<String, Object> searchKey) throws Exception {
		return adminOrderPersistence.getOrderListSearchCnt(searchKey);
	}

	@Override
	public int getMaxSellPrice() throws Exception {
		return adminOrderPersistence.getMaxSellPrice();
	}

	@Override
	public List<OrderVO> getOrderListByOrderNumber(String order_number) throws Exception {
		return adminOrderPersistence.getOrderListByOrderNumber(order_number);
	}

	@Override
	public int customerInfoModify(OrderVO ovo) throws Exception {
		return adminOrderPersistence.customerInfoModify(ovo);
	}
	
	@Override
	public int shipInfoModify(OrderVO ovo) throws Exception {
		return adminOrderPersistence.shipInfoModify(ovo);
	}

	@Override
	public int orderRequest(Map<String, String> requestValue) throws Exception {
		return adminOrderPersistence.orderRequest(requestValue);
	}

	@Override
	public int deductionMileage(Map<String, String> requestValue) throws Exception {
		return adminOrderPersistence.deductionMileage(requestValue);
	}

	@Override
	public int restoreMileage(String order_number) throws Exception {
		return adminOrderPersistence.restoreMileage(order_number);
	}

}
