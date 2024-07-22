package org.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.admin.domain.EmployeeVO;
import org.admin.service.AdminMemberService;
import org.goods.domain.CategoryVO;
import org.goods.domain.GoodsVO;
import org.member.domain.MemberVO;
import org.sera.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/member/*")
public class AdminMemberController {
	
	@Inject
	private AdminMemberService adminMemberService;
	
	@Inject
	private MemberService memberService;
	
	public static final int PAGE_MAX_MEMBER_CNT = 10;
	public static final int PAGE_MAX_BUTTON_CNT = 10;

	//고객목록 조회
		@RequestMapping(value="/memberList", method=RequestMethod.GET)
		public void memberList(@RequestParam(value="active", defaultValue="yes") String active, 
				@RequestParam(value="black_list", defaultValue="no") String blackList, HttpSession session,Model model) throws Exception{
			
			int allMemberCnt = 0;
			int maxPageCnt = 1;
			int pageCntBeign = 1;
			int pageCntEnd = 1;
			
			EmployeeVO loggedEvo = (EmployeeVO)session.getAttribute("loginEmp");
			
			if(loggedEvo!=null) {
				String memberType = "active";
				
				if(!active.equals("yes") && !active.equals("no")) {active="yes";}
				if(!blackList.equals("yes") && !blackList.equals("no")) {blackList="no";}
				if(blackList.equals("yes")) {
					memberType="blackList";
				}else {
					if(active.equals("no")) {
						memberType = "notActive";
					}else {
						memberType = "active";
					}
				}
				
				Map<String,Object> searchKey = new HashMap<String,Object>();
				searchKey.put("active", active);
				searchKey.put("blackList", blackList);
				searchKey.put("page_cnt",0);
				searchKey.put("PAGE_MAX_MEMBER_CNT",PAGE_MAX_MEMBER_CNT);
				
				//한 페이지에 표시할 회원 목록
				List<MemberVO> mvo = adminMemberService.getMemberListDefault(searchKey);
				
				//검색된 전체 회원 수
				allMemberCnt = adminMemberService.getMemberListDefaultCnt(searchKey);
				
				//리스트 페이지 버튼수
				maxPageCnt = (int) Math.ceil((double)allMemberCnt/(double)PAGE_MAX_MEMBER_CNT);
				
				//리스트 페이지 버튼 시작값, 끝값
				pageCntBeign = (int) Math.ceil((1-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
				pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
				
				model.addAttribute("allMemberCnt", allMemberCnt);
				model.addAttribute("select_page_cnt", 1);
				model.addAttribute("pageCntBeign", pageCntBeign);
				model.addAttribute("pageCntEnd", pageCntEnd);
				model.addAttribute("maxPageCnt", maxPageCnt);
				
				model.addAttribute("active", active);
				model.addAttribute("blackList", blackList);
				model.addAttribute("memberType", memberType);
				model.addAttribute("memberList", mvo);
			}
		}
		
		//고객목록 검색
		@RequestMapping(value="/memberList", method=RequestMethod.POST)
		public void memberListSearch(
				@RequestParam(value="active", defaultValue="yes") String active,
				@RequestParam(value="black_list", defaultValue="no") String blackList,
				@RequestParam(value="search-key-type") String searchKeyType, 
				@RequestParam(value="search-key-value") String searchKeyValue,
				@RequestParam(value="grade", defaultValue="all") String grade,
				@RequestParam(value="gender", defaultValue="all") String gender,
				@RequestParam(value="skin_type", defaultValue="all") String skinType,
				@RequestParam(value="access_route", defaultValue="all") String accessRoute,
				@RequestParam(value="date-range-select") String dateRangeSelect,
				@RequestParam(value="day-begin") String dayBegin,
				@RequestParam(value="day-end") String dayEnd,
				@RequestParam(value="list-sort", defaultValue="desc") String listSort,
				@RequestParam(value="turn-select", defaultValue="goods_reg_date") String turnSelect, 
				@RequestParam(value="btn-expand-remember", defaultValue="expand-not-active") String btnExpandRemem,
				@RequestParam(value="page_cnt", defaultValue = "1") int select_page_cnt,
				HttpSession session, Model model) throws Exception{
			
			int allMemberCnt = 0;
			int maxPageCnt = 1;
			int pageCntBeign = 1;
			int pageCntEnd = 1;
			select_page_cnt = select_page_cnt<=0?1:select_page_cnt;
			
			EmployeeVO loginEvo = (EmployeeVO)session.getAttribute("loginEmp");
			
			if(loginEvo!=null) {
				String level = loginEvo.getLevel()+"";
				
				String memberType = "active";
				
				if(!active.equals("yes") && !active.equals("no")) {active="yes";}
				if(!blackList.equals("yes") && !blackList.equals("no")) {blackList="no";}
				if(blackList.equals("yes")) {
					memberType="blackList";
				}else {
					if(active.equals("no")) {
						memberType = "notActive";
					}else {
						memberType = "active";
					}
				}
				
				Map<String,Object> searchKey = new HashMap<String,Object>();
				
				searchKey.put("active", active);
				searchKey.put("blackList", blackList);
				searchKey.put("searchKeyType", searchKeyType);
				searchKey.put("searchKeyValue", searchKeyValue);
				searchKey.put("grade", grade);
				searchKey.put("gender", gender);
				searchKey.put("skinType", skinType);
				searchKey.put("accessRoute", accessRoute);
				searchKey.put("dateRangeSelect", dateRangeSelect);
				searchKey.put("dayBegin", dayBegin);
				searchKey.put("dayEnd", dayEnd);
				searchKey.put("listSort", listSort);
				searchKey.put("turnSelect", turnSelect);
				searchKey.put("btnExpandRemem", btnExpandRemem);
				searchKey.put("page_cnt", (select_page_cnt-1)*PAGE_MAX_MEMBER_CNT);
				searchKey.put("PAGE_MAX_MEMBER_CNT",PAGE_MAX_MEMBER_CNT);
				
				
				//한 페이지에 표시할 회원 목록
				List<MemberVO> mvo = adminMemberService.memberListSearch(searchKey);
				
				//검색된 전체 회원 수
				allMemberCnt = adminMemberService.memberListSearchCnt(searchKey);
				
				//리스트 페이지 버튼수
				maxPageCnt = (int) Math.ceil((double)allMemberCnt/(double)PAGE_MAX_MEMBER_CNT);
				
				//리스트 페이지 버튼 시작값, 끝값
				pageCntBeign = (int) Math.ceil((select_page_cnt-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
				pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
				
				model.addAttribute("allMemberCnt", allMemberCnt);
				model.addAttribute("select_page_cnt", select_page_cnt);
				model.addAttribute("pageCntBeign", pageCntBeign);
				model.addAttribute("pageCntEnd", pageCntEnd);
				model.addAttribute("maxPageCnt", maxPageCnt);
				
				model.addAttribute("searchKey", searchKey);
				model.addAttribute("active", active);
				model.addAttribute("blackList", blackList);
				model.addAttribute("memberType", memberType);
				model.addAttribute("memberList", mvo);
			}
			
		}
		
		//회원 상세 정보 열람
		@RequestMapping(value="/memberOne", method=RequestMethod.GET)
		public String memberOne(@RequestParam(value="user_id", defaultValue="") String user_id, Model model)  throws Exception{
			MemberVO mvo = memberService.selectOnId(user_id);
			
			model.addAttribute("memberInfo", mvo);
			
			return "/admin/member/memberOne";
		}
		
		//회원 상세 정보 수정
		@RequestMapping(value="/memberOneModify", method=RequestMethod.POST)
		public String  memberOneModify(MemberVO mvo, RedirectAttributes rtts) throws Exception{
			if(mvo.getActive().equals("yes")) {
				mvo.setActive_conver_reson("");
			}
			if(mvo.getBlack_list().equals("no")) {
				mvo.setBlack_list_reson("");
			}
			
			int resultRow = adminMemberService.memberOneModify(mvo);
			
			if(resultRow==1) {
				rtts.addFlashAttribute("modifyMsg","modifySuccess");
			}else {
				rtts.addFlashAttribute("modifyMsg","modifyFail");
			}
			
			return "redirect:/admin/member/memberOne?user_id="+mvo.getUser_id();
		}
		
		//휴면 회원 상세 정보 열람
		@RequestMapping(value="/sleeperOne", method=RequestMethod.GET)
		public String sleeperOne(@RequestParam(value="user_id", defaultValue="") String user_id, Model model)  throws Exception{
			MemberVO mvo = memberService.selectOnId(user_id);
			
			model.addAttribute("memberInfo", mvo);
			
			return "/admin/member/sleeperOne";
		}
		
		//휴면 회원 상세 정보 수정
		@RequestMapping(value="/sleeperOneModify", method=RequestMethod.POST)
		public String  sleeperOneModify(MemberVO mvo, RedirectAttributes rtts) throws Exception{
			int resultRow = adminMemberService.sleeperConver(mvo.getUser_id());
			
			if(resultRow==1) {
				rtts.addFlashAttribute("converMsg","converSuccess");
			}else {
				rtts.addFlashAttribute("converMsg","converFail");
			}
			
			return "redirect:/admin/member/memberList?active=no";
		}
		
		//블랙리스트 회원 상세 정보 열람
		@RequestMapping(value="/blackOne", method=RequestMethod.GET)
		public String blackOne(@RequestParam(value="user_id", defaultValue="") String user_id, Model model)  throws Exception{
			MemberVO mvo = memberService.selectOnId(user_id);
			
			model.addAttribute("memberInfo", mvo);
			
			return "/admin/member/blackOne";
		}
		
		//블랙리스트 회원 상세 정보 수정
		@RequestMapping(value="/blackOneModify", method=RequestMethod.POST)
		public String  blackOneModify(MemberVO mvo, RedirectAttributes rtts) throws Exception{
			int resultRow = adminMemberService.blacklistConver(mvo.getUser_id());
			
			if(resultRow==1) {
				rtts.addFlashAttribute("blacklistConver","converSuccess");
			}else {
				rtts.addFlashAttribute("blacklistConver","converFail");
			}
			
			return "redirect:/admin/member/memberList?black_list=yes";
		}
		
		@ResponseBody
		@RequestMapping(value="/memberDelete", method=RequestMethod.POST)
		public String  memberDelete(@RequestParam(value="user_id", defaultValue="empty") String user_id) throws Exception{
			String resultMsg = "fail";
			
			if(!user_id.equals("empty")) {
				MemberVO mvo = new MemberVO();
				mvo.setUser_id(user_id);
				
				int resultRow = memberService.memberDelete(mvo);
				
				if(resultRow==1) {resultMsg="success";}
			}
			
			
			return resultMsg;
		}
		
		
	
}
