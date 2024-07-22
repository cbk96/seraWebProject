<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	<script>
		$(function(){
	   		var loginMember = '<%=session.getAttribute("loginMember")%>';
	   		var cartOnePrice = $(".cart-one-price>span>span:nth-child(1)").text();
	   		var cartItems = document.querySelectorAll(".cart-one-price>span>span:nth-child(1)");
	   		var quantitys = document.querySelectorAll("input[name='quantity']");
	   		var user_id = $("input[name='user_id']").val();
	   		
	   		//가격 값들을 1000 단위 "," 표시 
	   		for(var i=0; i<cartItems.length;  i++){
	   			cartItems[i].innerText = (parseInt(cartItems[i].innerText) * parseInt(quantitys[i].value)).toLocaleString();
	   		}
	   		
	 		 //////이벤트 실행
	   		
	   		//구매수량 변경
	   		$(".quantity-minus").click(function(){
	   			var quantChangeId= $(this).attr("name").replace("-minus","");
	   			var sellPrice = $("."+quantChangeId+"-price").val();
	   			var resultPrice = $("."+quantChangeId+"-result-price");
	   			var changeQuantity = parseInt($("."+quantChangeId+"-quantity").val())-1;
	   			
	   			$("."+quantChangeId+"-quantity").val(changeQuantity);
	   			
	   			changeNumberValue($("."+quantChangeId+"-quantity"), sellPrice, resultPrice, quantChangeId, user_id);
	   		});
	   		$(".quantity-plus").click(function(){
	   			var quantChangeId = $(this).attr("name").replace("-plus","");
	   			var sellPrice = $("."+quantChangeId+"-price").val();
	   			var resultPrice = $("."+quantChangeId+"-result-price");
	   			var changeQuantity = parseInt($("."+quantChangeId+"-quantity").val())+1
	   			
	   			$("."+quantChangeId+"-quantity").val(changeQuantity);
	   			
	   			changeNumberValue($("."+quantChangeId+"-quantity"), sellPrice, resultPrice, quantChangeId, user_id);
	   		});
	   		
	   		$("input[name='quantity']").change(function(){
	   			var quantChangeId = $(this).attr("class").replace("-quantity","");
	   			var sellPrice = $("."+quantChangeId+"-price").val();
	   			var resultPrice = $("."+quantChangeId+"-result-price");
	   			var changeQuantity = parseInt($(this).val());
	   			
	   			changeNumberValue($(this), sellPrice, resultPrice, quantChangeId, user_id);
	   		});
	   		
		});
		
		//구매수량 변경에 따른 상품가 표시 변경
		function changeNumberValue(numObj, sellPrice, resultPrice, goods_id, user_id){
			var minValue =parseInt(numObj.attr("min"));
   			var maxValue =parseInt(numObj.attr("max"));
   			var resultValue = parseInt(numObj.val());
   			
   			if(parseInt(numObj.val()) < minValue){resultValue = minValue;}
   			if(parseInt(numObj.val()) > maxValue){resultValue = maxValue;}
   			
   			var quantChangeValue = {goods_id : goods_id, quantity : resultValue, user_id : user_id};
   			
   			numObj.val(resultValue);
   			
   			resultPrice.children("span").children("span:nth-child(1)").text((sellPrice * resultValue).toLocaleString());
   			
   			//구매수량 변경 사항 데이터베이스에 반영
			$.ajax({
				url:"/goods/cartOneUpdate",
				type:"post",
				data:quantChangeValue,
				success:function(result){}
			});
		}
		
		
		//장바구니 상품 삭제
		function cartItemDelete(deleteItem, user_id){
			var vitualForm = document.createElement('form');
			var itemIdInput = document.createElement("input");
			var userIdnput = document.createElement("input");
			
			itemIdInput.setAttribute("type","hidden");
			itemIdInput.setAttribute("name","deleteItem");
			itemIdInput.setAttribute("value",deleteItem);
			
			userIdnput.setAttribute("type","hidden");
			userIdnput.setAttribute("name","user_id");
			userIdnput.setAttribute("value",user_id);
			
			vitualForm.action="/goods/cartDelete";
			vitualForm.method="post";
			vitualForm.appendChild(itemIdInput);
			vitualForm.appendChild(userIdnput);
			
			document.body.appendChild(vitualForm);
			
			vitualForm.submit();
		}
	</script>
	<div id="resultMsg" style="display:none;">
		<input type="hidden" name="modifyMsg" value="${modifyMsg}">
	</div>
   	
   	<div class="banner banner-member">
   		<h2>MYPAGE</h2>
   		<p>마이페이지</p>
   	</div>
   	 <div class="section-tab-bar">
   	 	<ul>
	  		<li class="now-tab">장바구니</li>
	  	</ul>
   	 </div>
   	<section>
   		<div class="page-title">
   			<span>View</span><span> Cart</span>
   		</div>
   		
   		<h3 class="content-title">장바구니 </h3>
   		<form method="post">
   		<div class=" goods-list-cart">
	   			<c:choose>
	   				<c:when test="${cartInfo.size()!=0 && cartInfo!=null}">
		   				<ul class=" user-info">
		   					<c:forEach items="${cartInfo}" var="cartInfo">
			   					<li>
				   					<a href="/goods/goodsOne?goods_id=${cartInfo.goods_id}">
				   						<span class="goods-main-image goods-image-small">
				   							<i class="bi bi-image-alt"></i>
				   							<img src="${cartInfo.goods_image}" onerror="this.style.display='none'">
				   						</span>
				   						<span>${cartInfo.goods_name} </span>
				   						</a>
				   						<span class="goods-quantity-tiny">
											<input type="number" name="quantity"  class="${cartInfo.goods_id}-quantity" value="${cartInfo.quantity}" min="1" max="${cartInfo.amount}">
											<button type="button" name="${cartInfo.goods_id}-minus" class="btn-tiny-square quantity-minus" ><i class="bi bi-dash"></i></button>
											<button type="button"name="${cartInfo.goods_id}-plus"  class="btn-tiny-square quantity-plus" ><i class="bi bi-plus"></i></button>
										</span>
				   						<span class="cart-one-price ${cartInfo.goods_id}-result-price">
				   							<button type="button" class="btn-tiny " onclick="cartItemDelete('${cartInfo.goods_id}', '${cartInfo.user_id}')">삭제</button>
											<span>
												<span>${cartInfo.sell_price}</span><span>원</span>
												<input type="hidden" class="${cartInfo.goods_id}-price" name="sell_price" value="${cartInfo.sell_price}">
											</span>
										</span>
				   				</li>
			   				</c:forEach>
		   				</ul>
		   				<div class="confirm-btn-container ">
				   			<a href="/goods/orderFromCart"  id="btn-all-buy" class="btn btn-main " >전체구매</a>
				   			<input type="hidden" name="user_id" value="${cartInfo[0].user_id}">
				   		</div>
	   				</c:when>
	   				<c:otherwise>
	   					<p>장바구니가 비어 있습니다.</p>
	   				</c:otherwise>
	   			</c:choose>
   		</div>
   		</form>
   		
   		
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>