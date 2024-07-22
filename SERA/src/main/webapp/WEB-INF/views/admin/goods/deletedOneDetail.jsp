<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
   	$(function(){
   		var loggedLevel = parseInt(document.getElementById("loggedLevel").value);
   		var modifyForm = document.getElementById("modify-form");
   		var modifyMsg = document.getElementById("modifyMsg").value;
   		var btnHardDelete = document.getElementById("btn-hard-delete");
   		var btnRestore = document.getElementById("btn-restore");
		var empList = $(".admin-info-view>li:nth-child(6)>div>p");
		var viewPrice = document.querySelectorAll(".view-price>p:nth-child(1)");
   		var photoUpload = document.getElementById("photo-upload");
   		
   		/////기본 실행
   		
   		//상품 페이지 접속시 상품 수정 결과 메세지가 있으면 출력
   		if(modifyMsg!=""){
   			if(modifyMsg=="modifySuccess"){
   	   			alert("상품 정보 수정이 완료되었습니다.");
   	   		}else if(modifyMsg=="modifySuccess"){
   	   			alert("상품 정보 수정중 오류가 발생했습니다.");
   	   		}else if(modifyMsg=="deleteSuccess"){
   	   			alert("상품 삭제가 완료되었습니다.");
   	   		}else if(modifyMsg=="deleteFail"){
   	   			alert("상품 삭제중 오류가 발생했습니다.");
   	   		}else if(modifyMsg=="hardDeleteSuccess"){
   	   			alert("상품 영구 삭제가 완료되었습니다.");
   	   			location.href="/admin/goods/?saleActive=goods_delete";
   	   		}else if(modifyMsg=="hardDeleteFail"){
   	   			alert("상품 영구 삭제중 오류가 발생했습니다.");
   	   		}else if(modifyMsg=="restoreSuccess"){
   	   			alert("상품 복원이 완료되었습니다.");
   	   			location.href="/admin/goods/";
   	   		}else if(modifyMsg=="restoreFail"){
   	   			alert("상품 복원중 오류가 발생했습니다.");
   	   		}
   		}
   		
   		
   		/////이벤트 실행
   		
   		//상품 정보 수정
   		btnHardDelete.addEventListener("click", function(){
   			if(confirm("상품을 영구적으로 삭제하시겠습니까?\n영구 삭제 후에는 복원이 불가능합니다.")){
   				modifyForm.setAttribute("action","/admin/goods/goodsHardDelete");
   				modifyForm.submit();
   			}else{
   				modifyForm.removeAttribute("action");
   				return;
   			}
   		});
   		
   		//상품 삭제
   		btnRestore.addEventListener("click", function(){
   			if(confirm("상품을 복원하시겠습니까?\복원 후에는 상품 목록에서 확인할 수 있습니다.")){
   				modifyForm.setAttribute("action","/admin/goods/goodsRestore");
   				modifyForm.submit();
   			}else{
   				modifyForm.removeAttribute("action");
   				return;
   			}
   		});
   		
   		
   	});
   	
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
   			<li class="now-tab">삭제상품정보</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default" >
	   		<h3 class="content-title">삭제상품정보</h3>
	   		<form method="post" name="member_form"  id="modify-form" enctype="multipart/form-data">
		   		<ul class="admin-info-view admin-info-view-default radio-visible">
		   			<li class="photo-column">
		   				<label>상품이미지</label>
		   				<div>
		   					<p class="photo-frame goods-main-image goods-image-small" >
		   						<i class="bi bi-camera-fill"></i>
		   						<img src="${goodsInfo.goods_image}" onerror="this.style.display='none'">
		   					</p>
		   				</div>
		   				<ul class="admin-info-view radio-visible">
		   					<li>	
				   				<label>상품 일련번호</label>
				   				<div><p>${goodsInfo.goods_id}</p></div>
				   				<input type="hidden" name="goods_id" value="${goodsInfo.goods_id}">
							</li>
							<li>
				   				<label>상품명</label>
				   				<div><p>${goodsInfo.goods_name}</p></div>
				   			</li>	
				   			<li>	
				   				<label>상품 검색 키워드</label>
				   				<div><p>${goodsInfo.goods_search_key}</p></div>
				   			</li>
		   				</ul>
		   			</li>
		   			<li>
		   				<label>카테고리</label>
		   				<div class="divide-layout"><p><strong>대분류</strong> ${goodsInfo.main_type}</p><p><strong>중분류</strong> ${goodsInfo.sub_type}</p></div>
		   			</li>
		   			<li>
		   				<label>추천 피부 유형</label>
		   				<div>
		   					<p>
		   						<c:choose>
		   							<c:when test="${goodsInfo.skin_type == 'oily_skin'}">지성 피부</c:when>
		   							<c:when test="${goodsInfo.skin_type == 'dry_skin'}">건성 피부</c:when>
		   							<c:when test="${goodsInfo.skin_type == 'combination_skin'}">복합성 피부</c:when>
		   							<c:otherwise>미설정</c:otherwise>
		   						</c:choose>
		   					</p>
		   				</div>
		   			</li>
		   			<li>
		   				<label>매입가</label>
		   				<div class="view-price"><p>${goodsInfo.purchase_price}</p>원</div>
		   			</li>
		   			<li>
		   				<label>판매가</label>
		   				<div class="view-price"><p>${goodsInfo.sell_price}</p>원</div>
		   			</li>
		   			<li>
		   				<label>배송비</label>
		   				<div class="view-price"><p>${goodsInfo.shipping_fee}</p>원</div>
		   			</li>
		   			<li>
		   				<label>재고</label>
		   				<div><p>${goodsInfo.amount}</p></div>
		   			</li>
		   			<li>
		   				<label>조회수</label>
		   				<div><p>${goodsInfo.view_cnt}</p></div>
		   			</li>
		   			<li>
		   				<label>판매여부</label>
		   				<div><p><c:if test="${goodsInfo.sale_active == 'd'}">삭제상품</c:if></p></div>
		   			</li>
		   			<li>
		   				<label>상세정보</label>
		   				<div><div class="testarea-layout"><p>${goodsInfo.goods_content}</p></div></div>
		   			</li>
		   			<li class="confirm-btn-container">
		   				<button type="button" id="btn-hard-delete" class="btn admin-btn-main" >완전삭제</button>
		   				<button type="button" id="btn-restore" class="btn admin-btn-main" >상품복원</button>
			   			<a href="/admin/goods/?saleActive=goods_delete" class="btn btn-navy">목록</a>
			   			<input type="hidden" name="emp_id" value="${loginEmp.emp_id }">
			   		</li>
		   		</ul>
	   		</form>
	   		
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