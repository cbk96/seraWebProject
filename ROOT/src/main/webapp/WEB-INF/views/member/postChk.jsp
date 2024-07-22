<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl 태그 라이브러리 -->
<!DOCTYPE html>
<html lang="ko"> 
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0; minimum-scale=1.0; user-scalable=no;">
<title>우편번호 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/member.css">
<script>
	$(function(){
		window.addEventListener("resize", function(){
			window.resizeTo(350, 450);
		});
	});

	function btnPostcodeChk(){
		var postChk = document.post_chk_form;
		
		if(postChk.area3.value == ""){
			alert("주소가 입력되지 않았습니다.");
			postChk.area3.focus();
			return;
		}
		postChk.action="/member/postChk";
		postChk.submit();
	}
	
	function sendPostCode(postCode, area1, area2, area3, area4){
		var address = area1+ " " + area2 + " " +area3 + " " + area4;
		
		opener.document.member_form.post_code.value = postCode;
		opener.document.member_form.address.value = address;
		
		self.close();
	}
</script>
</head>
<body>
	<form name="post_chk_form" method="post" id="post_chk_form">
		<div class="search-form">
			<input type="text" name="area3"  placeholder="동/면 입력" class="input-default input-bottom-border">
			<div class="btn-search-icon-container">
				<button type="reset" class="btn btn-search-icon"><i class="bi bi-x-lg"></i></button>
				<button type="button" class="btn btn-search-icon" onclick="btnPostcodeChk()"><i class="bi bi-search"></i></button>
			</div>
		</div>
		<div class="pvo-list-container">
			<c:choose>
				<c:when test="${pvoList != null}">
					<c:forEach items="${pvoList}" var="pvoList">
						<ul class="pvo-list" >
							<li>${pvoList.post_code}</li>
							<li>
								<span>지 번</span>
								<div onclick="sendPostCode('${pvoList.post_code}', '${pvoList.area1}', '${pvoList.area2}', '${pvoList.area3}', '${pvoList.area4}')">
									<span>${pvoList.area1}</span>
									<span>${pvoList.area2}</span>
									<span>${pvoList.area3}</span>
									<span>${pvoList.area4}</span>
								</div>
							</li>
						</ul>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>검색된 주소가 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>
	</form>
</body>
</html>

