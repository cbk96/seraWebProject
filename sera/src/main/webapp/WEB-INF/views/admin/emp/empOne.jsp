<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
   	$(function(){
   		var loggedLevel = parseInt(document.getElementById("loggedLevel").value);
   		var modifyMsg = document.getElementById("modifyMsg").value;
   		var modifyForm = document.getElementById("modify-form");
   		var btnModify = document.getElementById("btn-modify");
   		var btnLeave = document.getElementsByClassName("btn-leave")[0];
   		var empLevelName = ["인턴","사원","주임","계장","대리","과장","차장","부장","이사","사장"];
		var empList = $(".admin-info-view>li:nth-child(6)>div>p");
		var empId = document.getElementsByName("emp_id")[0];
   		var photoUpload = document.getElementById("photo-upload");
		
   		/////기본 실행
   		if(loggedLevel<9){
   			alert("운영자 상세정보 열람은 최고 관리자만 가능합니다.");
   			location.href="/admin/"
   		}
   		
   		if(modifyMsg!=""){
   			if(modifyMsg=="modifySuccess"){
   	   			alert("운영자 정보 수정이 완료되었습니다.");
   	   		}else{alert("운영자 정보 수정중 오류가 발생했습니다.");}
   		}
   		
   		if(empList.length>0){
			for(var i=0; i<empList.length; i++){
   				var empLevel = parseInt(empList[i].innerText);
   				empList[i].innerText = empLevelName[empLevel];
   			}
		}
   		
   		
   		$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(3)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(4)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(5)").css("display","none");
   		
   		/////이벤트 실행
   		
   		//관리자 정보 수정
   		btnModify.addEventListener("click", function(){
   			if(confirm(empId.value+" 운영자 정보를 수정하시겠습니까?")){
   				modifyForm.setAttribute("action","/admin/emp/empOneModify");
   				modifyForm.submit();
   			}else{
   				modifyForm.removeAttribute("action");
   				return;
   			}
   		});
   		
   		//관리자 퇴사 처리 / 관리자 정보 삭제
   		btnLeave.addEventListener("click", function(){
   			var processType = btnLeave.getAttribute("id");
   			var empInfo = {emp_id : empId.value};
   			
   			//관리자 퇴사 처리
   			if(processType=="btn-leave"){
   				if(confirm(empId.value+" 운영자를 퇴사 처리 하시겠습니까?")){
   	   				
   	   				$.ajax({
   	   	   				url : "/admin/emp/empLeave",
   	   	   				type : "post",
   	   	   				data : empInfo,
   	   	   				success:function(data){
   	   	   					if(data==="success"){
   	   	   						alert(empId.value+"운영자의 퇴사처리가 완료 되었습니다.");
   	   	   						location.reload();
   	   	   					}else{
   	   	   						alert(empId.value+"운영자의 퇴사처리중 오류가 발생하였습니다.");
   	   	   						location.reload();
   	   	   					}
   	   	   				}
   	   	   			});
   	   			}else{
   	   				return;
   	   			}
   			//관리자 정보 삭제
   			}else if(processType=="btn-delete"){
   				if(confirm(empId.value+" 운영자 정보를 삭제 하시겠습니까?")){
   	   				
   	   				$.ajax({
   	   	   				url : "/admin/emp/empDelete",
   	   	   				type : "post",
   	   	   				data : empInfo,
   	   	   				success:function(data){
   	   	   					if(data==="success"){
   	   	   						alert(empId.value+" 운영자 정보의 삭제처리가 완료 되었습니다.");
   	   	   						location.href="/admin/emp/empList";
   	   	   					}else{
   	   	   						alert(empId.value+" 운영자 정보의 삭제 처리중 오류가 발생하였습니다.");
   	   	   						location.reload();
   	   	   					}
   	   	   				}
   	   	   			});
   	   			}else{
   	   				return;
   	   			}
   			}
   			
   			
   		});
   		
   		//textarea 줄바꿈 방지
   		$(".size-fixed-textarea").on("change, keydown", function(){
   			var inputReson = $(this).val();
   			 $(this).val(inputReson.replace("\n",""));
   		});
   	
   		photoUpload.addEventListener("change", function(e){
   			imageUpload(e, "emps", empId.value);
   	   	});
   		
   	});
  	
   	
   	/////함수
   	function openModifyInput(){
   		$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n+1)").css("display","none");
   		$(".admin-info-view>li>div:nth-of-type(2n)").css("display","flex");
   		$(".confirm-btn-container>button:nth-child(1)").css("display","none");
   		$(".confirm-btn-container>a:nth-child(2)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(3)").css("display","block");
   		$(".confirm-btn-container>button:nth-child(4)").css("display","block");
   		$(".confirm-btn-container>button:nth-child(5)").css("display","block");
   	}
   	
   	function cancleModify(){
   		$(".admin-info-view>li>div:nth-of-type(2n+1)").css("display","flex");
   		$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(1)").css("display","block");
   		$(".confirm-btn-container>a:nth-child(2)").css("display","block");
   		$(".confirm-btn-container>button:nth-child(3)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(4)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(5)").css("display","none");
   	}
   	
   	function post_codeSearch(){
   		window.open("/member/postChk", "post_code_check", "width=350px, height=420px, scrollbars=yes");
   	}
   	
   	
   </script>
   <script src="/resources/js/searchOptionSettion.js"></script>
   <script src="/resources/ckeditor/ckeditor.js"></script>
   <script src="/resources/js/empImageUpload.js"></script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="loggedLevel" id="loggedLevel" value="${loginEmp.level }">
   		<input type="hidden" name="modifyMsg" id="modifyMsg" value="${modifyMsg}">
   	</div>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>MALL SETTING</h2>
   		<p>쇼핑몰 설정</p>
   	</div>
   	
   	<div class="admin-section" >
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">운영자 상세정보</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default" >
	   		<h3 class="content-title">운영자 상세정보</h3>
	   		<form method="post" name="member_form"  id="modify-form" enctype="multipart/form-data">
		   		<ul class="admin-info-view admin-info-view-default radio-visible">
		   			<li class="photo-column">
		   				<label>증명사진</label>
		   				<div>
		   					<p class="photo-frame" >
		   						<c:choose>
		   							<c:when test="${modifyEvo.emp_id_photo!=null}">
		   								<img src="${modifyEvo.emp_id_photo}" alt="증명사진">
		   							</c:when>
		   							<c:otherwise>
		   								<i class="bi bi-person-fill"></i>
		   							</c:otherwise>
		   						</c:choose>
		   						<input type="hidden" name="emp_id_photo"  id="upload-image-hidden" value="${modifyEvo.emp_id_photo}">
		   					</p>
		   				</div>
		   				<div>
		   					<p class="photo-frame">
		   						<input type="file" name="photo-upload"  id="photo-upload"accept="image/*">
		   						<label for="photo-upload"  id="photo-upload-area">
		   							<img name="photo-preview" class="photo-preview" src="${modifyEvo.emp_id_photo}">
		   							<i class="bi bi-camera-fill"></i>
		   							<span>증명사진 업로드</span>
		   						</label>
		   					</p>
		   				</div>
		   				<ul class="admin-info-view radio-visible">
		   					<li>	
				   				<label>아이디</label>
				   				<div><p>${modifyEvo.emp_id}</p></div>
								<div><input type="text" name="emp_id" value="${modifyEvo.emp_id}" maxLength="10" class="input-full-border" readOnly></div>
							</li>
							<li>
				   				<label>이름</label>
				   				<div><p>${modifyEvo.emp_name}</p></div>
				   				<div><input type="text" name="emp_name" value="${modifyEvo.emp_name}" maxLength="20" class="input-full-border" required></div>
				   			</li>	
				   			<li>	
				   				<label>닉네임</label>
				   				<div><p>${modifyEvo.emp_nick_name}</p></div>
				   				<div><input type="text" name="emp_nick_name" value="${modifyEvo.emp_nick_name}" maxLength="20" class="input-full-border" required></div>
				   			</li>
		   				</ul>
		   			</li>
		   			<li>
			   			<label>성별</label>
		   				<div>
		   					<p>
			   					<c:choose>
			   						<c:when test="${modifyEvo.emp_gender=='male'}">남성</c:when>
				   					<c:when test="${modifyEvo.emp_gender=='female'}">여성</c:when>
				   				</c:choose>
			   				</p>
			   			</div>
			   			<div>	
		   					<input type="radio"   id="male"  name="emp_gender" value="male" <c:if test="${modifyEvo.emp_gender == 'male'}">checked</c:if>>
							<label for="male">남 자</label>
							<input type="radio"   id="female"  name="emp_gender" value="female" <c:if test="${modifyEvo.emp_gender == 'female'}">checked</c:if>>
							<label for="female">여 자</label>
		   				</div>
		   			</li>
		   			<li>
		   				<label>전화번호</label>
		   				<div><p>${modifyEvo.emp_tel}</p></div>
		   				<div><input type="tel" name="emp_tel" value="${modifyEvo.emp_tel}" class="input-full-border" maxLength="13" required></div>
		   			</li>
		   			<li>
		   				<label>이메일</label>
		   				<div><p>${modifyEvo.emp_email}</p></div>
		   				<div><input type="email" name="emp_email" value="${modifyEvo.emp_email}" maxLength="50" class="input-full-border"></div>
		   			</li>
		   			<li>
		   				<label>부서</label>
		   				<div><p>${modifyEvo.depart}</p></div>
		   				<div>
		   					<select name="depart" class="input-full-border">
		   						<option  value="임시 부서1"  <c:if test="${modifyEvo.depart == '임시 부서1'}">selected</c:if>>임시 부서1</option>
								<option  value="임시 부서2"  <c:if test="${modifyEvo.depart == '임시 부서2'}">selected</c:if>>임시 부서2</option>
								<option  value="  부서3"  <c:if test="${modifyEvo.depart == '임시 부서3'}">selected</c:if>>임시 부서3</option>
								<option  value="임시 부서4"  <c:if test="${modifyEvo.depart == '임시 부서4'}">selected</c:if>>임시 부서4</option>
							</select>
		   				</div>
		   			</li>
		   			<li>
		   				<label>직급</label>
		   				<div><p>${modifyEvo.level}</p></div>
		   				<div>
							<select name="level" class="input-full-border">
								<c:if test="${modifyEvo.emp_id != 'admin'}">
		   						<option  value="0" <c:if test="${modifyEvo.level == 0}">selected</c:if>>인턴</option>
								<option  value="1" <c:if test="${modifyEvo.level == 1}">selected</c:if>>사원</option>
								<option  value="2" <c:if test="${modifyEvo.level == 2}">selected</c:if>>주임</option>
								<option  value="3" <c:if test="${modifyEvo.level == 3}">selected</c:if>>계장</option>
								<option  value="4" <c:if test="${modifyEvo.level == 4}">selected</c:if>>대리</option>
								<option  value="5" <c:if test="${modifyEvo.level == 5}">selected</c:if>>과장</option>
								<option  value="6" <c:if test="${modifyEvo.level == 6}">selected</c:if>>차장</option>
								<option  value="7" <c:if test="${modifyEvo.level == 7}">selected</c:if>>부장</option>
								<option  value="8" <c:if test="${modifyEvo.level == 8}">selected</c:if>>이사</option>
								</c:if>
								<option  value="9" <c:if test="${modifyEvo.level == 9}">selected</c:if>>사장</option>
		   					</select>
						</div>
		   			</li>
		   			<c:choose>
		   				<c:when test="${modifyEvo.admin_approval == 2}">
		   					<li class="not-toggle-view">
			   					<label>운영자 등록 승인</label>
			   					<div>
									<p>
										<c:choose>
				  							<c:when test="${modifyEvo.admin_approval == 2}">관리자</c:when>
				  							<c:when test="${modifyEvo.admin_approval == 1}">승인</c:when>
				  							<c:when test="${modifyEvo.admin_approval == -1}">퇴사</c:when>
				  							<c:otherwise>미승인</c:otherwise>
				  						</c:choose>
									</p>
								</div>
		   					</li>
		   				</c:when>
		   				<c:otherwise>
		   					<li>
								<label>운영자 등록 승인</label>
								<div>
									<p>
										<c:choose>
				  							<c:when test="${modifyEvo.admin_approval == 2}">관리자</c:when>
				  							<c:when test="${modifyEvo.admin_approval == 1}">승인</c:when>
				  							<c:when test="${modifyEvo.admin_approval == -1}">퇴사</c:when>
				  							<c:otherwise>미승인</c:otherwise>
				  						</c:choose>
									</p>
								</div>
				   				<div>
				   					<select name="admin_approval" class="input-full-border">
				   						<c:choose>
				  							<c:when test="${modifyEvo.admin_approval == -1}">
				  								<option  value="-1" <c:if test="${modifyEvo.admin_approval == -1}">selected</c:if>>퇴사</option>
				  							</c:when>
				  							<c:otherwise>
				  								<option  value="0" <c:if test="${modifyEvo.admin_approval == 0}">selected</c:if>>미승인</option>
												<option  value="1" <c:if test="${modifyEvo.admin_approval == 1}">selected</c:if>>승인</option>
				  							</c:otherwise>
				  						</c:choose>
				   						
									</select>
				   				</div>
							</li>
		   				</c:otherwise>
		   			</c:choose>
		   			<li class="not-toggle-view">
		   				<label>입사일</label>
		   				<div>
		   					<span><fmt:formatDate value="${modifyEvo.join_day}" pattern="yyyy년 MM월 dd일"/></span>
		   				</div>
		   			</li>
		   			<li class="not-toggle-view">
		   				<label>퇴사일</label>
		   				<div>
		   					<span>
		   						<c:choose>
		   							<c:when test="${modifyEvo.last_work_day != null}">
		   								<fmt:formatDate value="${modifyEvo.last_work_day}" pattern="yyyy년 MM월 dd일"/>
		   							</c:when>
		   							<c:otherwise>
		   								---- 년 -- 월 -- 일
		   							</c:otherwise>
		   						</c:choose>
		   					</span>
		   				</div>
		   			</li>
		   			<li class="confirm-btn-container">
		   				<button type="button" class="btn admin-btn-main" onclick="openModifyInput()">수정</button>
		   				<a href="/admin/emp/empList" class="btn btn-navy">목록</a>
			   			<button type="button" id="btn-modify" class="btn admin-btn-main" >수정완료</button>
			   			<c:choose>
			   				<c:when test="${modifyEvo.emp_id != 'admin'}">
				   				<c:choose>
			   						<c:when test="${modifyEvo.admin_approval == -1}">
			   							<button type="button" id="btn-delete" class="btn admin-btn-main btn-leave" >관리자 정보 삭제</button>
			   						</c:when>
			   						<c:otherwise>
			   							<button type="button" id="btn-leave" class="btn admin-btn-main btn-leave" >퇴사처리</button>
			   						</c:otherwise>
			   					</c:choose>
				   			</c:when>
				   			<c:otherwise>
				   				<button type="button" class="btn btn-white btn-leave">${modifyEvo.emp_id} 관리자는 퇴사처리가 불가합니다. </button>
				   			</c:otherwise>
			   			</c:choose>
			   			<button type="button" class="btn btn-navy" onclick="cancleModify()">취소</button>
			   		</li>
		   		</ul>
	   		</form>
	   		
	   	</div>
	 </div>  	
   <%@ include file="../includes/adminFooter.jsp" %>