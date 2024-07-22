<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   	<script>
   		$(function(){
   			var empLevelName = ["인턴","사원","주임","계장","대리","과장","차장","부장","이사","사장"];
   			var empList = $(".admin-list-view li:not(:first-child)>p:nth-child(8)");
   			
   			if(empList.length>0){
   				for(var i=1; i<empList.length; i++){
   	   				var empLevel = parseInt(empList[i].innerText);
   	   				empList[i].innerText = empLevelName[empLevel];
   	   			}
   			}
   		});
   		
   		function AppoChange(empId, empAppo){
			var empData = {emp_id:empId, admin_approval : empAppo};
			var confirmMsg = parseInt(empAppo)>0?"의 운영자 승인을 해제하시겠습니까? ":"을 운영자 등록을 승인하시겠습니까?"
			
			if(confirm(empId+confirmMsg)){
				$.ajax({
   					url:"/admin/emp/approval",
   					type:"post",
   					data:empData,
   					success:function(result){
   						if(result=="success"){
   							alert(empId+"의 운영자 "+(empAppo>0?"승인 해제":"승인 처리")+"가 완료 되었습니다.");
   						}else{
   							alert("관리자 승인 처리중 문제가 발생하였습니다.");
   						}
   					}
   				});
				location.href="/admin/emp/empList";
			}
   		}
   		
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
   		<h2>MALL SETTING</h2>
   		<p>쇼핑몰 설정</p>
   	</div>
   	
   	<div class="admin-section">
   		<!-- <ul class="admin-section-tab-bar">
   			<li class="now-tab"><p>운영자목록</p></li>
   			<c:if test="${loginEmp.level == 9}"><li><a href="/admin/emp/join">운영자등록</a></li></c:if>
   		</ul>-->
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">운영자목록</li>
   			<c:if test="${loginEmp.level == 9}"><li><a href="/admin/emp/join">운영자등록</a></li></c:if>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default">
   			<h3 class="content-title">운영자목록</h3>
	   		<form action="/admin/emp/empList"  method="post" id="list-search-form">
		   		<ul class="admin-info-view admin-info-view-default">
		   			<li>
		   				<label>분류</label>
		   				<div class="search-type-admin">
		   					<select name="search-key-type" class="input-full-border">
								<option value="emp_id" <c:if test="${searchKey.searchKeyType == 'emp_id'}">selected</c:if>>아이디</option>
								<option value="emp_name" <c:if test="${searchKey.searchKeyType == 'emp_name'}">selected</c:if>>이름</option>
								<option value="emp_nick_name" <c:if test="${searchKey.searchKeyType == 'emp_nick_name'}">selected</c:if>>닉네임</option>
								<option value="emp_tel" <c:if test="${searchKey.searchKeyType == 'emp_tel'}">selected</c:if>>전화번호</option>
								<option value="emp_email" <c:if test="${searchKey.searchKeyType == 'emp_email'}">selected</c:if>>이메일</option>
							</select>
							<input type="text"  name="search-key-value" class="input-full-border" value="${searchKey.searchKeyValue}">
						</div>
		   			</li>
		   			<li>
		   				<label>부서</label>
		   				<div class="search-type-admin">
		   					<select name="defart" class="input-full-border">
		   						<c:if test="${loginEmp.level >= 9}"><option  value="">전체</option></c:if>
								<c:if test="${loginEmp.depart == '임시 부서1' || loginEmp.level >= 9}"><option  value="임시 부서1"  <c:if test="${searchKey.inputDefart == '임시 부서1'}">selected</c:if>>임시 부서1</option></c:if>
								<c:if test="${loginEmp.depart == '임시 부서2' || loginEmp.level >= 9}"><option  value="임시 부서2" <c:if test="${searchKey.inputDefart == '임시 부서2'}">selected</c:if> >임시 부서2</option></c:if>
								<c:if test="${loginEmp.depart == '임시 부서3' || loginEmp.level >= 9}"><option  value="임시 부서3"  <c:if test="${searchKey.inputDefart == '임시 부서3'}">selected</c:if>>임시 부서3</option></c:if>
								<c:if test="${loginEmp.depart == '임시 부서4' || loginEmp.level >= 9}"><option  value="임시 부서4"  <c:if test="${searchKey.inputDefart == '임시 부서4'}">selected</c:if>>임시 부서4</option></c:if>
							</select>
		   				</div>
		   			</li>
		   			<li class="search-more-optioin">
			   				<ul class="admin-info-view">
		   					<li>
				   				<label>직급</label>
				   				<div class="search-type-admin">
				   					<select name="level" class="input-full-border">
				   						<option  value="" >전체</option>
				   						<option  value="0" <c:if test="${searchKey.inputLevel == '0'}">selected</c:if>>인턴</option>
										<option  value="1" <c:if test="${searchKey.inputLevel == '1'}">selected</c:if>>사원</option>
										<option  value="2" <c:if test="${searchKey.inputLevel == '2'}">selected</c:if>>주임</option>
										<option  value="3" <c:if test="${searchKey.inputLevel == '3'}">selected</c:if>>계장</option>
										<option  value="4" <c:if test="${searchKey.inputLevel == '4'}">selected</c:if>>대리</option>
										<option  value="5" <c:if test="${searchKey.inputLevel == '5'}">selected</c:if> >과장</option>
										<option  value="6" <c:if test="${searchKey.inputLevel == '6'}">selected</c:if>>차장</option>
										<option  value="7" <c:if test="${searchKey.inputLevel == '7'}">selected</c:if>>부장</option>
										<option  value="8" <c:if test="${searchKey.inputLevel == '8'}">selected</c:if>>이사</option>
										<option  value="9" <c:if test="${searchKey.inputLevel == '9'}">selected</c:if>>사장</option>
				   					</select>
				   				</div>
				   			</li>
		   				</ul>
	  				<li>
		   				<label>기간별</label>
		   				<div class="date-range join-day-range search-range-admin">
		   					<select name="date-range-select" class="input-full-border">
	   							<option value="join_day" <c:if test="${searchKey.dateRangeSelect == 'join_day'}">selected</c:if>>입사일</option>
	   							<option value="last_work_day" <c:if test="${searchKey.dateRangeSelect == 'last_work_day'}">selected</c:if>>퇴사일</option>
	   						</select>	
		   					<input type="date"  name="day-begin" class="input-full-border">
		   					<span>~</span>
		   					<input type="date"  name="day-end" class="input-full-border">
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
	   		<ul class="admin-list-view admin-list-emps">
	   			<li><div class="list_length">조회된 운영자 ${allEmpCnt}명</div></li>
	   			<li>
					<p>아이디</p>
					<p>이름</p>
					<p>닉네임</p>
					<p>성별</p>
					<p>부서</p>
					<p>전화번호</p>
					<p>이메일</p>
					<p>직급</p>
					<p>입사일</p>
					<p>퇴사일</p>
					<p>상세정보</p>
	   			</li>
	   			<c:choose>
	   				<c:when test="${fn:length(empList)!=0}">
			   			<c:forEach items="${empList}" var="empList">
			   				<li>
			   					<p>${empList.emp_id}</p>
			   					<p>${empList.emp_name}</p>
			   					<p>${empList.emp_nick_name}</p>
			   					<p>
			   						<c:if test="${empList.emp_gender=='male'}">남성</c:if>
			   						<c:if test="${empList.emp_gender=='female'}">여성</c:if>
			   					</p>
			   					<p>${empList.depart}</p>
			   					<p>${empList.emp_tel}</p>
			   					<p>${empList.emp_email}</p>
			   					<p>${empList.level}</p>
			   					<p><fmt:formatDate value="${empList.join_day}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
			   					<p>
			   						<c:choose>
			   							<c:when test="${empList.last_work_day != null}"><fmt:formatDate value="${empList.last_work_day}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></c:when>
			   							<c:otherwise>---- 년 -- 월 -- 일</c:otherwise>
			   						</c:choose>
			   					</p>
			   					<p>
			   						<a href="/admin/emp/empOne?emp_id=${empList.emp_id}" class="btn btn-navy btn-emp-detail-pc">상세정보</a>
			   						<a href="/admin/emp/empOne?emp_id=${empList.emp_id}" class="btn btn-navy btn-emp-detail-m"><i class="bi bi-caret-right-fill"></i></a>
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
	   			<c:if test="${select_page_cnt-1>0}">	<li class="btn"><button  onclick="researchingToPageCnt(0)"><i class="bi bi-chevron-compact-left"></i></button></li></c:if>
	   			<c:forEach  var="i"  begin="${pageCntBeign}" end="${pageCntEnd}">
	   				<c:choose>
	   					<c:when test="${select_page_cnt==i}">
	   						<li class="btn"  style="color:#a56f63; font-weight:900;">${i} </li>
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
   
   <%@ include file="../includes/adminFooter.jsp" %>