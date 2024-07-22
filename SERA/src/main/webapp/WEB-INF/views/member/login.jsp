<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
   	
   	<script>
   		$(function(){
   			
   			memberAutoCreate();
   			
   			var loginMember = '<%=session.getAttribute("loginMember")%>';
   	   		var loginChkBtn =document.getElementById("login-chk");
   	   		var circleBtnElement = document.getElementById("btn-circle");
   	   		
	   	   	var resultMsg = document.getElementById("resultMsg").value;
	   		
	   		if(resultMsg!=""){
	   			if(resultMsg==="foundMember"){
					location.href="/";
				}else if(resultMsg==="notFoundId"){
					alert("잘못된 아이디입니다.");
				}else if(resultMsg==="notFoundPass"){
					alert("잘못된 비밀번호입니다.");
				}else{
					alert("아이디 혹은 비밀번호가 잘못 입력되었습니다.");
				}
	   		}else{
	   	   		/*로그인 세션이 존재하는 경우 (로그인 되어 있는 경우) 로그인 페이지 접근시 인덱스 페이지 호출*/
	   	   		if(loginMember != "null"){
	   	   			alert("이미 로그인 되어있습니다.");
	   	   			location.href="/";
	   	   		}
	   		}
   	   		 
   	     /*원형 버튼 클릭 이벤트*/
	   	    circleBtnElement.addEventListener("click", function(e){
   	    		e.currentTarget.classList.toggle("btn-cilrcle-click");
   		    });
   	   		
   		});
   		

   		//프로젝트 시연용 초기 고객회원 계정, 운영자 계정 생성
   		function memberAutoCreate(){
   			$.ajax({
   				url:'/admin/emp/memberAutoCreate',
   				type:'POST'
   			});
   		}
   		
   		
   	</script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="resultMsg" id="resultMsg" value="${resultMsg }">
   	</div>
   	
   	<div class="banner banner-member">
   		<h2>LOGIN</h2>
   		<p>로그인</p>
   	</div>
   	 
   	<section>
	   	<div class="section-login">
	   		<div class="page-title page-title-join">
	   			<span>log</span><span>in</span>
	   		</div>
	   		<form action="/member/login" method="post">
		   		<ul class="login input-layout input-layout-narrow">
		 			<li>	<input type="text" name="user_id" placeholder="아이디" maxLength="10" required class="input-default input-bottom-border" autocomplete="on"></li>
		 			<li><input type="password" name="user_pwd" placeholder="비밀번호" maxLength="20" required class="input-default input-bottom-border"></li>
		 			<li class="login-status">
		 				<span><a href="/member/idPwdSearch">아이디 / 비밀번호 찾기</a></span>
		 			</li>
		 			<li><button type="submit" id="login-chk" class="btn btn-main btn-submit" >로그인</button></li>
		 		</ul>
	 		</form>
	   	</div>
   </section> 
   <%@ include file="../includes/footer.jsp" %>