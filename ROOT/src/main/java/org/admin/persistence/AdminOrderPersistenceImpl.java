package org.admin.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.goods.domain.OrderVO;
import org.springframework.stereotype.Repository;

@Repository
public class AdminOrderPersistenceImpl implements AdminOrderPersistence {
	
	@Inject
	private SqlSession sql;
	
	public String namespace = "org.sera.mappers.adminOrders";

	@Override
	public List<OrderVO> getOrderListDefault(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getOrderListDefault", searchKey);
	}

	@Override
	public int getOrderListDefaultCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".getOrderListDefaultCnt", searchKey);
	}

	@Override
	public List<OrderVO> getOrderListSearch(Map<String, Object> searchKey) throws Exception {
		return sql.selectList(namespace+".getOrderListSearch", searchKey);
	}

	@Override
	public int getOrderListSearchCnt(Map<String, Object> searchKey) throws Exception {
		return sql.selectOne(namespace+".getOrderListSearchCnt", searchKey);
	}

	@Override
	public int getMaxSellPrice() throws Exception {
		return sql.selectOne(namespace+".getMaxSellPrice");
	}

	@Override
	public List<OrderVO> getOrderListByOrderNumber(String order_number) throws Exception {
		return sql.selectList(namespace+".getOrderListByOrderNumber", order_number);
	}

	@Override
	public int customerInfoModify(OrderVO ovo) throws Exception {
		return sql.update(namespace+".customerInfoModify", ovo);
	}
	
	@Override
	public int shipInfoModify(OrderVO ovo) throws Exception {
		return sql.update(namespace+".shipInfoModify", ovo);
	}

	@Override
	public int orderRequest(Map<String, String> requestValue) throws Exception {
		return sql.update(namespace+".orderRequest", requestValue);
	}

	@Override
	public int deductionMileage(Map<String, String> requestValue) throws Exception {
		return sql.delete(namespace+".deductionMileage", requestValue);
	}

	@Override
	public int restoreMileage(String order_number) throws Exception {
	return sql.delete(namespace+".restoreMileage", order_number);
	}

}
