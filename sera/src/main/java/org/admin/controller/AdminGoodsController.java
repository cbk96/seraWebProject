package org.admin.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.admin.domain.EmployeeVO;
import org.admin.service.AdminGoodsService;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.goods.service.GoodsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/goods/*")
public class AdminGoodsController {
	
	@Inject
	private AdminGoodsService adminGoodsService;
	
	@Inject
	private GoodsService goodService;
	
	public static final int PAGE_MAX_AD_GOODS_CNT = 10;
	public static final int PAGE_MAX_BUTTON_CNT = 10;
	
	//상품목록 조회
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String goodsList(@RequestParam(value="saleActive", defaultValue="for_sale") String saleActive, HttpSession session,Model model) throws Exception{
		EmployeeVO loginEvo = (EmployeeVO)session.getAttribute("loginEmp");
		
		int allGoodCnt = 0;
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		
		if(loginEvo!=null) {
			String depart = loginEvo.getDepart();
			int level = loginEvo.getLevel();
			
			List<CategoryVO> cvoMainType = goodService.getMainType();
			List<CategoryVO> cvoSubType = goodService.getSubType();
			
			if(!saleActive.equals("for_sale") && !saleActive.equals("goods_delete")) {
				saleActive="for_sale";
			}
			
			Map<String,Object> searchKey = new HashMap<String,Object>();
			searchKey.put("saleActive", saleActive);
			searchKey.put("page_cnt",0);
			searchKey.put("PAGE_MAX_AD_GOODS_CNT",PAGE_MAX_AD_GOODS_CNT);
			
			if(level>=9) {
				searchKey.put("depart", "all");
			}else {
				searchKey.put("depart", depart);
			}
			
			//한 페이지에 표시할 상품 목록
			List<GoodsVO> gvo = adminGoodsService.getGoodsListDefault(searchKey);
			
			//검색된 전체 상품 수
			allGoodCnt = adminGoodsService.getGoodsListDefaultCnt(searchKey);
			
			//리스트 페이지 버튼수
			maxPageCnt = (int) Math.ceil((double)allGoodCnt/(double)PAGE_MAX_AD_GOODS_CNT);
			
			//리스트 페이지 버튼 시작값, 끝값
			pageCntBeign = (int) Math.ceil((1-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
			pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
			
			model.addAttribute("allGoodCnt", allGoodCnt);
			model.addAttribute("select_page_cnt", 1);
			model.addAttribute("pageCntBeign", pageCntBeign);
			model.addAttribute("pageCntEnd", pageCntEnd);
			model.addAttribute("maxPageCnt", maxPageCnt);
			
			model.addAttribute("saleActive", saleActive);
			model.addAttribute("mainType",cvoMainType);
			model.addAttribute("subType",cvoSubType);
			model.addAttribute("goodsList", gvo);
		}
		return "/admin/goods/goodsList";
	}
	
	//상품목록 검색
	@RequestMapping(value="/", method=RequestMethod.POST)
	public String goodsListSearch(
			@RequestParam(value="list-page-cnt", defaultValue="1") int listPageCnt,
			@RequestParam(value="saleActive", defaultValue="for_sale") String saleActive,
			@RequestParam(value="search-key-type") String searchKeyType, 
			@RequestParam(value="search-key-value") String searchKeyValue,
			@RequestParam(value="main_type") String mainType,
			@RequestParam(value="sub_type_cate_id", defaultValue="not_choose" ) String cateId,
			@RequestParam(value="price-ragne-select") String priceRagneSelect,
			@RequestParam(value="price-begin", defaultValue="0") String priceBegin,
			@RequestParam(value="price-end", defaultValue="-1") String priceEnd,
			@RequestParam(value="date-range-select") String dateRangeSelect,
			@RequestParam(value="day-begin") String dayBegin,
			@RequestParam(value="day-end") String dayEnd,
			@RequestParam(value="list-sort") String listSort,
			@RequestParam(value="turn-select", defaultValue="goods_reg_date") String turnSelect, 
			@RequestParam(value="btn-expand-remember", defaultValue="expand-not-active") String btnExpandRemem,
			@RequestParam(value="page_cnt", defaultValue = "1") int select_page_cnt,
			HttpSession session, Model model) throws Exception{
		
		int allGoodCnt = 0;
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		select_page_cnt = select_page_cnt<=0?1:select_page_cnt;
		
		if(Integer.parseInt(priceEnd)<1) {
			priceEnd = adminGoodsService.getMaxprice(priceRagneSelect);
		}
		
		EmployeeVO loginEvo = (EmployeeVO)session.getAttribute("loginEmp");
		if(loginEvo!=null) {
			int level = loginEvo.getLevel();
			String depart = loginEvo.getDepart();
			if(level>=9) {depart = "all";}
			
			if(!saleActive.equals("for_sale") && !saleActive.equals("goods_delete")) {
				saleActive="for_sale";
			}
			
			Map<String,Object> searchKey = new HashMap<String,Object>();
			searchKey.put("saleActive", saleActive);
			searchKey.put("searchKeyType", searchKeyType);
			searchKey.put("searchKeyValue", searchKeyValue);
			searchKey.put("level", level);
			searchKey.put("depart", depart);
			searchKey.put("inputMainType", mainType);
			searchKey.put("inputCateId", cateId);
			searchKey.put("priceRagneSelect", priceRagneSelect);
			searchKey.put("priceBegin", priceBegin);
			searchKey.put("priceEnd", priceEnd);
			searchKey.put("dateRangeSelect", dateRangeSelect);
			searchKey.put("dayBegin", dayBegin);
			searchKey.put("dayEnd", dayEnd);
			searchKey.put("listSort", listSort);
			searchKey.put("turnSelect", turnSelect);
			searchKey.put("btnExpandRemem", btnExpandRemem);
			searchKey.put("page_cnt",(select_page_cnt-1)*PAGE_MAX_AD_GOODS_CNT);
			searchKey.put("PAGE_MAX_AD_GOODS_CNT",PAGE_MAX_AD_GOODS_CNT);
			
			//검색 옵션에 표시할 대분류 카테고리와 중분류 카테고리 목록
			List<CategoryVO> cvoMainType = goodService.getMainType();
			List<CategoryVO> cvoSubType = goodService.getSubType();
			
			//한 페이지에 표시할 상품 목록 cateId cateId
			List<GoodsVO> gvo = adminGoodsService.getGoodsListSearch(searchKey);
			
			//검색된 전체 상품 수
			allGoodCnt = adminGoodsService.getGoodsListSearchCnt(searchKey);
			
			//리스트 페이지 버튼수
			maxPageCnt = (int) Math.ceil((double)allGoodCnt/(double)PAGE_MAX_AD_GOODS_CNT);
			
			//리스트 페이지 버튼 시작값, 끝값
			pageCntBeign = (int) Math.ceil((select_page_cnt-PAGE_MAX_BUTTON_CNT)*0.1) 
					* PAGE_MAX_BUTTON_CNT +1;
			pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt 
					? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
			
			
			model.addAttribute("allGoodCnt", allGoodCnt);
			model.addAttribute("select_page_cnt", select_page_cnt);
			model.addAttribute("pageCntBeign", pageCntBeign);
			model.addAttribute("pageCntEnd", pageCntEnd);
			model.addAttribute("maxPageCnt", maxPageCnt);
			
			model.addAttribute("searchKey",searchKey);
			model.addAttribute("saleActive", saleActive);
			model.addAttribute("mainType",cvoMainType);
			model.addAttribute("subType",cvoSubType);
			model.addAttribute("goodsList", gvo);
		}
		return "/admin/goods/goodsList";
	}
	
	//상품등록
	@RequestMapping(value="goodsRegist", method=RequestMethod.GET)
	public void goodsRegist(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		EmployeeVO emp = (EmployeeVO)session.getAttribute("loginEmp");
		
		if(emp!=null) {
			String webPath = "/resources/images/goods/";
			String folderPath = request.getSession().getServletContext().getRealPath(webPath);
			String imageUploadPath = "";
			
			LocalDate today = LocalDate.now();
			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
			String todayFormat = today.format(dateFormatter);
			
			try {
				File uploadPath = new File(folderPath);
				
				if(!uploadPath.exists()) {uploadPath.mkdir(); }
				String[] files = uploadPath.list();
				imageUploadPath = todayFormat+emp.getEmp_id()+files.length;
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			List<CategoryVO> cvoMainType = goodService.getMainType();
			List<CategoryVO> cvoSubType = goodService.getSubType();
			
			model.addAttribute("imageUploadPath", imageUploadPath);
			model.addAttribute("mainType",cvoMainType);
			model.addAttribute("subType",cvoSubType);
		}
		
	}
	
	@RequestMapping(value="goodsRegist", method=RequestMethod.POST)
	public void goodsRegistForm(GoodsVO gvo, Model model) throws Exception {
		
		String resultMsg = "registFail";
		
		int insertChk = adminGoodsService.goodsInsert(gvo);
		
		if(insertChk==1) {
			resultMsg = "registSuccess";
		}else {resultMsg = "registFail";}
		
		model.addAttribute("resultMsg", resultMsg);
	}
	
	//상품일련번호 중복 여부 체크
	@ResponseBody
	@RequestMapping(value="/goodsIdChk", method=RequestMethod.POST)
	public String idChk(HttpServletRequest request) throws Exception{
		StringBuffer stringBuffer = new StringBuffer();
		String resultMsg = null;
		String goodsId = request.getParameter("goodsId");
		goodsId = goodsId.replace(" ", "");
		int codePointChkCnt = 0;
		
		GoodsVO gvo = adminGoodsService.selectGoodsOne(goodsId);
		
		if(!goodsId.equals("")) {
			
			for(int i=0; i<goodsId.length(); i++) {
				int codePoint = goodsId.codePointAt(i);
				if(codePoint<0 || codePoint>255) {codePointChkCnt+=1;}
			}
			
			if(codePointChkCnt>=1) {
				resultMsg = "onlyCanUseEng";
			}else {
				if(gvo!= null ) {
					resultMsg = "canNotUse";
				}else {
					resultMsg = "canUse";
				}
			}
		}else {
			resultMsg = "empty";
		}
	
		return resultMsg;
	}
		
	//상품 정보 조회(관리자용)
	@RequestMapping(value="goodsOneDetail", method=RequestMethod.GET)
	public String goodsOneDetail(HttpServletRequest request, HttpSession session, @RequestParam(value="goods_id") String goodsId, Model model) throws Exception{
		
		EmployeeVO emp = (EmployeeVO)session.getAttribute("loginEmp");
		String returnUrl = "/admin/goods/goodsOneDetail";
		
		if(emp!=null) {
			
			GoodsVO gvo = adminGoodsService.selectGoodsOne(goodsId);
			
			String webPath = "/resources/images/goods/";
			String folderPath = request.getSession().getServletContext().getRealPath(webPath);
			String imageUploadPath = "";
			
			LocalDate today = LocalDate.now();
			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
			String todayFormat = today.format(dateFormatter);
			
			try {
				File uploadPath = new File(folderPath);
				
				if(!uploadPath.exists()) {uploadPath.mkdir(); }
				String[] files = uploadPath.list();
				imageUploadPath = todayFormat+emp.getEmp_id()+files.length;
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			List<CategoryVO> cvoMainType = goodService.getMainType();
			List<CategoryVO> cvoSubType = goodService.getSubType();
			
			model.addAttribute("imageUploadPath", imageUploadPath);
			model.addAttribute("mainType",cvoMainType);
			model.addAttribute("subType",cvoSubType);
			
			if(gvo!=null) {	
				model.addAttribute("goodsInfo", gvo);
				if(gvo.getSale_active().equals("d")) {returnUrl = "/admin/goods/deletedOneDetail";}
			}
		}
		
		return returnUrl;
	}
	
	//상품 정보 수정 처리
	@RequestMapping(value="goodsModify", method=RequestMethod.POST)
	public String goodsModify(GoodsVO gvo, RedirectAttributes rtts) throws Exception{
		int modifyResult = adminGoodsService.goodsModify(gvo);
		
		if(modifyResult==1) {
			rtts.addFlashAttribute("modifyMsg","modifySuccess");
		}else {
			rtts.addFlashAttribute("modifyMsg","modifyFail");
		}
		
		return "redirect:/admin/goods/goodsOneDetail?goods_id="+gvo.getGoods_id();
	}
	
	//상품 삭제 처리
	@RequestMapping(value="goodsDelete", method=RequestMethod.POST)
	public String goodsDelete(GoodsVO gvo, RedirectAttributes rtts) throws Exception{
		int modifyResult = adminGoodsService.goodsDelete(gvo);
		
		if(modifyResult==1) {
			rtts.addFlashAttribute("modifyMsg","deleteSuccess");
		}else {
			rtts.addFlashAttribute("modifyMsg","deleteFail");
		}
		
		return "redirect:/admin/goods/goodsOneDetail?goods_id="+gvo.getGoods_id();
	}
	
	//상품 영구 삭제 처리
	@RequestMapping(value="goodsHardDelete", method=RequestMethod.POST)
	public String goodsHardDelete(GoodsVO gvo, RedirectAttributes rtts) throws Exception{
		int modifyResult = adminGoodsService.goodsHardDelete(gvo);
		
		if(modifyResult==1) {
			rtts.addFlashAttribute("modifyMsg","hardDeleteSuccess");
		}else {
			rtts.addFlashAttribute("modifyMsg","hardDeleteFail");
		}
		
		return "redirect:/admin/goods/goodsOneDetail?goods_id="+gvo.getGoods_id();
	}
	
	//삭제 상품 복원 처리
	@RequestMapping(value="goodsRestore", method=RequestMethod.POST)
	public String goodsRestore(GoodsVO gvo, RedirectAttributes rtts) throws Exception{
		int modifyResult = adminGoodsService.goodsRestore(gvo);
		
		if(modifyResult==1) {
			rtts.addFlashAttribute("modifyMsg","restoreSuccess");
		}else {
			rtts.addFlashAttribute("modifyMsg","restoreFail");
		}
		
		return "redirect:/admin/goods/goodsOneDetail?goods_id="+gvo.getGoods_id();
	}
	
	//카테고리 목록 수집
	@RequestMapping(value="categoryList", method=RequestMethod.GET)
	public void categoryList(Model model) throws Exception{
		List<CategoryVO> cvo = adminGoodsService.getCategoryList();
		
		model.addAttribute("categoryList",cvo);
	}

}
