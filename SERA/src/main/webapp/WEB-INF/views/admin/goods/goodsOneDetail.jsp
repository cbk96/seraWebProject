<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
   	$(function(){
   		var loggedLevel = parseInt(document.getElementById("loggedLevel").value);
   		var modifyForm = document.getElementById("modify-form");
   		var modifyMsg = document.getElementById("modifyMsg").value;
   		var btnModify = document.getElementById("btn-modify");
   		var btnDelete = document.getElementById("btn-delete");
		var empList = $(".admin-info-view>li:nth-child(6)>div>p");
		var viewPrice = document.querySelectorAll(".view-price>p:nth-child(1)");
		var goodsId = document.getElementsByName("goods_id")[0];
   		var photoUpload = document.getElementById("photo-upload");
   		var allRequiredInput = document.querySelectorAll("[required='required']");
   		var submitChkCount = 0;
   		var imageUploadPath = document.getElementById("imageUploadPath").value;
   		
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
   		
   		//상세 이미지의 원본 사이즈 값을 삭제
   		$("img").removeAttr("style");
   		
   		//판매가격의 천의 자리수 마다 ',' 입력
   		for(var i=0; i<viewPrice.length; i++){
   			viewPrice[i].innerText = parseInt(viewPrice[i].innerText).toLocaleString();
   		}
   		
   		$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(3)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(4)").css("display","none");
   		$(".confirm-btn-container>button:nth-child(5)").css("display","none");
   		
   		
   		/////이벤트 실행
   		
   		//상품 정보 수정
   		btnModify.addEventListener("click", function(){
   			submitChkCount = 0;
   			if(confirm("상품 정보를 수정하시겠습니까?")){
   				modifyForm.setAttribute("action","/admin/goods/goodsModify");

   				for(var i =0; i< allRequiredInput.length; i++){
   					if(allRequiredInput[i].value==""){
   						submitChkCount +=1;
   					}
   				}
   				if(submitChkCount==0){
   					modifyForm.submit();
   				}else{
   					alert("입력되지 않은 정보가 있습니다.");
   				}
   			}else{
   				modifyForm.removeAttribute("action");
   				return;
   			}
   		});
   		
   		
   		
   		//상품 삭제
   		btnDelete.addEventListener("click", function(){
   			if(confirm("상품을 삭제하시겠습니까?\n삭제 후에는 삭제 상품 목록에서 확인할 수 있습니다.")){
   				modifyForm.setAttribute("action","/admin/goods/goodsDelete");
   				modifyForm.submit();
   			}else{
   				modifyForm.removeAttribute("action");
   				return;
   			}
   		});
   		
   		//매입가에 따른 판매가 입력폼 최소값 조정
   		$("input[name='purchase_price']").change(function(){
   			var maxPrice = 99999999;
   				
   			if(parseInt($(this).val())<maxPrice){maxPrice = parseInt($(this).val());
   			}
   			$("input[name='sell_price']").attr("min",$(this).val());
   			
   			if(parseInt($("input[name='sell_price']").val()) < parseInt($(this).val())){
   				$("input[name='sell_price']").val(maxPrice);
   			}
   		});
   		
   		$("input[name='sell_price']").change(function(){
   			$(".max-over-alert").css("display","none");
   			
   			if(parseInt($(this).val())<parseInt($(this).attr("min"))){
   				$(".max-over-alert").css("display","block");
   			}
   		});
   		
   		//숫자 입력폼에 최소값 이하의 값 입력 방지
   		$("input[type='number']").change(function(){
   			if(parseInt($(this).val())<parseInt($(this).attr("min"))){
   				$(this).val($(this).attr("min"));
   			}
   			if(parseInt($(this).val())>parseInt($(this).attr("max"))){
   				$(this).val($(this).attr("max"));
   			}
   		});
   		
   		//상품 이미지 업로드
   		photoUpload.addEventListener("change", function(e){
   			imageUpload(e, "goods",imageUploadPath);
	   	});
   		
   	});
		/////함수
	   	function openModifyInput(){
	   		$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n+1)").css("display","none");
	   		$(".admin-info-view>li>div:nth-of-type(2n)").css("display","flex");
	   		$(".confirm-btn-container>button:nth-child(1)").css("display","none");
	   		$(".confirm-btn-container>a:nth-child(2)").css("display","none");
	   		$(".confirm-btn-container>button:nth-child(3)").css("display","block");
	   		$(".confirm-btn-container>button:nth-child(4)").css("display","block");
	   		$(".confirm-btn-container>button:nth-child(5)").css("display","block");
	   	}
	   	
	   	function cancleModify(){
	   		$(".admin-info-view>li>div:nth-of-type(2n+1)").css("display","flex");
	   		$(".admin-info-view>li:not(.not-toggle-view)>div:nth-of-type(2n)").css("display","none");
	   		$(".confirm-btn-container>button:nth-child(1)").css("display","block");
	   		$(".confirm-btn-container>a:nth-child(2)").css("display","block");
	   		$(".confirm-btn-container>button:nth-child(3)").css("display","none");
	   		$(".confirm-btn-container>button:nth-child(4)").css("display","none");
	   		$(".confirm-btn-container>button:nth-child(5)").css("display","none");
	   	}
   	
   </script>
   <script src="/resources/js/searchOptionSettion.js"></script>
   <script src="/resources/js/empImageUpload.js"></script>
   <script src="/resources/ckeditor/ckeditor.js"></script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="loggedLevel" id="loggedLevel" value="${loginEmp.level }">
   		<input type="hidden" name="modifyMsg" id="modifyMsg" value="${modifyMsg}">
   		<input type="hidden" name="imageUploadPath" id="imageUploadPath" value="${imageUploadPath}">
   	</div>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>MALL SETTING</h2>
   		<p>쇼핑몰 설정</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<li class="now-tab">상품상세정보</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default" >
	   		<h3 class="content-title">상품상세정보</h3>
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
		   				<div>
		   					<p class="photo-frame">
		   						<input type="file" name="photo-upload"  id="photo-upload"accept="image/*">
		   						<label for="photo-upload"  id="photo-upload-area">
		   							<img name="photo-preview"  class="photo-preview" src="${goodsInfo.goods_image}" onerror="this.style.display='none'">
		   							<i class="bi bi-camera-fill"></i>
		   							<span>상품이미지 업로드</span>
		   						</label>
		   					</p>
		   					<input type="hidden" name="goods_image"  id="upload-image-hidden" value="${goodsInfo.goods_image}">
		   				</div>
		   				<ul class="admin-info-view radio-visible">
		   					<li>	
				   				<label>상품 일련번호</label>
				   				<div><p>${goodsInfo.goods_id}</p></div>
				   				<div><input type="text" name="goods_id"  value="${goodsInfo.goods_id}" class="input-full-border"  maxLength="10" readonly></div>
							</li>
							<li>
				   				<label>상품명</label>
				   				<div><p>${goodsInfo.goods_name}</p></div>
				   				<div><input type="text" name="goods_name"  value="${goodsInfo.goods_name}" class="input-full-border" required="required"></div>
				   			</li>	
				   			<li>	
				   				<label>상품 검색 키워드</label>
				   				<div><p>${goodsInfo.goods_search_key}</p></div>
				   				<div><input type="text" name="goods_search_key"  value="${goodsInfo.goods_search_key}" class="input-full-border" ></div>
				   			</li>
		   				</ul>
		   			</li>
		   			<li>
		   				<label>카테고리</label>
		   				<div class="divide-layout search-multi-row-admin"><p><strong>대분류</strong> ${goodsInfo.main_type}</p><p><strong>중분류</strong> ${goodsInfo.sub_type}</p></div>
		   				<div class="search-multi-row-admin">
		   					<select name="main_type" id="main_type" class="input-full-border" onchange="subTypeSetting()" required="required">
		   						<option value="">--대분류--</option>
		   						<c:forEach items="${mainType}" var="mainCate">
		   							<c:if test="${loginEmp.depart == mainCate.depart || loginEmp.level>=9}">
		   								<option  class="${mainCate.depart}" value="${mainCate.main_type}"  <c:if test="${goodsInfo.main_type == mainCate.main_type}">selected</c:if>>${mainCate.main_type}</option>
		   							</c:if>
		   						</c:forEach>
							</select>
							<select name="category_id" id="sub_type" class="input-full-border" required="required">
								<option class="default_option" value="">--중분류--</option>
		   						<c:forEach items="${subType}" var="subCate">
		   							<option class="${subCate.main_type}" value="${subCate.category_id}"  <c:if test="${goodsInfo.category_id == subCate.category_id}">selected</c:if>>${subCate.sub_type}</option>
		   						</c:forEach>
							</select>
		   				</div>
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
		   				<div>
							<select name="skin_type" class="input-full-border">
								<option  value="" >--피부 타입 선택--</option>
		   						<option  value="oily_skin" <c:if test="${goodsInfo.skin_type == 'oily_skin'}">selected</c:if> >지성 피부</option>
								<option  value="dry_skin"  <c:if test="${goodsInfo.skin_type == 'dry_skin'}">selected</c:if>>건성 피부</option>
								<option  value="combination_skin"  <c:if test="${goodsInfo.skin_type == 'combination_skin'}">selected</c:if>>복합성 피부</option>
		   					</select>
						</div>
		   			</li>
		   			<li>
		   				<label>매입가</label>
		   				<div class="view-price"><p>${goodsInfo.purchase_price}</p>원</div>
		   				<div><input type="number" name="purchase_price" value="${goodsInfo.purchase_price}" min="0" max="99999999" class="input-full-border"  required="required">원</div>
		   			</li>
		   			<li>
		   				<label>판매가</label>
		   				<div class="view-price"><p>${goodsInfo.sell_price}</p>원</div>
		   				<div>
		   					<input type="number" name="sell_price"  value="${goodsInfo.sell_price}" min="0" max="99999999" class="input-full-border" required="required">원
		   					<p class="max-over-alert">매입가 보다 낮은 가격은 입력할 수 없습니다.</p>
		   				</div>
		   			</li>
		   			<li>
		   				<label>배송비</label>
		   				<div class="view-price"><p>${goodsInfo.shipping_fee}</p>원</div>
		   				<div><input type="number" name="shipping_fee" value="${goodsInfo.shipping_fee}" min="0" max="99999999" class="input-full-border"  required="required">원</div>
		   			</li>
		   			<li>
		   				<label>재고</label>
		   				<div><p>${goodsInfo.amount}</p></div>
		   				<div><input type="number" name="amount" value="${goodsInfo.amount}" min="0" max="99999999" class="input-full-border" required="required"></div>
		   			</li>
		   			<li class="not-toggle-view">
		   				<label>조회수</label>
		   				<div><p>${goodsInfo.view_cnt}</p></div>
		   			</li>
		   			<li>
		   				<label>판매여부</label>
		   				<div>
		   					<p>
		   						<c:choose>
		   							<c:when test="${goodsInfo.sale_active == 'y'}">판매중</c:when>
		   							<c:when test="${goodsInfo.sale_active == 'n'}">품절</c:when>
		   							<c:otherwise>미설정</c:otherwise>
		   						</c:choose>
		   					</p>
		   				</div>
		   				<div>
							<select name="sale_active" class="input-full-border">
		   						<option  value="y" <c:if test="${goodsInfo.sale_active == 'y'}">selected</c:if> >판매함</option>
								<option  value="n"  <c:if test="${goodsInfo.sale_active == 'n'}">selected</c:if>>품절</option>
		   					</select>
						</div>
		   			</li>
		   			<li>
		   				<label>상세정보</label>
		   				<div><div class="testarea-layout"><p>${goodsInfo.goods_content}</p></div></div>
		   				<div>
		   					<div class="testarea-layout">
		   					<textarea name="goods_content" id="goods_content" class="input-default input-full-border goods-content-textarea"  maxlength="5000">${goodsInfo.goods_content}</textarea>
			   					<script>
			   					$(function(){
			   						var imageUploadPath = document.getElementById("imageUploadPath").value;
				   					
			   						ckeditor_config = {
										width : '100%',
										height : '2000px',
										resize_enaleb : false,
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode : CKEDITOR.ENTER_P,
										filebrowserUploadUrl : "/admin/emp/ckUpload?imageUploadPath="+imageUploadPath
									};
		   							
		   							CKEDITOR.replace("goods_content", ckeditor_config);
			   					});
								</script>
							</div>
		   				</div>
		   			</li>
		   			<li class="confirm-btn-container">
		   				<button type="button" class="btn admin-btn-main" onclick="openModifyInput()">수정</button>
		   				<a href="/admin/goods/" class="btn btn-navy">목록</a>
		   				<button type="button" id="btn-modify" class="btn admin-btn-main" >수정완료</button>
			   			<button type="button" class="btn btn-navy"  onclick="cancleModify()">취소</button>
			   			<button type="button" id="btn-delete" class="btn btn-navy" >상품삭제</button>
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