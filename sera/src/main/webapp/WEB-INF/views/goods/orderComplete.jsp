<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	
   	
   	<div class="banner banner-member">
   		<h2>ORDER</h2>
   		<p>상품주문</p>
   	</div>
   	 <div class="section-tab-bar">
   	 	<ul>
	  		<li class="now-tab">상품주문</li>
	  	</ul>
   	 </div>
   	<section>
   		<div class="page-title">
   			<span>Order</span><span> Result</span>
   		</div>
   		
   		<h3 class="content-title">주문처리결과</h3>
   		<div class="order-result-view">
   			<c:choose>
   				<c:when test="${orderResultMsg=='order_success'}">
   					<div><i class="bi bi-bag-check-fill"></i></div>
   					<h1>주문이 완료되었습니다.</h1>
		   			<div class="confirm-btn-container">
			   			<c:choose>
			   				<c:when test="${loginMember!=null}"><a href="/member/mypage"  id="btn-join" class="btn btn-main " >마이페이지로</a></c:when>
			   				<c:otherwise><a href="/"  id="btn-join" class="btn btn-main " >홈화면으로</a></c:otherwise>
			   			</c:choose>
			   		</div>
   				</c:when>
   				<c:when test="${orderResultMsg=='goods_out_of_stock'}">
   					<div><i class="bi bi-bag-x-fill"></i></div>
   					<h1>요청 구매 수량보다 재고 수량이 적어 구매가 불가합니다.</h1>
		   			<div class="confirm-btn-container">
			   			<a href="/"  id="btn-join" class="btn btn-main " >홈화면으로</a>
			   		</div>
   				</c:when>
   				<c:when test="${orderResultMsg=='goods_not_found'}">
   					<div><i class="bi bi-bag-x-fill"></i></div>
   					<h1>상품 정보가 존재하지 않아 주문이 불가합니다.</h1>
		   			<div class="confirm-btn-container">
			   			<a href="/"  id="btn-join" class="btn btn-main " >홈화면으로</a>
			   		</div>
   				</c:when>
   				<c:otherwise>
   					<div><i class="bi bi-exclamation-diamond-fill"></i></div>
   					<h1>잘못된 접근입니다.</h1>
		   			<div class="confirm-btn-container">
			   			<a href="/"  id="btn-join" class="btn btn-main">홈화면으로</a>
			   		</div>
   				</c:otherwise>
   			</c:choose>
   		</div>
   		
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>