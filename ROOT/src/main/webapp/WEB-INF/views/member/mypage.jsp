<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/header.jsp"%>
	<script>
		$(function(){
	   		var loginMember = '<%=session.getAttribute("loginMember")%>';
	   			
	   		if(loginMember == "null"){
   	   			alert("로그인 정보가 존재하지 않습니다.");
   	   			location.href="/";
   	   		}
	   		
	   		//묶음 주문 내역 더보기 클릭
	   		$(".order-more-view").click(function(){
	   			var moreViewOrder = "order-element-"+$(this).attr("id").replace("order-more-view-","");
	   			
	   			if($(this).attr("class").indexOf("more-hide")!=-1){
	   				$(this).addClass("more-visible");
		   			$(this).removeClass("more-hide");
		   			$("."+moreViewOrder+":not(:first-child)").css("display","none");
		   			$(this).children("span").children("i").attr("class","bi bi-chevron-down");
	   			}else if($(this).attr("class").indexOf("more-visible")!=-1){
	   				$(this).addClass("more-hide");
		   			$(this).removeClass("more-visible");
		   			$("."+moreViewOrder).css("display","block");
		   			$(this).children("span").children("i").attr("class","bi bi-chevron-up");
	   			}
	   		});
	   		
	   		//구매확정
	   		//btn-order-purchase-confirm
	   		$(".btn-order-purchase-confirm").click(function(){
	   			var confirmOrderNumber = $(this).children("input[name='order_number_hidden']").val();
	   			var goods_id = $(this).children("input[name='goods_id_hidden']").val();
	   			var sell_price = $(this).children("input[name='sell_pric_hidden']").val();
	   			var order_value = {order_number : confirmOrderNumber, goods_id : goods_id, sell_price : sell_price};
	   			
	   			if(confirm("구매확정 하시겠습니까?\n구매확정 후 반품은 불가합니다.")){
	   				
	   				$.ajax({
	   	   				url : "/goods/purchaseConfirm",
	   	   				data : order_value,
	   	   				type : "POST",
	   	   				success:function(result){
	   	   					if(result=="success"){
	   	   						alert("구매확정이 처리되었습니다..");
	   	   						location.reload();
	   	   					}else{
	   	   						alert("구매확정 처리중 오류가 발생되었습니다.");
	   	   						location.reload();
	   	   					}
	   	   				}
	   	   			});
	   				
	   			}
	   		});
	   		
	   		
	   		//주문취소 요청
	   		$(".btn-order-cancel").click(function(){
	   			var cancelOrderNumber = $(this).children("input[name='order_number_hidden']").val();
	   			var goods_id = $(this).children("input[name='goods_id_hidden']").val();
	   			var order_value = {order_number : cancelOrderNumber, goods_id : goods_id, requestType : "cancel"};
	   			
	   			if(confirm("주문 취소를 요청하시겠습니까?")){
	   				
	   				$.ajax({
	   	   				url : "/goods/requestOrder",
	   	   				data : order_value,
	   	   				type : "POST",
	   	   				success:function(result){
	   	   					if(result=="success"){
	   	   						alert("주문 취소 요청이 접수 되었습니다.\n관리자 확인후 취소 처리가 완료됩니다.");
	   	   						location.reload();
	   	   					}else{
	   	   						alert("주문 취소 요청중 오류가 발생되었습니다.");
	   	   						location.reload();
	   	   					}
	   	   				}
	   	   			});
	   				
	   			}
	   		});
	   		
	   		//반품요청
	   		$(".btn-order-return").click(function(){
	   			var returnOrderNumber = $(this).children("input[name='order_number_hidden']").val();
	   			var goods_id = $(this).children("input[name='goods_id_hidden']").val();
	   			var order_value = {order_number : returnOrderNumber, goods_id : goods_id, requestType : "return"};
	   			
	   			if(confirm("반품을 요청하시겠습니까?")){
	   				
	   				$.ajax({
	   	   				url : "/goods/requestOrder",
	   	   				data : order_value,
	   	   				type : "POST",
	   	   				success:function(result){
	   	   					if(result=="success"){
	   	   						alert("반품 요청이 접수 되었습니다.\n관리자 확인후 취소 처리가 완료됩니다.");
	   	   						location.reload();
	   	   					}else{
	   	   						alert("반품 요청중 오류가 발생되었습니다.");
	   	   					}
	   	   				}
	   	   			});
	   				
	   			}
	   		});
	   		
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
	
	<div id="resultMsg" style="display:none;">
		<input type="hidden" name="modifyMsg" value="${modifyMsg}">
	</div>
   	
   	<div class="banner banner-member">
   		<h2>MYPAGE</h2>
   		<p>마이페이지</p>
   	</div>
   	 <div class="section-tab-bar select-tab-bar">
   	 	<ul>
	  		<li class="now-tab">마이페이지</li>
	  		<li><a href="/member/memberModify">회원정보 수정</a></li>
	  	</ul>
   	 </div>
   	<section>
   		<div class="page-title">
   			<span>My</span><span> Page</span>
   		</div>
   		
   		<h3 class="content-title">회원정보</h3>
   		<div class="user-info user-info-basic">
   			<div>
   				<p>${loginMember.nick_name}님의</p>
   				<h3>회원등급은 <span>${loginMember.grade}</span> 입니다.</h3>
   				<p></p>
   			</div>
   			<ul>
   				<li>
   					<p><i class="bi bi-piggy-bank"></i></p>
   					<p>마일리지</p>
   					<p><strong>${loginMember.mileage}</strong>점</p>
   				</li>
   				<li>
   					<p><i class="bi bi-droplet"></i></p>
   					<p>피부타입</p>
   					<p>
   						<strong>
	   						<c:choose>
		  							<c:when test="${loginMember.skin_type=='oily_skin'}">지성</c:when>
		  							<c:when test="${loginMember.skin_type=='dry_skin'}">건성</c:when>
		  							<c:when test="${loginMember.skin_type=='combination_skin'}">복합성</c:when>
			  					</c:choose>
   						</strong>
   					</p>
   				</li>
   			</ul>
   		</div>
   		
   		<h3 class="content-title">진행 중인 주문</h3>
   		<div class="user-info user-info-orders-step">
   			<ul>
   				<li>
	   				<p>결제대기</p>
	   				<p>${orderStauts.waiting_pay}</p>
	   			</li>
	   			<li><i class="bi bi-caret-right-fill"></i></li>
	   			<li>
	   				<p>결제완료</p>
	   				<p>${orderStauts.complete_pay}</p>
	   			</li>
	   			<li><i class="bi bi-caret-right-fill"></i></li>
	   			<li>
	   				<p>배송준비중</p>
	   				<p>${orderStauts.prepa_delivery}</p>
	   			</li>
	   			<li><i class="bi bi-caret-right-fill"></i></li>
	   			<li>
	   				<p>배송중</p>
	   				<p>${orderStauts.shipping}</p>
	   			</li>
	   			<li><i class="bi bi-caret-right-fill"></i></li>
	   			<li>
	   				<p>배송완료</p>
	   				<p>${orderStauts.complete_delivery}</p>
	   			</li>
	   			<li><i class="bi bi-caret-right-fill"></i></li>
	   			<li>
	   				<p>구매확정</p>
	   				<p>${orderStauts.complete_order}</p>
	   			</li>
   			</ul>
   			<div>
   				<p><strong>취소</strong>${orderStauts.cancel_order}건</p>
   				<p><strong>반품</strong>${orderStauts.return_order}건</p>
   			</div>
   		</div>
   		
   		<h3 class="content-title">주문내역</h3>
   		<form action="/member/mypage/" method="get" id="list-search-form">
	   		<ul class="mypage-order-search">
	   			<li>
	   				<label>분류</label>
	   				<div>
	   					<select name="search-key-type" class="input-full-border order-search-type">
	   						<option value="order_number" <c:if test="${searchKey.searchKeyType == 'order_number'}">selected</c:if>>주문번호</option>
							<option value="goods_name" <c:if test="${searchKey.searchKeyType == 'goods_name'}">selected</c:if>>상품명</option>
						</select>
						<input type="text"  name="search-key-value" class="input-full-border" value="${searchKey.searchKeyValue}">
					</div>
	   			</li>
	   			
	   			<li>
	   				<label>주문일</label>
	   				<div class="date-range order-date-range">
	   					<input type="date"  name="day-begin" class="input-full-border" value="${searchKey.dayBegin}">
	   					<span>~</span>
	   					<input type="date"  name="day-end" class="input-full-border" value="${searchKey.dayEnd}">
	   				</div>
	   			</li>
	   			<li>
	   				<button type="submit" class="btn btn-main">검색</button>
	   				<input type="hidden" name="btn-expand-remember"  id="btn-expand-remember"  value="${searchKey.btnExpandRemem}">
	   				<input type="hidden" name="page_cnt" >
	   			</li>
	   		</ul>
   		</form>
   		<div class="user-info user-info-orders">
   			<ul class="user-list-view user-list-order">
	   			<li>
					<p>주문번호</p>
					<p>상품명</p>
					<p>주문자명</p>
					<p>주문일자</p>
					<p>주문상태</p>
					<p>수량</p>
					<p>주문금액</p>
					<p>구매확정/상품평</p>
					<p>취소/반품요청</p>
	   			</li>
	   			<c:choose>
	   			<c:when test="${allOrders.size()!=0}">
		   			<c:forEach items="${allOrders}" var="orderBundel" varStatus="orderIndex">
		   				<li>
		   					<ul>
		   						<c:forEach items="${orderBundel}" var="orderList" varStatus="orderItemIndex">
		   							<li class="order-element-${orderIndex.index}" id="order-item-element-${orderItemIndex.index}">
		   								<p>${orderList.order_number}</p>
		   								<p>
		   									<a href="/goods/goodsOne?goods_id=${orderList.goods_id}">
		   										<span class="goods-main-image goods-image-tiny">
						   							<i class="bi bi-image-alt"></i>
						   							<img src="${orderList.goods_image}" onerror="this.style.display='none'">
						   						</span>
						   						<span>${orderList.goods_name}</span>
		   									</a>
		   								</p>
		   								<p>${orderList.name}</p>
		   								<p><fmt:formatDate value="${orderList.order_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p>
		   								<p>${orderList.order_status}</p>
		   								<p>${orderList.quantity}</p>
		   								<p>${orderList.sell_price * orderList.quantity}원</p>
		   								<p>
		   									<c:choose>
		   										<c:when test="${orderList.order_status=='배송완료' }">
		   											<span class="btn-order-purchase-confirm">
				   										<button type="button" class="request-return btn btn-navy" id="request-return-${orderItemIndex.index}" >구매확정</button>
				   										<input type="hidden" name="order_number_hidden" value="${orderList.order_number}">
				   										<input type="hidden" name="goods_id_hidden" value="${orderList.goods_id}">
				   										<input type="hidden" name="sell_pric_hidden" value="${orderList.sell_price * orderList.quantity}">
				   									</span>
		   										</c:when>
		   										<c:when test="${orderList.order_status=='구매확정' }">
		   											<a href="/goods/goodsOne?goods_id=${orderList.goods_id}#goods-reply" class="btn btn-navy">상품평 작성</a>
		   										</c:when>
		   										<c:otherwise>
		   											<span>상품평 작성은 구매확정후 가능합니다.</span>
		   										</c:otherwise>
		   									</c:choose>
		   								</p>
		   								<p>
		   									<c:choose>
						   						<c:when test="${orderList.customer_req=='cancel'}">
						   							<c:choose>
						   								<c:when test="${orderList.order_status=='취소'}">
						   									<span><button type="button" class="btn btn-navy"  >취소완료</button></span>
						   								</c:when>
						   								<c:otherwise>
						   									<span><button type="button" class="btn btn-alert">취소요청중</button></span>
						   								</c:otherwise>
						   							</c:choose>
						   						</c:when>
						   						<c:when test="${orderList.customer_req=='return'}">
						   							<c:choose>
						   								<c:when test="${orderList.order_status=='반품'}">
						   									<span><button type="button" class="btn btn-navy" >반품완료</button></span>
						   								</c:when>
						   								<c:otherwise>
						   									<span><button type="button" class="btn btn-alert">반품요청중</button></span>
						   								</c:otherwise>
						   							</c:choose>
						   						</c:when>
						   						<c:otherwise>
						   							<c:choose>
						   								<c:when test="${orderList.order_status=='결제대기' || orderList.order_status=='결제완료'}">
						   									<span class="btn-order-cancel">
						   										<button type="button" class="request-cancel btn btn-alert" id="request-cancel-${orderItemIndex.index}" >취소요청</button>
						   										<input type="hidden" name="order_number_hidden" value="${orderList.order_number}">
						   										<input type="hidden" name="goods_id_hidden" value="${orderList.goods_id}">
						   									</span>
						   								</c:when>
						   								<c:when test="${orderList.order_status=='배송완료'}">
						   									<span class="btn-order-return">
						   										<button type="button" class="request-return btn btn-alert" id="request-return-${orderItemIndex.index}" >반품요청</button>
						   										<input type="hidden" name="order_number_hidden" value="${orderList.order_number}">
						   										<input type="hidden" name="goods_id_hidden" value="${orderList.goods_id}">
						   									</span>
						   								</c:when>
						   								<c:when test="${orderList.order_status=='배송준비중'}">
						   									<span>배송준비중에서는 취소 요청이 불가합니다.</span>
						   								</c:when>
						   								<c:when test="${orderList.order_status=='배송중'}">
						   									<span>배송중에서는 취소 요청이 불가합니다.</span>
						   								</c:when>
						   								<c:otherwise>
						   									<span>구매확정 된 주문은 취소 요청이 불가합니다.</span>
						   								</c:otherwise>
						   							</c:choose>
						   						</c:otherwise>
						   					</c:choose>
		   								</p>
		   								<input type="hidden" name="order-number-${orderIndex.index}" value="${orderList.order_number}">
				   					</li>
		   						</c:forEach>
		   					</ul>
		   					<c:if test="${orderBundel.size()>1}"><div class="order-more-view more-visible" id="order-more-view-${orderIndex.index}"><span><i class="bi bi-chevron-down"></i></span>더보기</div></c:if>
		   				</li>
		   			</c:forEach>
	   			</c:when>
	   			<c:otherwise>
   					<p class="search-null-result">검색된 주문내역이 없습니다.</p>
   				</c:otherwise>
   			</c:choose>
   			</ul>
   		</div>
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
   		
   	</section>
   
   <%@ include file="../includes/footer.jsp" %>