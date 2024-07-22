<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	<script>
	$(function(){
   		var loginMember = '<%=session.getAttribute("loginMember")%>';
   		var btnJoin = document.getElementById("btn-join");
   		var modifyForm = document.getElementById("modify_form");
   		var modifyMsg = document.getElementById("modifyMsg").value;
   		var allRequiredInput = document.querySelectorAll("[required='required']");
   		var submitChkCount = 0;
   		var emptyRequiredPoint = 0;
   		
   		if(loginMember == "null"){
	   			alert("로그인 정보가 존재하지 않습니다.");
	   			location.href="/";
	   		}
   		
   		btnJoin.addEventListener("click", function(){
   			submitChkCount=0;
			if(confirm("회원정보를 수정하시겠습니까?")){
				
				for(var i =allRequiredInput.length-1; i>= 0; i--){
   					if(allRequiredInput[i].value==""){
   						submitChkCount +=1;
   						emptyRequiredPoint = i;
   					}
   				}
   				if(submitChkCount==0){
   					modifyForm.submit();
   				}else{
   					alert("입력되지 않은 정보가 있습니다.");
   					allRequiredInput[emptyRequiredPoint].focus();
   				}
			}else{
				return;
			}
		});
   		
   		if(modifyMsg!=""){
   			if(modifyMsg=="modifySuccess"){
   	   			alert("회원정보 수정이 완료되었습니다.");
   	   			location.href="/member/mypage"
   	   		}else{alert("회원정보 수정이 실패했습니다.");}
   		}
   		
	});
		
		function post_codeSearch(){
	   		window.open("/member/postChk", "post_code_check", "width=350px, height=420px, scrollbars=yes");
	   	}
	</script>
	<script src="/resources/js/modifyDupliChk.js"></script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="modifyMsg" id="modifyMsg" value="${modifyMsg }">
   	</div>
   	<div class="banner banner-member">
   		<h2>MYPAGE</h2>
   		<p>마이페이지</p>
   	</div>
   	 <div class="section-tab-bar select-tab-bar">
   	 	<ul>
	  		<li><a href="/member/mypage">마이페이지</a></li>
	  		<li class="now-tab">회원정보 수정</li>
	  	</ul>
   	 </div>
   	<section>
   		<div class="page-title">
   			<span>EDIT</span><span> ACCOUNT</span>
   		</div>
   		
 		<form action="/member/memberModify"  method="post" id="modify_form"name="member_form">
	 		<h3 class="content-title">기본정보</h3>
	 		<p><span>*</span>는 필수 사항입니다.</p>
	 		<ul class="input-layout input-layout-border input-layout-wide" >
				<li>
					<label><span>*</span>아이디</label>
					<input type="text"  name="user_id" value="${loginMember.user_id}" required="required" class="input-default input-bottom-border" readonly>
				</li>
				<li id="idChkContainer" class="inputChkContainer"><p id="idChkCMsg"></p></li>
				<li>
					<label><span>*</span>이름</label>
					<input type="text"  name="name"  value="${loginMember.name}" required="required" class="input-default input-bottom-border">
				</li>
				<li>
					<label><span>*</span>비밀번호</label>
					<input type="password"  name="user_pwd"  required="required" class="input-default input-bottom-border">
				</li>
				<li>
					<label><span>*</span>닉네임</label>
					<input type="text"  name="nick_name" value="${loginMember.nick_name}"  required="required" class="input-default input-bottom-border">
				</li>
				<li id="nickChkContainer" class="inputChkContainer"><p id="nickChkCMsg"></p></li>
				<li>
					<label><span>*</span>연락처</label>
					<input type="text"  name="tel"  value="${loginMember.tel}" required="required" class="input-default input-bottom-border">
				</li>
				<li  class="radio-container radio-container-2child">
					<label><span>*</span>성별</label>
					<div>
						<input type="radio"   id="male"  name="gender" value="male" <c:if test="${loginMember.gender == 'male'}">checked</c:if>  class="input-default input-bottom-border">
						<label for="male">남 자</label>
						<input type="radio"   id="female"  name="gender" value="female" <c:if test="${loginMember.gender == 'female'}">checked</c:if>  class="input-default input-bottom-border">
						<label for="female">여 자</label>
					</div>
				</li>
				<li class="radio-container radio-container-3child">
					<label><span>*</span>피부타입</label>
					<div>
						<input type="radio"  id="oily_skin" name="skin_type" value="oily_skin" <c:if test="${loginMember.skin_type == 'oily_skin'}">checked</c:if> class="input-default input-bottom-border">
						<label for="oily_skin">지성</label>
						<input type="radio"  id="dry_skin" name="skin_type" value="dry_skin" <c:if test="${loginMember.skin_type == 'dry_skin'}">checked</c:if> class="input-default input-bottom-border">
						<label for="dry_skin">건성</label>
						<input type="radio"  id="combination_skin" name="skin_type" value="combination_skin"  <c:if test="${loginMember.skin_type == 'combination_skin'}">checked</c:if> class="input-default input-bottom-border">
						<label for="combination_skin">복합성</label>
					</div>
				</li>
				<li class="input-btn-container input-address">
					<label><span></span>주소</label>
					<input type="text"  name="post_code"  value="${loginMember.post_code}" readonly class="input-default input-bottom-border">
					<button type="button" onclick="post_codeSearch()"  class="btn btn-navy">우편번호 찾기</button>
				</li>
				<li>
					<label></label>
					<input type="text"  name="address" placeholder="상세 주소"  value="${loginMember.address}" class="input-default input-bottom-border">
				</li>
			</ul>
	   		
	   		<h3 class="content-title">추가정보</h3>
	   		<ul class="input-layout input-layout-border input-layout-wide">
	   			<li>
					<label><span></span>이메일</label>
					<input type="email"  name="email" value="${loginMember.email}"  class="input-default input-bottom-border">
				</li>
	   			<li>
					<label><span></span>생년월일</label>
					<input type="date"  name="birth" value="${loginMember.birth}"class="input-default input-bottom-border">
				</li>
				<li>
					<label><span></span>선호브랜드</label>
					<input type="text"  name="brand" value="${loginMember.brand}"class="input-default input-bottom-border">
				</li>
	   		</ul>
	   		<div class="confirm-btn-container">
	   			<button type="button" id="btn-join" class="btn btn-main " >회원정보수정</button>
	   		</div>
 		</form>
 		
 		<h3 class="content-title">회원탈퇴</h3>
 		<div class="user-info user-info-alert">
 			<h4>사용하고 계신 계정 정보는 탈퇴 후 복구 및 재사용이 불가합니다.</h4>
 			<p>보유하신 마일리지, 쿠폰은 복구가 불가하오니 신중하게 선택하여 주시기 바랍니다.</p>
 		</div>
 		<div class="confirm-btn-container">
   			<a href="/member/memberDelete"  id="btn-delete" class="btn btn-navy " >회원탈퇴</a>
   		</div>
   		
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>