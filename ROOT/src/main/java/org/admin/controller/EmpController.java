package org.admin.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.admin.domain.EmployeeVO;
import org.admin.service.EmpService;
import org.apache.commons.lang3.StringUtils;
import org.member.domain.MemberVO;
import org.sera.service.MemberService;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;

@Controller
@RequestMapping("/admin/emp/*")
public class EmpController {
	
	@Inject
	private EmpService empService;
	
	@Inject
	private MemberService memberService;
	
	@Inject
	private BCryptPasswordEncoder bPassEncoder;
	
	public final static int PAGE_MAX_EMP_CNT = 10;
	public final static int PAGE_MAX_BUTTON_CNT = 10;
	
	@ResponseBody
	@RequestMapping(value="/memberAutoCreate", method=RequestMethod.POST)
	public void memberAutoCreate() throws Exception{
		MemberVO memberDBChk = memberService.selectOnId("admin");
		EmployeeVO empDBChk = empService.selectOnId("admin");
		String password = bPassEncoder.encode("1234");
		
		if(memberDBChk==null) {
			MemberVO memberInfo = new MemberVO();
			memberInfo.setUser_id("admin");
			memberInfo.setUser_pwd(password);
			memberInfo.setMember_type("admin");
			memberInfo.setName("홍길동");
			memberInfo.setNick_name("관리자");
			memberInfo.setGender("male");
			memberInfo.setSkin_type("oily_skin");
			memberInfo.setTel("010-0000-0000");
			
			memberService.insertJoin(memberInfo);
		}
		
		if(empDBChk==null) {
			EmployeeVO empInfo = new EmployeeVO();
			empInfo.setEmp_id("admin");
			empInfo.setEmp_pwd(password);
			empInfo.setEmp_name("홍길동");
			empInfo.setEmp_nick_name("관리자");
			empInfo.setEmp_tel("010-0000-0000");
			empInfo.setDepart("임시 부서1");
			empInfo.setLevel(9);
			empInfo.setAdmin_approval("1");
			
			empService.insertJoin(empInfo);
		}
	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void empJoin() throws Exception{}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String empJoinInsert(EmployeeVO evo) throws Exception{
		String password = evo.getEmp_pwd();
		password = bPassEncoder.encode(password);
		evo.setEmp_pwd(password);
		evo.setLevel(0);
		
		empService.insertJoin(evo);
		return "redirect:/admin/emp/empList";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void empLogin() throws Exception{}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public void empLoginInsert(EmployeeVO evo, HttpServletRequest request, Model model) throws Exception{

		String resultMsg = "notFoundId";
		
		EmployeeVO chkMvo = empService.selectOnId(evo.getEmp_id());
		
		HttpSession session = request.getSession();
		
		if(chkMvo != null) {
			boolean passChk = bPassEncoder.matches(evo.getEmp_pwd(), chkMvo.getEmp_pwd());
			if(passChk){
				session.setAttribute("loginEmp", chkMvo);
				resultMsg = "foundMember";
			}else {
				session.invalidate();
				resultMsg = "notFoundPass";
			}
		}else {
			resultMsg = "notFoundId";
		}
		
		model.addAttribute("resultMsg", resultMsg);
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate();
		
		return "redirect:/admin/emp/login";
	}
	
	@ResponseBody
	@RequestMapping(value="/idChk", method=RequestMethod.POST)
	public String idChk(HttpServletRequest request) throws Exception{
		String resultMsg = null;
		String inputId = request.getParameter("inputId");
		inputId = inputId.replace(" ", "");
		
		EmployeeVO evo = empService.selectOnId(inputId);
		
		if(!inputId.equals("")) {
			if(evo!= null ) {
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
		
		EmployeeVO evo = empService.nickChk(inputNickName);
		
		if(!inputNickName.equals("")) {
			if(evo!= null ) {
				resultMsg = "canNotUse";
			}else {
				resultMsg = "canUse";
			}
		}else {
			resultMsg = "empty";
		}
		return resultMsg;
	}
	
	//직원목록 조회
	@RequestMapping(value="/empList", method=RequestMethod.GET)
	public void empList( HttpSession session,Model model) throws Exception{
		
		EmployeeVO loginEvo = (EmployeeVO)session.getAttribute("loginEmp");
		if(loginEvo!=null) {
			String depart = loginEvo.getDepart();
			int level = loginEvo.getLevel();		
			int allEmpCnt = 0;
			int maxPageCnt = 1;
			int pageCntBeign = 1;
			int pageCntEnd = 1;
			
			Map<String, Object> searchKey = new HashMap<String, Object>();
			searchKey.put("page_cnt",0);
			searchKey.put("PAGE_MAX_EMP_CNT",PAGE_MAX_EMP_CNT);
			
			if(loginEvo!=null) {
				if(level==9) {
					depart = "all";
					searchKey.put("depart",depart);
					
					//한 페이지에 표시할 운영자 목록
					List<EmployeeVO> evo = empService.getEmpList(searchKey);
					
					//검색된 전체 운영자 수
					allEmpCnt = empService.getEmpListAllCnt(searchKey);
					
					//리스트 페이지 버튼수
					maxPageCnt = (int) Math.ceil((double)allEmpCnt/(double)PAGE_MAX_EMP_CNT);
					
					//리스트 페이지 버튼 시작값, 끝값
					pageCntBeign = (int) Math.ceil((1-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
					pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
					
					model.addAttribute("empList", evo);
				}else {
					searchKey.put("depart",depart);
					List<EmployeeVO> evo = empService.getEmpList(searchKey);
					
					allEmpCnt = empService.getEmpListAllCnt(searchKey);
					
					//리스트 페이지 버튼수
					maxPageCnt = (int) Math.ceil((double)allEmpCnt/(double)PAGE_MAX_EMP_CNT);
					
					//리스트 페이지 버튼 시작값, 끝값
					pageCntBeign = (int) Math.ceil((1-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
					pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
					
					model.addAttribute("empList", evo);
				}
				
				model.addAttribute("allEmpCnt", allEmpCnt);
				model.addAttribute("select_page_cnt", 1);
				model.addAttribute("pageCntBeign", pageCntBeign);
				model.addAttribute("pageCntEnd", pageCntEnd);
				model.addAttribute("maxPageCnt", maxPageCnt);
			}
		}
	}
	
	//직원목록 검색
	@RequestMapping(value="/empList", method=RequestMethod.POST)
	public void empListSearch(
			@RequestParam(value="search-key-type") String searchKeyType, 
			@RequestParam(value="search-key-value") String searchKeyValue,
			@RequestParam(value="defart") String inputDefart,
			@RequestParam(value="level") String inputLevel,
			@RequestParam(value="date-range-select") String dateRangeSelect,
			@RequestParam(value="day-begin") String dayBegin,
			@RequestParam(value="day-end") String dayEnd, Model model,
			@RequestParam(value="btn-expand-remember", defaultValue="expand-not-active") String btnExpandRemem,
			@RequestParam(value="page_cnt", defaultValue = "1") int select_page_cnt
			) throws Exception{
		
		int allEmpCnt = 0;
		int maxPageCnt = 1;
		int pageCntBeign = 1;
		int pageCntEnd = 1;
		select_page_cnt = select_page_cnt<=0?1:select_page_cnt;
		
		Map<String,Object> searchKey = new HashMap<String,Object>();
		searchKey.put("searchKeyType", searchKeyType);
		searchKey.put("searchKeyValue", searchKeyValue);
		searchKey.put("inputDefart", inputDefart);
		searchKey.put("inputLevel", inputLevel);
		searchKey.put("dateRangeSelect", dateRangeSelect);
		searchKey.put("dayBegin", dayBegin);
		searchKey.put("dayEnd", dayEnd);
		searchKey.put("btnExpandRemem", btnExpandRemem);
		searchKey.put("page_cnt", (select_page_cnt-1)*PAGE_MAX_EMP_CNT);
		searchKey.put("PAGE_MAX_EMP_CNT",PAGE_MAX_EMP_CNT);
		
		System.out.println("select_page_cnt : "+select_page_cnt);
		
		//한페이지에 표시할 운영자 목록
		List<EmployeeVO> evo = empService.getEmpListSearch(searchKey);
		
		//검색된 전체 운영자 수
		allEmpCnt = empService.getEmpListSearchAllCnt(searchKey);
		
		//리스트 페이지 버튼수
		maxPageCnt = (int) Math.ceil((double)allEmpCnt/(double)PAGE_MAX_EMP_CNT);
		
		//리스트 페이지 버튼 시작값, 끝값
		pageCntBeign = (int) Math.ceil((select_page_cnt-PAGE_MAX_BUTTON_CNT)*0.1) * PAGE_MAX_BUTTON_CNT +1;
		pageCntEnd = pageCntBeign + (PAGE_MAX_BUTTON_CNT -1) > maxPageCnt ? maxPageCnt : pageCntBeign+(PAGE_MAX_BUTTON_CNT-1);
		
		model.addAttribute("allEmpCnt", allEmpCnt);
		model.addAttribute("select_page_cnt", select_page_cnt);
		model.addAttribute("pageCntBeign", pageCntBeign);
		model.addAttribute("pageCntEnd", pageCntEnd);
		model.addAttribute("maxPageCnt", maxPageCnt);
		
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("empList", evo);
	}
	
	@RequestMapping(value="/empOne", method=RequestMethod.GET)
	public void empOne(@RequestParam(value="emp_id", defaultValue="") String emp_id, HttpSession session, Model model) throws Exception{
		EmployeeVO loggedEvo = (EmployeeVO)session.getAttribute("loginEmp");
		if(loggedEvo!=null) {
			int empLevel  = loggedEvo.getLevel();
			
			if(empLevel >=9) {
				EmployeeVO modifyEvo = empService.selectOnId(emp_id);
				model.addAttribute("modifyEvo",modifyEvo);
			}
		}
	}
	
	
	@RequestMapping(value="/empOneModify", method=RequestMethod.POST)
	public String empOneModify(EmployeeVO evo, RedirectAttributes rtts) throws Exception{
		
		int resultRow = empService.empOneModify(evo);
		
		if(resultRow==1) {
			rtts.addFlashAttribute("modifyMsg","modifySuccess");
		}else {
			rtts.addFlashAttribute("modifyMsg","modifyFail");
		}
		
		return "redirect:/admin/emp/empOne?emp_id="+evo.getEmp_id();
	}
	
	@RequestMapping(value="/empOneModify", method=RequestMethod.GET)
	public String empOneModifyResult() throws Exception{
		return "redirect:/admin/emp/empOne";
	}
	
	@ResponseBody
	@RequestMapping(value="/approval", method=RequestMethod.POST)
	public String adminApproval(EmployeeVO evo) throws Exception {
		String resultMsg = "fail";
		int resultRow = empService.adminApproval(evo);
		
		if(resultRow==1) {resultMsg="success";}
		
		return resultMsg;
	}
	
	//관리자 퇴사처리
	@ResponseBody
	@RequestMapping(value="/empLeave", method=RequestMethod.POST)
	public String empLeave(@RequestParam("emp_id") String emp_id) throws Exception {
		String resultMsg = "fail";
		int resultRow = empService.empLeave(emp_id);
		
		if(resultRow==1) {resultMsg="success";}
		
		return resultMsg;
	}
	
	//관리자 정보 삭제
	@ResponseBody
	@RequestMapping(value="/empDelete", method=RequestMethod.POST)
	public String empDelete(@RequestParam("emp_id") String emp_id) throws Exception {
		String resultMsg = "fail";
		int resultRow = empService.empDelete(emp_id);
		
		if(resultRow==1) {resultMsg="success";}
		
		return resultMsg;
	}
	
	
	@ResponseBody
	@PostMapping(value="/imageUpload", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, String> imageUpload(@RequestParam(value="uploadImage", required=false) List<MultipartFile> modifyProfile, 
			@RequestParam(value="itmeUrl") String itmeUrl,
			@RequestParam(value="itemName") String itemName,
			HttpServletResponse resp, HttpServletRequest request) throws Exception{
		OutputStream out = null;
		String webParentPath = "/resources/images/"+itmeUrl+"/";
		String webPath = "/resources/images/"+itmeUrl+"/"+itemName+"/";
		String folerParentPath = request.getSession().getServletContext().getRealPath(webParentPath);
		String folerPath = request.getSession().getServletContext().getRealPath(webPath);
		Map<String,String> resultValue = new HashMap<String,String>();
		
		if(modifyProfile.size() != 0) {
			MultipartFile file = modifyProfile.get(0);
			if(file.getSize() >0 && StringUtils.isNotBlank(file.getName())) {
				if(file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						
						String fileName = file.getOriginalFilename();
						byte[] bytes = file.getBytes();
						
						File uploadParentPath = new File(folerParentPath);
						File uploadPath = new File(folerPath);
						if(!uploadParentPath.exists()) {uploadParentPath.mkdir(); }
						if(!uploadPath.exists()) {uploadPath.mkdir(); }
						
						 String uuidRandomValue = UUID.randomUUID().toString();
				         String realUploadPath = uploadPath + "/" + uuidRandomValue + fileName;
				         
				         out = new FileOutputStream(new File(realUploadPath));
				         out.write(bytes);
				         
				         String fileUrl = request.getContextPath() + "/resources/images/"+itmeUrl+"/"+itemName+"/" + uuidRandomValue + fileName;
				         
				         JsonObject json = new JsonObject();
				         json.addProperty("fileName", fileName);
				         json.addProperty("url", fileUrl);
				         
				         resultValue.put("upImgUrl", fileUrl);
				         resultValue.put("upImgRealUrl", realUploadPath);
					}catch(IOException e){
			            e.printStackTrace();
			        } finally {
			            if (out != null) {out.close();}
			        }
				}
			}
		}
		return resultValue;
		
	}
	
	
	
	
	
	
	
	@ResponseBody
	@RequestMapping(value = "/ckUpload")
    public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, HttpSession session,
    		MultipartHttpServletRequest multiFile, @RequestParam(value="imageUploadPath", defaultValue="dummy") String imageUploadPath) throws Exception {
		JsonObject jsonObject = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		
		
		if(file != null) {
			if(file.getSize() >0 && StringUtils.isNotBlank(file.getName())) {
				if(file.getContentType().toLowerCase().startsWith("image/")) {
				    try {
			            String fileName = file.getOriginalFilename();
			            byte[] bytes = file.getBytes();
			            //String uploadPath = request.getSession().getServletContext().getRealPath("/resources/images/goods");
			           
			            //File uploadFile = new File(uploadPath);
			            //if(!uploadFile.exists()) { uploadFile.mkdir(); }
			    		
			    		String webParentPath = "/resources/images/goods/";
			    		String webPath = "/resources/images/goods/"+imageUploadPath+"/";
			    		String folerParentPath = request.getSession().getServletContext().getRealPath(webParentPath);
			    		String folerPath = request.getSession().getServletContext().getRealPath(webPath);
			            
			    		File uploadParentFile = new File(folerParentPath);
			            if(!uploadParentFile.exists()) { uploadParentFile.mkdir(); }
			            File uploadFile = new File(folerPath);
			            if(!uploadFile.exists()) { uploadFile.mkdir(); }
			            
			            String uuidFileName = UUID.randomUUID().toString();
			            folerPath = folerPath + "/" + uuidFileName + fileName;
			            
			            out = new FileOutputStream(new File(folerPath));
			            out.write(bytes);
			            
			            printWriter = response.getWriter();
			            String fileUrl = request.getContextPath() + webPath + uuidFileName + fileName;
			            
			            JsonObject json = new JsonObject();
			            json.addProperty("uploaded", 1);
			            json.addProperty("fileName", fileName);
			            json.addProperty("url", fileUrl);
			            printWriter.print(json);
			        }catch(IOException e){
			            e.printStackTrace();
			        } finally {
			            if (out != null) {out.close();}
		                if (printWriter != null) {printWriter.close();}
			        }
				}
			}
		}
	}
	
	
}
