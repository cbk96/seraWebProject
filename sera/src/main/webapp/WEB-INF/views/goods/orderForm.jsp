<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	<script>
		$(function(){
	   		var loginMember = '<%=session.getAttribute("loginMember")%>';
	   		var orderOneItem = document.querySelectorAll(".goods-list-order>ul>li>span>span:nth-child(1)");
	   		var user_id = $("input[name='user_id']").val();
	   		var viewPrice = document.querySelectorAll(".view-price");
	   		
	   		//가격 값들을 1000 단위 "," 표시 
	   		for(var i=0; i<orderOneItem.length;  i++){
	   			orderOneItem[i].innerText = parseInt(orderOneItem[i].innerText).toLocaleString();
	   		}
	  		for(var i=0; i<viewPrice.length; i++){
	  			viewPrice[i].innerText = parseInt(viewPrice[i].innerText).toLocaleString();
	  		}
	   		
	 	  	//총 결제금액 표시
		   	var resultPrices = $(".resultPrice");
		   	var sumPrices = 0;
		   	var sumPricesBackUp = 0;
		   	var resultAllPrice = $("#resultAllPrice>span:nth-child(2)");
		   	var mileValue = $("input[name='discount_price']");
		   	var maxMileage = parseInt($("input[name='maxMileage']").val());
		   
		   	for(var i=0; i<resultPrices.length; i++){
		   		sumPrices += parseInt(resultPrices.eq(i).val());
		   		sumPricesBackUp = sumPrices;
		   		resultAllPrice.text(sumPrices.toLocaleString()+"원");
		   	}
		   	
		   	//총 결제 금액이 마일리지 총액보다 크면 마일리지 최대 사용 가능 금액 한도를 총 결제 금액으로 변경
		   	if(maxMileage > sumPrices){
		   		mileValue.attr("max",sumPrices);
		   	}
		   	
		   	
	   		//결제수단 입력란 표시/비표시
	   		$(".payment").change(function(){
	   			var payment_info = $(this).attr("id")+"_info";
	   			
	   			$(".payment-info").css("display","none");
	   			$("."+payment_info).css("display","block");
	   		});
	   		
		   	//마일리지 입력폼에 최소값 이하의 값 입력 방지
	   		mileValue.change(function(){
	   			
	   			if(parseInt($(this).val())<parseInt($(this).attr("min"))){
	   				$(this).val($(this).attr("min"));
	   			}
	   			if(parseInt($(this).val())>parseInt($(this).attr("max"))){
	   				$(this).val($(this).attr("max"));
	   			}
	   			
	   			//마일리지 사용액 만큼 총 결제금액 차감
	   			sumPrices = sumPricesBackUp - parseInt(mileValue.val());
	   			resultAllPrice.text(sumPrices.toLocaleString()+"원");
	   		});
		   	
		   	
	   		
		});
		
		function post_codeSearch(){
	   		window.open("/member/postChk", "post_code_check", "width=350px, height=420px, scrollbars=yes");
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
	  		<li class="now-tab">주문서 작성</li>
	  	</ul>
   	 </div>
   	<section>
   		<div class="page-title">
   			<span>Purchase </span><span> Order</span>
   		</div>
   		
   		<h3 class="content-title">주문서 작성</h3>
   		<form action="/goods/orderConfirm" method="post" name="member_form">
   		<div>
   			<ul class=" goods-list-order">
	   			<c:choose>
	   				<c:when test="${orderInfo.size()!=0 && orderInfo!=null}">
		   					<c:forEach items="${orderInfo}" var="orderInfo">
			   					<li>
				   					<a href="/goods/goodsOne?goods_id=${orderInfo.goods_id}">
				   						<span>
					   						<span class="goods-main-image goods-image-tiny">
					   							<i class="bi bi-image-alt"></i>
					   							<img src="${orderInfo.goods_image}" onerror="this.style.display='none'">
					   							<input type="hidden" name="goods_image" value="${orderInfo.goods_image}">
					   						</span>
				   						</span>
				   						<span>${orderInfo.goods_name} </span>
				   					</a>
			   						<span>
			   							<span>${orderInfo.quantity}개</span>
										<span class="view-price">${orderInfo.sell_price * orderInfo.quantity}</span><span>원</span>
										<input type="hidden" class="${orderInfo.goods_id}-price" name="sell_price" value="${orderInfo.sell_price}">
										<input type="hidden"  name="goods_id" value="${orderInfo.goods_id}">
										<input type="hidden"  name="goods_name" value="${orderInfo.goods_name}">
										<input type="hidden"  name="category_id" value="${orderInfo.category_id}">
										<input type="hidden"  name="quantity" value="${orderInfo.quantity}">
										<input type="hidden"  class="resultPrice" value="${orderInfo.sell_price * orderInfo.quantity}">
									</span>
				   				</li>
			   				</c:forEach>
	   				</c:when>
	   				<c:otherwise>
	   					<li class="search-null-result">상품 정보가 없습니다.</li>
	   				</c:otherwise>
	   			</c:choose>
	   		</ul>
	   		
	 		<ul class="input-layout input-layout-wide input-layout-order-info" >
	 			<li>
	 				<h3>배송정보</h3>
	 			</li>
				<li>
					<label><span>*</span>수령자명</label>
					<input type="text"  name="name"  value="${loginMember.name}" required class="input-default input-bottom-border">
				</li>
				<li>
					<label><span>*</span>연락처</label>
					<input type="text"  name="tel"  value="${loginMember.tel}" required class="input-default input-bottom-border">
				</li>
				<li class="input-btn-container input-address">
					<label><span>*</span>주소</label>
					<input type="text"  name="post_code"  value="${loginMember.post_code}" required readonly class="input-default input-bottom-border">
					<button type="button" onclick="post_codeSearch()"  class="btn btn-navy">우편번호 찾기</button>
				</li>
				<li>
					<label></label>
					<input type="text"  name="address" placeholder="상세 주소"  value="${loginMember.address}" required class="input-default input-bottom-border">
				</li>
			</ul>
			
			
	 		<ul class="input-layout input-layout-wide input-layout-order-info" >
	 			<li><h3>결제정보</h3></li>
	 			<li>
	 				<label><span></span>마일리지</label>
	 				<c:choose>
	 					<c:when test="${loginMember!=null}">
	 						<input type="number" name="discount_price" min="0" max="${loginMember.mileage}"placeholder="최대  ${loginMember.mileage}원 할인 가능" class="input-default input-bottom-border">
	 					</c:when>
	 					<c:otherwise>
	 						<p><i class="bi bi-exclamation-circle"></i> 마일리지 적립/할인은 회원만 가능합니다.</p>
	 					</c:otherwise>
	 				</c:choose>
	 				<input type="hidden" name="maxMileage" value="${loginMember.mileage}" >
	 			</li>
				<li class="radio-container radio-container-3child">
					<label><span></span>결제수단</label>
					<div>
						<input type="radio"  id="credit_cart" name="payment" value="credit_cart"  checked class="payment input-default input-bottom-border">
						<label for="credit_cart">신용카드</label>
						<input type="radio"  id="account_transfer" name="payment" value="account_transfer"  class="payment input-default input-bottom-border">
						<label for="account_transfer">계좌이체</label>
						<input type="radio"  id="bank_transfer" name="payment" value="bank_transfer" class="payment input-default input-bottom-border">
						<label for="bank_transfer">무통장입금</label>
					</div>
				</li>
				<li>
					<div class="payment-info credit_cart_info">
						<!-- 신용카드 결제 -->
						<div>
							<label><span></span>신용카드</label>
							<select name="credit_cart_pay_value" class="input-full-border" >
			   					<option value="">--신용카드 선택--</option>
			   					<option value="현대카드">현대카드</option>
			   					<option value="국민카드">국민카드</option>
			   					<option value="신한카드">신한카드</option>
			   					<option value="삼성카드">삼성카드</option>
			   					<option value="롯데카드">롯데카드</option>
			   					<option value="우리BC카드">우리BC카드</option>
			   					<option value="우리카드">우리카드</option>
			   					<option value="하나카드">하나카드</option>
			   					<option value="비씨카드">비씨카드</option>
			   					<option value="농협카드">농협카드</option>
			   					<option value="씨티카드">씨티카드</option>
			   					<option value="카카오뱅크카드">카카오뱅크카드</option>
				   			</select>
						</div>
						<div>
							<label><span></span>할부</label>
							<select name="credit_cart_pay_value"  class="input-full-border" >
			   					<option value="">--할부 선택--</option>
			   					<option value="">일시불</option>
			   					<option value="2month">2개월 무이자 할부</option>
			   					<option value="3month">3개월 무이자 할부</option>
			   					<option value="4month">4개월</option>
			   					<option value="5month">5개월</option>
			   					<option value="6month">6개월</option>
			   					<option value="7month">7개월</option>
			   					<option value="8month">8개월</option>
			   					<option value="9month">9개월</option>
			   					<option value="10month">10개월</option>
			   					<option value="11month">11개월</option>
			   					<option value="12month">12개월</option>
			   					<option value="18month">18개월</option>
			   					<option value="24month">24개월</option>
			   					<option value="30month">30개월</option>
			   					<option value="36month">36개월</option>
				   			</select>
						</div>
		   			</div>
					<div class="payment-info account_transfer_info">
						<!-- 실시간 계좌 결제 -->
						<div>
							<label><span></span>출금 계좌</label>
							<select name="account_transfer_pay_value" class="input-full-border" >
			   					<option value="">--은행 선택--</option>
			   					<option value="우리">우리</option>
			   					<option value="신한">신한</option>
			   					<option value="하나">하나</option>
			   					<option value="국민">국민</option>
			   					<option value="기업">기업</option>
			   					<option value="농협">농협</option>
			   					<option value="외환">외환</option>
				   			</select>
						</div>
						<div class="back-pay-value-input search-multi-row">
							<label class="visible-label"><span></span></label>
							<input type="text" name="account_transfer_pay_value" placeholder="예금주" maxlength="20" class="input-default input-full-border">
				   			<input type="text" name="account_transfer_pay_value" placeholder="계좌번호" maxlength="50" class="input-default input-full-border">
						</div>
					</div>
					<div class="payment-info bank_transfer_info">
						<!-- 무통장입금 -->
						<div>
							<label><span></span>입금하실 계좌</label>
							<select name="back_pay_value" class="input-full-border" >
			   					<option value="">--은행 선택--</option>
			   					<option value="우리 1234-567-891111">우리 1234-567-891111</option>
			   					<option value="신한 123-456-789111">신한 123-456-789111</option>
			   					<option value="하나 123-456789-111111">하나 123-456789-111111</option>
			   					<option value="국민 123-45-6789-111">국민 123-45-6789-111</option>
			   					<option value="기업 123-456789-11-111">기업 123-456789-11-111</option>
			   					<option value="농협 123-4567-8910-11">농협 123-4567-8910-11</option>
			   					<option value="외환 123-456789-101">외환 123-456789-101</option>
				   			</select>
						</div>
						<div>
							<label><span></span>환불받을계좌</label>
							<select name="back_pay_value" class="input-full-border" >
			   					<option value="">--은행 선택--</option>
			   					<option value="우리">우리은행</option>
			   					<option value="신한">신한은행</option>
			   					<option value="하나">하나은행</option>
			   					<option value="국민">국민은행</option>
			   					<option value="기업">기업은행</option>
			   					<option value="농협">농협은행</option>
			   					<option value="외환">외환은행</option>
				   			</select>
						</div>
						<div class="back-pay-value-input search-multi-row">
							<label class="visible-label"><span></span></label>
							<input type="text" name="back_pay_value" placeholder="예금주" maxlength="20" class="input-default input-full-border">
				   			<input type="text" name="back_pay_value" placeholder="계좌번호" maxlength="50"class="input-default input-full-border">
						</div>
					</div>
				</li>
			</ul>
			
			<ul class="input-layout input-layout-wide input-layout-order-info" >
				<li>
					<div id="resultAllPrice">
						<span>총 결제금액</span>
						<span></span>
					</div>
				</li>
			</ul>
			
			<div class="confirm-btn-container ">
				<input type="hidden" name="user_id" value="${orderInfo[0].user_id}">
	   			<input type="hidden" name="oderFrom" value="${oderFrom}">
	   			<c:if test="${orderInfo!=null}"><button type="submit"  id="btn-all-buy" class="btn btn-main " >결제</button></c:if>
	   		</div>
			
   		</div>
   		</form>
   		
   		
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>
