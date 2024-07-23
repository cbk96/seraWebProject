<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	<script>
	$(function(){
   		var loginMember = '<%=session.getAttribute("loginMember")%>';
   		var sellPrice = document.querySelectorAll(".goods-price>span:nth-child(1)");
   		
   		//판매가격의 천의 자리수 마다 ',' 입력
   		for(var i=0; i<sellPrice.length; i++){
   			sellPrice[i].innerText = parseInt(sellPrice[i].innerText).toLocaleString();
   		}
   		
	});
	</script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		
   	</div>
   	<div class="banner banner-member">
   		<h2>GOODS</h2>
   		<p>상품 정보</p>
   	</div>
   	 <div class="section-tab-bar">
   	 	<ul>
	   	 	<li><a href="/goods/">전체상품 <i class="bi bi-chevron-right"></i></a></li>
		   	<li class="now-tab">${skinTypeKorean}</li>
	  	</ul>
   	 </div>
   	 
   	<section>
   		<div class="goods-category-wrap">
   			<p>피부타입</p>
   			<div>
   				<p <c:if test="${skinType=='oily_skin'}">class="on-category"</c:if>><a href="/goods/goodsListBySkinType?skin_type=oily_skin">지성 피부</a></p>
				<p <c:if test="${skinType=='dry_skin'}">class="on-category"</c:if>><a href="/goods/goodsListBySkinType?skin_type=dry_skin">건성 피부</a></p>
				<p <c:if test="${skinType=='combination_skin'}">class="on-category"</c:if>><a href="/goods/goodsListBySkinType?skin_type=combination_skin">복합성 피부</a></p>
   			</div>
   		</div>
   	
 		<form action="/goods/goodsListBySkinType"  method="get" id="modify_form"name="join_form">
	 		<h3 class="goods-search-title">상세검색</h3>
	   		<ul class=" search-layout input-layout-wide">
	   			<li>
					<label>상품명</label>
					<input type="text"  name="search_value" value="${search_value }" class="input-default input-bottom-border">
				</li>
				<li>
					<label>피부 타입별</label>
					<ul class="search-keyward-list">
						<li><a href="/goods/goodsListBySkinType?skin_type=oily_skin">지성 피부</a></li>
						<li><a href="/goods/goodsListBySkinType?skin_type=dry_skin">건성 피부</a></li>
						<li><a href="/goods/goodsListBySkinType?skin_type=combination_skin">복합성 피부</a></li>
					</ul>
				</li>
				<li class="confirm-btn-container" >
	   				<button type="submit" id="btn-join" class="btn btn-main" >상세검색</button>
	   				<input type="hidden" name="skin_type" value="${skinType}">
	   			</li>
	   		</ul>
	   	</form>
	   	
	   	<div class="goods-list-wrap">
	   		<div class="list_length">${goodsCnt}개 상품</div>
	   		<c:choose>
	   			<c:when test="${goods.size()>0}">
	   				<ul class="goods-list goods-list-all">
			   			<c:forEach items="${goods}" var="goods">
			   				<li>
			   					<p>
			   						<a href="/goods/goodsOne?goods_id=${goods.goods_id}" class="goods-main-image goods-image-middle">
			   							<i class="bi bi-image-alt"></i>
			   							<img src="${goods.goods_image}" alt="상품 이미지" onerror="this.style.display='none'">
			   						</a>
			   					</p>
			   					<p><a href="/goods/goodsOne?goods_id=${goods.goods_id}">${goods.goods_name}</a></p>
			   					<p class="goods-price"><span>${goods.sell_price}</span><span>원</span><span>(5% 적립)</span></p>
			   				</li>
			   			</c:forEach>
			   		</ul>
	   			</c:when>
	   			<c:otherwise>
	   				<p class="search-null-result">조회된 상품이 없습니다.</p>
	   			</c:otherwise>
	   		</c:choose>
	   		
	   		<ul class="page-cnt-btn-container">
	   			<li class="btn btn-page"><a href="/goods/goodsListBySkinType?skin_type=${skinType}&page_cnt=1&search_value=${search_value}" ><i class="bi bi-chevron-double-left"></i></a></li>
	   			<c:if test="${select_page_cnt-1>0}"><li class="btn btn-page"><a href="/goods/goodsListBySkinType?skin_type=${skinType}&page_cnt=${select_page_cnt-1}&search_value=${search_value}" ><i class="bi bi-chevron-compact-left"></i></a></li></c:if>
	   			<c:forEach  var="i"  begin="${pageCntBeign}" end="${pageCntEnd}">
	   				<c:choose>
	   					<c:when test="${select_page_cnt==i}">
	   						<li class="btn btn-page" style="color:#a56f63; font-weight:900;">${i}</li>
	   					</c:when>
	   					<c:otherwise>
	   						<li class="btn btn-page"><a href="/goods/goodsListBySkinType?skin_type=${skinType}&page_cnt=${i}&search_value=${search_value}" >${i}</a></li>
	   					</c:otherwise>
	   				</c:choose>
	   			</c:forEach>
	   			<c:if test="${select_page_cnt < maxPageCnt}"><li class="btn btn-page"><a href="/goods/goodsListBySkinType?skin_type=${skinType}&page_cnt=${select_page_cnt+1}&search_value=${search_value}" ><i class="bi bi-chevron-compact-right"></i></a></li></c:if> 
	   			<li class="btn btn-page"><a href="/goods/goodsListBySkinType?skin_type=${skinType}&page_cnt=${maxPageCnt}&search_value=${search_value}" ><i class="bi bi-chevron-double-right"></i></a></li>
	   		</ul>
	   		<input type="hidden" name="now-select-page" value="${select_page_cnt}">
	   	</div>
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>