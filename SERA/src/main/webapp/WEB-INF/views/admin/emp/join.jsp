<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <script src="/resources/ckeditor/ckeditor.js"></script>
   <script>
   	window.onload = function(){
   		
   		var inputId = document.getElementsByName("emp_id")[0];
   		var btnJoin = document.getElementById("btn-join");
   		var photoUpload = document.getElementById("photo-upload");
   		
   		inputId.addEventListener("change",function(e){
   			
   			btnJoin.setAttribute("disabled","disabled");
   			
   			var inputIdValue = inputId.value.replace(" ","");
   			inputId.value = inputIdValue;
   			var idChkCMsg = document.getElementById("idChkCMsg");
   			var inputIdObject = {inputId : inputIdValue};
   			
   			$.ajax({
   				url : "/admin/emp/idChk",
   				type : "post",
   				data : inputIdObject,
   				success:function(data){
   					if(data==="empty"){
   						idChkCMsg.style.display = "block";
   						idChkCMsg.style.color = "#ff3131";
   						idChkCMsg.innerText = "아이디가 입력되지 않았습니다.";
   						btnJoin.setAttribute("disabled","disabled");
   					}else if(data==="canUse"){
   						idChkCMsg.style.display = "block";
   						idChkCMsg.style.color = "#2736ff";
   						idChkCMsg.innerText = "사용 가능한 아이디입니다.";
   						btnJoin.removeAttribute("disabled");
   					}else{
   						idChkCMsg.style.display = "block";
   						idChkCMsg.style.color = "#ff3131";
   						idChkCMsg.innerText = "사용할 수 없는 아이디입니다.";
   						btnJoin.setAttribute("disabled","disabled");
   					}
   				}
   			});
   		});
   		
   		photoUpload.addEventListener("change", function(e){
   			if(inputId.value!=""){
   	   			imageUpload(e, "emps", inputId.value);
   	   		}else{
   	   			photoUpload.value="";
   	   			alert("관리자 아이디를 먼저 입력해주십시오");
   	   		}
   	   	});
  	
   	}
   	
   	
   	
   	function post_codeSearch(){
   		window.open("/member/postChk", "post_code_check", "width=350px, height=420px, scrollbars=yes");
   	}
   	
   	
   </script>
   <script src="/resources/js/empImageUpload.js"></script>
   
   <div class="admin-banner admin-banner-join">
   		<h2>MALL SETTING</h2>
   		<p>쇼핑몰 설정</p>
   	</div>
   
   <div class="admin-section ">
   		<ul class="admin-section-tab-bar">
   			<li><a href="/admin/emp/empList?depart=${loginEmp.depart}&&level=${loginEmp.level}">운영자목록</a></li>
   			<li class="now-tab">운영자등록</li>
   		</ul>
   		
   		
   		<div class="admin-section-content admin-section-content-join ">
   			<h3 class="content-title">운영자등록</h3>
	   		<p><span>*</span>는 필수 사항입니다.</p>
	   		
			<form action="/admin/emp/join" method="post" name="member_form">
				<ul class="input-layout input-layout-border input-layout-wide " >
					<li>
						<label><span>*</span>직원 아이디</label>
						<input type="text"  name="emp_id" required maxLength="10" class="input-default input-bottom-border">
					</li>
					<li id="idChkContainer" class="inputChkContainer"><p id="idChkCMsg"></p></li>
					<li>
						<label><span>*</span>직원 비밀번호</label>
						<input type="password"  name="emp_pwd" required maxLength="20" class="input-default input-bottom-border">
					</li>
					<li>
						<label><span>*</span>직원 이름</label>
						<input type="text"  name="emp_name" required maxLength="20" class="input-default input-bottom-border">
					</li>
					<li>
						<label><span></span>직원 닉네임</label>
						<input type="text"  name="emp_nick_name" maxLength="20" class="input-default input-bottom-border">
					</li>
					<li id="nickChkContainer" class="inputChkContainer"><p id="nickChkCMsg"></p></li>
					<li  class="radio-container radio-container-2child">
						<label><span>*</span>직원 성별</label>
						<div>
							<input type="radio"   id="male"  name="emp_gender" value="male" checked class="input-default input-bottom-border">
							<label for="male">남 자</label>
							<input type="radio"  id="female" name="emp_gender" value="female" class="input-default input-bottom-border">
							<label for="female">여 자</label>
						</div>
					</li>
					<li>
						<label><span>*</span>직원 전화번호</label>
						<input type="text"  name="emp_tel" required maxLength="13" class="input-default input-bottom-border">
					</li>
					<li>
						<label><span></span>직원 이메일</label>
						<input type="email"  name="emp_email" required maxLength="50" class="input-default input-bottom-border">
					</li>
					<li>
						<label><span>*</span>부서</label>
						<select name="depart" class="input-default input-bottom-border">
							<option value="임시 부서1">임시 부서1</option>
							<option value="임시 부서2">임시 부서2</option>
							<option value="임시 부서3">임시 부서3</option>
							<option value="임시 부서4">임시 부서4</option>
						</select>
					</li>
					<li><label><span></span>증명사진</label>
						<div class="emp-photo-cover">
							<p class="photo-frame">
		   						<input type="file" name="photo-upload"  id="photo-upload"accept="image/*">
		   						<label for="photo-upload" >
		   							<i class="bi bi-camera-fill"></i>
		   							<span>증명사진 업로드</span>
		   							<img name="photo-preview" class="photo-preview">
		   						</label>
		   						<input type="hidden" name="emp_id_photo" id="upload-image-hidden">
		   					</p>
		   				</div>
					</li>
					<li>
						<button type="submit" id="btn-join" class="btn admin-btn-main  btn-confirm" disabled="disabled">운영자등록</button>
					</li>
				</ul>
			</form>
		</div>
	</div>
<%@ include file="../includes/adminFooter.jsp" %>