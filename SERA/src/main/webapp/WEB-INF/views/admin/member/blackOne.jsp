<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
   	$(function(){
   		var converMsg = document.getElementById("converMsg").value;
   		var modifyForm = document.getElementById("modify-form");
   		var btnModify = document.getElementById("btn-modify");
   		
   		//////기본 실행문
   		if(converMsg!=""){
   			if(converMsg=="converSuccess"){
   	   			alert($("input[name='user_id']")+" 회원이 블랙리스트에서 해제되었습니다.");
   	   		}else{alert("블랙리스트 해제를 실패했습니다.");}
   		}
   		
   		
   		//////이벤트 실행문
   		btnModify.addEventListener("click", function(){
   			if(confirm($("input[name='user_id']")+" 회원을 블랙리스트에서 해제하시겠습니까?")){
   				modifyForm.submit();
   			}else{return;}
   		});
   	});
   	
   </script>
   <script src="/resources/js/searchOptionSettion.js"></script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="converMsg" id="converMsg" value="${converMsg }">
   	</div>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>MEMBER MANAGEMENT</h2>
   		<p>회원관리</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">블랙리스트 관리</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default">
	   		<h3 class="content-title">블랙리스트 관리</h3>
	   		<form action="/admin/member/blackOneModify"  method="post"  id="modify-form">
		   		<ul class="admin-info-view admin-info-view-default radio-visible">
		   			<li>
		   				<label>아이디</label>
		   				<div>
		   					<p>${memberInfo.user_id}</p>
		   					<input type="hidden" name="user_id" value="${memberInfo.user_id}">
		   				</div>
		   			</li>
		   			<li class="two-column">
		   				<label>이름</label>
		   				<div><p>${memberInfo.name}</p></div>
						
						<label>닉네임</label>
		   				<div><p>${memberInfo.nick_name}</p></div>
		   			</li>
		   			<li>
		   				<label>블랙리스트 등록 여부</label>
		   				<div>
			   				<p>
			   					<c:choose>
				  					<c:when test="${memberInfo.black_list == 'no'}">
						   				미등록
						   			</c:when>
						   			<c:when test="${memberInfo.black_list == 'yes'}">
						   				블랙리스트 등록
						   			</c:when>
					   			</c:choose>	
			   				</p>
		   				</div>
		   			</li>
		   			<li>
		   				<label>블랙리스트 등록 사유</label>
		   				<div>
		   					<textarea class="input-default size-fixed-textarea" required readonly maxlength="100" >${memberInfo.black_list_reson}</textarea>
		   				</div>
		   			</li>
		   			<li class="confirm-btn-container">
		   				<button type="button" id="btn-modify" class="btn admin-btn-main" >블랙리스트 해제</button>
			   			<a href="/admin/member/memberList?black_list=yes" class="btn btn-navy">목록</a>
			   		</li>
		   		</ul>
	   		</form>
	   		
	   	</div>
	 </div>  	
   <%@ include file="../includes/adminFooter.jsp" %>