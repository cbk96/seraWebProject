<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ include file="../includes/adminHeader.jsp"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   
   <script>
   	$(function(){
   		var loggedLevel = parseInt(document.getElementById("loggedLevel").value);
   		var resultMsg = document.getElementById("resultMsg").value;
   		var modifyForm = document.getElementById("modify-form");
   		var goodsId = document.getElementsByName("goods_id")[0];
   		var btnRegist = document.getElementById("btn-regist");
		var empList = $(".admin-info-view>li:nth-child(6)>div>p");
   		var photoUpload = document.getElementById("photo-upload");
   		var allRequiredInput = document.querySelectorAll("[required='required']");
   		var submitChkCount = 0;
		var imageUploadPath = document.getElementById("imageUploadPath").value;
		
   		/////기본 실행
   		
   		if(resultMsg!=""){
   			if(resultMsg=="registSuccess"){
   	   			alert("상품 등록이 완료되었습니다.");
   	   			location.href="/admin/goods/";
   	   		}else{alert("상품 등록중 오류가 발생했습니다.");}
   		}
   		
   		if(empList.length>0){
			for(var i=0; i<empList.length; i++){
   				var empLevel = parseInt(empList[i].innerText);
   				empList[i].innerText = empLevelName[empLevel];
   			}
		}
   		
   		//상세 이미지의 원본 사이즈 값을 삭제
   		$("img").removeAttr("style");
   		
   		
   		/////이벤트 실행
   		
   		//상품등록 확인 메세지
   		btnRegist.addEventListener("click", function(){
   			submitChkCount = 0;
   			if(confirm("상품을 등록하시겠습니까?")){
   				modifyForm.setAttribute("action","/admin/goods/goodsRegist");
   				
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
   		
   		//상품일련번호 중복 여부 체크
   		goodsId.addEventListener("change",function(e){
   			btnRegist.setAttribute("disabled","disabled");
   			
   			var goodsIdValue = document.getElementsByName("goods_id")[0].value.replaceAll(" ","");
   			goodsId.value = goodsIdValue;
   			var goodsIdChkMsg = document.getElementById("goods-id-chk-msg");
   			var goodsIdObject = {goodsId : goodsIdValue};
   			
   			$.ajax({
   				url : "/admin/goods/goodsIdChk",
   				type : "post",
   				data : goodsIdObject,
   				success:function(data){
   					if(data==="empty"){
   						goodsIdChkMsg.style.display = "block";
   						goodsIdChkMsg.style.color = "#ff3131";
   						goodsIdChkMsg.innerText = "일련번호가 입력되지 않았습니다.";
   						btnRegist.setAttribute("disabled","disabled");
   					}else if(data==="canUse"){
   						goodsIdChkMsg.style.display = "block";
   						goodsIdChkMsg.style.color = "#2736ff";
   						goodsIdChkMsg.innerText = "사용 가능한 일련번호입니다.";
   						btnRegist.removeAttribute("disabled");
   					}else if(data==="onlyCanUseEng"){
   						goodsIdChkMsg.style.display = "block";
   						goodsIdChkMsg.style.color = "#ff3131";
   						goodsIdChkMsg.innerText = "영문과 숫자, 특수문자만 사용 가능합니다.";
   						btnRegist.setAttribute("disabled","disabled");
   					}else{
   						goodsIdChkMsg.style.display = "block";
   						goodsIdChkMsg.style.color = "#ff3131";
   						goodsIdChkMsg.innerText = "이미 사용중인 일련번호입니다.";
   						btnRegist.setAttribute("disabled","disabled");
   					}
   				}
   			});
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
   			imageUpload(e, "goods", imageUploadPath);
   	   	});
   		
   	});
   </script>
   <script src="/resources/js/searchOptionSettion.js"></script>
   <script src="/resources/js/empImageUpload.js"></script>
   <script src="/resources/ckeditor/ckeditor.js"></script>
   	
   	<div id="hiddenMsgSection" style="display:none;">
   		<input type="hidden" name="loggedLevel" id="loggedLevel" value="${loginEmp.level }">
   		<input type="hidden" name="resultMsg" id="resultMsg" value="${resultMsg}">
   		<input type="hidden" name="imageUploadPath" id="imageUploadPath" value="${imageUploadPath}">
   	</div>
   	
   	<div class="admin-banner admin-banner-join">
   		<h2>MALL SETTING</h2>
   		<p>쇼핑몰 설정</p>
   	</div>
   	
   	<div class="admin-section">
   		<ul class="admin-section-tab-bar">
   			<c:if test="${loginEmp.level>=9}"><li><a href="/admin/goods/categoryList">카테고리 관리</a></li></c:if>
	   		<li><a href="/admin/goods/">상품목록</a></li>
 			<li><a href="/admin/goods/?saleActive=goods_delete">삭제상품목록</a></li>
 			<li class="now-tab">상품등록</li>
   		</ul>
   		
   		<div class="admin-section-content admin-section-content-default" >
	   		<h3 class="content-title">상품등록</h3>
	   		<form method="post" name="member_form"  id="modify-form" enctype="multipart/form-data">
		   		<ul class="admin-info-view admin-info-view-default radio-visible">
		   			<li class="photo-column">
		   				<label>상품이미지</label>
		   				<div>
		   					<p class="photo-frame">
		   						<input type="file" name="photo-upload"  id="photo-upload"accept="image/*">
		   						<label for="photo-upload"  id="photo-upload-area">
		   							<i class="bi bi-camera-fill"></i>
		   							<img name="photo-preview" class="photo-preview" src="${registGvo.goods_image}">
		   							<span>상품이미지 업로드</span>
		   						</label>
		   					</p>
		   					<input type="hidden" name="goods_image"  id="upload-image-hidden" >
		   				</div>
		   				<ul class="admin-info-view radio-visible">
		   					<li>	
				   				<label>상품 일련번호</label>
				   				<div>
				   					<input type="text" name="goods_id" class="input-full-border"  maxLength="10" required="required">
				   					<p id="goods-id-chk-msg"></p>
				   				</div>
							</li>
							<li>
				   				<label>상품명</label>
				   				<div><input type="text" name="goods_name"  class="input-full-border" required="required"></div>
				   			</li>	
				   			<li>	
				   				<label>상품 검색 키워드</label>
				   				<div><input type="text" name="goods_search_key"  class="input-full-border" ></div>
				   			</li>
		   				</ul>
		   			</li>
		   			<li>
		   				<label>카테고리</label>
		   				<div class="search-multi-row-admin">
		   					<select name="main_type" id="main_type" class="input-full-border" onchange="subTypeSetting()" required="required">
		   						<option value="">--대분류--</option>
		   						<c:forEach items="${mainType}" var="mainCate">
		   							<c:if test="${loginEmp.depart == mainCate.depart || loginEmp.level>=9}">
		   								<option  class="${mainCate.depart}" value="${mainCate.main_type}" >${mainCate.main_type}</option>
		   							</c:if>
		   						</c:forEach>
							</select>
							<select name="category_id" id="sub_type" class="input-full-border" required="required">
								<option class="default_option" value="">--중분류--</option>
		   						<c:forEach items="${subType}" var="subCate">
		   							<option class="${subCate.main_type}" value="${subCate.category_id}"  >${subCate.sub_type}</option>
		   						</c:forEach>
							</select>
		   				</div>
		   			</li>
		   			<li>
		   				<label>추천 피부 유형</label>
		   				<div>
		   					<select name="skin_type" class="input-full-border" >
		   						<option  value="" >--피부 타입 선택--</option>
		   						<option  value="oily_skin" >지성 피부</option>
		   						<option  value="dry_skin" >건성 피부</option>
								<option  value="combination_skin" >복합성 피부</option>
		   					</select>
		   				</div>
		   			</li>
		   			<li>
		   				<label>매입가</label>
		   				<div><input type="number" name="purchase_price" min="0" max="99999999"class="input-full-border"  required="required">원</div>
		   			</li>
		   			<li>
		   				<label>판매가</label>
		   				<div>
		   					<input type="number" name="sell_price"  min="0" max="99999999" class="input-full-border" required="required">원
		   					<p class="max-over-alert">매입가 보다 낮은 가격은 입력할 수 없습니다.</p>
		   				</div>
		   			</li>
		   			<li>
		   				<label>배송비</label>
		   				<div><input type="number" name="shipping_fee" min="0" max="99999999" class="input-full-border"  required="required">원</div>
		   			</li>
		   			<li>
		   				<label>재고</label>
		   				<div><input type="number" name="amount"  min="0" max="99999999" class="input-full-border" required="required"></div>
		   			</li>
		   			<li>
		   				<label>판매여부</label>
		   				<div>
							<select name="sale_active" class="input-full-border" required="required">
		   						<option  value="y" >판매함</option>
								<option  value="n" >품절</option>
		   					</select>
						</div>
		   			</li>
		   			<li>
		   				<label>상세정보</label>
		   				<div>
		   					<div class="testarea-layout">
		   					<textarea name="goods_content" id="goods_content" class="input-default input-full-border goods-content-textarea"  maxlength="5000"></textarea>
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
		   				<button type="submit" id="btn-regist" class="btn admin-btn-main" disabled="disabled" >상품등록</button>
			   			<a href="/admin/goods/" class="btn btn-navy" >취소</a>
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