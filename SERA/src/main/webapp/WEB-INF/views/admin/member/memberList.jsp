<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
	   function researchingToPageCnt(page_cnt){
			var listSearchForm = $("#list-search-form");
			var hidden_page_cnt = $("input[name='page_cnt']");
			var nowSelectPage = $("input[name='now-select-page']").val();
   			
   			if(page_cnt<=0){
   				hidden_page_cnt.val(nowSelectPage-1);
   				listSearchForm.submit();
   			}else{
   				hidden_page_cnt.val(page_cnt);
   				listSearchForm.submit();
   			}
		}
   </script>
   	<script src="/resources/js/searchOptionSettion.js"></script>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>MEMBER MANAGEMENT</h2>
   		<p>회원관리</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   		<c:choose>
   			<c:when test="${memberType == 'active'}">
   				<li class="now-tab">회원목록</li>
   				<li><a href="/admin/member/memberList?black_list=yes">블랙리스트관리</a></li>
   				<li><a href="/admin/member/memberList?active=no">휴면회원목록</a></li>
   			</c:when>
   			<c:when test="${memberType == 'blackList'}">
   				<li><a href="/admin/member/memberList">회원목록</a></li>
   				<li class="now-tab">블랙리스트관리</li>
   				<li><a href="/admin/member/memberList?active=no">휴면회원목록</a></li>
   			</c:when>
   			<c:when test="${memberType == 'notActive'}">
   				<li><a href="/admin/member/memberList">회원목록</a></li>
   				<li><a href="/admin/member/memberList?black_list=yes">블랙리스트관리</a></li>
   				<li class="now-tab">휴면회원목록</li>
   			</c:when>
   		</c:choose>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default">
	   		<h3 class="content-title">
	 			<c:choose>
	  					<c:when test="${memberType == 'active'}">
		   				회원목록
		   			</c:when>
		   			<c:when test="${memberType == 'blackList'}">
		   				블랙리스트관리
		   			</c:when>
		   			<c:when test="${memberType == 'notActive'}">
		   				휴면회원목록
		   			</c:when>
	   			</c:choose>
	  		</h3>
	   		<form action="/admin/member/memberList?active=${active}&black_list=${blackList}"  method="post" id="list-search-form">
		   		<ul class="admin-info-view admin-info-view-default">
		   			<li>
		   				<label>분류</label>
		   				<div class="search-type-admin">
		   					<select name="search-key-type" class="input-full-border">
								<option value="user_id" <c:if test="${searchKey.searchKeyType == 'user_id'}">selected</c:if>>아이디</option>
								<option value="name" <c:if test="${searchKey.searchKeyType == 'name'}">selected</c:if>>이름</option>
								<option value="nick_name" <c:if test="${searchKey.searchKeyType == 'nick_name'}">selected</c:if>>닉네임</option>
								<option value="brand" <c:if test="${searchKey.searchKeyType == 'brand'}">selected</c:if>>회원 선호 브랜드</option>
								<option value="tel" <c:if test="${searchKey.searchKeyType == 'tel'}">selected</c:if>>연락처</option>
								<option value="email" <c:if test="${searchKey.searchKeyType == 'email'}">selected</c:if>>이메일</option>
							</select>
							<input type="text"  name="search-key-value" class="input-full-border" value="${searchKey.searchKeyValue}">
						</div>
		   			</li>
		   			<li>
		   				<label>회원등급</label>
		   				<div class="search-type-admin">
		   					<select name="grade" class="input-full-border">
		   						<option value="all" <c:if test="${searchKey.grade == 'all'}">selected</c:if>>전체</option>
	   							<option value="common" <c:if test="${searchKey.grade == 'common'}">selected</c:if>>common</option>
	   							<option value="bronze" <c:if test="${searchKey.grade == 'bronze'}">selected</c:if>>bronze</option>
	   							<option value="silver" <c:if test="${searchKey.grade == 'silver'}">selected</c:if>>silver</option>
	   							<option value="gold" <c:if test="${searchKey.grade == 'gold'}">selected</c:if>>gold</option>
	   							<option value="platinum" <c:if test="${searchKey.grade == 'platinum'}">selected</c:if>>platinum</option>
	   						</select>	
		   				</div>
		   			</li>
		   			<li class="search-more-optioin">
		   				<ul class="admin-info-view radio-visible">
				   			<li>
				   				<label>성별</label>
				   				<div class="search-radio-admin">
				   					<input type="radio" id="all_gender" name="gender" value="all" <c:if test="${searchKey ==null}">checked</c:if><c:if test="${searchKey.gender == 'all'}">checked</c:if>><label for="all_gender">전체</label> 
				   					<input type="radio" id="male" name="gender" value="male"  <c:if test="${searchKey.gender == 'male'}">checked</c:if>><label for="male">남성</label> 
				   					<input type="radio" id="female" name="gender" value="female"<c:if test="${searchKey.gender == 'female'}">checked</c:if>><label for="female">여성</label> 
				   				</div>
				   			</li>
				   			<li>
				   				<label>피부타입</label>
				   				<div class="search-radio-admin">
				   					<input type="radio" id="all_skin" name="skin_type" value="all" <c:if test="${searchKey ==null}">checked</c:if><c:if test="${searchKey.skinType == 'all'}">checked</c:if>><label for="all_skin">전체</label> 
				   					<input type="radio" id="oily_skin" name="skin_type" value="oily_skin"  <c:if test="${searchKey.skinType == 'oily_skin'}">checked</c:if>><label for="oily_skin">지성</label> 
				   					<input type="radio" id="dry_skin" name="skin_type" value="dry_skin"  <c:if test="${searchKey.skinType == 'dry_skin'}">checked</c:if>><label for="dry_skin">건성</label> 
				   					<input type="radio" id="combination_skin" name="skin_type" value="combination_skin"  <c:if test="${searchKey.skinType == 'combination_skin'}">checked</c:if>><label for="combination_skin">복합성</label> 
				   				</div>
				   			</li>
				   			<li>
				   				<label>접근 경로</label>
				   				<div class="search-radio-admin">
				   				<input type="radio" id="from_all" name="access_route" value="all" <c:if test="${searchKey ==null}">checked</c:if><c:if test="${searchKey.accessRoute == 'all'}">checked</c:if>><label for="from_all">전체</label>
				   					<input type="radio" id="from_friend" name="access_route" value="from_friend"  <c:if test="${searchKey.accessRoute == 'from_friend'}">checked</c:if>><label for="from_friend">지인의 추천</label> 
				   					<input type="radio" id="from_searching" name="access_route" value="from_searching"  <c:if test="${searchKey.accessRoute == 'from_searching'}">checked</c:if>><label for="from_searching">인터넷 검색</label> 
				   					<input type="radio" id="from_commercial" name="access_route" value="from_commercial"  <c:if test="${searchKey.accessRoute == 'from_commercial'}">checked</c:if>><label for="from_commercial">광고</label> 
				   				</div>
				   			</li>
				   			<li>
				   				<label>정렬기준</label>
				   				<div class="search-radio-admin">
				   					<select name="list-sort" class="input-full-border">
			   							<option value="asc" <c:if test="${searchKey.listSort == 'asc'}">selected</c:if>>오름차순</option>
			   							<option value="desc" <c:if test="${searchKey.listSort == 'desc'}">selected</c:if>>내림차순</option>
			   						</select>
				   					<input type="radio" id="reg_date" name="turn-select" value="reg_date" <c:if test="${searchKey ==null}">checked</c:if><c:if test="${searchKey.turnSelect == 'reg_date'}">checked</c:if>><label for="reg_date">가입일 순</label> 
				   					<input type="radio" id="up_date" name="turn-select" value="up_date"  <c:if test="${searchKey.turnSelect == 'up_date'}">checked</c:if>><label for="up_date">수정일 순</label> 
				   					<input type="radio" id="user_id" name="turn-select" value="user_id"  <c:if test="${searchKey.turnSelect == 'user_id'}">checked</c:if>><label for="user_id">아이디 순</label> 
				   					<input type="radio" id="user_name" name="turn-select" value="name"  <c:if test="${searchKey.turnSelect == 'name'}">checked</c:if>><label for="user_name">이름 순</label>
				   					<input type="radio" id="nick_name" name="turn-select" value="nick_name"  <c:if test="${searchKey.turnSelect == 'nick_name'}">checked</c:if>><label for="nick_name">닉네임 순</label> 
				   				</div>
				   			</li>
		   				</ul>
		   			</li>
		   			<li>
		   				<label>가입/수정일</label>
		   				<div class="date-range search-range-admin">
		   					<select name="date-range-select" class="input-full-border">
	   							<option value="reg_date" <c:if test="${searchKey.dateRangeSelect == 'reg_date'}">selected</c:if>>가입일</option>
	   							<option value="up_date" <c:if test="${searchKey.dateRangeSelect == 'up_date'}">selected</c:if>>수정일</option>
	   						</select>	
		   					<input type="date"  name="day-begin" class="input-full-border" value="${searchKey.dayBegin}">
		   					<span>~</span>
		   					<input type="date"  name="day-end" class="input-full-border" value="${searchKey.dayEnd}">
		   				</div>
		   			</li>
		   			<li>
		   				<button type="submit" class="btn admin-btn-main">검색</button>
		   				<button type="button" id="btn-expand" class="btn btn-white"><i class="bi bi-caret-down"></i></button>
		   				<input type="hidden" name="btn-expand-remember"  id="btn-expand-remember"  value="${searchKey.btnExpandRemem}">
		   				<input type="hidden" name="page_cnt" >
		   			</li>
		   		</ul>
	   		</form>
	   		<ul class="admin-list-view admin-list-members">
	   			<li><div class="list_length">조회된 회원 ${allMemberCnt}명</div></li>
	   			<li>
					<p>아이디</p>
					<p>이름</p>
					<p>닉네임</p>
					<p>고객등급</p>
					<p>성별</p>
					<p>피부타입</p>
					<p>선호 브랜드</p>
					<p>연락처</p>
					<p>이메일</p>
					<p>주소</p>
					<p>사이트 접근 경로</p>
					<p>생년월일</p>
					<p>가입일</p>
					<p>상세정보</p>
	   			</li>
	   			<c:choose>
	   				<c:when test="${fn:length(memberList)!=0}">
	   					<c:forEach items="${memberList}" var="memberList">
			   				<li>
			  					<p>${memberList.user_id}</p>
			  					<p>${memberList.name}</p>
			  					<p>${memberList.nick_name}</p>
			  					<p>${memberList.grade}</p>
			  					<p>
			  						<c:if test="${memberList.gender=='male'}">남성</c:if>
			   						<c:if test="${memberList.gender=='female'}">여성</c:if>
			  					</p>
			  					<p>
			  						<c:choose>
			  							<c:when test="${memberList.skin_type=='oily_skin'}">지성</c:when>
			  							<c:when test="${memberList.skin_type=='dry_skin'}">건성</c:when>
			  							<c:when test="${memberList.skin_type=='combination_skin'}">복합성</c:when>
			  						</c:choose>
			  					</p>
			  					<p>${memberList.brand}</p>
			  					<p>${memberList.tel}</p>
			  					<p>${memberList.email}</p>
			  					<p><span>${memberList.post_code}</span> <span>${memberList.address}</span></p>
			  					<p>
			  						<c:choose>
			  							<c:when test="${memberList.access_route=='from_friend'}">지인 추천</c:when>
			  							<c:when test="${memberList.access_route=='from_searching'}">인터넷 검색</c:when>
			  							<c:when test="${memberList.access_route=='from_commercial'}">광고</c:when>
			  						</c:choose>
			  					</p>
			  					<p><fmt:formatDate value="${memberList.birth}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
			  					<p><fmt:formatDate value="${memberList.reg_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
			  					<p>
			  						<c:choose>
							   			<c:when test="${memberType == 'active'}">
							   				<a href="/admin/member/memberOne?user_id=${memberList.user_id}" class="btn btn-navy btn-emp-detail-pc">상세정보</a>
							   				<a href="/admin/member/memberOne?user_id=${memberList.user_id}" class="btn btn-navy btn-emp-detail-m"><i class="bi bi-caret-right-fill"></i></a>
							   			</c:when>
							   			<c:when test="${memberType == 'notActive'}">
							   				<a href="/admin/member/sleeperOne?user_id=${memberList.user_id}" class="btn btn-navy btn-emp-detail-pc">상세정보</a>
							   				<a href="/admin/member/sleeperOne?user_id=${memberList.user_id}" class="btn btn-navy btn-emp-detail-m"><i class="bi bi-caret-right-fill"></i></a>
							   			</c:when>
							   			<c:when test="${memberType == 'blackList'}">
							   				<a href="/admin/member/blackOne?user_id=${memberList.user_id}" class="btn btn-navy btn-emp-detail-pc">상세정보</a>
							   				<a href="/admin/member/blackOne?user_id=${memberList.user_id}" class="btn btn-navy btn-emp-detail-m"><i class="bi bi-caret-right-fill"></i></a>
							   			</c:when>
						   			</c:choose>
			  					</p>
			   				</li>
			   			</c:forEach>
	   				</c:when>
	   				<c:otherwise>
	   					<p class="search-null-result">검색된 결과가 없습니다.</p>
	   				</c:otherwise>
	   			</c:choose>
	   		</ul>
	   		<ul class="page-cnt-btn-container">
	   			<li class="btn"><button  onclick="researchingToPageCnt(1)" ><i class="bi bi-chevron-double-left"></i></button></li>
	   			<c:if test="${select_page_cnt-1>0}">	<li class="btn"><button  onclick="researchingToPageCnt(0)" ><i class="bi bi-chevron-compact-left"></i></button></li></c:if>
	   			<c:forEach  var="i"  begin="${pageCntBeign}" end="${pageCntEnd}">
	   				<c:choose>
	   					<c:when test="${select_page_cnt==i}">
	   						<li class="btn"  style="color:#a56f63; font-weight:900;">${i}</li>
	   					</c:when>
	   					<c:otherwise>
	   						<li class="btn"><button onclick="researchingToPageCnt(${i})" >${i}</button></li>
	   					</c:otherwise>
	   				</c:choose>
	   			</c:forEach>
	   			<c:if test="${select_page_cnt < maxPageCnt}"><li class="btn"><button  onclick="researchingToPageCnt(${select_page_cnt+1})" ><i class="bi bi-chevron-compact-right"></i></button></li></c:if> 
	   			<li class="btn"><button onclick="researchingToPageCnt(${pageCntEnd})" ><i class="bi bi-chevron-double-right"></i></button></li>
	   		</ul>
	   		<input type="hidden" name="now-select-page" value="${select_page_cnt}">
	   	</div>
	 </div>  	
   	<script>
   		//대분류 선택에 따른 중분류 표시
	   	function subTypeSetting(){
	   		var mainType = document.getElementById("main_type");
	   		var selectMainType = mainType.options[mainType.selectedIndex].value;
	   		var allSubTypes = document.querySelectorAll("#sub_type>option");
	   		var visibleSubTypes = document.querySelectorAll("#sub_type>option[class='"+selectMainType+"']");
	   		
	   		for(var i=0; i<allSubTypes.length; i++){
	   			if(allSubTypes[i].getAttribute("class")==selectMainType || allSubTypes[i].getAttribute("class")=="default_option" ){
	   				allSubTypes[i].style.display = "block";
	   			}else{
	   				allSubTypes[i].style.display = "none";
	   			}
	   		}
		}
   	</script>
   <%@ include file="../includes/adminFooter.jsp" %>