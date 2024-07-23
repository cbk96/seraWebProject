<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- 날짜 형식을 변경하기 위해 사용 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sera admin</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/member.css">
<link rel="stylesheet" href="/resources/css/adminCommon.css">
<link rel="stylesheet" href="/resources/css/adminReset.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
   	
   	<script>
   		$(function(){
   			
   			memberAutoCreate();
   			
   			var loginEmp = '<%=session.getAttribute("loginEmp")%>';
   	   		var loginChkBtn =document.getElementById("login-chk");
   	   		var circleBtnElement = document.getElementById("btn-circle");
   	   		
	   	   	var resultMsg = document.getElementById("resultMsg").value;
	   		
	   		if(resultMsg!=""){
	   			if(resultMsg==="foundMember"){
					location.href="/admin/";
				}else if(resultMsg==="notFoundId"){
					alert("잘못된 아이디입니다.");
				}else if(resultMsg==="notFoundPass"){
					alert("잘못된 비밀번호입니다.");
				}else{
					alert("아이디 혹은 비밀번호가 잘못 입력되었습니다.");
				}
	   		}else{
	   	   		/*로그인 세션이 존재하는 경우 (로그인 되어 있는 경우) 로그인 페이지 접근시 인덱스 페이지 호출*/
	   	   		if(loginEmp != "null"){
	   	   			alert("이미 로그인 되어있습니다.");
	   	   			location.href="/admin/";
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
   	
   	<!-- <div class="admin-banner admin-banner-login">
   		<h2>LOGIN</h2>
   		<p>로그인</p>
   	</div> -->
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="resultMsg" id="resultMsg" value="${resultMsg}">
   	</div>
   	 
   	<section>
	   	<div class="admin-section-login">
	   		<div class="page-title page-title-join">
	   			<span>EMPOLYEE </span><span>log in</span>
	   		</div>
		   	<form action="/admin/emp/login" method="post">
		   		<ul class="login input-layout input-layout-narrow">
		 			<li>	<input type="text" name="emp_id" placeholder="아이디" required maxLength="10" class="input-default input-bottom-border" autocomplete="on"></li>
		 			<li><input type="password" name="emp_pwd" placeholder="비밀번호" required maxLength="20" class="input-default input-bottom-border"></li>
		 			<li><button type="submit" id="login-chk" class="btn admin-btn-main btn-submit" >로그인</button></li>
		 		</ul>
	 		</form>
	   	</div>
   	</section> 
   
   <%@ include file="../../includes/footer.jsp" %>