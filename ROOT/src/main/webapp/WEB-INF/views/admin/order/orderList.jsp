<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
   $(function(){
	   var viewPrice = document.querySelectorAll(".view-price");
  		
  		//판매가격의 천의 자리수 마다 ',' 입력
  		for(var i=0; i<viewPrice.length; i++){
  			viewPrice[i].innerText = parseInt(viewPrice[i].innerText).toLocaleString();
  		}
   });
   
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
   		<h2>ORDERS MANAGEMENT</h2>
   		<p>주문 관리</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">주문목록</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default">
	   		<h3 class="content-title">주문목록</h3>
	   		<form action="/admin/order/orderSearch"  method="post" id="list-search-form">
		   		<ul class="admin-info-view admin-info-view-default">
		   			<li>
		   				<label>분류</label>
		   				<div class="search-type-admin">
		   					<select name="search-key-type" class="input-full-border">
		   						<option value="order_number" <c:if test="${searchKey.searchKeyType == 'order_number'}">selected</c:if>>주문번호</option>
								<option value="goods_id" <c:if test="${searchKey.searchKeyType == 'goods_id'}">selected</c:if>>상품일련번호</option>
								<option value="goods_name" <c:if test="${searchKey.searchKeyType == 'goods_name'}">selected</c:if>>상품명</option>
								<option value="user_id" <c:if test="${searchKey.searchKeyType == 'user_id'}">selected</c:if>>구매자 아이디</option>
								<option value="name" <c:if test="${searchKey.searchKeyType == 'name'}">selected</c:if>>구매자명</option>
							</select>
							<input type="text"  name="search-key-value" class="input-full-border" value="${searchKey.searchKeyValue}">
						</div>
		   			</li>
		   			<li>
		   				<label>구매액</label>
		   				<div class="price-range search-range-admin">
		   					<input type="number"  min="0" name="price-begin" class="input-full-border" value="${searchKey.priceBegin}">
		   					<span>~</span>
		   					<input type="number"  min="0" name="price-end" class="input-full-border" value="${searchKey.priceEnd}">
		   				</div>
		   			</li>
		   			<li>
		   				<label>배송상태</label>
		   				<div class="search-type-admin">
		   					<select name="order_status" class="input-full-border">
		   						<option value="all" <c:if test="${searchKey.order_status == 'all'}">selected</c:if>>전체</option>
		   						<option value="결제대기" <c:if test="${searchKey.order_status == '결제대기'}">selected</c:if>>결제대기</option>
	   							<option value="결제완료" <c:if test="${searchKey.order_status == '결제완료'}">selected</c:if>>결제완료</option>
	   							<option value="배송준비중" <c:if test="${searchKey.order_status == '배송준비중'}">selected</c:if>>배송준비중</option>
	   							<option value="배송중" <c:if test="${searchKey.order_status == '배송중'}">selected</c:if>>배송중</option>
	   							<option value="배송완료" <c:if test="${searchKey.order_status == '배송완료'}">selected</c:if>>배송완료</option>
	   							<option value="구매확정" <c:if test="${searchKey.order_status == '구매확정'}">selected</c:if>>구매확정</option>
	   							<option value="취소" <c:if test="${searchKey.order_status == '취소'}">selected</c:if>>취소</option>
	   							<option value="반품" <c:if test="${searchKey.order_status == '반품'}">selected</c:if>>반품</option>
	   						</select>
		   				</div>
		   			</li>
		   			<li class="search-more-optioin">
		   				<ul class="admin-info-view radio-visible">
				   			<li>
				   				<label>정렬기준</label>
				   				<div class="search-radio-admin">
				   					<select name="list-sort" class="input-full-border">
				   						<option value="desc" <c:if test="${searchKey.listSort == 'desc'}">selected</c:if>>내림차순</option>
			   							<option value="asc" <c:if test="${searchKey.listSort == 'asc'}">selected</c:if>>오름차순</option>
			   						</select>
				   					<input type="radio" id="order_date" name="turn-select" value="order_date"  <c:if test="${searchKey ==null}">checked</c:if><c:if test="${searchKey.turnSelect == 'order_date'}">checked</c:if>><label for="order_date">주문일 순</label> 
				   					<input type="radio" id="cancel_date" name="turn-select" value="cancel_date"  <c:if test="${searchKey.turnSelect == 'cancel_date'}">checked</c:if>><label for="cancel_date">취소일 순</label> 
				   					<input type="radio" id="order_number" name="turn-select" value="order_number"   <c:if test="${searchKey.turnSelect == 'order_number'}">checked</c:if>><label for="order_number">주문번호 순</label> 
				   				</div>
				   			</li>
		   				</ul>
		   			</li>
		   			<li>
		   				<label>주문취소일</label>
		   				<div class="date-range search-range-admin">
		   					<input type="hidden" name="date-range-select" value="order_date">
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
	   		<ul class="admin-list-view admin-list-orders">
	   			<li><div class="list_length">조회된 주문 ${allOrderCnt}건</div></li>
	   			<li> 
	   				<!--  <p>주문취소 요청</p>-->
					<p>주문번호</p>
					<p>구매자 유형</p>
					<p>구매자 아이디</p>
					<p>구매자명</p>
					<p>구매액</p>
					<p>주문일</p>
					<p>상세정보</p>
	   			</li>
	   			<c:choose>
	   				<c:when test="${fn:length(orderList)!=0}">
			   			<c:forEach items="${orderList}" var="orderOne">
			   				<li>
			   					<!-- <p>
			   						<c:choose>
				   						<c:when test="${orderOne.customer_req=='cancel' || orderOne.customer_req=='return'}">
				   							<span class="btn btn-sold-out btn-alert">요청접수</span>
				   						</c:when>
				   						<c:otherwise>요청 없음</c:otherwise>
				   					</c:choose>
			   					</p>-->
			  					<p>${orderOne.order_number}</p>
			  					<p>
			  						<c:choose>
			  							<c:when test="${orderOne.member_order=='y'}"><span class="btn btn-for-sale btn-navy">회원</span></c:when>
			  							<c:when test="${orderOne.member_order=='n'}"><span class="btn btn-sold-out btn-white">비회원</span></c:when>
			  						</c:choose>	
			  					</p>
			  					<p>${orderOne.user_id}</p>
			  					<p>${orderOne.name}</p>
			  					<p><span class="view-price">${orderOne.all_price}</span></p>
			  					<p><fmt:formatDate value="${orderOne.order_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
			  					
			   					<p>
			   						<a href="/admin/order/orderOneDetail?order_number=${orderOne.order_number}" class="btn btn-navy btn-emp-detail-pc">상세정보</a>
			   						<a href="/admin/order/orderOneDetail?order_number=${orderOne.order_number}" class="btn btn-navy btn-emp-detail-m"><i class="bi bi-caret-right-fill"></i></a>
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
   <%@ include file="../includes/adminFooter.jsp" %>