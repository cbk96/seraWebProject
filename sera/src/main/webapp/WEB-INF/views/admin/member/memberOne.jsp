<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
   	$(function(){
   		var modifyMsg = document.getElementById("modifyMsg").value;
   		var modifyForm = document.getElementById("modify-form");
   		var btnModify = document.getElementById("btn-modify");
   		var btnDelete = document.getElementsByClassName("btn-delete");
   		var userId = document.getElementsByName("user_id")[0];
   		
   		/////기본 실행
   		if(modifyMsg!=""){
   			if(modifyMsg=="modifySuccess"){
   	   			alert("회원정보 수정이 완료되었습니다.");
   	   		}else{alert("회원정보 수정중 오류가 발생했습니다.");}
   		}
   		
   		$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(3)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(4)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(5)").css("display","none");
   		
   		
   		/////이벤트 실행
   		
   		//회원 정보 수정
   		btnModify.addEventListener("click", function(){
   			if(confirm(userId.value+" 회원 정보를 수정하시겠습니까?")){
   				modifyForm.setAttribute("action","/admin/member/memberOneModify");
   				modifyForm.submit();
   			}else{
   				modifyForm.removeAttribute("action");
   				return;
   			}
   		});
   		
   		$("#active").change(function(){
   			if($(this).val()=='no'){
   				$("#input_active_conver_reson").slideDown(300).css("display","flex");
   			}else{
   				$("#input_active_conver_reson").slideUp(300).css("display","flex");
   			}
   		});
   		
   		$("#black_list").change(function(){
   			if($(this).val()=='yes'){
   				$("#input_black_list_reson").slideDown(300).css("display","flex");
   			}else{
   				$("#input_black_list_reson").slideUp(300).css("display","flex");
   			}
   		});
   		
   	//textarea 줄바꿈 방지
   		$(".size-fixed-textarea").on("change, keydown", function(){
   			var inputReson = $(this).val();
   			 $(this).val(inputReson.replace("\n",""));
   		});
   		
   	});
   	
  	
   	
   	/////함수
   	
   	//회원탈퇴
   	function memberDelete(user_id){
   		alert(user_id);
   		if(confirm(user_id+" 회원을 탈퇴 처리 하시겠습니까?\n탈퇴 처리되면 회원 관련 모든 정보가 삭제되고 복구는 불가합니다.")){
				var userInfo = {user_id : user_id}
				$.ajax({
	   				url : "/admin/member/memberDelete",
	   				type : "post",
	   				data : userInfo,
	   				success:function(data){
	   					if(data==="success"){
	   						alert(user_id+" 회원의 탈퇴 처리가 완료 되었습니다.");
	   						location.href="/admin/member/memberList";
	   					}else{
	   						alert(user_id+"회원의 탈퇴 처리중 오류가 발생하였습니다.");
	   						location.reload();
	   					}
	   				}
	   			});
			}else{
				return;
			}
   	}
   	
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
   		$("#active").val("yes");
   		$("#black_list").val("no");
   		
   		$("#input_active_conver_reson").css("display","none");
   		$("#input_black_list_reson").css("display","none");
   	}
   	
   	function post_codeSearch(){
   		window.open("/member/postChk", "post_code_check", "width=350px, height=420px, scrollbars=yes");
   	}
   	
   </script>
   <script src="/resources/js/inputDupliChk.js"></script>
   <script src="/resources/js/searchOptionSettion.js"></script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="modifyMsg" id="modifyMsg" value="${modifyMsg }">
   	</div>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>MEMBER MANAGEMENT</h2>
   		<p>회원관리</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">회원상세정보</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default">
	   		<h3 class="content-title">회원상세정보</h3>
	   		<form method="post" name="member_form"  id="modify-form">
		   		<ul class="admin-info-view admin-info-view-default radio-visible">
		   			<li class="two-column">
		   				<label>아이디</label>
		   				<div><p>${memberInfo.user_id}</p></div>
						<div><input type="text" name="user_id" value="${memberInfo.user_id}"  class="input-full-border" readOnly required></div>
						
						<label>이름</label>
		   				<div><p>${memberInfo.name}</p></div>
		   				<div><input type="text" name="name" value="${memberInfo.name}" class="input-full-border" required></div>
		   			</li>
		   			<li class="two-column">
		   				<label>닉네임</label>
		   				<div><p>${memberInfo.nick_name}</p></div>
		   				<div><input type="text" name="nick_name" value="${memberInfo.nick_name}" class="input-full-border" required></div>
						
						<label>회원등급</label>
		   				<div><p>${memberInfo.grade}</p></div>
		   				<div>
		   					<select name="grade" class="input-full-border"  >
		   						<option value="common"  <c:if test="${memberInfo.grade == 'common'}">selected</c:if>>common</option>
	   							<option value="bronze"  <c:if test="${memberInfo.grade == 'bronze'}">selected</c:if>>bronze</option>
	   							<option value="silver" <c:if test="${memberInfo.grade == 'silver'}">selected</c:if>>silver</option>
	   							<option value="gold" <c:if test="${memberInfo.grade == 'gold'}">selected</c:if>>gold</option>
	   							<option value="platinum" <c:if test="${memberInfo.grade == 'platinum'}">selected</c:if>>platinum</option>
	   						</select>	
		   				</div>
		   			</li>
		   			<li class="two-column">
			   			<label>성별</label>
		   				<div>
		   					<p>
			   					<c:choose>
			   						<c:when test="${memberInfo.gender=='male'}">남성</c:when>
				   					<c:when test="${memberInfo.gender=='female'}">여성</c:when>
				   				</c:choose>
			   				</p>
			   			</div>
			   			<div>	
		   					<input type="radio"   id="male"  name="gender" value="male" <c:if test="${memberInfo.gender == 'male'}">checked</c:if>>
							<label for="male">남 자</label>
							<input type="radio"   id="female"  name="gender" value="female" <c:if test="${memberInfo.gender == 'female'}">checked</c:if>>
							<label for="female">여 자</label>
		   				</div>
		   				<label>피부타입</label>
		   				<div>
		   					<p>
			   					<c:choose>
		  							<c:when test="${memberInfo.skin_type=='oily_skin'}">지성</c:when>
		  							<c:when test="${memberInfo.skin_type=='dry_skin'}">건성</c:when>
		  							<c:when test="${memberInfo.skin_type=='combination_skin'}">복합성</c:when>
		  						</c:choose>
	  						</p>
	  					</div>
						<div>
							<input type="radio"  id="oily_skin" name="skin_type" value="oily_skin" <c:if test="${memberInfo.skin_type == 'oily_skin'}">checked</c:if>>
							<label for="oily_skin">지성</label>
							<input type="radio"  id="dry_skin" name="skin_type" value="dry_skin" <c:if test="${memberInfo.skin_type == 'dry_skin'}">checked</c:if>>
							<label for="dry_skin">건성</label>
							<input type="radio"  id="combination_skin" name="skin_type" value="combination_skin"  <c:if test="${memberInfo.skin_type == 'combination_skin'}">checked</c:if>>
							<label for="combination_skin">복합성</label>
		   				</div>
		   			</li>
		   			<li class="two-column">
		   				<label>전화번호</label>
		   				<div><p>${memberInfo.tel}</p></div>
		   				<div><input type="text" name="tel" value="${memberInfo.tel}" class="input-full-border" required></div>
						
						<label>이메일</label>
		   				<div><p>${memberInfo.email}</p></div>
		   				<div><input type="email" name="email" value="${memberInfo.email}" class="input-full-border"></div>
		   			</li>
		   			<li>
		   				<label>주소</label>
		   				<div class="search-multi-row-admin">
		   					<p>${memberInfo.post_code}</p>
		   					<p>${memberInfo.address}</p>
		   				</div>
		   				<div class="search-multi-row-admin">
		   					<input type="text" name="post_code" value="${memberInfo.post_code}" class="input-full-border">
		   					<input type="text" name="address" value="${memberInfo.address}" class="input-full-border">
		   					<button type="button" onclick="post_codeSearch()" id="btn-post-code-search" class="btn-small btn-navy">우편번호 찾기</button>
						</div>
		   			</li>
		   			<li class="two-column">
		   				<label>선호 브랜드</label>
		   				<div><p>${memberInfo.brand}</p></div>
		   				<div><input type="text" name="brand" value="${memberInfo.brand}" class="input-full-border">
		   				</div>
		   				<label>접근 경로</label>
		   				<div>
		   					<p>
		  						<c:choose>
		  							<c:when test="${memberInfo.access_route=='from_friend'}">지인 추천</c:when>
		  							<c:when test="${memberInfo.access_route=='from_searching'}">인터넷 검색</c:when>
		  							<c:when test="${memberInfo.access_route=='from_commercial'}">광고</c:when>
		  						</c:choose>
	  						</p>
	  					</div>
	  					<div>
		   					<input type="radio" id="from_friend" name="access_route" value="from_friend"  <c:if test="${memberInfo.access_route == 'from_friend'}">checked</c:if>><label for="from_friend">지인의 추천</label> 
		   					<input type="radio" id="from_searching" name="access_route" value="from_searching"  <c:if test="${memberInfo.access_route == 'from_searching'}">checked</c:if>><label for="from_searching">인터넷 검색</label> 
		   					<input type="radio" id="from_commercial" name="access_route" value="from_commercial"  <c:if test="${memberInfo.access_route == 'from_commercial'}">checked</c:if>><label for="from_commercial">광고</label> 
		   				</div>
		   			</li>
		   			<li>
						<label>생년월일</label>
						<div><p><fmt:formatDate value="${memberInfo.birth}" pattern="yyyy년 MM월 dd일"/></p></div>	
						<div><input type="date"  name="birth" value="${memberInfo.birth}" class="input-full-border"></div>
					</li>
					<li>
						<label>휴면회원전환</label>
		   				<div>
			   				<p>
			   					<c:choose>
				  					<c:when test="${memberInfo.active == 'yes'}">
						   				일반회원
						   			</c:when>
						   			<c:when test="${memberInfo.active == 'no'}">
						   				휴면회원
						   			</c:when>
					   			</c:choose>	
			   				</p>
		   				</div>
						<div>
							<select name="active" id="active" class="input-full-border"  >
	   							<option value="yes"  <c:if test="${memberInfo.active == 'yes'}">selected</c:if>>일반회원</option>
	   							<option value="no"  <c:if test="${memberInfo.active == 'no'}">selected</c:if>>휴면회원</option>
	   						</select>	
						</div>
					</li>
					<li class="search-more-optioin" id="input_active_conver_reson">
						<ul class="admin-info-view radio-visible">
							<li>
				   				<label>전환사유</label>
				   				<div>
				   					<textarea class="input-default size-fixed-textarea" required readonly maxlength="100" >${memberInfo.active_conver_reson}</textarea>
				   				</div>
				   				<div>
				   					<textarea name="active_conver_reson" class="input-default input-full-border size-fixed-textarea" required maxlength="100">${memberInfo.active_conver_reson}</textarea>
				   				</div>
				   			</li>
						</ul>
					</li>
					<li>
						<label>블랙리스트 등록</label>
		   				<div>
			   				<p>
			   					<c:choose>
				  					<c:when test="${memberInfo.black_list == 'no'}">
						   				미등록
						   			</c:when>
						   			<c:when test="${memberInfo.black_list == 'yes'}">
						   				블랙리스트
						   			</c:when>
					   			</c:choose>	
			   				</p>
		   				</div>
						<div>
							<select name="black_list" id="black_list" class="input-full-border"  >
	   							<option value="no"  <c:if test="${memberInfo.black_list == 'no'}">selected</c:if>>미등록</option>
	   							<option value="yes"  <c:if test="${memberInfo.black_list == 'yes'}">selected</c:if>>블랙리스트</option>
	   						</select>	
						</div>
					</li>
					<li class="search-more-optioin" id="input_black_list_reson">
						<ul class="admin-info-view radio-visible">
							<li>
				   				<label>등록사유</label>
				   				<div>
				   					<textarea class="input-default size-fixed-textarea" required readonly maxlength="100" >${memberInfo.black_list_reson}</textarea>
				   				</div>
				   				<div>
				   					<textarea name="black_list_reson" class="input-default input-full-border size-fixed-textarea" required maxlength="100">${memberInfo.black_list_reson}</textarea>
				   				</div>
				   			</li>
						</ul>
					</li>
					<li>
						<label>관리자 계정으로 전환</label>
		   				<div>
			   				<p>
			   					<c:choose>
				  					<c:when test="${memberInfo.member_type == 'customer'}">
						   				고객 계정
						   			</c:when>
						   			<c:when test="${memberInfo.member_type == 'admin'}">
						   				관리자 계정
						   			</c:when>
					   			</c:choose>	
			   				</p>
		   				</div>
						<div>
							<select name="member_type" id="member_type" class="input-full-border"  >
	   							<option value="customer"  <c:if test="${memberInfo.member_type == 'customer'}">selected</c:if>>고객 계정</option>
	   							<option value="admin"  <c:if test="${memberInfo.member_type == 'admin'}">selected</c:if>>관리자 계정</option>
	   						</select>	
						</div>
					</li>
		   			<li class="two-column not-toggle-view">
		   				<label>가입일</label>
		   				<div>
		   					<span><fmt:formatDate value="${memberInfo.reg_date}" pattern="yyyy년 MM월 dd일"/></span>
		   				</div>
		   				<label>수정일</label>
		   				<div>
		   					<span><fmt:formatDate value="${memberInfo.up_date}" pattern="yyyy년 MM월 dd일"/></span>
		   				</div>
		   			</li>
		   			<li class="confirm-btn-container">
		   				<button type="button" class="btn admin-btn-main" onclick="openModifyInput()">수정</button>
		   				<a href="/admin/member/memberList" class="btn btn-navy">목록</a>
			   			<button type="button" id="btn-modify" class="btn admin-btn-main" >수정완료</button>
			   			<c:choose>
			   				<c:when test="${memberInfo.user_id=='admin'}">
			   					<button type="button" class="btn btn-white btn-delete" >${memberInfo.user_id} 회원은 탈퇴처리가 불가합니다.</button>
			   				</c:when>
			   				<c:otherwise>
			   					<button type="button" id="btn-delete" class="btn admin-btn-main btn-delete" onclick="memberDelete('${memberInfo.user_id}')">회원탈퇴처리</button>
			   				</c:otherwise>
			   			</c:choose>
			   			<button type="button" class="btn btn-navy" onclick="cancleModify()">취소</button>
			   		</li>
		   		</ul>
	   		</form>
	   		
	   	</div>
	 </div>  	
   <%@ include file="../includes/adminFooter.jsp" %>