<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   	<script src="/resources/js/searchOptionSettion.js"></script>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>GOODS MANAGEMENT</h2>
   		<p>상품 관리</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">카테고리 관리</li>
   			<li><a href="/admin/goods/">상품목록</a></li>
   			<li><a href="/admin/goods/?saleActive=goods_delete">삭제상품목록</a></li>
   			<li><a href="/admin/goods/goodsRegist">상품등록</a></li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default">
	   		<h3 class="content-title">카테고리 목록</h3>
	   		<ul class="admin-list-view admin-list-categorys">
	   			<li></li>
	   			<li>
					<p>카테고리 번호</p>
					<p>대분류</p>
					<p>중분류</p>
					<p>담당부서</p>
	   			</li>
	   			<c:choose>
	   				<c:when test="${fn:length(categoryList)!=0}">
			   			<c:forEach items="${categoryList}" var="categoryList">
			   				<li>
			  					<p>${categoryList.category_id }</p>
			  					<p>${categoryList.main_type }</p>
			  					<p>${categoryList.sub_type }</p>
			  					<p>${categoryList.depart }</p>
			   				</li>
			   			</c:forEach>
		   			</c:when>
		   			<c:otherwise>
	   					<p class="search-null-result">검색된 카테고리가 없습니다.</p>
	   				</c:otherwise>
	   			</c:choose>
	   		</ul>
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