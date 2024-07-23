package org.sera.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.goods.domain.GoodsVO;
import org.goods.service.GoodsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	private GoodsService goodsService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception{
		logger.info("Welcome home! The client locale is {}.", locale);
		
		int bestItemCnt = 12;
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		//판매량 상위 12개 조회
		List<GoodsVO> relatedGvo = goodsService.getBestSale(bestItemCnt);
		//추천 상품의 수가 12개 미만인 경우 최근 등록 상품으로 보충
		if(relatedGvo.size()<12) {
			int supportCnt = 12 - relatedGvo.size();
			List<GoodsVO> oilyGvoSupport = goodsService.getGoodsLimitByCount(supportCnt);
			relatedGvo.addAll(oilyGvoSupport);
		}
		model.addAttribute("relatedGoodsInfo", relatedGvo);
		
		//추천 피부 타입별 상품 12개씩 조회
		List<GoodsVO> oilyGvo = goodsService.getGoodsBySkinType("oily_skin", bestItemCnt);
		List<GoodsVO> dryGvo = goodsService.getGoodsBySkinType("dry_skin", bestItemCnt);
		List<GoodsVO> combinationGvo = goodsService.getGoodsBySkinType("combination_skin", bestItemCnt);
		
		//피부별 추천 상품의 수가 12개 미만인 경우 최근 등록순 상품으로 보충
		if(oilyGvo.size() < 12){
			int supportCnt = 12 - oilyGvo.size();
			List<GoodsVO> oilyGvoSupport = goodsService.getGoodsBySkinTypeAll("oily_skin", supportCnt);
			oilyGvo.addAll(oilyGvoSupport);
		}
		if(dryGvo.size() < 12){
			int supportCnt = 12 - dryGvo.size();
			List<GoodsVO> dryGvoSupport = goodsService.getGoodsBySkinTypeAll("dry_skin", supportCnt);
			dryGvo.addAll(dryGvoSupport);
		}
		if(combinationGvo.size() < 12){
			int supportCnt = 12 - combinationGvo.size();
			List<GoodsVO> combiGvoSupport = goodsService.getGoodsBySkinTypeAll("combination_skin", supportCnt);
			combinationGvo.addAll(combiGvoSupport);
		}
		
		model.addAttribute("oily_skin_goods", oilyGvo);
		model.addAttribute("dry_skin_goods", dryGvo);
		model.addAttribute("combination_skin_goods", combinationGvo);
		
		return "index";
	}
	
}
