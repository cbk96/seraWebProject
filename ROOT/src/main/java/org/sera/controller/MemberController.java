package org.sera.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.goods.domain.OrderVO;
import org.goods.service.GoodsService;
import org.member.domain.MemberVO;
import org.member.domain.MileageVO;
import org.sera.domain.PostCodeVO;
import org.sera.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Inject
	private MemberService memberService;
	
	@Inject
	private GoodsService goodsService;
	
	@Autowired
	private BCryptPasswordEncoder bPassEncoder;
	
	final static int PAGE_MAX_ORDER_CNT = 10;
	
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void join() {}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinForm(MemberVO mvo) throws Exception{
		String password = mvo.getUser_pwd();
		password = bPassEncoder.encode(password);
		mvo.setUser_pwd(password);
		mvo.setMember_type("customer");
		
		memberService.insertJoin(mvo);
		return "redirect:/member/login";
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method=RequestMethod.POST)
	public String idChk(HttpServletRequest request) throws Exception{
		String resultMsg = null;
		String inputId = request.getParameter("inputId");
		inputId = inputId.replace(" ", "");
		
		MemberVO mvo = memberService.selectOnId(inputId);
		
		if(!inputId.equals("")) {
			if(mvo!= null ) {
				resultMsg = "canNotUse";
			}else {
				resultMsg = "canUse";
			}
		}else {
			resultMsg = "empty";
		}
	
		return resultMsg;
	}
	
	@ResponseBody
	@RequestMapping(value="/nickChk", method=RequestMethod.POST)
	public String nickChk(HttpServletRequest request) throws Exception{
		String resultMsg = null;
		String inputNickName = request.getParameter("inputNickName");
		inputNickName = inputNickName.replace(" ", "");
		
		MemberVO mvo = memberService.nickChk(inputNickName);
		
		if(!inputNickName.equals("")) {
			if(mvo!= null ) {
				resultMsg = "canNotUse";
			}else {
				resultMsg = "canUse";
			}
		}else {
			resultMsg = "empty";
		}
		return resultMsg;
	}
	
	@ResponseBody
	@RequestMapping(value="/modifyNickChk", method=RequestMethod.POST)
	public String modifyNickChk(HttpServletRequest request, HttpSession session) throws Exception{
		String resultMsg = null;
		String inputNickName = request.getParameter("inputNickName");
		inputNickName = inputNickName.replace(" ", "");
		
		MemberVO loggedMvo = (MemberVO)session.getAttribute("loginMember");
		
		MemberVO mvo = memberService.nickChk(inputNickName);
		
		if(!inputNickName.equals("")) {
			if(mvo== null || loggedMvo.getNick_name().equals(inputNickName)) {
				resultMsg = "canUse";
			}else {
				resultMsg = "canNotUse";
			}
		}else {
			resultMsg = "empty";
		}
		return resultMsg;
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void viewLogin() {}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public void selectLogin(MemberVO mvo, HttpServletRequest request, Model model) throws Exception{
		
		String resultMsg = "notFoundId";
		
		MemberVO chkMvo = memberService.selectOnId(mvo.getUser_id());
		
		HttpSession session = request.getSession();
		
		if(chkMvo != null) {
			boolean passChk = bPassEncoder.matches(mvo.getUser_pwd(), chkMvo.getUser_pwd());
			if(passChk){
				int mileage = 0 ;
				List<MileageVO> mileageChk = memberService.getMileage(chkMvo.getUser_id());
				if(mileageChk!=null) {
					for(int i=0; i<mileageChk.size(); i++) {
						mileage += mileageChk.get(i).getAccumulate_price();
					}
				}
				chkMvo.setMileage(mileage);
				session.setAttribute("loginMember", chkMvo);
				resultMsg = "foundMember";
			}else {
				session.invalidate();
				resultMsg = "notFoundPass";
			}
		}else {
			resultMsg = "notFoundId";
		}
		
		model.addAttribute("resultMsg",resultMsg);
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/idPwdSearch", method=RequestMethod.GET)
	public void idPwdSearch() throws Exception {}
	
	@ResponseBody
	@RequestMapping(value="/idSearch", method=RequestMethod.POST)
	public String idSearch(HttpServletRequest request) throws Exception{
		String msg = "tmp_empty";
		String inputName = request.getParameter("inputName");
		String inputTel = request.getParameter("inputTel");
		MemberVO mvo = new MemberVO();
		mvo.setName(inputName);
		mvo.setTel(inputTel);
		
		MemberVO dbmvo = memberService.idSearch(mvo);
		
		if(dbmvo!=null) {
			msg = dbmvo.getUser_id()+"_idFound";
		}else {
			msg = "idNotFound";
		}
		
		return msg;
	}
	
	@ResponseBody
	@RequestMapping(value="/pwdSearch", method=RequestMethod.POST)
	public String pwdSearch(HttpServletRequest request) throws Exception {
		String msg = "";
		String inputName = request.getParameter("inputName");
		String inputId = request.getParameter("inputId");
		String inputPwd = request.getParameter("inputPwd");
		
		MemberVO mvo = new MemberVO();
		mvo.setName(inputName);
		mvo.setUser_id(inputId);
		mvo.setUser_pwd(bPassEncoder.encode(inputPwd));
		
		MemberVO dbmvo = memberService.pwdSearch(mvo);
		
		if(dbmvo!=null) {
			memberService.pwdChange(mvo);
			msg = inputPwd+"_pwdNotChange";
		}else {
			msg = "pwdNotChange";
		}
		
		return msg;
	}
	
	@RequestMapping(value="postChk", method=RequestMethod.GET)
	public void postChk() throws Exception{	}
	
	@RequestMapping(value="postChk", method=RequestMethod.POST)
	public void postChk(PostCodeVO pvo, Model model) throws Exception{	
		List<PostCodeVO> pvoList = memberService.searchPostCode(pvo);
		
		if(pvoList.size() > 0) {
			System.out.println("not zero");
			model.addAttribute("pvoList",pvoList);
		}
	}
	
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public void mypage (
			@RequestParam(value="search-key-type", defaultValue="order_number") String searchKeyType, 
			@RequestParam(value="search-key-value", defaultValue="") String searchKeyValue,
			@RequestParam(value="day-begin", defaultValue="empty") String dayBegin,
			@RequestParam(value="day-end", defaultValue="empty") String dayEnd,
			@RequestParam(value="list-sort", defaultValue="asc") String listSort,
			@RequestParam(value="page_cnt", defaultValue = "1") int select_page_cnt,
			HttpSession session, Model model) throws Exception{
		
		MemberVO mvo  = (MemberVO)session.getAttribute("loginMember");
		
		int waiting_pay = 0;
		int complete_pay = 0;
		int prepa_delivery = 0;
		int shipping = 0;
		int complete_delivery = 0;
		int complete_order = 0;
		int cancel_order = 0;
		int product_exchange = 0;
		int return_order = 0;
		
		int allGoodCnt = 0;
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		
		//회원 로그인 여부 체크
		if(mvo!=null) {
			if(dayBegin.equals("empty")) {
				LocalDate today = LocalDate.now().minusMonths(1);
				DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				dayBegin = today.format(dateFormatter);
			}
			if(dayEnd.equals("empty")) {
				LocalDate today = LocalDate.now();
				DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				dayEnd = today.format(dateFormatter);
			}
			
			Map<String,Object> searchKey = new HashMap<String,Object>();
			searchKey.put("user_id", mvo.getUser_id());
			searchKey.put("searchKeyType", searchKeyType);
			searchKey.put("searchKeyValue", searchKeyValue);
			searchKey.put("dayBegin", dayBegin);
			searchKey.put("dayEnd", dayEnd);
			searchKey.put("page_cnt",(select_page_cnt-1)*PAGE_MAX_ORDER_CNT);
			searchKey.put("PAGE_MAX_ORDER_CNT",PAGE_MAX_ORDER_CNT);
			
			//검색조건에 해당되는 주문번호 10개 수집
			List<OrderVO> ovoNumber = goodsService.getOrderNumber(searchKey);
			
			//검색조건에 해당되는 모든 주문번호 수집
			List<OrderVO> ovoAllNumber = goodsService.getAllOrderNumber(searchKey);
			if(ovoAllNumber.size()>0) allGoodCnt = ovoAllNumber.size();
			
			//회원의 모든 주문내역 수집
			List<OrderVO> allOrderStatus = goodsService.getAllOrderStatus(mvo.getUser_id());
			
			//주문번호로 주문내역 수집(같은 주문번호에 속한 주문상품들(한번에 복수의 상품을 주문한 주문건)을 묶어서 출력하기 위해 필요)
			List<List<OrderVO>> allOrders = new ArrayList<List<OrderVO>>();
			
			for(int i=0; i<ovoNumber.size(); i++) {
				List<OrderVO> ovos = goodsService.getOrdersForNumber(ovoNumber.get(i));
				allOrders.add(ovos);
			}
			
			//리스트 페이지 버튼수
			maxPageCnt = (int) Math.ceil((double)allGoodCnt/(double)PAGE_MAX_ORDER_CNT);
			
			//리스트 페이지 버튼 시작값, 끝값
			pageCntBeign = (int) Math.ceil((select_page_cnt-PAGE_MAX_ORDER_CNT)*0.1) 
					* PAGE_MAX_ORDER_CNT +1;
			pageCntEnd = pageCntBeign + (PAGE_MAX_ORDER_CNT -1) > maxPageCnt 
					? maxPageCnt : pageCntBeign+(PAGE_MAX_ORDER_CNT-1);
			
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
			
			//주문상태별 주문수 가져오기
			if(allOrderStatus!=null) {
				for(int i=0; i<allOrderStatus.size(); i++) {
					if(allOrderStatus.get(i).getOrder_status().equals("결제대기")) {
						waiting_pay+=1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("결제완료")) {
						complete_pay += 1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("배송준비중")) {
						prepa_delivery +=1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("배송중")) {
						shipping+=1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("배송완료")) {
						complete_delivery+=1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("구매확정")) {
						complete_order+=1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("취소")) {
						cancel_order+=1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("교환")) {
						product_exchange+=1;
					}else if(allOrderStatus.get(i).getOrder_status().equals("반품")) {
						return_order+=1;
					}
				}
			}
			
			Map<String, Integer> orderStauts = new HashMap<String, Integer>();
			orderStauts.put("waiting_pay", waiting_pay);
			orderStauts.put("complete_pay", complete_pay);
			orderStauts.put("prepa_delivery", prepa_delivery);
			orderStauts.put("shipping", shipping);
			orderStauts.put("complete_delivery", complete_delivery);
			orderStauts.put("complete_order", complete_order);
			orderStauts.put("cancel_order", cancel_order);
			orderStauts.put("product_exchange", product_exchange);
			orderStauts.put("return_order", return_order);
			
			model.addAttribute("searchKey", searchKey);
			model.addAttribute("allGoodCnt", allGoodCnt);
			model.addAttribute("select_page_cnt", select_page_cnt);
			model.addAttribute("pageCntBeign", pageCntBeign);
			model.addAttribute("pageCntEnd", pageCntEnd);
			model.addAttribute("maxPageCnt", maxPageCnt);
			
			model.addAttribute("orderStauts", orderStauts);
			model.addAttribute("allOrders", allOrders);
		}
		
	}
	
	@RequestMapping(value="memberModify", method=RequestMethod.GET)
	public void memberModify () throws Exception{}
	
	@RequestMapping(value="memberModify", method=RequestMethod.POST)
	public void memberModify (HttpSession session, MemberVO mvo, Model model) throws Exception{
		String password = mvo.getUser_pwd();
		password = bPassEncoder.encode(password);
		mvo.setUser_pwd(password);
		
		int modifyChk = memberService.memberModify(mvo);
		
		if(modifyChk==1) {
			MemberVO remvo = memberService.loadAccount(mvo.getUser_id());
			session.setAttribute("loginMember", remvo);
			
			model.addAttribute("modifyMsg","modifySuccess");
		}else {
			model.addAttribute("modifyMsg","modifyFail");
		}
	}
	
	@RequestMapping(value="memberDelete", method=RequestMethod.GET)
	public void memberDelete() {}
	
	@RequestMapping(value="memberDelete", method=RequestMethod.POST)
	public String memberDelete(HttpSession sessoin, MemberVO mvo) throws Exception {
		int mileDelChk = 0;
		int cartDelChk = 0;
		
		mileDelChk = goodsService.mileageDelete(mvo);
		cartDelChk = goodsService.cartDelete(mvo);
		
		if(mileDelChk>=1 && cartDelChk>=1) {
			memberService.memberDelete(mvo);
			sessoin.invalidate();
		}
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping(value="searchingAccount", method=RequestMethod.POST)
	public String searchingAccount(MemberVO inputMvo, HttpSession session) throws Exception {
		String msg = "not_found_account";
		
		MemberVO loggedMvo = (MemberVO)session.getAttribute("loginMember");
		MemberVO chkMvo = memberService.searchingAccount(inputMvo.getUser_id());
		
		if(chkMvo!=null && loggedMvo!=null) {
			boolean searchingPwdMatch = bPassEncoder.matches(inputMvo.getUser_pwd(), chkMvo.getUser_pwd());
			boolean loggedIdMatch = inputMvo.getUser_id().equals(loggedMvo.getUser_id());
			
			if(searchingPwdMatch && loggedIdMatch) {msg = "found_account";} else {msg = "not_found_account";}
		}else {msg = "not_found_account";}
		
		
		return msg;
	}

}
