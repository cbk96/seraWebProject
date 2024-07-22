<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="includes/header.jsp"%>
   
   <script>
  	$(function(){
  		var sellPrice = document.querySelectorAll(".goods-price>span:nth-child(1)");
  	   		
  		$('.flexslider_main').flexslider({
            animation: "slide",
            animationLoop : "true",
            touch : "true"
        });
  			
  		//관련 상품 목록 슬라이더
	   	$(window).load(function() {
	   		$('.flexslider_sub').flexslider({
	   			animation: "slide",
	   			slideshow: false,
	  			animationLoop: true,
	   			itemWidth: 300,
	   			itemMargin: 50
	   		});
	   	});
   		
   		//판매가격의 천의 자리수 마다 ',' 입력
   		for(var i=0; i<sellPrice.length; i++){
   			sellPrice[i].innerText = parseInt(sellPrice[i].innerText).toLocaleString();
   		}
   		
   		//피부별 추천 상품 탭바 클릭
   		$(".tab-bar>li").click(function(){
   			var tabMoveValue = parseInt($(this).children("p").attr("class"));
   			var itemContainer = $(".index-item-list-container>ul");
   			var nowSelectedTab = $(".now-selected");
   			var listSize = parseInt($(".index-item-list").css("width"));
   			
   			nowSelectedTab.removeClass("now-selected");
   			$(this).addClass("now-selected");
   			
   			itemContainer.css("left", tabMoveValue*listSize+"px");
   		});
   		
   		});
   </script>
    
    <div class="flexslider flexslider_main">
		<ul class="slides">
			<li>
			   	<div class="banner banner-index banner-index-1">
			   		<div>
			   			<h2>FLOW<br>LIFTING WRAPPING CREAM</h2>
				   		<span>여느 것과는 아주 다른<br>유달리 특별한 리프팅을 경험해보세요.</span>
				   		<a href="/goods/goodsOne?goods_id=koy1">shop now</a>
			   		</div>
			   	</div>
			</li>
			<li>
			   	<div class="banner banner-index banner-index-4">
			   		<div>
			   			<h2>BLOOM GLOW<br>ESSENCE SUN CREAM</h2>
				   		<span>다이어 파우더 레시피로 완성된<br>  원래 내 것 같은 광채를 확인해보세요..</span>
				   		<a href="/goods/goodsOne?goods_id=koy2">shop now</a>
			   		</div>
			   	</div>
			</li>
			<li>
			   	<div class="banner banner-index banner-index-2">
			   		<div>
			   			<h2>SOLID VOLUME AMPOULE</h2>
				   		<span>한 병에 담긴 밀도있는 탄력<br> 속부터 차오르는 매끄러운 우아함.</span>
				   		<a href="/goods/goodsOne?goods_id=koy3">shop now</a>
			   		</div>
			   	</div>
			</li>
		</ul>
   	</div>
   	
   	<section class="full-section">
   	
   		<div class="index-container index-item-slide-container">
   			<h2>BEST SELLERS</h2>
	  		<div class="goods-list-container goods-list-padding flexslider flexslider_sub">
	   			<ul class="slides">
		   			<c:forEach items="${relatedGoodsInfo}" var="relatedGoods">
		   				<li>
		   					<a href="/goods/goodsOne?goods_id=${relatedGoods.goods_id}">
		   						<span class="goods-main-image goods-image-mini">
		   							<i class="bi bi-image-alt"></i>
		   							<img src="${relatedGoods.goods_image}" onerror="this.style.display='none'">
		   						</span>
		   					</a>
		   					<p class="goods-name">${relatedGoods.goods_name}</p>
		   					<p class="goods-price"><span>${relatedGoods.sell_price}</span><span>원</span><span>(5% 적립)</span></p>
		   				</li>
		   			</c:forEach>
		   		</ul>
	   		</div>
   		</div>
   		
   		<div class="half-banner">
   			<p><a href="/goods/goodsOne?goods_id=koy3"><img src="/resources/images/half_banner_01.jpg"></a></p>
   			<p><a href="/goods/goodsOne?goods_id=koy1"><img src="/resources/images/half_banner_02.jpg"></a></p>
   		</div>
   		
   		<div class="index-container">
	   		<h2>피부 타입별 추천상품</h2>
	   		<ul class="tab-bar">
   				<li class="now-selected"><p class="0" style="display:none;"></p>지성 피부</li>
   				<li><p class="-1" style="display:none;"></p>건성 피부</li>
   				<li><p class="-2" style="display:none;"></p>복합성 피부</li>
   			</ul>
	   		<div class="index-item-list-container">
	   			<ul>
	   				<li>
	   					<ul class="index-item-list">
				   			<c:forEach items="${oily_skin_goods}" var="goods">
				   				<li>
				   					<p>
				   						<a href="/goods/goodsOne?goods_id=${goods.goods_id}" class="goods-main-image goods-image-middle">
				   							<i class="bi bi-image-alt"></i>
				   							<img src="${goods.goods_image}" alt="상품 이미지" onerror="this.style.display='none'">
				   						</a>
				   					</p>
				   					<p><a href="/goods/goodsOne?goods_id=${goods.goods_id}" class="goods-name">${goods.goods_name}</a></p>
				   					<p class="goods-price"><span>${goods.sell_price}</span><span>원</span><span>(5% 적립)</span></p>
				   				</li>
				   			</c:forEach>
				   		</ul>
	   				</li>
	   				
	   				<li>
	   					<ul class="index-item-list">
				   			<c:forEach items="${dry_skin_goods}" var="goods">
				   				<li>
				   					<p>
				   						<a href="/goods/goodsOne?goods_id=${goods.goods_id}" class="goods-main-image goods-image-middle">
				   							<i class="bi bi-image-alt"></i>
				   							<img src="${goods.goods_image}" alt="상품 이미지" onerror="this.style.display='none'">
				   						</a>
				   					</p>
				   					<p><a href="/goods/goodsOne?goods_id=${goods.goods_id}" class="goods-name">${goods.goods_name}</a></p>
				   					<p class="goods-price"><span>${goods.sell_price}</span><span>원</span><span>(5% 적립)</span></p>
				   				</li>
				   			</c:forEach>
				   		</ul>
	   				</li>
	   				
	   				<li>
	   					<ul class="index-item-list">
				   			<c:forEach items="${combination_skin_goods}" var="goods">
				   				<li>
				   					<p>
				   						<a href="/goods/goodsOne?goods_id=${goods.goods_id}" class="goods-main-image goods-image-middle">
				   							<i class="bi bi-image-alt"></i>
				   							<img src="${goods.goods_image}" alt="상품 이미지" onerror="this.style.display='none'">
				   						</a>
				   					</p>
				   					<p><a href="/goods/goodsOne?goods_id=${goods.goods_id}" class="goods-name">${goods.goods_name}</a></p>
				   					<p class="goods-price"><span>${goods.sell_price}</span><span>원</span><span>(5% 적립)</span></p>
				   				</li>
				   			</c:forEach>
				   		</ul>
	   				</li>
	   			</ul>
	   		</div>
   		</div>
   		
   	</section>
   
   <%@ include file="includes/footer.jsp" %>