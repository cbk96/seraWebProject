<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	<script>
		$(function(){
	   		var loginMember = '<%=session.getAttribute("loginMember")%>';
	   			
	   		if(loginMember == "null"){
   	   			alert("로그인 정보가 존재하지 않습니다.");
   	   			location.href="/";
   	   		}
	   		
	   		var deleteForm = document.getElementById("delete-form");
			var deleteBtn = document.getElementById("btn-delete");
			
			deleteBtn.addEventListener("click", function(){
				var inputUserId = document.getElementsByName("user_id")[0].value;
				var inputUserPwd = document.getElementsByName("user_pwd")[0].value;
				var requestValue = {user_id : inputUserId, user_pwd : inputUserPwd};
				
				if(confirm("정말 탈퇴하시겠습니까?")){
					$.ajax({
						url:"/member/searchingAccount",
						type:"post",
						data:requestValue,
						success:function(data){
							if(data == "found_account"){
								alert("회원탈퇴가 완료 되었습니다.");
								deleteForm.submit();
							}else{
								alert("본인확인에 실패했습니다.");
							}
						}
					});
				}else{
					return;
				}
			});
		});
		
		function accountChk(){
			
		}
	</script>
   	
   	<div class="banner banner-member">
   		<h2>MYPAGE</h2>
   		<p>마이페이지</p>
   	</div>
   	 <div class="section-tab-bar select-tab-bar">
   	 	<ul>
	  		<li class="now-tab">회원탈퇴</li>
	  	</ul>
   	 </div>
   	<section>
   		<div class="page-title">
   			<span>member</span><span> Withdrawal</span>
   		</div>
   		
 		<form action="/member/memberDelete"  method="post" id="delete-form">
 		<h3 class="content-title">회원탈퇴</h3>
	 		<p><span>*</span>회원탈퇴를 위해 본인확인이 필요합니다.</p>
	 		<ul class="input-layout input-layout-border input-layout-wide" >
				<li>
					<label><span>*</span>아이디</label>
					<input type="text"  name="user_id" required class="input-default input-bottom-border" >
				</li>
				<li>
					<label><span>*</span>비밀번호</label>
					<input type="password"  name="user_pwd"  required class="input-default input-bottom-border">
				</li>
			</ul>
	   		<div class="confirm-btn-container">
	   			<a href="/member/mypage" class="btn btn-main " >취소</a>
	   			<button type="button"  id="btn-delete" class="btn btn-navy " >회원탈퇴</button>
	   		</div>
 		</form>
   		
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>