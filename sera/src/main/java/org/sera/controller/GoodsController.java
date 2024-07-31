package org.sera.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.goods.domain.CartVO;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.goods.domain.GoodsViewVO;
import org.goods.domain.OrderVO;
import org.goods.domain.ReplyVO;
import org.goods.service.GoodsService;
import org.member.domain.MemberVO;
import org.member.domain.MileageVO;
import org.sera.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/goods/*")
public class GoodsController {
	
	@Inject
	private GoodsService goodsService;
	
	@Inject
	private MemberService memberService;
	
	public final static int PAGE_MAX_GOODS_CNT = 9;
	public final static int PAGE_MAX_BUTTON_CNT = 10;
	
	//상품 리스트 조회 | 검색 
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String goodsList(
			@RequestParam(value="main_type", defaultValue="all") String main_type, 
			@RequestParam(value="sub_type", defaultValue = "all") String sub_type, 
			@RequestParam(value="search_value", defaultValue = "all") String search_value, 
			@RequestParam(value="page_cnt", defaultValue = "1") int select_page_cnt, 
			Model model) throws Exception {
		
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		select_page_cnt = select_page_cnt<=0?1:select_page_cnt;
		
		Map<String, Object> goodsSearch = new HashMap<String, Object>();
		goodsSearch.put("main_type", main_type);
		goodsSearch.put("sub_type", sub_type);
		goodsSearch.put("search_value", search_value);
		goodsSearch.put("page_cnt", (select_page_cnt-1)*PAGE_MAX_GOODS_CNT);
		goodsSearch.put("PAGE_MAX_GOODS_CNT", PAGE_MAX_GOODS_CNT);
		
		//한 페이지에 표시할 상품 목록
		List<GoodsVO> GoodsListToSearch = goodsService.selectGoodsListToSearch(goodsSearch);
		
		//전체 대분류(메인) 카테고리
		List<CategoryVO> allMainType = goodsService.getMainType();
		
		//선택(검색)한 카테고리
		Map<String, Object> categoryValue = new HashMap<String, Object>();
		
		//선택(검색)한 대분류 카테고리의 중분류(하위) 카테고리
		List<CategoryVO> allSubType =  goodsService.getSubTypeToMainType(main_type);
		
		//검색된 전체 상품수
		int goodsCnt = goodsService.getGoodsCnt(goodsSearch);
		
		//리스트 페이지 버튼수
		maxPageCnt = (int) Math.ceil((double)goodsCnt/(double)PAGE_MAX_GOODS_CNT);
		
		//리스트 페이지 버튼 시작값, 끝값
		pageCntBeign = (int) Math.ceil((select_page_cnt-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
		pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
		
		
		categoryValue.put("main_type", main_type);
		categoryValue.put("sub_type", sub_type);
		
		model.addAttribute("search_value", search_value.equals("all")?"":search_value);
		model.addAttribute("select_page_cnt", select_page_cnt);
		model.addAttribute("pageCntBeign",pageCntBeign);
		model.addAttribute("pageCntEnd",pageCntEnd);
		model.addAttribute("maxPageCnt", maxPageCnt);
		model.addAttribute("goodsCnt", goodsCnt);
		model.addAttribute("allMainType", allMainType);
		model.addAttribute("allSubType", allSubType);
		model.addAttribute("categoryValue", categoryValue);
		model.addAttribute("goods", GoodsListToSearch);
		
		return "/goods/goodsList";
	}
	
	
	//피부 타입별 상품 리스트 조회 | 검색 
	@RequestMapping(value="/goodsListBySkinType", method=RequestMethod.GET)
	public String goodsListBySkinType(
			@RequestParam(value="skin_type", defaultValue="oily_skin") String skin_type, 
			@RequestParam(value="search_value", defaultValue = "all") String search_value, 
			@RequestParam(value="page_cnt", defaultValue = "1") int select_page_cnt, 
			Model model) throws Exception {
		
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		String skinTypeKorean = "지성";
		select_page_cnt = select_page_cnt<=0?1:select_page_cnt;
		
		Map<String, Object> goodsSearch = new HashMap<String, Object>();
		goodsSearch.put("skin_type", skin_type);
		goodsSearch.put("search_value", search_value);
		goodsSearch.put("page_cnt", (select_page_cnt-1)*PAGE_MAX_GOODS_CNT);
		goodsSearch.put("PAGE_MAX_GOODS_CNT", PAGE_MAX_GOODS_CNT);
		
		//전체 피부 타입명들
		List<String> allSkinType = goodsService.getSkinTypes();
		
		//피부 타입명 한글로 전환
		switch(skin_type) {
			case "oily_skin" : skinTypeKorean = "지성 피부용"; break;
			case "dry_skin" : skinTypeKorean = "건성 피부용"; break;
			case "combination_skin" : skinTypeKorean = "복합성 피부용"; break;
		}
		
		//한 페이지에 표시할 피부 타입별 추천 상품 목록
		List<GoodsVO> GoodsListToSearch = goodsService.selectGoodsListBySkinType(goodsSearch);
		
		//검색된 전체 상품수
		int goodsCnt = goodsService.selectGoodsListBySkinTypeCnt(goodsSearch);
		
		//리스트 페이지 버튼수
		maxPageCnt = (int) Math.ceil((double)goodsCnt/(double)PAGE_MAX_GOODS_CNT);
		
		//리스트 페이지 버튼 시작값, 끝값
		pageCntBeign = (int) Math.ceil((select_page_cnt-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
		pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
		
		
		
		model.addAttribute("search_value", search_value.equals("all")?"":search_value);
		model.addAttribute("select_page_cnt", select_page_cnt);
		model.addAttribute("pageCntBeign",pageCntBeign);
		model.addAttribute("pageCntEnd",pageCntEnd);
		model.addAttribute("maxPageCnt", maxPageCnt);
		model.addAttribute("goodsCnt", goodsCnt);
		model.addAttribute("skinType", skin_type);
		model.addAttribute("allSkinType", allSkinType);
		model.addAttribute("skinTypeKorean", skinTypeKorean);
		model.addAttribute("goods", GoodsListToSearch);
		
		return "/goods/goodsListBySkinType";
	}
	
	//상품 상세 페이지
	@RequestMapping(value="/goodsOne", method=RequestMethod.GET)
	public void goodsOne(@RequestParam(value="goods_id") String goods_id, HttpSession session, Model model) throws Exception {
		GoodsVO gvo = goodsService.selectGoodsOne(goods_id);
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		
		// 상품 조회수 증가 / 상품 상세 페이지에 접근한 고객이 회원인 경우에만 조회수 증가
		// 각 상품마다 한 회원별로 조회수 증가는 한번만 이뤄진다.
		if(gvo!=null && mvo != null) {
			Map<String, String> viewInfo = new HashMap<String, String>();
			viewInfo.put("goods_id", gvo.getGoods_id());
			viewInfo.put("user_id", mvo.getUser_id());
			boolean replyWriteChk = false;
			
			GoodsViewVO viewInfoChk = goodsService.viewInfoChk(viewInfo);
			
			if(viewInfoChk == null) {goodsService.viewCountUp(viewInfo);}
			
			List<OrderVO> ovos = goodsService.getOrdersForMember(viewInfo);
			
			//고객이 상품을 주문한적이 있는지 확인
			if(ovos.size()>0){	
				model.addAttribute("orderinfo", ovos.get(0));
				//고객이 상품 리뷰를 작성한 내역이 있는지 확인 
				//한상품당 회원마다 한번의 리뷰 작성만 가능
				List<ReplyVO> rvos = goodsService.getReplyOneForUserId(ovos.get(0));
				if(rvos.size() <= 0) {replyWriteChk = true;}
			}
			
			model.addAttribute("replyWriteChk", replyWriteChk);
		}
		
		//상품 정보가 조회된 경우에만 실행
		if(gvo!=null) {
			//상품 조회수 조회 / 상품 테이블에 조회수 입력
			int view_cnt = goodsService.getViewCnt(gvo.getGoods_id());
			gvo.setView_cnt(view_cnt);
			goodsService.relayViewCnt(gvo);
			
			//연관상품 목록 조회
			List<GoodsVO> relatedGvo = goodsService.relateGoodsList(gvo.getSub_type(), gvo.getGoods_id());
			model.addAttribute("relatedGoodsInfo", relatedGvo);
			
			//상품 리뷰 조회
			List<ReplyVO> rvos = goodsService.getReplyList(gvo);
			model.addAttribute("reply_items", rvos);
			
			//리뷰 점수 평균값 전달
			 int scoreSum = 0; 
			 double scoreAvg = 0.0;
			 
			 if(rvos.size()>0) {
				 for(int i=0; i<rvos.size(); i++) {scoreSum += rvos.get(i).getScore(); }
				 scoreAvg = scoreSum / rvos.size();
			 }
			 model.addAttribute("scoreAvg", scoreAvg);
		}
		
		
		
		
		model.addAttribute("goodsInfo", gvo);
	}
	
	//장바구니에 담기
	@RequestMapping(value="/inserCart", method=RequestMethod.POST)
	public String inserCart(@RequestParam(value="quantity", defaultValue="1") int quantity, GoodsVO gvo, HttpServletRequest request, HttpSession session, HttpSession tempSession) throws Exception {
		
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		
		CartVO cvo = new CartVO();
		cvo.setGoods_id(gvo.getGoods_id());
		cvo.setGoods_image(gvo.getGoods_image());
		cvo.setGoods_name(gvo.getGoods_name());
		cvo.setCategory_id(gvo.getCategory_id());
		cvo.setSell_price(gvo.getSell_price());
		cvo.setAmount(gvo.getAmount());
		cvo.setQuantity(quantity);
		cvo.setShipping_fee(gvo.getShipping_fee());
		
		if(mvo==null) {
			//로그인하지 않은 고객은 세션에 장바구니 정보를 임시 저장
			cvo.setUser_id("noneMember");
			
			List<CartVO> cvoItems =  (ArrayList) tempSession.getAttribute("tempCartSession");
			
			if(cvoItems==null) {
				cvoItems = new ArrayList<CartVO>();
				tempSession = request.getSession();
			}
			
			for(int i =0; i<cvoItems.size(); i++) {
				if(cvoItems.get(i).getGoods_id().equals(cvo.getGoods_id())) {
					if((cvoItems.get(i).getQuantity() + cvo.getQuantity()) > cvoItems.get(i).getAmount()) {
						cvo.setQuantity(cvoItems.get(i).getAmount());
					}else {
						cvo.setQuantity(cvoItems.get(i).getQuantity() + cvo.getQuantity());
					}
					cvoItems.remove(i);
				}
			}
			
			cvoItems.add(cvo);
			tempSession.setAttribute("tempCartSession", cvoItems);
		}else {
			//로그인한 회원 고객은 장바구니 정보를 db 테이블에 저장
			cvo.setUser_id(mvo.getUser_id());
			
			goodsService.inserCart(cvo);
		}
		
		return "redirect:/goods/cart";
	}
	
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public String viewCart(HttpSession session, HttpSession tempSession, Model model) throws Exception {
		
		List<CartVO> cvo = null;
		List<CartVO> cvoItems =  (ArrayList) tempSession.getAttribute("tempCartSession");
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		
		if(mvo!=null) {
			cvo = goodsService.viewCart(mvo.getUser_id());
		}else {
			if(cvoItems!=null) {cvo = cvoItems;}
		}
		
		model.addAttribute("cartInfo",cvo);
		
		return "/goods/cart";
	}
	
	//장바구니 상품 삭제
	@RequestMapping(value="/cartDelete", method=RequestMethod.POST)
	public String cartDelete(HttpSession session, HttpSession tempSession, @RequestParam("deleteItem") String deleteItem, @RequestParam("user_id") String user_id, Model model) throws Exception {
		List<CartVO> cvo = null;	
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		
		if(mvo==null && user_id.equals("noneMember")) {
			//비로그인 고객이 상품을 삭제하는 경우
			cvo =  (ArrayList) tempSession.getAttribute("tempCartSession");
			
			for(int i=0; i < cvo.size(); i++) {
				if(cvo.get(i).getGoods_id().equals(deleteItem)) {cvo.remove(i);}
			}
			tempSession.setAttribute("tempCartSession", cvo);
			
		}else {
			//로그인한 회원 고객이 상품을 삭제하는 경우
			Map<String, String> deleteItemInfo = new HashMap<String, String>();
			deleteItemInfo.put("goods_id", deleteItem);
			deleteItemInfo.put("user_id", user_id);
			goodsService.cartDelete(deleteItemInfo);
			
			cvo = goodsService.viewCart(user_id);
		}
		
		model.addAttribute("cartInfo",cvo);
		
		return "/goods/cart";
	}
	
	//장바구니 페이지에서 변경된 구매수량을 DB 테이블에 반영 
	@ResponseBody
	@RequestMapping(value="/cartOneUpdate", method=RequestMethod.POST)
	public void cartOneUpdate(
			HttpSession session, HttpSession tempSession,
			@RequestParam("goods_id") String goods_id, 
			@RequestParam("quantity") int quantity,
			@RequestParam("user_id") String user_id) throws Exception {
		
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		
		if(mvo==null && user_id.equals("noneMember")) {
			//비로그인 고객의 경우
			List<CartVO> cvoItems =  (ArrayList) tempSession.getAttribute("tempCartSession");
			
			for(int i=0; i < cvoItems.size(); i++) {
				if(cvoItems.get(i).getGoods_id().equals(goods_id)) {cvoItems.get(i).setQuantity(quantity);}
			}
			tempSession.setAttribute("tempCartSession", cvoItems);
			
		}else {
			//로그인한 회원 고객의 경우
			CartVO cvo = new CartVO();
			cvo.setGoods_id(goods_id);
			cvo.setQuantity(quantity);
			cvo.setUser_id(user_id);
			goodsService.cartOneUpdate(cvo);
		}
	}
	
	//상품 주문 (바로 구매)
	@RequestMapping(value="/order", method=RequestMethod.POST)
	public String attemptOrder(HttpSession session, GoodsVO gvo, @RequestParam(value="quantity", defaultValue="1") int quantity, Model model) throws Exception {
		
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		List<CartVO> cvoItems = new ArrayList<CartVO>();
		CartVO cvo = new CartVO();
		
		cvo.setGoods_id(gvo.getGoods_id());
		cvo.setGoods_image(gvo.getGoods_image());
		cvo.setGoods_name(gvo.getGoods_name());
		cvo.setCategory_id(gvo.getCategory_id());
		cvo.setSell_price(gvo.getSell_price());
		cvo.setAmount(gvo.getAmount());
		cvo.setQuantity(quantity);
		cvo.setShipping_fee(gvo.getShipping_fee());
		
		if(mvo!=null) {
			cvo.setUser_id(mvo.getUser_id());
			
			//갱신된 마일리지 정보를 로그인 session에 반영
			List<MileageVO> mileageChk = memberService.getMileage(mvo.getUser_id());
			int resultMileage = 0;
			
			if(mileageChk!=null) {
				for(int i=0; i<mileageChk.size(); i++) {
					resultMileage += mileageChk.get(i).getAccumulate_price();
				}
			}
			
			mvo.setMileage(resultMileage);
			session.setAttribute("loginMember", mvo);
			
		}else {
			cvo.setUser_id("noneMember");
		}
		
		cvoItems.add(cvo);
		
		model.addAttribute("oderFrom", "fromGoodsOne");
		model.addAttribute("orderInfo", cvoItems);
		
		return "/goods/orderForm";
	}
	
	//상품 주문 (장바구니 구매)
	@RequestMapping(value="/orderFromCart", method=RequestMethod.GET)
	public String attemptOrderFromCart(HttpSession session, HttpSession tempSession, Model model) throws Exception {
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		List<CartVO> cvoItems = null;
		
		if(mvo!=null) {
			cvoItems = goodsService.viewCart(mvo.getUser_id());
			
			//갱신된 마일리지 정보를 로그인 session에 반영
			List<MileageVO> mileageChk = memberService.getMileage(mvo.getUser_id());
			int resultMileage = 0;
			
			if(mileageChk!=null) {
				for(int i=0; i<mileageChk.size(); i++) {
					resultMileage += mileageChk.get(i).getAccumulate_price();
				}
			}
			
			mvo.setMileage(resultMileage);
			session.setAttribute("loginMember", mvo);
			
		}else {
			cvoItems = (ArrayList) tempSession.getAttribute("tempCartSession");
		}
		
		model.addAttribute("oderFrom", "fromCart");
		model.addAttribute("orderInfo", cvoItems);
		
		return "/goods/orderForm";
	}

	//잘못된 주문서 접근
	@RequestMapping(value="/orderConfirm", method=RequestMethod.GET)
	public String wrongOrderConfirm() {
		return "/goods/orderComplete";
	}
	
	//주문서 작성
	@RequestMapping(value="/orderConfirm", method=RequestMethod.POST)
	public String orderConfirm(
			@RequestParam(value="oderFrom", defaultValue="notOrder") String oderFrom,
			@RequestParam(value="name") String name,
			@RequestParam(value="discount_price", defaultValue="0") int discount_price,
			@RequestParam(value="payment") String payment,
			@RequestParam(value="credit_cart_pay_value") String credit_cart_pay_value,
			@RequestParam(value="account_transfer_pay_value") String account_transfer_pay_value,
			@RequestParam(value="back_pay_value") String back_pay_value,
			@RequestParam(value="quantity", defaultValue="1") int quantity,//상품페이지에서 구매한 경우에만 사용
			@RequestParam(value="shipping_fee", defaultValue="0") int shipping_fee,//상품페이지에서 구매한 경우에만 사용
			@RequestParam(value="post_code") String post_code,
			@RequestParam(value="address") String address,
			HttpSession session, HttpSession tempSession, GoodsVO gvo, Model model) throws Exception {
		
		String resultUrl = oderFrom.equals("notOrder")?"redirect:/":"redirect:/";
		String memberOrderChk = "n";
		String uuidOrderNumber = UUID.randomUUID().toString();
		String orderResultMsg = null;
		int goodsInsert = 0;
		boolean odrerConfirmChk = false;
		
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		List<CartVO> cvoItems = (ArrayList) tempSession.getAttribute("tempCartSession");
		List<OrderVO> ovoItems = new ArrayList<OrderVO>(); 
		
		if(payment.equals("credit_cart")) {payment = payment+"/"+credit_cart_pay_value;}
		else if(payment.equals("account_transfer")) {payment = payment+"/"+account_transfer_pay_value;}
		else if(payment.equals("bank_transfer")) {payment = payment+"/"+back_pay_value;}
		
		
		if(oderFrom.equals("fromCart")) {
			//장바구니에서 주문
			
			OrderVO ovo = null;
			resultUrl = "/goods/orderComplete";
			
			if(mvo!=null) {
				cvoItems = goodsService.viewCart(mvo.getUser_id()); 
				memberOrderChk = "y";
				//장바구니 삭제
				goodsService.cartAllDelete(mvo.getUser_id());
			}else if(cvoItems!=null) { 
				memberOrderChk = "n";
				//장바구니 삭제
				tempSession.removeAttribute("tempCartSession");
			}
			
			if(cvoItems!=null) {
				int all_price = 0;
				for(int i=0; i<cvoItems.size(); i++) {
					all_price += cvoItems.get(i).getSell_price() * cvoItems.get(i).getQuantity();
				}
				
				for(int i=0; i<cvoItems.size(); i++) {
					ovo = new OrderVO();
					ovo.setOrder_number(uuidOrderNumber);
					ovo.setGoods_id(cvoItems.get(i).getGoods_id());
					ovo.setGoods_image(cvoItems.get(i).getGoods_image());
					ovo.setGoods_name(cvoItems.get(i).getGoods_name());
					ovo.setCategory_id(cvoItems.get(i).getCategory_id());
					ovo.setUser_id(cvoItems.get(i).getUser_id());
					ovo.setName(name);
					ovo.setOrder_status("결제완료");
					ovo.setMember_order(memberOrderChk);
					ovo.setSell_price(cvoItems.get(i).getSell_price() * cvoItems.get(i).getQuantity());
					ovo.setAll_price(all_price);
					ovo.setDiscount_price(discount_price); 	
					ovo.setQuantity(cvoItems.get(i).getQuantity());
					ovo.setShipping_fee(cvoItems.get(i).getShipping_fee());
					ovo.setPost_code(post_code);
					ovo.setAddress(address);
					ovo.setPayment(payment);
					
					//상품 재고 확인후 구매 수량보다 재고가 많은 경우에만 주문처리
					GoodsVO goodsAmount = goodsService.getGoodsAmount(ovo.getGoods_id());
					if(goodsAmount!=null) {
						if(ovo.getQuantity() <= goodsAmount.getAmount()) {
							//재고 차감
							goodsService.deductionGoodsAmount(ovo);
							odrerConfirmChk = true;
						}else {
							odrerConfirmChk = false;
							orderResultMsg="goods_out_of_stock";
						}
					}else {
						odrerConfirmChk = false;
						orderResultMsg = "goods_not_found";
					}
					
					ovoItems.add(ovo);
				}
			}
		}else if(oderFrom.equals("fromGoodsOne")) {
			//상품 상세페이지에서 주문
			resultUrl = "/goods/orderComplete";
			String user_id= "noneMember";
			
			
			if(mvo!=null) {
				cvoItems = goodsService.viewCart(mvo.getUser_id());  
				memberOrderChk = "y";
				user_id = mvo.getUser_id();
			}else { 
				memberOrderChk = "n";
				user_id = "noneMember";
			}
				OrderVO ovo = new OrderVO();
				ovo.setOrder_number(uuidOrderNumber);
				ovo.setGoods_id(gvo.getGoods_id());
				ovo.setGoods_image(gvo.getGoods_image());
				ovo.setGoods_name(gvo.getGoods_name());
				ovo.setCategory_id(gvo.getCategory_id());
				ovo.setUser_id(user_id);
				ovo.setName(name);
				ovo.setOrder_status("결제완료");
				ovo.setMember_order(memberOrderChk);
				ovo.setSell_price(gvo.getSell_price() * quantity);
				ovo.setAll_price(gvo.getSell_price() * quantity);
				ovo.setDiscount_price(discount_price);
				ovo.setQuantity(quantity);
				ovo.setShipping_fee(shipping_fee);
				ovo.setPost_code(post_code);
				ovo.setAddress(address);
				ovo.setPayment(payment);
				
				//상품 재고 확인후 구매 수량보다 재고가 많은 경우에만 주문처리
				GoodsVO goodsAmount = goodsService.getGoodsAmount(ovo.getGoods_id());
				if(goodsAmount!=null) {
					if(ovo.getQuantity() <= goodsAmount.getAmount()) {
						//재고 차감
						goodsService.deductionGoodsAmount(ovo);
						odrerConfirmChk = true;
					}else {
						odrerConfirmChk = false;
						orderResultMsg="goods_out_of_stock";
					}
				}else {
					odrerConfirmChk = false;
					orderResultMsg = "goods_not_found";
				}
				
				ovoItems.add(ovo);
		}
		
		if(odrerConfirmChk) {
			if(mvo!=null) {
				//사용한 만큼의 마일리지 차감
				goodsService.deductionMileage(ovoItems.get(0));
			}
			//주문처리
			goodsInsert = goodsService.orderGoodsInsert(ovoItems); 
			orderResultMsg = "order_success";
		}
		
		if(mvo!=null) {
			//갱신된 마일리지 정보를 로그인 session에 반영
			List<MileageVO> mileageChk = memberService.getMileage(mvo.getUser_id());
			int resultMileage = 0;
			
			if(mileageChk!=null) {
				for(int i=0; i<mileageChk.size(); i++) {
					resultMileage += mileageChk.get(i).getAccumulate_price();
				}
			}
			
			mvo.setMileage(resultMileage);
			session.setAttribute("loginMember", mvo);
		}
		
		model.addAttribute("orderResultMsg", orderResultMsg);
		return resultUrl;
	}
	
	//상품평작성
	@RequestMapping(value="/reply", method=RequestMethod.POST)
	public String goodsReply(ReplyVO rvo) throws Exception {
		
		goodsService.goodsReply(rvo);
		
		return "redirect:/goods/goodsOne?goods_id="+rvo.getGoods_id()+"#goods-reply";
	}
	
	//구매확정
	//orderConfirm
	@ResponseBody
	@RequestMapping(value="/purchaseConfirm", method=RequestMethod.POST)
	public String orderConfirm(	OrderVO ovo, HttpSession session) throws Exception {
		
		String requestMsg =  "fail";
		MemberVO mvo = (MemberVO)session.getAttribute("loginMember");
		
		if(mvo!=null) {
			ovo.setUser_id(mvo.getUser_id());
			
			if(!ovo.getOrder_number().equals("empty") &&!ovo.getGoods_id().equals("empty")) {
				int requestResult = goodsService.purchaseConfirm(ovo);
				
				if(requestResult>=1) {
					requestMsg = "success";

					//마일리지 적립
					goodsService.mileageCountUp(ovo);
					
					//갱신된 마일리지 정보를 로그인 session에 반영
					List<MileageVO> mileageChk = memberService.getMileage(mvo.getUser_id());
					int resultMileage = 0;
					
					if(mileageChk!=null) {
						for(int i=0; i<mileageChk.size(); i++) {
							resultMileage += mileageChk.get(i).getAccumulate_price();
						}
					}
					
					mvo.setMileage(resultMileage);
					session.setAttribute("loginMember", mvo);
				}
			}
		}
		return requestMsg;
	}
	
	//주문 취소/반품 요청
	@ResponseBody
	@RequestMapping(value="/requestOrder", method=RequestMethod.POST)
	public String requestCancel(
			@RequestParam(value="order_number", defaultValue="empty") String order_number,
			@RequestParam(value="goods_id", defaultValue="empty") String goods_id,
			@RequestParam(value="requestType", defaultValue="empty") String requestType
			) throws Exception {
		
		String requestMsg =  "fail";
		
		Map<String, String> requestValue = new HashMap<String, String>();
		requestValue.put("order_number", order_number);
		requestValue.put("goods_id", goods_id);
		requestValue.put("requestType", requestType);
		
		if(!order_number.equals("empty") && (!goods_id.equals("empty") && !requestType.equals("empty"))) {
			int requestResult = goodsService.requestCancel(requestValue);
			
			if(requestResult>=1) {
				requestMsg = "success";
			}
		}
		
		return requestMsg;
	}


}
