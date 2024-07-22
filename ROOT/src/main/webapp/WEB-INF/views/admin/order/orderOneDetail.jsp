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
   		
   		//$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(3)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(4)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(5)").css("display","none");
   		
   		
   		/////이벤트 실행///////
   		
   		//주문자 정보 수정
   		$("#customerInfoModify").click(function(){
   			if(confirm("주문자 정보를 수정합니다.")){
   	   			var order_number = $("input[name='order_number']");
   	   			var name = $("input[name='name']");
   	   			var post_code = $("input[name='post_code']");
   	   			var address  = $("input[name='address']");
   	   			
   	   			var allRequiredInput = document.querySelectorAll("[required='required']");
   	   			var submitChkCount = 0;
   				var emptyRequired = 0;
   				var customerForm = document.getElementById("customer-form");
				
   				for(var i =allRequiredInput.length; i< 0; i--){
   					if(allRequiredInput[i].value==""){
   						submitChkCount +=1;
   						emptyRequired = i;
   					}
   				}
   				if(submitChkCount==0){
   					customerForm.setAttribute("action","/admin/order/customerInfoModify");
   					customerForm.submit();
   				}else{
   					alert("입력되지 않은 정보가 있습니다.");
   					allRequiredInput[emptyRequired].focus();
   				}
   			}
   		});
   		
	   	//마일리지 복원
		$("#restoreMileage").click(function(){
			if(confirm("마일리지를 복원합니다.")){
				var order_number = $("input[name='order_number']").val();
				var orderInfo = {order_number : order_number};
				
				$.ajax({
   	   				url:"/admin/order/restoreMileage",
   	   				data:orderInfo,
   	   				type:"POST",
   	   				success:function(result){
   	   					if(result=="success"){
   	   						alert("마일리지가 복원 되었습니다.");
   	   					}else{
   	   						alert("마일리지 복원중 오류가 발생되었습니다.");
   	   					}
   	   				}
   	   			});
				
			}
		});
   		
   		//상품별 배송상태 변경
   		$(".item-modify-btn").click(function(){
   			if(confirm("배송상태를 변경하시겠습니까?")){
   				var goods_id = $(this).attr("id").replace("-btn","");
   	   			var clickItemId = goods_id+"-line";
   	   			var clickItem = $("#"+clickItemId);
   	   			var order_number = clickItem.children("input[name='order_number']").val();
   	   			var order_status = clickItem.children("p").children("select[name='order_status']").val();
   	   			
   	   			var itemInfo = {goods_id : goods_id, order_number : order_number, order_status : order_status};
   	   			
   	   			$.ajax({
   	   				url:"/admin/order/orderItemModify",
   	   				data:itemInfo,
   	   				type:"POST",
   	   				success:function(result){
   	   					if(result=="success"){
   	   						alert("배송상태가 변경되었습니다.");
   	   					}else{
   	   						alert("배송상태가 변경중 오류가 발생되었습니다.");
   	   					}
   	   				}
   	   			});
   			}
   			
   		});
   		//취소처리
   		$(".btn-cancel").click(function(){
   			var order_number =($(this).attr("id").replace("customerInfoCancle-",""));
   			var goods_id = $(this).children("input[name='goods_id_hidden']").val();
   			var sell_price = $(this).children("input[name='sell_price_hidden']").val();
   			var order_value = {order_number : order_number, goods_id : goods_id, sell_price : sell_price,  requestType : "취소"};
   			
   			if(confirm("주문 취소를 처리 하시겠습니까?")){
   				
   				$.ajax({
   	   				url : "/admin/order/orderRequest",
   	   				data : order_value,
   	   				type : "POST",
   	   				success:function(result){
   	   					if(result=="success"){
   	   						alert("선택한 상품의 주문이 취소 처리되었습니다.");
   	   						location.reload();
   	   					}else{
   	   						alert("주문 취소 처리중 오류가 발생되었습니다.");
   	   					}
   	   				}
   	   			});
   				
   			}
   		});
   		
   		
   		//반품처리
   		//customerInfoReturn
   		//btn-return
   		$(".btn-return").click(function(){
   			var order_number =($(this).attr("id").replace("customerInfoReturn-",""));
   			var goods_id = $(this).children("input[name='goods_id_hidden']").val();
   			
   			var order_value = {order_number : order_number, goods_id : goods_id, requestType : "반품"};
   			
   			if(confirm("반품처리 하시겠습니까?")){
   				
   				$.ajax({
   	   				url : "/admin/order/orderRequest",
   	   				data : order_value,
   	   				type : "POST",
   	   				success:function(result){
   	   					if(result=="success"){
   	   						alert("선택한 상품이 반품 처리되었습니다.");
   	   						location.reload();
   	   					}else{
   	   						alert("반품 처리중 오류가 발생되었습니다.");
   	   					}
   	   				}
   	   			});
   				
   			}
   		});
   		
   	});
	   	
	   	function post_codeSearch(){
	   		window.open("/member/postChk", "post_code_check", "width=350px, height=420px, scrollbars=yes");
	   	}
   	
   </script>
   <script src="/resources/js/searchOptionSettion.js"></script>
   <script src="/resources/js/empImageUpload.js"></script>
   <script src="/resources/ckeditor/ckeditor.js"></script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="loggedLevel" id="loggedLevel" value="${loginEmp.level }">
   		<input type="hidden" name="modifyMsg" id="modifyMsg" value="${modifyMsg}">
   	</div>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>MALL SETTING</h2>
   		<p>쇼핑몰 설정</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">주문상세정보</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default" >
	   		<h3 class="content-title">결제정보</h3>
	   		<ul class="admin-info-view admin-info-view-default admin-info-view-nohave-btn">
	   			<li>	
		   			<label>주문번호</label>
   					<div><p>${ordererInfo.order_number}</p></div>
				</li>
	   			<li>	
		   			<label>결제수단</label>
   					<div><p>${ordererInfo.payment}</p></div>
				</li>
	   			<li>	
		   			<label>결제일</label>
   					<div><p><fmt:formatDate value="${ordererInfo.order_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate></p></div>
				</li>
				<li>	
		   			<label>총 결제 금액</label>
   					<div class="admin-price-result">
   						<span>상품 총 금액</span>
   						<span><span class="view-price">${ordererInfo.all_price}</span>원</span>
   						<span>마일리지 사용</span>
   						<span><span class="view-price">${ordererInfo.discount_price}</span>원</span>
   						<span>총 결제 금액</span>
   						<span><span class="view-price">${ordererInfo.all_price - ordererInfo.discount_price}</span>원</span>
   					</div>
				</li>
				<li class="confirm-btn-container">
	   				<button type="button" class="btn admin-btn-main" id="restoreMileage">마일리지 복원</button>
		   		</li>
	   		</ul>
	   		
	   		<h3 class="content-title-narrow-margin">주문자정보</h3>
	   		<form method="post" name="member_form"  id="customer-form" enctype="multipart/form-data">
		   		<ul class="admin-info-view admin-info-view-default radio-visible">
		   			<li class="photo-column">
		   				<ul class="admin-info-view radio-visible">
		   					<li>	
					   			<label>주문자 아이디</label>
					   			<div><p>${ordererInfo.user_id}</p></div>
							</li>
							
		   				</ul>
		   				<ul class="admin-info-view radio-visible">
		   					<li>	
					   			<label>주문자명</label>
			   					<div><input type="text" name="name" value="${ordererInfo.name}" class="input-full-border" maxlength="20" required="required"></div>
							</li>
		   				</ul>
		   			</li>
					<li>	
			   			<label>구매자 유형</label>
			   			<div>
				   			<p>
			   					<c:choose>
			   						<c:when test="${ordererInfo.member_order=='y'}">회원</c:when>
			   						<c:otherwise>비회원</c:otherwise>
			   					</c:choose>
		   					</p>
	   					</div>
					</li>
					<li>	
			   			<label>배송지 주소</label>
			   			<div class="search-multi-row-admin">
			   				<input type="text" name="post_code" value="${ordererInfo.post_code}"   readonly required="required" class="input-full-border">
		   					<input type="text" name="address" value="${ordererInfo.address}" required="required" maxlength="60" class="input-full-border">
		   					<button type="button" onclick="post_codeSearch()" id="btn-post-code-search" class="btn-small btn-navy">우편번호 찾기</button>
			   			</div>
					</li>
		   			
		   			<li class="confirm-btn-container">
		   				<button type="button" class="btn admin-btn-main" id="customerInfoModify">주문자 정보 수정</button>
		   				<input type="hidden" name="order_number" id="order_number" value="${ordererInfo.order_number}">
			   		</li>
		   		</ul>
	   		</form>
	   		
	   		<h3 class="content-title-narrow-margin">상품정보</h3>
	   		<ul class="admin-order-list">
	   			<li>
					<p>구매상품</p>
					<p>구매수량</p>
					<p>주문금액</p>
					<p>배송상태</p>
					<p>배송상태변경</p>
					<p>취소/반품요청</p>
					<p>취소/반품요청일</p>
	   			</li>
				<c:forEach items="${order_items}" var="orderList">
 						<li class="order-element-${orderIndex.index}"  id="${orderList.goods_id}-line">
	 							<p>
	 								<a href="/goods/goodsOne?goods_id=${orderList.goods_id}" target="_blank">
	 									<span class="goods-main-image goods-image-tiny">
					   						<i class="bi bi-image-alt"></i>
					   						<img src="${orderList.goods_image}" onerror="this.style.display='none'">
					   					</span>
					   					<span>${orderList.goods_name}</span>
	 								</a>
	 							</p>
	 							<p>${orderList.quantity}</p>
	 							<p><span class="view-price">${orderList.sell_price * orderList.quantity}</span>원</p>
	 							<p>
	 								<c:choose>
	 									<c:when test="${orderList.order_status=='구매확정'}">
	 										구매확정
	 									</c:when>
	 									<c:when test="${orderList.order_status=='취소'}">
	 										주문취소
	 									</c:when>
	 									<c:when test="${orderList.order_status=='반품'}">
	 										반품
	 									</c:when>
	 									<c:otherwise>
	 										<select name="order_status" class="input-full-border order_status order-status-toggle">
						   						<option value="결제완료" <c:if test="${orderList.order_status == '결제완료'}">selected</c:if>>결제완료</option>
					   							<option value="배송준비중" <c:if test="${orderList.order_status == '배송준비중'}">selected</c:if>>배송준비중</option>
					   							<option value="배송중" <c:if test="${orderList.order_status == '배송중'}">selected</c:if>>배송중</option>
					   							<option value="배송완료" <c:if test="${orderList.order_status == '배송완료'}">selected</c:if>>배송완료</option>
					   						</select>
	 									</c:otherwise>
	 								</c:choose>
	 							</p>
	 							<p>
	 								<c:choose>
	 									<c:when test="${orderList.order_status=='취소' || (orderList.order_status=='반품' || orderList.order_status=='구매확정')}">
	 										* 구매확정, 반품, 취소 상태는 배송상태변경이 불가합니다.
	 									</c:when>
	 									<c:otherwise>
	 										<button type="button" id="${orderList.goods_id}-btn" class="btn btn-navy item-modify-btn" >배송상태변경</button>
	 									</c:otherwise>
	 								</c:choose>
	 							</p>
	 							<p>
	 								<c:choose>
				   						<c:when test="${orderList.customer_req=='cancel'}">
				   							<c:choose>
				   								<c:when test="${orderList.order_status=='취소'}">
				   									취소완료
				   								</c:when>
				   								<c:otherwise>
				   									<span class="btn btn-alert btn-cancel" id="customerInfoCancle-${orderList.order_number}">
				   										취소처리
				   										<input type="hidden" name ="goods_id_hidden" value="${orderList.goods_id}" >
				   										<input type="hidden" name ="sell_price_hidden" value="${orderList.sell_price * orderList.quantity}" >
				   									</span>
				   								</c:otherwise>
				   							</c:choose>
				   						</c:when>
				   						<c:when test="${orderList.customer_req=='return'}">
				   							<c:choose>
				   								<c:when test="${orderList.order_status=='반품'}">
				   									반품완료
				   								</c:when>
				   								<c:otherwise>
				   									<span  class="btn btn-alert btn-return" id="customerInfoReturn-${orderList.order_number}">
				   										반품처리
				   										<input type="hidden" name ="goods_id_hidden" value="${orderList.goods_id}" >
				   										<input type="hidden" name ="sell_price_hidden" value="${orderList.sell_price * orderList.quantity}" >
				   									</span>
				   								</c:otherwise>
				   							</c:choose>
				   						</c:when>
				   						<c:otherwise>요청 없음</c:otherwise>
				   					</c:choose>
	 							</p>
	 							<p>
	 								<c:choose>
				   						<c:when test="${orderList.customer_req=='cancel' || orderList.customer_req=='return'}">
				   							<fmt:formatDate value="${ordererInfo.reguest_date}" pattern="yyyy년 MM월 dd일"></fmt:formatDate>
				   						</c:when>
				   						<c:otherwise>---- 년 -- 월 -- 일</c:otherwise>
				   					</c:choose>
	 							</p>
	 							<input type="hidden" name="order_number" value="${orderList.order_number}">
	   					</li>
 					</c:forEach>
 				</ul>
 				<div class="confirm-btn-container">
	   				<a href="/admin/order/" class="btn btn-navy">목록</a>
		   		</div>
	   		
	   	</div>
	 </div>  	
   <%@ include file="../includes/adminFooter.jsp" %>