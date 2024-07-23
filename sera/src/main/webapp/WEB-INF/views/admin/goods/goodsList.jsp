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
   		<h2>GOODS MANAGEMENT</h2>
   		<p>상품 관리</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<c:if test="${loginEmp.level>=9}"><li><a href="/admin/goods/categoryList">카테고리 관리</a></li></c:if>
	   		<c:choose>
	   			<c:when test="${saleActive == 'goods_delete'}">
	   				<li><a href="/admin/goods/">상품목록</a></li>
	   				<li class="now-tab">삭제상품목록</li>
	   			</c:when>
	   			<c:otherwise>
	   				<li class="now-tab">상품목록</li>
	   				<li><a href="/admin/goods/?saleActive=goods_delete">삭제상품목록</a></li>
	   			</c:otherwise>
	   		</c:choose>
	   		<li><a href="/admin/goods/goodsRegist">상품등록</a></li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default">
	   		<h3 class="content-title">
	 				<c:choose>
	  					<c:when test="${saleActive == 'goods_delete'}">
		   				삭제상품목록
		   			</c:when>
		   			<c:otherwise>
		   				상품목록
		   			</c:otherwise>
	   			</c:choose>
	 		</h3>
	   		<form action="/admin/goods/?saleActive=${saleActive}"  method="post" id="list-search-form">
		   		<ul class="admin-info-view admin-info-view-default">
		   			<li>
		   				<label>카테고리</label>
		   				<div class="search-multi-select-admin">
		   					<select name="main_type" id="main_type" class="input-full-border" onchange="subTypeSetting()" required>
		   						<option value="">--대분류--</option>
		   						<c:if test="${loginEmp.level>=9}"><option value="allType"  <c:if test="${searchKey.inputMainType == 'allType'}">selected</c:if>>전체</option></c:if>
		   						<c:forEach items="${mainType}" var="mainCate">
		   							<c:if test="${loginEmp.depart == mainCate.depart || loginEmp.level>=9}">
		   								<option  class="${mainCate.depart}" value="${mainCate.main_type}"  <c:if test="${mainCate.main_type == searchKey.inputMainType}">selected</c:if>>${mainCate.main_type}</option>
		   							</c:if>
		   						</c:forEach>
							</select>
							<select name="sub_type_cate_id" id="sub_type" class="input-full-border" required>
								<option class="default_option" value="">--중분류--</option>
		   						<c:if test="${loginEmp.level>=9}"><option class="default_option" value="allType"  <c:if test="${searchKey.inputCateId == 'allType'}">selected</c:if>>전체</option></c:if>
		   						<c:forEach items="${subType}" var="subCate">
		   							<option class="${subCate.main_type}" value="${subCate.category_id}"  <c:if test="${subCate.category_id == searchKey.inputCateId}">selected</c:if>>${subCate.sub_type}</option>
		   						</c:forEach>
							</select>
		   				</div>
		   			</li>
		   			<li>
		   				<label>분류</label>
		   				<div class="search-type-admin">
		   					<select name="search-key-type" class="input-full-border">
		   						<option value="goods_name" <c:if test="${searchKey.searchKeyType == 'goods_name'}">selected</c:if>>상품명</option>
								<option value="goods_id" <c:if test="${searchKey.searchKeyType == 'goods_id'}">selected</c:if>>일련번호</option>
								<option value="goods_search_key" <c:if test="${searchKey.searchKeyType == 'goods_search_key'}">selected</c:if>>상품 검색키워드</option>
								<option value="emp_id" <c:if test="${searchKey.searchKeyType == 'emp_id'}">selected</c:if>>등록자</option>
							</select>
							<input type="text"  name="search-key-value" class="input-full-border" value="${searchKey.searchKeyValue}">
						</div>
		   			</li>
		   			<li class="search-more-optioin">
		   				<ul class="admin-info-view radio-visible">
		   					<li>
				   				<label>가격</label>
				   				<div class="price-range search-range-admin">
				   					<select name="price-ragne-select" class="input-full-border">
			   							<option value="sell_price" <c:if test="${searchKey.priceRagneSelect == 'sell_price'}">selected</c:if>>판매가</option>
			   							<option value="purchase_price" <c:if test="${searchKey.priceRagneSelect == 'purchase_price'}">selected</c:if>>매입가</option>
			   						</select>	
				   					<input type="number"  min="0" name="price-begin" class="input-full-border" value="${searchKey.priceBegin}">
				   					<span>~</span>
				   					<input type="number"  min="0" name="price-end" class="input-full-border" value="${searchKey.priceEnd}">
				   				</div>
				   			</li>
				   			<li>
				   				<label>정렬기준</label>
				   				<div class="search-radio-admin">
				   					<select name="list-sort" class="input-full-border">
				   						<option value="desc" <c:if test="${searchKey.listSort == 'desc'}">selected</c:if>>내림차순</option>
			   							<option value="asc" <c:if test="${searchKey.listSort == 'asc'}">selected</c:if>>오름차순</option>
			   						</select>
				   					<input type="radio" id="goods_reg_date" name="turn-select" value="goods_reg_date"  <c:if test="${searchKey ==null}">checked</c:if><c:if test="${searchKey.turnSelect == 'goods_reg_date'}">checked</c:if>><label for="goods_reg_date">등록일 순</label> 
				   					<input type="radio" id="goods_up_date" name="turn-select" value="goods_up_date"  <c:if test="${searchKey.turnSelect == 'goods_up_date'}">checked</c:if>><label for="goods_up_date">수정일 순</label> 
				   					<input type="radio" id="goods_id" name="turn-select" value="goods_id"   <c:if test="${searchKey.turnSelect == 'goods_id'}">checked</c:if>><label for="goods_id">일련번호 순</label> 
				   					<input type="radio" id="goods_name" name="turn-select" value="goods_name"   <c:if test="${searchKey.turnSelect == 'goods_name'}">checked</c:if>><label for="goods_name">상품명 순</label>
				   					<input type="radio" id="view_cnt" name="turn-select" value="view_cnt"   <c:if test="${searchKey.turnSelect == 'view_cnt'}">checked</c:if>><label for="view_cnt">조회수 순</label> 
				   				</div>
				   			</li>
		   				</ul>
		   			</li>
		   			<li>
		   				<label>등록/수정일</label>
		   				<div class="date-range search-range-admin">
		   					<select name="date-range-select" class="input-full-border">
	   							<option value="goods_reg_date" <c:if test="${searchKey.dateRangeSelect == 'goods_reg_date'}">selected</c:if>>등록일</option>
	   							<option value="goods_up_date" <c:if test="${searchKey.dateRangeSelect == 'goods_up_date'}">selected</c:if>>수정일</option>
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
	   		<ul class="admin-list-view admin-list-goods">
	   			<li><div class="list_length">조회된 상품 ${allGoodCnt}개</div></li>
	   			<li>
					<p>일련번호</p>
					<p>판매여부</p>
					<p>상품명</p>
					<p>등록자</p>
					<p>상품 이미지</p>
					<p>대분류</p>
					<p>중분류</p>
					<p>매입가</p>
					<p>판매가</p>
					<p>재고</p>
					<p>조회수</p>
					<p>등록일</p>
					<p>수정일</p>
					<p>상세정보</p>
	   			</li>
	   			<c:choose>
	   				<c:when test="${fn:length(goodsList)!=0}">
			   			<c:forEach items="${goodsList}" var="goodsList">
			   				<li>
			  					<p>${goodsList.goods_id}</p>
			  					<p>
			  						<c:choose>
			  							<c:when test="${goodsList.sale_active=='y'}"><span class="btn btn-for-sale btn-navy">판매중</span></c:when>
			  							<c:when test="${goodsList.sale_active=='n'}"><span class="btn btn-sold-out btn-white">품절</span></c:when>
			  							<c:when test="${goodsList.sale_active=='d'}"><span class="btn btn-sold-out btn-alert">삭제상품</span></c:when>
			  						</c:choose>
			  					</p>
			   					<p><a href="/admin/goods/goodsOneDetail?goods_id=${goodsList.goods_id}">${goodsList.goods_name}</a></p>
			   					<p>${goodsList.emp_id}</p>
			   					<p>
			   						<a href="/goods/goodsOne?goods_id=${goodsList.goods_id}" target="blank" class="goods-main-image goods-image-tiny">
				   						<i class="bi bi-image-alt"></i>
				   						<img src="${goodsList.goods_image}" onerror="this.style.display='none'" alt="상품 이미지">
			   						</a>
			   					</p>
			   					<p>${goodsList.main_type}</p>
			   					<p>${goodsList.sub_type}</p>
			   					<p>${goodsList.purchase_price}원</p>
			   					<p>${goodsList.sell_price}원</p>
			   					<p>${goodsList.amount}</p>
			   					<p>${goodsList.view_cnt}</p>
			   					<p><fmt:formatDate value="${goodsList.goods_reg_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
			   					<p><fmt:formatDate value="${goodsList.goods_up_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
			   					<p>
			   						<a href="/admin/goods/goodsOneDetail?goods_id=${goodsList.goods_id}" class="btn btn-navy btn-emp-detail-pc">상세정보</a>
			   						<a href="/admin/goods/goodsOneDetail?goods_id=${goodsList.goods_id}" class="btn btn-navy btn-emp-detail-m"><i class="bi bi-caret-right-fill"></i></a>
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
	   			<li class="btn">
	   				<button  onclick="researchingToPageCnt(1)" >
	   					<i class="bi bi-chevron-double-left"></i>
	   				</button>
	   			</li>
	   			<c:if test="${select_page_cnt-1>0}">
	   				<li class="btn">
	   					<button  onclick="researchingToPageCnt(0)" >
	   						<i class="bi bi-chevron-compact-left"></i>
	   					</button>
	   				</li>
	   			</c:if>
	   			<c:forEach  var="i"  begin="${pageCntBeign}" end="${pageCntEnd}">
	   				<c:choose>
	   					<c:when test="${select_page_cnt==i}">
	   						<li class="btn"  style="color:#a56f63; font-weight:900">${i} </li>
	   					</c:when>
	   					<c:otherwise>
	   						<li class="btn"><button onclick="researchingToPageCnt(${i})" >${i}</button></li>
	   					</c:otherwise>
	   				</c:choose>
	   			</c:forEach>
	   			<c:if test="${select_page_cnt < maxPageCnt}">
		   			<li class="btn">
		   				<button  onclick="researchingToPageCnt(${select_page_cnt+1})" >
		   					<i class="bi bi-chevron-compact-right"></i>
		   				</button>
		   			</li>
	   			</c:if> 
	   			<li class="btn">
	   				<button onclick="researchingToPageCnt(${maxPageCnt})" >
	   					<i class="bi bi-chevron-double-right"></i>
	   				</button>
	   			</li>
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