package org.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.admin.domain.EmployeeVO;
import org.admin.service.AdminOrderService;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.goods.domain.OrderVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/order/*")
public class AdminOrderController {
	
	@Inject
	private AdminOrderService adminOrderService;
	
	public static final int PAGE_MAX_AD_ORDERS_CNT = 10;
	public static final int PAGE_MAX_BUTTON_CNT = 10;
	
	//주문목록 조회
	@RequestMapping(value ="/", method=RequestMethod.GET)
	public String orderList(Model model) throws Exception{
		
		int allOrderCnt = 0;
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		
		
		Map<String,Object> searchKey = new HashMap<String,Object>();
		searchKey.put("page_cnt",0);
		searchKey.put("PAGE_MAX_AD_ORDERS_CNT",PAGE_MAX_AD_ORDERS_CNT);
		
		
		//한 페이지에 표시할 주문 목록
		List<OrderVO> ovo = adminOrderService.getOrderListDefault(searchKey);
		
		//검색된 전체 주문 수
		allOrderCnt = adminOrderService.getOrderListDefaultCnt(searchKey);
		
		//리스트 페이지 버튼수
		maxPageCnt = (int) Math.ceil((double)allOrderCnt/(double)PAGE_MAX_AD_ORDERS_CNT);
		
		//리스트 페이지 버튼 시작값, 끝값
		pageCntBeign = (int) Math.ceil((1-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
		pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
		
		model.addAttribute("allOrderCnt", allOrderCnt);
		model.addAttribute("select_page_cnt", 1);
		model.addAttribute("pageCntBeign", pageCntBeign);
		model.addAttribute("pageCntEnd", pageCntEnd);
		model.addAttribute("maxPageCnt", maxPageCnt);
		model.addAttribute("orderList", ovo);
		
		return "/admin/order/orderList";
	}
	
	//주문목록 검색
	@RequestMapping(value="/orderSearch", method=RequestMethod.POST)
	public String goodsListSearch(
			@RequestParam(value="list-page-cnt", defaultValue="1") int listPageCnt,
			@RequestParam(value="search-key-type") String searchKeyType, 
			@RequestParam(value="search-key-value") String searchKeyValue,
			@RequestParam(value="price-begin", defaultValue="0") int priceBegin,
			@RequestParam(value="price-end", defaultValue="-1") int priceEnd,
			@RequestParam(value="date-range-select") String dateRangeSelect,
			@RequestParam(value="order_status", defaultValue="all") String order_status,
			@RequestParam(value="day-begin") String dayBegin,
			@RequestParam(value="day-end") String dayEnd,
			@RequestParam(value="list-sort") String listSort,
			@RequestParam(value="turn-select", defaultValue="goods_reg_date") String turnSelect, 
			@RequestParam(value="btn-expand-remember", defaultValue="expand-not-active") String btnExpandRemem,
			@RequestParam(value="page_cnt", defaultValue = "1") int select_page_cnt,
			HttpSession session, Model model) throws Exception{
		
		int allOrderCnt = 0;
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		select_page_cnt = select_page_cnt<=0?1:select_page_cnt;
		
		if(priceEnd<1) {priceEnd = adminOrderService.getMaxSellPrice();}
		
		Map<String,Object> searchKey = new HashMap<String,Object>();
		searchKey.put("searchKeyType", searchKeyType);
		searchKey.put("searchKeyValue", searchKeyValue);
		searchKey.put("priceBegin", priceBegin);
		searchKey.put("priceEnd", priceEnd);
		searchKey.put("dateRangeSelect", dateRangeSelect);
		searchKey.put("order_status", order_status);
		searchKey.put("dayBegin", dayBegin);
		searchKey.put("dayEnd", dayEnd);
		searchKey.put("listSort", listSort);
		searchKey.put("turnSelect", turnSelect);
		searchKey.put("btnExpandRemem", btnExpandRemem);
		searchKey.put("page_cnt",(select_page_cnt-1)*PAGE_MAX_AD_ORDERS_CNT);
		searchKey.put("PAGE_MAX_AD_ORDERS_CNT",PAGE_MAX_AD_ORDERS_CNT);
		
		//한 페이지에 표시할 주문 목록
		List<OrderVO> ovo = adminOrderService.getOrderListSearch(searchKey);
		
		//검색된 전체 주문 수
		allOrderCnt = adminOrderService.getOrderListSearchCnt(searchKey);
		
		//리스트 페이지 버튼수
		maxPageCnt = (int) Math.ceil((double)allOrderCnt/(double)PAGE_MAX_AD_ORDERS_CNT);
		
		//리스트 페이지 버튼 시작값, 끝값
		pageCntBeign = (int) Math.ceil((1-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
		pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
		
		model.addAttribute("allOrderCnt", allOrderCnt);
		model.addAttribute("select_page_cnt", select_page_cnt);
		model.addAttribute("pageCntBeign", pageCntBeign);
		model.addAttribute("pageCntEnd", pageCntEnd);
		model.addAttribute("maxPageCnt", maxPageCnt);
		
		model.addAttribute("searchKey",searchKey);

		model.addAttribute("orderList", ovo);
		
		return "/admin/order/orderList";
	}
	
	//주문상세정보
	@RequestMapping(value="/orderOneDetail", method = RequestMethod.GET)
	public void orderOneDetail(@RequestParam(value="order_number", defaultValue="0") String order_number, Model model) throws Exception {
		List<OrderVO> ovos = adminOrderService.getOrderListByOrderNumber(order_number);
		if(ovos.size() > 0) {
			OrderVO ordererInfo = ovos.get(0);
			
			model.addAttribute("order_items", ovos);
			model.addAttribute("ordererInfo", ordererInfo);
		}
	}
	
	
	//주문자 정보 수정
	@RequestMapping(value="/customerInfoModify", method = RequestMethod.POST)
	public String customerInfoModify(OrderVO ovo) throws Exception{
		
		int modifyResult = adminOrderService.customerInfoModify(ovo);
		
		return "redirect:/admin/order/orderOneDetail?order_number="+ovo.getOrder_number();
	}
	
	
	//상품별 배송상태 변경
	@ResponseBody
	@RequestMapping(value="/orderItemModify", method = RequestMethod.POST)
	public String orderItemModify(
			@RequestParam(value="goods_id") String goods_id, 
			@RequestParam(value="order_number") String order_number,
			@RequestParam(value="order_status") String order_status) throws Exception{
		
		String reulstMsg = "fail";
		
		OrderVO ovo = new OrderVO();
		ovo.setGoods_id(goods_id);
		ovo.setOrder_number(order_number);
		ovo.setOrder_status(order_status);
		
		int modifyResult = adminOrderService.shipInfoModify(ovo);
		if(modifyResult>=1) {
			reulstMsg = "success";
		}
		
		return reulstMsg;
	}
	
	//주문 취소/반품 요청
	@ResponseBody
	@RequestMapping(value="/orderRequest", method=RequestMethod.POST)
	public String requestCancel(
			@RequestParam(value="order_number", defaultValue="empty") String order_number,
			@RequestParam(value="goods_id", defaultValue="empty") String goods_id,
			@RequestParam(value="sell_price", defaultValue="empty") String sell_price,
			@RequestParam(value="requestType", defaultValue="empty") String requestType
			) throws Exception {
		
		String requestMsg =  "fail";
		
		Map<String, String> requestValue = new HashMap<String, String>();
		requestValue.put("order_number", order_number);
		requestValue.put("goods_id", goods_id);
		requestValue.put("requestType", requestType);
		
		if(!order_number.equals("empty") && (!goods_id.equals("empty") && !requestType.equals("empty"))) {
			int requestResult = adminOrderService.orderRequest(requestValue);
			
			
			if(requestResult>=1) {
				requestMsg = "success";
			}
		}
		
		return requestMsg;
	}
	
	//마일리지 복원
	@ResponseBody
	@RequestMapping(value="/restoreMileage", method=RequestMethod.POST)
	public String restoreMileage(@RequestParam(value="order_number", defaultValue="empty") String order_number) throws Exception {
		
		String requestMsg =  "fail";
		System.out.println("what the fuck");
		System.out.println(order_number);
		if(!order_number.equals("empty") ) {
			int requestResult = adminOrderService.restoreMileage(order_number);
			
			if(requestResult>=1) {
				requestMsg = "success";
			}
		}
		
		return requestMsg;
	}
}
