<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl 태그 라이브러리 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- 날짜 형식을 변경하기 위해 사용 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>sera</title>
<link rel="stylesheet" href="/resources/css/bootstrap-icons.min.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/member.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/resources/js/script.js"></script>
<script>
  	window.onload = function(){
  		
  		var btnIdSearch = document.getElementById("btn-id-search");
  		var btnPwdSearch = document.getElementById("btn-pwd-search");
		
  		//아이디 조회
  		btnIdSearch.addEventListener("click",function(e){
  			var inputName = document.getElementsByName("name")[0].value.replaceAll(" ","");
  	   		var inputTel = document.getElementsByName("tel")[0].value.replaceAll(" ","");
  	   		
			var inputNameObject = {inputName : inputName, inputTel : inputTel};
			
			//alert(inputName + " | "+inputTel);
			
			if((inputName!=null&&inputName!="")&&(inputTel!=null&&inputTel!="")){
				$.ajax({
	 				url : "/member/idSearch",
	 				type : "post",
	 				data : inputNameObject,
	 				success:function(data){
	 					if(data.indexOf("_idFound")!=-1){
	 						alert("입력된 정보로 조회된 아이디는 '"+data.replace("_idFound","")+"'입니다");
	 					}else{
	 						alert("입력된 정보로 조회되는 회원 정보가 없습니다.");
	 					}
	 				}
	 			});
			}else{
				alert("이름이나 연락처가 입력되지 않았습니다.");
			}
		});
  		
  		//비밀번호 재설정
  		btnPwdSearch.addEventListener("click",function(e){
  			var inputName = document.getElementsByName("name")[1].value.replaceAll(" ","");
  	   		var inputId = document.getElementsByName("user_id")[0].value.replaceAll(" ","");
  	   		var inputPwd = document.getElementsByName("user_pwd")[0].value.replaceAll(" ","");
  	   		
			var inputNameObject = {inputName : inputName, inputId : inputId, inputPwd : inputPwd};
			
			if((inputName!=null&&inputName!="")&&(inputId!=null&&inputId!="")){
				if(inputPwd!=null && inputPwd!=""){
					$.ajax({
	 	 				url : "/member/pwdSearch",
	 	 				type : "post",
	 	 				data : inputNameObject,
	 	 				success:function(data){
	 	 					if(data.indexOf("_pwdNotChange")!=-1){
	 	 						//alert("입력된 비밀번호 '"+data.replace("_pwdNotChange","")+"'로 수정처리 되었습니다.");
	 	 						alert("입력된 비밀번호로 수정처리 되었습니다.");
	 	 					}else{
	 	 						alert("입력된 정보로 조회되는 회원 정보가 없습니다.");
	 	 					}
	 	 				}
	 	 			});
				}else{
					alert("변경할 비밀번호가 입력되지 않았습니다.");
				}
			}else{
				alert("이름이나 아이디가 입력되지 않았습니다.");
			}
		});
  		
  	}
 </script>
 </head>  	 
   <section class="section-idPwdSearch">
   	<div class="idPwdSearch-container">
   		<div>
   			<div class="page-title">
	   			<span>Searching</span><span> Id</span>
	   		</div>
	   		<p>아이디 찾기</p>
   			<ul class="input-layout always-flex-layout">
  				<li>
					<label><span></span>이름</label>
					<input type="text"  name="name"  required class="input-default input-bottom-border">
				</li>
				<li>
					<label><span></span>연락처</label>
					<input type="text"  name="tel"  required class="input-default input-bottom-border">
				</li>
				<li>
					<button type="submit" id="btn-id-search" class="btn btn-main btn-submit">아이디 조회</button>
				</li>
  			</ul>
  		</div>	
 		<div>
 			<div class="page-title">
		   		<span>Reset</span><span> PASSWORD</span>
		   	</div>
   			<p>비밀번호 재설정</p>
			<ul class="input-layout always-flex-layout">
			<li>
				<label><span></span>이름</label>
				<input type="text"  name="name"  required class="input-default input-bottom-border">
			</li>
			<li>
				<label><span></span>아이디</label>
				<input type="text"  name="user_id"  required class="input-default input-bottom-border">
			</li>
			<li>
				<label class="label-twoLine"><span>변경할</span><span>비밀번호</span></label>
				<input type="password"  name="user_pwd"  required class="input-default input-bottom-border">
			</li>
			<li>
				<button type="submit" id="btn-pwd-search" class="btn btn-main btn-submit">비밀번호 재설정</button>
			</li>
			</ul>
 		</div>	
	</div>
	<div class="confirm-btn-container" >
		<a href="/" class="btn btn-navy">메인 페이지로</a>
	</div>
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>