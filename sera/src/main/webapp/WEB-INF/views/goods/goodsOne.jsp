<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	<script>
	$(function(){
   		var loginMember = '<%=session.getAttribute("loginMember")%>';
   		var orderForm = document.getElementById("order_form");
   		var viewPrice = $(".goods-price>strong");
   		var totalViewPrice = $(".goods-total-price>strong:nth-child(2)");
   		var sellPrice = parseInt(document.getElementsByName("sell_price")[0].value);
   		var goodsId = document.getElementsByName("goods_id")[0].value;
   		var btnOrder = document.getElementById("btn-order");
   		var btnAddCart = document.getElementById("btn-add-cart");
   		var resultStarLine = document.getElementsByClassName("reulst_star_line");
   		
   		
   		
   		//////기본 실행
   		
   		//상품 정보가 조회되지 않는 경우 상품 목록 페이지 호출
   		if(goodsId==""){
   			alert("판매중인 상품이 아닙니다.");
   			location.href="/goods/";
   		}
   		
   		//판매가격의 천의 자리수 마다 ',' 입력
   		viewPrice.text(sellPrice.toLocaleString());
   		totalViewPrice.text(sellPrice.toLocaleString());
   		
   		if(loginMember == "null"){
	   			//alert("로그인 정보가 존재하지 않습니다.");
	   			//location.href="/";
	   		}
   		
   		//상세 이미지의 원본 사이즈 값을 삭제
   		$("img").removeAttr("style");
   		
   		
   		
   		//////이벤트 실행
   		
   		//구매수량 버튼
   		$("#quantity-minus").click(function(){
   			$("input[name='quantity']").val(parseInt($("input[name='quantity']").val())-1);
   			changeNumberValue($("input[name='quantity']"), sellPrice);
   		});
   		$("#quantity-plus").click(function(){
   			$("input[name='quantity']").val(parseInt($("input[name='quantity']").val())+1);
   			changeNumberValue($("input[name='quantity']"), sellPrice);
   		});
   		
   		$("input[name='quantity']").change(function(){
   			changeNumberValue($(this), sellPrice);
   		});
   		
   		//주문 버튼 클릭
   		if(btnOrder!=null){
   			btnOrder.addEventListener("click", function(){
   	   			orderForm.setAttribute("action", "/goods/order");
   					orderForm.submit();
   	   		});
   		}
   		
   		
   		//장바구니 버튼 클릭
   		if(btnAddCart!=null){
   			btnAddCart.addEventListener("click", function(){
   	   			orderForm.setAttribute("action", "/goods/inserCart");
   				orderForm.submit();
   	   		});
   		}
   		
   		
   		//관련 상품 목록 슬라이더
   		$(window).load(function() {
   		  $('.flexslider').flexslider({
   		    animation: "slide",
   		 	slideshow: false,
   		    animationLoop: true,
   		    itemWidth: 260,
   		    itemMargin: 0
   		  });
   		});
   		
   		//상품리뷰 별 클릭
   		$("input[name='score']").click(function(){
   			var click_score = $(this).val();
   			$(".star_line_input>label").html("<i class='bi bi-star'></i>");
   			for(var i=1; i<=click_score; i++){
   			 $(".star_line_input>label:nth-of-type("+i+")").html("<i class='bi bi-star-fill'></i>");
   			}
   		});
   		
   		//리뷰 스코어에 따른 별 아이콘 표시
   		for(var i=0; i<resultStarLine.length; i++){
   			var resultScore = resultStarLine[i].querySelector(".result_score").value;
   			
   			for(var j=0; j< parseInt(resultScore); j++){
   				//<i class="bi bi-star-fill"></i>
   				resultStarLine[i].innerHTML += "<i class='bi bi-star-fill'></i>";
   			}
   			for(var k=0; k< 5-parseInt(resultScore); k++){
   				//<i class="bi bi-star-fill"></i>
   				resultStarLine[i].innerHTML += "<i class='bi bi-star'></i>";
   			}
   			
   		}
   		
	});
		
		function changeNumberValue(numObj, sellPrice){
			var minValue =parseInt(numObj.attr("min"));
   			var maxValue =parseInt(numObj.attr("max"));
   			var resultValue = parseInt(numObj.val());
   			var quantityAlert =  $("#quantity-alert");
   			
   			quantityAlert.css("display","none");
   			
   			if(parseInt(numObj.val()) < minValue){resultValue = minValue;}
   			if(parseInt(numObj.val()) > maxValue){
   				resultValue = maxValue; 
   				quantityAlert.children("span").text(maxValue);
   				quantityAlert.css("display","block");
   			}
   			
   			numObj.val(resultValue);
   			
   			$(".goods-total-price>strong:nth-child(2)").text((sellPrice * resultValue).toLocaleString());
		}
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
	  		<li><a href="/goods/?main_type=${goodsInfo.main_type} ">${goodsInfo.main_type} <i class="bi bi-chevron-right"></i> </a></li>
	  		<li><a href="/goods/?main_type=${goodsInfo.main_type}&sub_type=${goodsInfo.sub_type}">${goodsInfo.sub_type} <i class="bi bi-chevron-right"></i> </a></li>
	  		<li class="now-tab">상품상세 정보</li>
	  	</ul>
   	 </div>
   	<section>
   		
 		<form method="post" id="order_form"name="join_form">
 			<input type="hidden" name="goods_id" value="${goodsInfo.goods_id}">
	 		<div class="goods-wrap">
	 			<div class="goods-image-wrap">
	 				<p class="goods-main-image goods-image-big">
	 					<i class="bi bi-image-alt"></i>
	 					<img src="${goodsInfo.goods_image}" onerror="this.style.display='none'">
	 					<input type="hidden" name="goods_image" value="${goodsInfo.goods_image}">
	 				</p>
	 			</div>
	 			
	 			<div class="goods-info-layout">
		 			<ul >
		 				<li class="goods-title"><p>${goodsInfo.goods_name}</p> <input type="hidden" name="goods_name" value="${goodsInfo.goods_name}"></li>
						<li class="goods-price goods-main-price">
							<strong>${goodsInfo.sell_price}</strong><span>원</span><span>회원 구매시 5% 마일리지 적립</span>
							<input type="hidden" name="sell_price" value="${goodsInfo.sell_price}">
						</li>
						<li class="goods-delivery">
							<p><strong><i class="bi bi-truck"></i> 배송정보</strong></p>
							<span>배송비</span><span>${goodsInfo.shipping_fee}</span><span>원</span><span>평균 3일 이내 배송</span>
							<input type="hidden" name="shipping_fee" value="${goodsInfo.shipping_fee}">
						</li>
						
						<li class="goods-view-cnt">
							<p><strong><i class="bi bi-eye"></i> 상품 조회 정보</strong></p>
							<p>지금까지 <span>${goodsInfo.view_cnt}</span>명의 사람이 이 상품을 보고 가셨어요!</p>
						</li>
						<li class="goods-up-date">
							<p><strong><i class="bi bi-calendar4"></i> 상품 등록일</strong></p>
							<p><fmt:formatDate value="${goodsInfo.goods_up_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
						</li> 
					</ul>
					
					<ul class="goods-order-box">
						<c:choose>
							<c:when test="${goodsInfo.amount>0 && goodsInfo.sale_active=='y'}">
								<li class="goods-quantity">
									<input type="number" name="quantity"  value="1" min="1" max="${goodsInfo.amount}">
									<input type="hidden" name="amount" value="${goodsInfo.amount}">
									<button type="button" class="btn btn-mini-square" id="quantity-minus"><i class="bi bi-dash"></i></button>
									<button type="button" class="btn btn-mini-square" id="quantity-plus"><i class="bi bi-plus"></i></button>
									<span id="quantity-alert"><span></span>개 이하로만 구매하실 수 있습니다.</span>
								</li>
								<li class="goods-total-price">
									<span>TOTAL</span><strong>${goodsInfo.sell_price}</strong><span>원</span>
								</li>
								<li class="goods-buy-btns">
									<button type="button" class="btn btn-main btn-half" id="btn-order">BUY IT NOW</button>
									<button type="button" class="btn btn-navy btn-half" id="btn-add-cart">ADD TO CART</button>
									<input type="hidden" name="category_id" value="${goodsInfo.category_id}">
								</li>
							</c:when>
							<c:otherwise>
								<li class="goods-cant-order-box">
									<p>본 상품은 현재 품절되어 구매하실 수 없습니다.</p>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
	 		</div>
	   		</form>
	   		
	   		<h3 class="content-title">관련상품</h3>
	   		<div class="input-layout-border goods-list-container flexslider carousel">
	   			<ul class="goods-list slides">
		   			<c:forEach items="${relatedGoodsInfo}" var="relatedGoods">
		   				<li>
		   					<a href="/goods/goodsOne?goods_id=${relatedGoods.goods_id}">
		   						<span class="goods-main-image goods-image-small">
		   							<i class="bi bi-image-alt"></i>
		   							<img src="${relatedGoods.goods_image}" onerror="this.style.display='none'">
		   						</span>
		   						<span>${relatedGoods.goods_name} </span>
		   					</a>
		   				</li>
		   			</c:forEach>
		   		</ul>
	   		</div>
	   		
	   		<h3 class="content-title">상세정보</h3>
	   		<div class="textarea-layout input-layout-border input-layout-wide testarea-layout">
	   			<p>${goodsInfo.goods_content}</p>
	   		</div>
	   		<h3 class="content-title" id="goods-reply">리뷰</h3>
	   		
	   		<div class="reply-info">
	   		
	   			<div class="reply-total">
	   				<div class="star_line_total reulst_star_line">
	   					<input type="hidden" class="result_score" value="${scoreAvg}">
   					</div>
   					<div>${scoreAvg}</div>
   					<div>${reply_items.size()}개의 리뷰</div>
	   			</div>
	   		
		   			<form action="/goods/reply" method="post">
		   				<div class="reply-input">
			   				<c:choose>
			   					<c:when test="${orderinfo.order_number!=null && replyWriteChk}">
					   				<div class=" star_line_input">
					   					<input type="radio"  id="star_1"name="score" value="1">
				   						<label for="star_1"><i class="bi bi-star-fill"></i></label>
				   						<input type="radio"  id="star_2" name="score" value="2">
				   						<label for="star_2"><i class="bi bi-star-fill"></i></label>
				   						<input type="radio"  id="star_3" name="score" value="3">
				   						<label for="star_3"><i class="bi bi-star-fill"></i></label>
				   						<input type="radio"  id="star_4" name="score" value="4">
				   						<label for="star_4"><i class="bi bi-star-fill"></i></label>
				   						<input type="radio"  id="star_5" name="score" value="5" checked>
				   						<label for="star_5"><i class="bi bi-star-fill"></i></label>
				   					</div>
				   					<div>
				   						<div>
					   						<textarea  name="reply_content" maxlength="70" class="input-default input-full-border" placeholder="상품평을 작성해주세요." required></textarea>
					   					</div>
					   					<div>
					   						<button type="submit" class="btn btn-main">등록</button>
					   						<input type="hidden" name="user_id" value="${loginMember.user_id }">
					   						<input type="hidden" name="order_number" value="${orderinfo.order_number }">
					   						<input type="hidden" name="goods_id" value="${orderinfo.goods_id }">
					   						<input type="hidden" name="goods_name" value="${orderinfo.goods_name }">
					   						<input type="hidden" name="nick_name" value="${loginMember.nick_name }">
					   					</div>
				   					</div>
			   					</c:when>
			   					<c:otherwise>
			   						<p class="search-null-result">상품을 주문하신 회원만 리뷰 작성이 가능합니다. <br> 리뷰는 한번만 작성가능합니다.</p>
			   					</c:otherwise>
		   					</c:choose>
			   			</div>
		   			</form>
	   			
	   			<ul>
		   			<c:forEach items="${reply_items}" var="reply_items">
		   				<li>
		   					<div>
			   					<div class="reulst_star_line">
			   						<input type="hidden" class="result_score" value="${reply_items.score}">
			   					</div>
			   					<div><fmt:formatDate value="${reply_items.up_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></div>
		   					</div>
		   					<div>${reply_items.nick_name}님</div>
							<div>${reply_items.reply_content}</div>
		   				</li>
		   			</c:forEach>
	   			</ul>
	   		</div>
   		
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>